<template>
  <div class="root-wrapper" v-show="isVisible">
    <div class="menu-container">
      <div class="menu-panel">
        <div class="animated-bg">
          <div class="bg-gradient"></div>
          <div class="bg-pattern"></div>
        </div>
        
        <input-form
          v-if="formData"
          :form-data="formData"
          @submit="handleSubmit"
          @cancel="handleCancel"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import InputForm from './components/InputForm.vue'

const isVisible = ref(false)
const formData = ref(null)

window.addEventListener('message', (event) => {
  const { action, data } = event.data
  
  switch (action) {
    case 'OPEN_MENU':
      formData.value = data
      isVisible.value = true
      break
    case 'CLOSE_MENU':
      closeMenu()
      break
  }
})

const handleSubmit = (data) => {
  fetch(`https://${GetParentResourceName()}/buttonSubmit`, {
    method: 'POST',
    body: JSON.stringify({ data })
  })
  closeMenu()
}

const handleCancel = () => {
  fetch(`https://${GetParentResourceName()}/closeMenu`, {
    method: 'POST',
    body: JSON.stringify({})
  })
  closeMenu()
}

const closeMenu = () => {
  isVisible.value = false
  formData.value = null
}

window.addEventListener('keyup', (e) => {
  if (e.key === 'Escape' && isVisible.value) {
    handleCancel()
  }
})
</script>

<style lang="scss">
.root-wrapper {
  width: 30vw;
  height: auto;
  top: 50%; /* Changed from 31.2% to center vertically */
  left: 90%; /* Changed from 62.5% to center horizontally */
  transform: translate(-50%, -50%); /* Updated transform to center properly */
  position: fixed; /* Changed from absolute to fixed for consistent positioning */
  overflow: hidden;
}

.menu-container {
  position: relative;
  display: flex;
  gap: 20px;
  z-index: 1000;
}

.menu-panel {
  position: relative;
  width: 440px;
  background: var(--menu-bg);
  border-radius: 20px;
  overflow: hidden;
  isolation: isolate;
  
  &::before {
    content: '';
    position: absolute;
    inset: 0;
    border-radius: inherit;
    z-index: -1;
  }
}

.animated-bg {
  position: absolute;
  inset: 0;
  overflow: hidden;
  opacity: 0.5;
  border-radius: inherit;
  background: var(--menu-bg);
  
  .bg-gradient {
    position: absolute;
    inset: -50%;
    background: conic-gradient(
      from 0deg at 50% 50%,
      var(--accent),
      rgba(255,255,255,0.1),
      var(--accent)
    );
    animation: rotate 15s linear infinite;
  }
  
  .bg-pattern {
    position: absolute;
    inset: 1px;
    background: var(--menu-bg);
    border-radius: inherit;
  }
}

@keyframes rotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
</style>
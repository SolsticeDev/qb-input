<template>
    <form @submit.prevent="handleSubmit" class="input-form">
      <div class="form-header">
        {{ formData.header || 'Form Title' }}
      </div>
      
      <div class="form-fields">
        <form-field
          v-for="(input, index) in formData.inputs"
          :key="index"
          :field="input"
          @update:value="updateValue"
        />
      </div>
      
      <div class="form-footer">
        <button type="submit" class="submit-btn">
          {{ formData.submitText || 'Submit' }}
        </button>
      </div>
    </form>
  </template>
  
  <script setup>
  import { ref } from 'vue'
  import FormField from './FormField.vue'
  
  const props = defineProps({
    formData: {
      type: Object,
      required: true
    }
  })
  
  const emit = defineEmits(['submit', 'cancel'])
  const formValues = ref({})
  
  const updateValue = (name, value) => {
    formValues.value[name] = value
  }
  
  const handleSubmit = () => {
    emit('submit', formValues.value)
  }
  </script>
  
  <style lang="scss">
  .input-form {
    position: relative;
    padding: 1.5rem;
    z-index: 1;
    
    .form-header {
      text-align: center;
      color: var(--text);
      font-size: 1.2rem;
      font-weight: 700;
      margin-bottom: 1.5rem;
      padding: 0.5rem;
      background: var(--item-bg);
      border-radius: 10px;
      border: 1px solid var(--border);
    }
    
    .form-fields {
      display: flex;
      flex-direction: column;
      gap: 1rem;
      margin-bottom: 1.5rem;
    }
    
    .form-footer {
      .submit-btn {
        width: 100%;
        padding: 1rem;
        background: var(--accent);
        border: none;
        border-radius: 10px;
        color: var(--text);
        font-family: inherit;
        font-size: 1rem;
        cursor: pointer;
        transition: var(--transition);
        
        &:hover {
          background: rgba(220, 20, 60, 0.8);
          transform: translateY(-2px);
        }
      }
    }
  }
  </style>
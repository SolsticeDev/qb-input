<template>
    <div class="form-field" :class="field.type">
      <input
        v-if="['text', 'password', 'number', 'color'].includes(field.type)"
        :type="field.type"
        :name="field.name"
        :placeholder="field.text"
        :value="field.default"
        :required="field.isRequired"
        @input="handleInput"
        class="field-input"
      />
      
      <div v-else-if="field.type === 'radio'" class="radio-group">
        <div class="group-title">{{ field.text }}</div>
        <label v-for="option in field.options" :key="option.value" class="radio-label">
          <input
            type="radio"
            :name="field.name"
            :value="option.value"
            :checked="field.default === option.value"
            @change="handleInput"
          />
          {{ option.text }}
        </label>
      </div>
      
      <div v-else-if="field.type === 'checkbox'" class="checkbox-group">
        <div class="group-title">{{ field.text }}</div>
        <label v-for="option in field.options" :key="option.value" class="checkbox-label">
          <input
            type="checkbox"
            :name="field.name"
            :value="option.value"
            :checked="option.checked"
            @change="handleCheckbox"
          />
          {{ option.text }}
        </label>
      </div>
      
      <select
        v-else-if="field.type === 'select'"
        :name="field.name"
        @change="handleInput"
        class="field-select"
      >
        <option
          v-for="option in field.options"
          :key="option.value"
          :value="option.value"
          :selected="field.default === option.value"
        >
          {{ option.text }}
        </option>
      </select>
    </div>
  </template>
  
  <script setup>
  const props = defineProps({
    field: {
      type: Object,
      required: true
    }
  })
  
  const emit = defineEmits(['update:value'])
  
  const handleInput = (event) => {
    emit('update:value', event.target.name, event.target.value)
  }
  
  const handleCheckbox = (event) => {
    emit('update:value', event.target.value, event.target.checked ? 'true' : 'false')
  }
  </script>
  
  <style lang="scss">
  .form-field {
    position: relative;
    
    .field-input,
    .field-select {
      width: 100%;
      padding: 0.8rem 1rem;
      background: var(--item-bg);
      border: 1px solid var(--border);
      border-radius: 10px;
      color: var(--text);
      font-family: inherit;
      transition: var(--transition);
      
      &:focus {
        outline: none;
        border-color: var(--accent);
        box-shadow: 0 0 0 2px var(--accent-glow);
      }
    }
  }
  
  .radio-group,
  .checkbox-group {
    background: var(--item-bg);
    border: 1px solid var(--border);
    border-radius: 10px;
    padding: 1rem;
    
    .group-title {
      color: var(--text);
      margin-bottom: 0.5rem;
      font-size: 0.9rem;
    }
    
    label {
      display: block;
      color: var(--text-secondary);
      margin: 0.5rem 0;
      cursor: pointer;
      transition: var(--transition);
      
      &:hover {
        color: var(--text);
      }
      
      input {
        margin-right: 0.5rem;
      }
    }
  }
  
  input[type="radio"],
  input[type="checkbox"] {
    accent-color: var(--accent);
    cursor: pointer;
  }
  
  input[type="color"] {
    height: 50px;
    padding: 5px;
    
    &::-webkit-color-swatch-wrapper {
      padding: 0;
    }
    
    &::-webkit-color-swatch {
      border: none;
      border-radius: 8px;
    }
  }
</style>

<script setup>
import { ref } from 'vue'
import { ElCard, ElCalendar, ElTimeline, ElTimelineItem } from 'element-plus'

// Datos de resumen ficticios
const summaryItems = ref([
  { title: 'Total de Pedidos', value: '150' },
  { title: 'Usuarios Registrados', value: '500' },
  { title: 'Ganancias Totales', value: '$25,000' },
  // Agrega más elementos de resumen según tus necesidades
])

// Fecha seleccionada para el calendario
const calendarDate = ref(new Date())

// Datos ficticios de usuarios en línea
const onlineUsers = ref([
  { name: 'Usuario 1', lastActive: '2024-05-18 10:30:00' },
  { name: 'Usuario 2', lastActive: '2024-05-18 11:15:00' },
  { name: 'Usuario 3', lastActive: '2024-05-18 12:00:00' }
])
</script>
<template>
    <div class="admin-home">
      <h1>Bienvenido al Panel de Administración</h1>
      
      <!-- Sección de resumen con animación de entrada -->
      <transition-group name="fade" tag="div" class="summary-section">
        <div v-for="(item, index) in summaryItems" :key="index" class="summary-item">
          <h2>{{ item.title }}</h2>
          <p>{{ item.value }}</p>
        </div>
      </transition-group>
  
      <!-- Componente de diagrama -->
      <el-card class="diagram-card">
        <h2 slot="header">Diagrama de Estadísticas</h2>
       
      </el-card>
  
      <!-- Componente de calendario -->
      <el-card class="calendar-card">
        <h2 slot="header">Calendario de Eventos</h2>
        <el-calendar v-model="calendarDate" :first-day-of-week="1" />
      </el-card>
  
    </div>
  </template>
  
  
  <style scoped>
  .admin-home {
    text-align: center;
    padding: 20px;
  }
  
  .fade-enter-active, .fade-leave-active {
    transition: opacity 0.5s;
  }
  .fade-enter, .fade-leave-to {
    opacity: 0;
  }
  
  .summary-section {
    display: flex;
    justify-content: space-around;
    margin-top: 50px;
  }
  
  .summary-item {
    width: 200px;
    border: 1px solid #ccc;
    padding: 20px;
  }
  
  .diagram-card, .calendar-card, .online-time-card {
    max-width: 80%;
    margin-top: 50px;
  }
  
  .stats-diagram {
    width: 100%;
  }
  </style>
  
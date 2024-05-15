<script setup>
import {
    Edit,
    Delete,
    View
} from '@element-plus/icons-vue'
const orders = ref([
    {
        "id":1,
        "userId":1,
        "total":1000,
        "status":"PENDING",
        "createdAt": "2022-01-01T00:00:00.000Z"
    },{
        "id":2,
        "userId":1,
        "total":1000,
        "status" :"SHIPPED",
        "createdAt": "2024-01-01T00:00:00.000Z"
    },{
        "id":3,
        "userId":3,
        "total":1000,
        "status" :"CANCELLED",
        "createdAt": "2023-01-01T00:00:00.000Z"
    }
])
import { ref } from 'vue'
import { orderListService } from '@/api/order.js';
const orderList = async () => {
    let result = await orderListService();
    orders.value = result.data;
}

const orderModel = ref({
    id: '',
    userId: '',
    total: '',
    status: '',
    createdAt: ''
})
// Agregar categoría a la base de datos y cerrar el dialogo
import { ElMessage,ElMessageBox } from 'element-plus';
</script>
<template>
    <el-card class="page-container">
            <template #header>
                <span>Gestión de pedidos</span>
            </template>
            <el-table :data="orders" style="width: 100%">
                <el-table-column prop="id" label="ID" width="100" />
                <el-table-column prop="userId" label="Usuario" />
                <el-table-column prop="total" label="Total" />
                <el-table-column prop="status" label="Estado" />
                <el-table-column prop="createdAt" label="Fecha" />
                <el-table-column label="Acciones" width="150">
                <template #default ="{ row }">
                    <el-button :icon="View" circle plain type="primary" ></el-button>
                    <el-button :icon="Edit" circle plain type="primary" ></el-button>
                    <el-button :icon="Delete" circle plain type="danger"></el-button>

                </template>
            </el-table-column>
                <template #empty>
                    <el-empty description="No hay datos" />
                </template>
            </el-table>
        </el-card>
</template>
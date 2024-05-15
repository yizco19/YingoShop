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

const users = ref([])
const items = ref({})
const products= ref({})

import { ref } from 'vue'
import { orderListService,orderItemList } from '@/api/order.js';
import { userListService } from '@/api/user.js';
import { productListAllService } from '@/api/product.js';
const productList = async () => {
    let result = await productListService();
    products.value = result.data;
}


const userList = async () => {
    let result = await userListService();
    users.value = result.data;
}
const orderList = async () => {
    let result = await orderListService();
    orders.value = result.data;

    // agregar al orders userName
    for (let i = 0; i < orders.value.length; i++) {
        let order = orders.value[i];
        for (let j = 0; j < users.value.length; j++) {
            let user = users.value[j];
            if (order.userId === user.id) {
                order.userName = user.userName
            }
        }
    }
}
const itemList = async (id) => {
    let result = await orderItemList(id);
    items.value = result.data;

}
userList();
orderList();
productList();
const orderModel = ref({
    id: '',
    userName: '',
    total: '',
    status: '',
    createdAt: '',
    items: [
        {
            productId: '',
            productPic: '',
            productName: '',
            quantity: ''
        }
    ]
})
// Visible del Drawer
const visibleDrawer = ref(false)
// Agregar categoría a la base de datos y cerrar el dialogo
import { ElMessage,ElMessageBox } from 'element-plus';

const showDialog = (row) => {
    itemList (row.id);
    orderModel.value.id = row.id
    orderModel.value.userName = row.userName
    orderModel.value.total = row.total
    orderModel.value.status = row.status
    orderModel.value.createdAt = row.createdAt
    visibleDrawer.value = true
    for(let i = 0; i < items.value.length; i++){
        for(let j = 0; j < products.value.length; j++){
            if(items.value[i].productId === products.value[j].id){
                items.value[i].productId = products.value[j].id
                items.value[i].productName = products.value[j].name
                items.value[i].productPic = products.value[j].productPic
                items.value[i].quantity = items.value[i].quantity
            }
        }

    }

}
const actionExit =() => {
    visibleDrawer.value = false
}
</script>
<template>
    <el-card class="page-container">
            <template #header>
                <span>Gestión de pedidos</span>
            </template>
            <el-table :data="orders" style="width: 100%">
                <el-table-column prop="id" label="ID" width="100" />
                <el-table-column prop="userName" label="Usuario" />
                <el-table-column prop="total" label="Total" />
                <el-table-column prop="status" label="Estado" />
                <el-table-column prop="createdAt" label="Fecha" />
                <el-table-column label="Acciones" width="150">
                <template #default ="{ row }">
                    <el-button :icon="View" circle plain type="primary" @click="showDialog(row)" ></el-button>
                    <el-button :icon="Edit" circle plain type="primary" ></el-button>
                    <el-button :icon="Delete" circle plain type="danger"></el-button>

                </template>
            </el-table-column>
                <template #empty>
                    <el-empty description="No hay datos" />
                </template>
            </el-table>
            <!-- dialogo  drawer -->
            <el-drawer v-model="visibleDrawer" title="Detalles del pedido" direction="rtl" size="80%">
                <!-- datalles de la orden -->
                <el-descriptions title="Detalles de la orden">
                    <el-descriptions-item label="ID">{{ orderModel.id }}</el-descriptions-item>
                    <el-descriptions-item label="Usuario">{{ orderModel.userName }}</el-descriptions-item>
                    <el-descriptions-item label="Total">{{ orderModel.total }}</el-descriptions-item>
                    <el-descriptions-item label="Estado">{{ orderModel.status }}</el-descriptions-item>
                    <el-descriptions-item label="Fecha">{{ orderModel.createdAt }}</el-descriptions-item>
                </el-descriptions>
                    
                <!-- items de la orden -->
                <el-table :data="items" style="width: 100%">
                    <el-table-column prop="productId" label="ID" width="100" />
                    <el-table-column prop="productName" label="Nombre" />
                    <el-table-column prop="productPic" label="Image">
                        <el-image style="width: 100px; height: 100px" :src="productPic" :preview-src-list="[productPic]" />
                    </el-table-column>
                    <el-table-column prop="quantity" label="Quantity" />
                </el-table>
            </el-drawer>
            <el-form-item>
          <el-button type="primary" @click="actionExit()">Salir</el-button>
        </el-form-item>
        </el-card>

</template>
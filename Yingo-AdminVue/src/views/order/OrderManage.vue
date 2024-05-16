<script setup>
import {
    Edit,
    Delete,
    View
} from '@element-plus/icons-vue'

import { ElMessage,ElMessageBox } from 'element-plus';
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
const items = ref([])
const products= ref({})
const statusOptions = [ // Opciones para el select de estado
    { label: 'PENDING', value: 'PENDING' },
    { label: 'PROCESSING', value: 'PROCESSING' },
    { label: 'SHIPPED', value: 'SHIPPED' },
    { label: 'DELIVERED', value: 'DELIVERED' },
    { label: 'CANCELLED', value: 'CANCELLED' },
];
const getStatusText = (statusNumber) => {
    switch (statusNumber) {
        case OrderConstant.PENDING:
            return 'PENDING';
        case OrderConstant.PROCESSING:
            return 'PROCESSING';
        case OrderConstant.SHIPPED:
            return 'SHIPPED';
        case OrderConstant.DELIVERED:
            return 'DELIVERED';
        case OrderConstant.CANCELLED:
            return 'CANCELLED';
        default:
            return 'UNKNOWN';
    }
}

import { ref } from 'vue'
import { orderListService,orderItemList ,orderDeleteService} from '@/api/order.js';
import { userListService } from '@/api/user.js';
import { productListAllService } from '@/api/product.js';
const productList = async () => {
    let result = await productListAllService();
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
        // cambia el formato de la fecha a YYYY-MM-DD
        const originalDate = order.createdAt;
        const formattedDate = originalDate.slice(0, 10);
        order.createdAt = formattedDate;

        // cambia status a texto
        order.status = getStatusText(order.status);

        for (let j = 0; j < users.value.length; j++) {
            let user = users.value[j];
            if (order.userId === user.id) {
                order.userName = user.nickname;
            }
        }
    }
};

const itemList = async (id) => {
    let result = await orderItemList(id);
    items.value = result.data;
    for(let i = 0; i < items.value.length; i++){
        console.log(items.value[i].productId)
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
userList();
orderList();
productList();
const orderModel = ref({
    id: '',
    userName: '',
    total: '',
    status: '',
    createdAt: ''
})
// Visible del Drawer
const visibleDrawer = ref(false)
// Visible del Dialog
const visibleDialog = ref(false)


const showDialog = (row) => {

    console.log(items.value);
    orderModel.value.id = row.id
    orderModel.value.userName = row.userName
    orderModel.value.total = row.total
    orderModel.value.status = row.status
    orderModel.value.createdAt = row.createdAt

    itemList (row.id);

    visibleDrawer.value = true

}
const actionExit =() => {
    visibleDrawer.value = false
}
const deleteOrder = (id) => {

    ElMessageBox.confirm(
        '¿Estas seguro de eliminar este pedido?',
        'Confirmar',
        {
            confirmButtonText: 'OK',
            cancelButtonText: 'Cancelar',
            type: 'warning',
        }
    )
        .then(async() => {
            let result = await orderDeleteService(id)
            ElMessage({
                type: 'success',
                message: 'Eliminado correctamente',
            })
            //Carga la lista de pedidos
            orderList()
        })
        .catch(() => {
            ElMessage({
                type: 'info',
                message: 'Cancelado',
            })
        })
}
const editStatus = (row) => {

    visibleDialog.value = true
    
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
                    <el-button :icon="Edit" circle plain type="primary" @click="editStatus(row)"></el-button>
                    <el-button :icon="Delete" circle plain type="danger" @click="deleteOrder(row.id)"></el-button>

                </template>
            </el-table-column>
                <template #empty>
                    <el-empty description="No hay datos" />
                </template>
            </el-table>
            <!-- dialogo  drawer -->
            <el-drawer v-model="visibleDrawer" title="Detalles del pedido" direction="rtl" size="80%">
                <!-- datalles de la orden -->
                <el-descriptions title="Información del pedido">
                    <el-descriptions-item label="ID">{{ orderModel.id }}</el-descriptions-item>
                    <el-descriptions-item label="Usuario">{{ orderModel.userName }}</el-descriptions-item>
                    <el-descriptions-item label="Total">{{ orderModel.total }}</el-descriptions-item>
                    <el-descriptions-item label="Estado">{{ orderModel.status }}</el-descriptions-item>
                    <el-descriptions-item label="Fecha">{{ orderModel.createdAt }}</el-descriptions-item>
                </el-descriptions>
                    
                <el-table :data="items" style="width: 70%">
                    <el-table-column prop="productId" label="ID" width="70" />
                    <el-table-column prop="productName" label="Nombre"  width="200" />
                    
                    <el-table-column label="Image" align="center">
    <template #default="{ row }">
        <img v-if="row.productPic" :src="row.productPic" class="avatar"  style="max-width: 200px; max-height: 200px;"/>
    </template>
</el-table-column>

                    <el-table-column prop="quantity" label="Cantidad" width="70" />
                </el-table>
                <el-form-item>
          <el-button type="primary" @click="actionExit()">Salir</el-button>
        </el-form-item>
            </el-drawer>
        <!-- Contenido del diálogo -->
        <el-dialog v-model="visibleDialog" title="Editar estado del pedido">
        <!-- Contenido del diálogo -->
        <el-form ref="editStatusForm" :model="editStatusForm" label-width="120px">
            <el-form-item label="Nuevo Estado">
                <el-select v-model="editStatusForm.newStatus" placeholder="Seleccione un estado">
                    <el-option v-for="(status, index) in statusOptions" :key="index" :label="status.label" :value="status.value"></el-option>
                </el-select>
            </el-form-item>
        </el-form>
        <!-- Botones de confirmación y cancelación -->
        <div slot="footer" class="dialog-footer">
            <el-button @click="visibleDialog = false">Cancelar</el-button>
            <el-button type="primary" @click="updateStatus">Confirmar</el-button>
        </div>
    </el-dialog>
        </el-card>


</template>

<style lang="scss" scoped>
.page-container {
  min-height: 100%;
  box-sizing: border-box;

  .header {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
}
</style>
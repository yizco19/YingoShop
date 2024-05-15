<script setup>
import { reactive } from 'vue'

import {
  Check,
  Delete,
  Edit,

} from '@element-plus/icons-vue'
//Lista de categorías
const categorys = ref([])
//Lista de Productos
const products = ref([])


// la id de la categoría seleccionada
const categoryId = ref('')
// la nombre de la producto seleccionada
const productName = ref('')

const onSubmit = () => {
  console.log('submit!')
}
import { ref } from 'vue'

// Modelo de datos para la barra de paginación
const pageNum = ref(1); // Página actual
const total = ref(20); // Total de elementos
const pageSize = ref(4); // Número de elementos por página


// Cuando el tamaño de página cambia, llama a esta función
const onSizeChange = (size) => {
  pageSize.value = size
  productList();
}

// Cuando el número de página actual cambia, llama a esta función
const onCurrentChange = (num) => {
  pageNum.value = num
  productList();
}


import { categoryListService } from '@/api/category.js'
const categoryList = async () => {
  let result = await categoryListService();
  categorys.value = result.data;
}



// Cargar productos
import { productListService ,productAddService,productUpdateService,productDeleteService} from '@/api/product.js'
const productList = async () => {
  let params = {
    pageNum: pageNum.value,
    pageSize: pageSize.value,
    productName: productName.value ? productName.value : null,
    categoryId: categoryId.value ? categoryId.value : null
  }
  let result = await productListService(params);

  total.value = result.data.total;
  products.value = result.data.items;

  // agregar al products categoryName
  for (let i = 0; i < products.value.length; i++) {
    let product = products.value[i];
    for (let j = 0; j < categorys.value.length; j++) {
      let category = categorys.value[j];
      if (product.categoryId === category.id) {
        product.categoryName = category.categoryName
      }
    }
  }

}
categoryList();
productList();
// Función para reiniciar el formulario
const resetForm = () => {
  categoryId.value = '';
  productName.value = '';
  productList();
}
import { Plus } from '@element-plus/icons-vue'
// Visible del Drawer
const visibleDrawer = ref(false)
// Formulario de producto
const productModel = ref({
  categoryId: '',
  name: '',
  description: '',
  productImg: '',
  price: '',
  visible: ''
})
import { QuillEditor } from '@vueup/vue-quill'
import '@vueup/vue-quill/dist/vue-quill.snow.css'

import { useTokenStore } from '@/store/token';
const tokenStore = useTokenStore()

//Función si la imagen se sube correctamente
const uploadSuccess = (result) => {
  productModel.value.productPic = result.data
  
}
const checkPrice = (rule, value, callback) => {
  // Comprobar si el valor es un número positivo
  if (value && isNaN(Number(value))) {
    callback(new Error('El precio debe ser un número'));
  } else if (value && Number(value) <= 0) {
    callback(new Error('El precio debe ser mayor que cero'));
  } else {
    callback(); // Validación exitosa
  }
};
const rules={
  price: [
    { required: true, message: 'Por favor ingrese el precio', trigger: 'blur' },
    {validator:checkPrice,trigger:'blur'}
  ]
}
import { ElMessage,ElMessageBox } from 'element-plus';
// Agregar producto a la base de datos y cerrar el dialogo
const addProduct = async() => {
  
  // Llamar a la API para enviar los datos al servidor
  let result = await productAddService(productModel.value)
  // Llamar a la API para cargar los datos

  ElMessage.success(result.msg ? result.msg : 'Producto agregado')

  // Cerrar el dialogo
  visibleDrawer.value = false
  productList()

}
const title = ref('Agregar producto')
//Muestra el formulario de edición
const showDialog = (row) => {
  title.value = 'Editar producto' ; 
  //Abrir el dialogo
  visibleDrawer.value = true
  //Insertar los datos
  productModel.value.id = row.id
  productModel.value.categoryId = row.categoryId
  productModel.value.name = row.name
  productModel.value.description = row.description
  productModel.value.price = row.price
  productModel.value.productPic = row.productPic
}
const updateProduct = async() => {
  console.log(productModel.value);
  let result = await productUpdateService(productModel.value)

  ElMessage.success(result.msg ? result.msg : 'Producto actualizado')
  productList()

}

const clearData = ()=>{
  productModel.value.categoryId = ''
  productModel.value.name = ''
  productModel.value.description = ''
  productModel.value.price = ''
  productModel.value.productPic = ''
}

const actionDialog = () => {
    if(title.value === 'Editar producto'){

      updateProduct();

    }else if(title.value === 'Agregar producto'){
      addProduct();
    }
    visibleDrawer.value = false
 
}

const deleteProduct = async(id) => {
  ElMessageBox.confirm(
    '¿Estás seguro de eliminar esta producto?',
    'Warning',
    {
      confirmButtonText: 'OK',
      cancelButtonText: 'Cancel',
      type: 'warning',
    }
  )
    .then(async() => {
        let result =await productDeleteService(id);
      ElMessage({
        type: 'success',
        message: 'Eliminado!',
      })
      // Cargar productos
      productList()


})
    .catch(() => {
      ElMessage({
        type: 'info',
        message: 'Cancelado',
      })
    })
}
</script>

<template>
  <el-card class="page-container">
    <template #header>
      <div class="header">
        <span>Gestión de Productos</span>
        <el-button type="primary" @click="visibleDrawer = true ; clearData()">Agregar producto</el-button>
      </div>
    </template>

    <!-- Formulario de consulta -->
    <el-form :inline="true" class="demo-form-inline">
      <el-form-item label="Nombre">
        <el-input v-model="productName" placeholder="Introduce el nombre" clearable />
      </el-form-item>

      <el-form-item label="Categoría">
        <el-select v-model="categoryId" placeholder="Selecciona Categoría" clearable style="width: 200px;">
          <el-option v-for="c in categorys" :key="c.id" :label="c.categoryName" :value="c.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="productList">Buscar</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="default" @click="resetForm">Reset</el-button>
      </el-form-item>
    </el-form>
    <!-- Tabla de datos -->
    <el-table :data="products" style="width: 100%">
      <el-table-column prop="name" label="Nombre" width="300" />
      <el-table-column prop="productPic" label="Image" />
      <el-table-column prop="categoryName" label="Categoria" />
      <el-table-column prop="price" label="Precio" />
      <el-table-column prop="visible" label="Visible" />
      <el-table-column label="change" width="150">
        <template #default="{ row }">
          <el-button :icon="Edit" circle plain type="primary" @click="showDialog(row)"></el-button>
          <el-button :icon="Delete" circle plain type="danger" @click="deleteProduct(row.id)"></el-button>
        </template>
      </el-table-column>
      <template #empty>
        <el-empty description="No hay datos" />
      </template>
    </el-table>
    <!-- barra de paginación -->
    <el-pagination v-model:current-page="pageNum" v-model:page-size="pageSize" :page-sizes="[3, 5, 10, 15]"
      layout="jumper, total, sizes, prev, pager, next" background :total="total" @size-change="onSizeChange"
      @current-change="onCurrentChange" style="margin-top: 20px; justify-content: flex-end" />
    <!-- Caja -->
    <el-drawer v-model="visibleDrawer" :title="title" direction="rtl" size="50%">
      <!-- Formulario de producto -->
      <el-form :model="productModel" label-width="100px" :rules="rules">
        <el-form-item label="Nombre">
          <el-input v-model="productModel.name" placeholder="Ingrese el nombre"></el-input>
        </el-form-item>
        <el-form-item label="Categoría" >
          <el-select placeholder="Selecciona Categoría" v-model="productModel.categoryId">
            <el-option v-for="c in categorys" :key="c.id" :label="c.categoryName" :value="c.id">
            </el-option>
          </el-select>
        </el-form-item>
      <el-form-item prop="price" label="Precio">
        <el-input v-model="productModel.price" type="number"  placeholder="Ingrese el precio" ></el-input>
        </el-form-item>
        <el-form-item label="Imagen">
          <!--
            auto-uploald: configuracion para subir imagenes automaticamente
            action: donde se suben las imagenes
            header: configuracion del encabezado
            on-success: cuando se sube correctamente
            on-error: cuando hay un error


          -->
          <el-upload class="avatar-uploader" :auto-upload="true" :show-file-list="false"
          action="/api/upload"
          name="file"
          :headers="{'Authorization': tokenStore.token}"
          :on-success="uploadSuccess"
          >
            <img v-if="productModel.productPic" :src="productModel.productPic" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon" >
              <Plus />
            </el-icon>
          </el-upload>
        </el-form-item>
        <el-form-item label="Descripción">
          <div class="editor">
            <quill-editor theme="snow" v-model:content="productModel.description" contentType="html">
            </quill-editor>
          </div>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="actionDialog()">Guardar</el-button>
          <el-button type="info" @click="visibleDrawer = false">Cancelar</el-button>
        </el-form-item>
      </el-form>
    </el-drawer>
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

/* Estilos de avatar */
.avatar-uploader {
  :deep() {
    .avatar {
      width: 80vh;
      height: fit-content;
      display: block;
    }

    .el-upload {
      border: 1px dashed var(--el-border-color);
      border-radius: 6px;
      cursor: pointer;
      position: relative;
      overflow: hidden;
      transition: var(--el-transition-duration-fast);
    }

    .el-upload:hover {
      border-color: var(--el-color-primary);
    }

    .el-icon.avatar-uploader-icon {
      font-size: 28px;
      color: #8c939d;
      width: 178px;
      height: 178px;
      text-align: center;
    }
  }
}

.editor {
  width: 100%;

  :deep(.ql-editor) {
    min-height: 200px;
  }
}
</style>
// importar request.js para hacer peticiones
import request from '@/utils/request'
// Ofrece API de Listado de Pedidos
export const orderListService = () => {
    //const tokenStore = useTokenStore();
    //return request.get('/category',{headers: {'Authorization':tokenStore.token}})
    
    return request.get('/order/admin/list')
}
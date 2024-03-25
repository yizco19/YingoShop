// importar request.js para hacer peticiones
import request from '@/utils/request'

// Ofrece API de registro
export const userRegisterService = (registerData) => {
    // urlSearchParams para construir la url con los datos
    const params = new URLSearchParams();
    for (const key in registerData) {
        params.append(key, registerData[key]);
    }
    return request.post('/user/register', params);
}

// Ofrece API de login
export const userLoginService = (loginData) => {
    // urlSearchParams para construir la url con los datos
    const params = new URLSearchParams();
    for (const key in loginData) {
        params.append(key, loginData[key]);
    }
    return request.post('/user/login', params);
}
import axios from 'axios'

const axiosInstance = axios.create({
  baseURL: process.env.VUE_APP_API_URL || 'https://v-sign-api.herokuapp.com'
})

export default axiosInstance

import APP_CONFIG from '../../../interfaces/app-config-interface';
import { executePOSTAPI } from '../../../utils/http-methods';
import { CONSTANTS } from '../../config/app-config';

const updateCartDataAPI: any = async (appConfig: APP_CONFIG, reqBody?: any, token?: any) => {
  let response: any;
  response = await executePOSTAPI(appConfig, 'update-customer-name-purity-api', reqBody, token);
  return response;
};
export default updateCartDataAPI;

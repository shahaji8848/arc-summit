import APP_CONFIG from '../../../interfaces/app-config-interface';
import { executePOSTAPI } from '../../../utils/http-methods';
import { CONSTANTS } from '../../config/app-config';

const updateCustNameAPI: any = async (appConfig: APP_CONFIG, reqBody?: any, token?: any) => {
  let response: any;
  const url = 'update-customer-name-api';
  response = await executePOSTAPI(appConfig, url, reqBody, token);
  return response;
};
export default updateCustNameAPI;

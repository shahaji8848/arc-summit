import APP_CONFIG from '../../../interfaces/app-config-interface';
import { callPostAPI } from '../../../utils/http-methods';
import { CONSTANTS } from '../../config/app-config';

const updateCustNameAPI: any = async (appConfig: APP_CONFIG, quotationId: any, token?: any, custName?: any) => {
  let response: any;
  let version = appConfig.version;
  const method = 'update_customer_name_for_cart';
  const entity = 'card';
  const apiSDKName = appConfig.app_name;

  const url = `${CONSTANTS.API_BASE_URL}${apiSDKName}?version=${version}&entity=${entity}&method=${method}&quotation_id=${quotationId}&customer_name=${custName}`;

  response = await callPostAPI(url, undefined, token);
  return response;
};
export default updateCustNameAPI;

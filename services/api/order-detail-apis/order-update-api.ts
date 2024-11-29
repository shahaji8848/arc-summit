import axios from 'axios';
import APP_CONFIG from '../../../interfaces/app-config-interface';
import { executeGETAPI, executePOSTAPI } from '../../../utils/http-methods';
import { CONSTANTS } from '../../config/app-config';

export const getUserPermissionsAPI = async (appConfig: APP_CONFIG, user: any, token: any) => {
  let additionalParams = { ...(user && { user }) };
  // Use executeGETAPI to handle GET Request logic
  const response = await executeGETAPI(
    appConfig,
    'user-permission-api',
    token,
    additionalParams // Pass additional parameters if needed
  );
  return response;
};

export const readyToDispatchApi: any = async (appConfig: APP_CONFIG, apiBody: any, token: any) => {
  const response = await executePOSTAPI(appConfig, 'ready-to-dispatch-api', apiBody, token);
  return response;
};

export const deleteOrderApi = async (appConfig: APP_CONFIG, apiBody: any, token: string) => {
  const response = await executePOSTAPI(appConfig, 'delete-order-api', apiBody, token);
  return response;
};

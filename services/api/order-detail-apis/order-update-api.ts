import APP_CONFIG from '../../../interfaces/app-config-interface';
import { executeGETAPI } from '../../../utils/http-methods';

export const getUserPermissions = async (appConfig: APP_CONFIG, name: any, token: any) => {
  let additionalParams = { ...(name && { name }) };
  // Use executeGETAPI to handle GET Request logic
  const response = await executeGETAPI(
    appConfig,
    'order-ready-to-dispatch-permission',
    token,
    additionalParams // Pass additional parameters if needed
  );
  return response;
};

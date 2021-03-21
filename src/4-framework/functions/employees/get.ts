import ioc from '#framework/ioc/inversify.config'
import { OutputBase } from '#adapter/outputBase'
import builder from '#framework/common/builder'
import { APIGatewayEvent, Handler } from 'aws-lambda';
import { IEmployeeController, IEmployeeControllerToken } from '#adapter/controllers/employeeController';

const employeeIdIsRequired = () => new OutputBase<any>({
  success: false,
  data: {},
  errors: {
    "code": "employeeIdIsRequired",
    "message": "Employee id is required"
  }
})

export const getEmployee: Handler = async (_event: APIGatewayEvent) => {
  console.log(`[I] INPUT DATA `,_event)
  const employeeId = _event.pathParameters!.employeeId
  if(!employeeId) {
    return employeeIdIsRequired
  }
  const employeeController = ioc.get<IEmployeeController>(IEmployeeControllerToken)
  const employee = await employeeController.get(employeeId)
  console.log(`OUTPUT DATA`, employee)
  return builder.response(employee)
}

exports.getEmployee = getEmployee
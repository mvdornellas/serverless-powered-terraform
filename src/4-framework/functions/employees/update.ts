import ioc from '#framework/ioc/inversify.config'
import builder from '#framework/common/builder'
import { APIGatewayEvent, Handler } from 'aws-lambda'
import parser from '#framework/common/parser'
import { IEmployeeController, IEmployeeControllerToken } from '#adapter/controllers/employeeController'
import { OutputBase } from '#adapter/outputBase'

const employeeIdIsRequired = () => new OutputBase<any>({
  success: false,
  data: {},
  errors: {
    'code': 'employeeIdIsRequired',
    'message': 'Employee id is required'
  }
})

export const updateEmployee: Handler = async (_event: APIGatewayEvent) => {
  console.log(`[I] INPUT DATA `,_event)
  const employeeId = _event.pathParameters!.employeeId
  if (!employeeId) {
    return employeeIdIsRequired
  }
  const body = parser.body(_event.body!)
  const employeeController = ioc.get<IEmployeeController>(IEmployeeControllerToken)
  const employee = await employeeController.update(employeeId, body)
  console.log(`OUTPUT DATA`, employee)
  return builder.response(employee)
}

exports.updateEmployee = updateEmployee

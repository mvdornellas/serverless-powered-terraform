import ioc from '#framework/ioc/inversify.config'
import builder from '#framework/common/builder'
import { APIGatewayEvent, Handler } from 'aws-lambda'
import parser from '#framework/common/parser'
import { IEmployeeController, IEmployeeControllerToken } from '#adapter/controllers/employeeController'

export const createEmployee: Handler = async (_event: APIGatewayEvent) => {
  console.log(`[I] INPUT DATA `,_event)
  const body = parser.body(_event.body!)
  const employeeController = ioc.get<IEmployeeController>(IEmployeeControllerToken)
  const employee = await employeeController.create(body)
  console.log(`OUTPUT DATA`, employee)
  return builder.response(employee)
}

exports.createEmployee = createEmployee

import builder from '#framework/common/builder'
import { APIGatewayEvent, Handler } from 'aws-lambda'
import { EmployeeController } from '#adapter/controllers/employeeController'
import parser from '#framework/common/parser'

export const createEmployee: Handler = async (_event: APIGatewayEvent) => {
  console.log(`[I] INPUT DATA `,_event)
  const body = parser.body(_event.body!)
  const employeeController = new EmployeeController()
  const employee = await employeeController.create(body)
  console.log(`OUTPUT DATA`, employee)
  return builder.response(employee)
}

exports.createEmployee = createEmployee

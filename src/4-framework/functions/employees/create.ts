import 'reflect-metadata'
import { OutputBase } from '#adapter/outputBase'
import builder from '#framework/common/builder'
import { APIGatewayEvent, Handler } from 'aws-lambda'

export const createEmployee: Handler = async (_event: APIGatewayEvent) => {
  return builder.response(new OutputBase<any>({
    data: { create: 'ok' }
  }))
}

exports.createEmployee = createEmployee

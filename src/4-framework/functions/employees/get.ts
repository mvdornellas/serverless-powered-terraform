import 'reflect-metadata'
import { OutputBase } from '#adapter/outputBase'
import builder from '#framework/common/builder'
import { APIGatewayEvent, Handler } from 'aws-lambda';

export const getEmployee: Handler = async (_event: APIGatewayEvent) => {
  return builder.response(new OutputBase<any>({
    data: { terraform: 'ok' }
  }))
}

exports.getEmployee = getEmployee
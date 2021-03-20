import 'reflect-metadata'
import { OutputBase } from '#adapter/outputBase'
import { APIGatewayEvent, Handler } from 'aws-lambda'
import builder from '#framework/common/builder'

export const handler: Handler = async (_event: APIGatewayEvent) => {
  return builder.response(new OutputBase<any>({
    data: { terraform: 'ok' }
  }))
}

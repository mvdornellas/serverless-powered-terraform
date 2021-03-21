import 'reflect-metadata'
import { EmployeeRepository } from '#framework/repositories/employeeRepository'
import { IEmployeeRepository, IEmployeeRepositoryToken } from '#application/repositories/iEmployeeRepository'
import { EmployeeController, IEmployeeController, IEmployeeControllerToken } from '#adapter/controllers/employeeController'
import { Container } from 'inversify'

let container = new Container()
container.bind<IEmployeeRepository>(IEmployeeRepositoryToken).to(EmployeeRepository)
container.bind<IEmployeeController>(IEmployeeControllerToken).to(EmployeeController)
export default container

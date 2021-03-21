import 'reflect-metadata'
import { injectable, inject } from 'inversify'
import { OutputBase } from '#adapter/outputBase'
import { Employee } from '#enterprise/entities/employee'
import { IEmployeeRepository, IEmployeeRepositoryToken } from '#application/repositories/iEmployeeRepository'
import { v4 as uuid } from 'uuid'

export interface IEmployeeController {
  create ({ name, age, role }: {
    name: string,
    age: number,
    role: string
  }): Promise<OutputBase<Employee>>

  update (id: string, { name, age, role }: {
    name: string,
    age: number,
    role: string
  }): Promise<OutputBase<Employee>>

  get (id: string): Promise<OutputBase<Employee>>

  delete (id: string): Promise<OutputBase<void>>
}

export const IEmployeeControllerToken = Symbol('IEmployeeController')

@injectable()
export class EmployeeController implements IEmployeeController {

  @inject(IEmployeeRepositoryToken) private employeeRepository!: IEmployeeRepository

  async create ({ name, age, role }: {
    name: string,
    age: number,
    role: string
  }): Promise<OutputBase<Employee>> {
    try {
      return new OutputBase<Employee>({
        data: await this.employeeRepository.create({
          id: uuid(),
          name,
          age,
          role
        } as Employee)
      })
    } catch (error) {
      return new OutputBase<Employee>({
        success: false,
        errors: JSON.stringify(error)
      })
    }
  }

  async update (id: string ,{ name, age, role }: {
    name: string,
    age: number,
    role: string
  }): Promise<OutputBase<Employee>> {
    try {
      return new OutputBase<Employee>({
        data: await this.employeeRepository.update({
          id,
          name,
          age,
          role
        } as Employee)
      })
    } catch (error) {
      return new OutputBase<Employee>({
        success: false,
        errors: JSON.stringify(error)
      })
    }
  }

  async get (id: string): Promise<OutputBase<Employee>> {
    try {
      return new OutputBase<Employee>({
        data: await this.employeeRepository.get(id)
      })
    } catch (error) {
      return new OutputBase<Employee>({
        success: false,
        errors: JSON.stringify(error)
      })
    }
  }

  async delete (id: string): Promise<OutputBase<void>> {
    try {
      return new OutputBase<Employee>({
        data: await this.employeeRepository.delete(id)
      })
    } catch (error) {
      return new OutputBase<Employee>({
        success: false,
        errors: JSON.stringify(error)
      })
    }
  }
}

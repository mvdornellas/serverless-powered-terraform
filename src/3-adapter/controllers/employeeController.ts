import { OutputBase } from '#adapter/outputBase'
import { Employee } from '#enterprise/entities/employee'
import { EmployeeRepository } from '#framework/repositories/employeeRepository'
import { v4 as uuid } from 'uuid'

export class EmployeeController {

  private readonly employeeRepository!: EmployeeRepository

  constructor () {
    this.employeeRepository = new EmployeeRepository()
  }

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
        data: await this.employeeRepository.create({
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

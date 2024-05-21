import pymysql
from sql_queries import create_queries, get_data_queries


if __name__ == "__main__":
    try:
        with (pymysql.connect(host='localhost', port=3306, user="root", password="", database="full_hospital_p312") as
              connection):
            print(connection, "ok")

            with connection.cursor() as cursor:
                # cursor.execute("""DROP DATABASE IF EXISTS full_hospital_p312""")
                while True:
                    print("-" * 100)
                    print("1. Создать базу данных с таблицами.")
                    print("2. get doctors and their specialization.")
                    print("3. get doctors and their salary.")
                    print("4. get wards from oncology.")
                    print("5. get departments with sponsors.")
                    print("6. get donates last month.")
                    print("7. get doctors departments examinations.")
                    print("8. get wards of Ronaldo.")
                    print("9. get departments and list of doctors with donations bigger than 100 000.")
                    print("10. get doctors with salary bigger than 100 000.")
                    print("11. get specializations which have diseases with severity more than 3.")
                    print("12. get departments and examinations on weekend.")
                    print("13. get_sponsors_patients")
                    print("0. Выход")
                    user_choice = input("Ваш выбор: ")
                    match user_choice:
                        case "0":
                            connection.close()
                            quit()
                        case "1":
                            create_queries.create_database(cursor, connection)
                        case "2":
                            get_data_queries.doctors_and_spezialization(cursor)
                        case "3":
                            get_data_queries.doctors_salary(cursor)
                        case "4":
                            get_data_queries.get_departments_wards(cursor)
                        case "5":
                            get_data_queries.get_departments_with_sponsors(cursor)
                        case "6":
                            get_data_queries.get_donations_last_month(cursor)
                        case "7":
                            get_data_queries.get_doctors_departments_examinations(cursor)
                        case "8":
                            get_data_queries.get_wards_of_doctor(cursor)
                        case "9":
                            get_data_queries.get_departments_with_donat_b_10000(cursor)
                        case "10":
                            get_data_queries.get_doctors_with_salary_b_50000(cursor)
                        case "11":
                            get_data_queries.get_specializations_with_severity_b_3(cursor)
                        case "12":
                            get_data_queries.get_departments_diseases_last_half_year(cursor)
                        case "13":
                            get_data_queries.get_sponsors_patients(cursor)
                        case _:
                            print("неизвестная команда.")

    except pymysql.Error as e:
        print(e)
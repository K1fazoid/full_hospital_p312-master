import pymysql


def doctors_and_spezialization(cursor):
    cursor.execute("""SELECT * FROM doctors_and_spezializations d_a_s
                      JOIN doctors d ON d_a_s.doctor_id = d.id
                      JOIN spezializations s ON s.id = d_a_s.spezialization_id                  
    """)
    for i in cursor:
        print(f"Имя: {i[3]}; фамилия: {i[4]};  специальность: {i[-1]}")


def doctors_salary(cursor):
    cursor.execute("""SELECT first_name, last_name, salary FROM doctors""")
    print("Имя\t\tФамилия\t\tЗарплата")
    for i in cursor:
        print(*i)


def get_departments_wards(cursor):
    cursor.execute("""SELECT ward_name, department_name FROM departments
                      JOIN wards  ON departments.id = wards.department_id
                      WHERE department_name = "Oncology"
    """)
    for i in cursor:
        print(*i, sep="; ")


def get_departments_with_sponsors(cursor):
    """
    4. Вывести названия отделений без повторений, которые
    спонсируются компанией “газпром”.
    """
    cursor.execute("""SELECT DISTINCT department_name FROM departments dep
                      JOIN donations don ON don.department_id = dep.id
                      JOIN sponsors sp ON sp.id = don.sponsor_id
                      WHERE sponsors_name = "PET"
    """)
    for i in cursor:
        print(*i, sep="; ")



def get_donations_last_month(cursor):
    """
    5. Вывести все пожертвования за последний месяц в
    виде: отделение, спонсор, сумма пожертвования, дата
    пожертвования.
    """
    cursor.execute("""SELECT department_name, sponsors_name, summ_donate, donate_date FROM donations don
                      JOIN sponsors sp ON sp.id = don.sponsor_id
                      JOIN departments dep ON dep.id = don.department_id  
                      WHERE donate_date >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
    """)
    for i in cursor:
        print(*i, sep="; ")


def get_doctors_departments_examinations(cursor):
    """
    6. Вывести фамилии врачей с указанием отделений, в
    которых они проводят обследования. Необходимо
    учитывать обследования, проводимые только в будние дни.
    """
    cursor.execute("""SELECT doc.last_name, dep.department_name FROM doctors doc
                      JOIN doctors_and_examinations d_a_e ON d_a_e.doctor_id = doc.id
                      JOIN examinations e ON e.id = d_a_e.examination_id  
                      JOIN departments dep ON dep.id = doc.department_id
                      WHERE day_of_week BETWEEN 1 AND 5
    """)
    for i in cursor:
        print(*i, sep="; ")


def get_wards_of_doctor(cursor):
    """
    Получить все палаты в том отделении, в котором работает "фамилия врача"
    """
    cursor.execute("""SELECT * FROM wards
                      WHERE wards.department_id IN 
                      (SELECT id FROM departments WHERE id IN 
                      (SELECT department_id FROM doctors WHERE last_name = "Ван Дер Линде"))
    """)
    for i in cursor:
        print(*i, sep="; ")


def get_departments_with_donat_b_10000(cursor):
    """
    Вывести названия отделений, которые получали пожертвование в размере больше 100000, с указанием
    их врачей.
    """
    cursor.execute("""SELECT department_name, first_name, last_name FROM departments dep
                      JOIN doctors doc ON doc.department_id = dep.id
                      JOIN donations don ON don.department_id = dep.id
                      WHERE summ_donate > 100000
                      GROUP BY department_name, first_name, last_name
    """)
    for i in cursor:
        print(*i, sep="; ")


def get_doctors_with_salary_b_50000(cursor):
    """
    9. Вывести врачей, с зарплатой больше 50 000
    """
    cursor.execute("""SELECT first_name, last_name, salary FROM doctors
                      WHERE salary > 50000
    """)
    for i in cursor:
        print(*i, sep="; ")


def get_specializations_with_severity_b_3(cursor):
    """
    Вывести названия специализаций, которые используются для
    лечения заболеваний со степенью тяжести выше 3.
    """
    cursor.execute("""SELECT name_of_spezialization, disease_name, severity FROM departments dep
                      JOIN diseases dis ON dis.department_id = dep.id
                      JOIN doctors doc ON doc.department_id = dep.id
                      JOIN doctors_and_spezializations d_a_s ON d_a_s.doctor_id = doc.id
                      JOIN spezializations sp ON sp.id = d_a_s.spezialization_id
                      WHERE severity > 3 
    """)
    for i in cursor:
        print(*i, sep="; ")


def get_departments_diseases_last_half_year(cursor):
    """
    11. Вывести названия отделений и названия заболеваний,
    обследования по которым они проводили по будням.
    """
    cursor.execute("""SELECT department_name, disease_name FROM departments dep
                      JOIN diseases dis ON dis.department_id = dep.id
                      JOIN doctors doc ON doc.department_id = dep.id
                      JOIN doctors_and_examinations d_a_e ON d_a_e.doctor_id = doc.id
                      JOIN examinations e ON e.id = d_a_e.examination_id
                      WHERE day_of_week BETWEEN 1 AND 5
    """)
    for i in cursor:
        print(*i, sep="; ")


def get_sponsors_patients(cursor):
    """
    13. Вывести названия спонсоров отделений, где лежит пациент,
    """

    fname = input("Введите имя пациента: ")
    lname = input("Введите фамилию пациента: ")
    string = f"""SELECT sponsors_name FROM sponsors
                      JOIN donations ON donations.sponsor_id = sponsors.id
                      JOIN departments ON departments.id = donations.department_id
                      JOIN wards ON wards.department_id = departments.id
                      JOIN patients par ON par.ward_id = wards.id
                      WHERE first_name = '{fname}' AND last_name='{lname}'
                    """

    cursor.execute(string)

    # """)
    for i in cursor:
        result_str = f"Отделение, где лечится {fname} {lname} спонсирует"
        print(result_str, *i)
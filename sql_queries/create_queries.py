def create_database(cursor, connection):
    cursor.execute("""CREATE DATABASE IF NOT EXISTS full_hospital_p312""")       # создание базы данных
    cursor.execute("""USE full_hospital_p312""")                                 # переключиться на созданную базу

    # отделения
    cursor.execute("""CREATE TABLE IF NOT EXISTS departments (
        id INT AUTO_INCREMENT PRIMARY KEY,
        building INT NOT NULL CHECK (building BETWEEN 1 AND 5),
        financing DECIMAL(10, 2) NOT NULL CHECK(financing >= 0),
        department_name TEXT NOT NULL UNIQUE 
    )""")

    # болезни
    cursor.execute("""CREATE TABLE IF NOT EXISTS diseases (
        id INT AUTO_INCREMENT PRIMARY KEY,
        severity INT NOT NULL DEFAULT 1 CHECK (severity >= 0),
        disease_name VARCHAR(100) NOT NULL UNIQUE,
        department_id INT,
        FOREIGN KEY(department_id) REFERENCES departments(id) 
    )""")

    # врачи
    cursor.execute("""CREATE TABLE IF NOT EXISTS doctors (
        id INT AUTO_INCREMENT PRIMARY KEY,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        phone VARCHAR(15) NOT NULL,
        salary DECIMAL(10, 2) NOT NULL CHECK (salary > 0),
        department_id INT,
        FOREIGN KEY(department_id) REFERENCES departments(id) 
    )""")



    # обследования
    cursor.execute("""CREATE TABLE IF NOT EXISTS examinations (
            id INT AUTO_INCREMENT PRIMARY KEY,
            examinations_name VARCHAR(100) NOT NULL UNIQUE,
            day_of_week INT NOT NULL CHECK (day_of_week BETWEEN 1 AND 7),
            start_time TIME NOT NULL CHECK (start_time >= '08:00:00' AND start_time < '18:00:00'),
            end_time TIME NOT NULL CHECK (end_time > start_time)
        )""")

    # палаты
    cursor.execute("""CREATE TABLE IF NOT EXISTS wards (
                id INT AUTO_INCREMENT PRIMARY KEY,
                ward_name VARCHAR(100) NOT NULL UNIQUE,
                floor INT NOT NULL CHECK (floor >= -1),
                department_id INT,
                FOREIGN KEY(department_id) REFERENCES departments(id)
            )""")
    # пациенты
    cursor.execute("""CREATE TABLE IF NOT EXISTS patients (
            id INT AUTO_INCREMENT PRIMARY KEY,
            first_name VARCHAR(100) NOT NULL,
            last_name VARCHAR(100) NOT NULL,
            birthday DATE NOT NULL,
            date_of_receipt DATE NOT NULL,
            ward_id INT,
            FOREIGN KEY(ward_id) REFERENCES wards(id) 
        )""")

    # связь многие ко многим (доктора и исследования)
    cursor.execute("""CREATE TABLE IF NOT EXISTS doctors_and_examinations (
                doctor_id INT,
                examination_id INT,
                PRIMARY KEY(doctor_id, examination_id),
                FOREIGN KEY(doctor_id) REFERENCES doctors(id),
                FOREIGN KEY(examination_id) REFERENCES examinations(id)
            )""")

    # отпуска
    cursor.execute("""CREATE TABLE IF NOT EXISTS vacations (
                id INT AUTO_INCREMENT PRIMARY KEY,
                start_date DATE NOT NULL,
                end_date DATE NOT NULL CHECK (end_date > start_date),
                doctor_id INT,
                FOREIGN KEY(doctor_id) REFERENCES doctors(id)
            )""")

    # специализации
    cursor.execute("""CREATE TABLE IF NOT EXISTS spezializations (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    name_of_spezialization VARCHAR(100) NOT NULL UNIQUE
                )""")


    # доктора и специализации (многие ко многим)
    cursor.execute("""CREATE TABLE IF NOT EXISTS doctors_and_spezializations (
                    doctor_id INT,
                    spezialization_id INT,
                    PRIMARY KEY(doctor_id, spezialization_id),
                    FOREIGN KEY(doctor_id) REFERENCES doctors(id),
                    FOREIGN KEY(spezialization_id) REFERENCES spezializations(id)
                )""")

    # спонсоры
    cursor.execute("""CREATE TABLE IF NOT EXISTS sponsors (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    sponsors_name VARCHAR(100) NOT NULL UNIQUE
                )""")


    # пожертвования
    cursor.execute("""CREATE TABLE IF NOT EXISTS donations (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    summ_donate DECIMAL(10,2) NOT NULL CHECK (summ_donate > 0),
                    donate_date DATE NOT NULL,
                    sponsor_id INT,
                    department_id INT,
                    FOREIGN KEY(sponsor_id) REFERENCES sponsors(id),
                    FOREIGN KEY(department_id) REFERENCES departments(id)
                )""")

    # пациенты и врачи (многие ко многим)
    cursor.execute("""CREATE TABLE IF NOT EXISTS patient_and_doctors (
                        patient_id INT,
                        doctor_id INT,
                        PRIMARY KEY(patient_id, doctor_id),
                        FOREIGN KEY(doctor_id) REFERENCES doctors(id),
                        FOREIGN KEY(patient_id) REFERENCES patients(id)
                    )""")

    # пациенты и болезни (многие ко многим)
    cursor.execute("""CREATE TABLE IF NOT EXISTS patient_and_diseases (
                        patient_id INT,
                        disease_id INT,
                        PRIMARY KEY(patient_id, disease_id),
                        FOREIGN KEY(disease_id) REFERENCES diseases(id),
                        FOREIGN KEY(patient_id) REFERENCES patients(id)
                    )""")

    # пациенты и обследования (многие ко многим)
    cursor.execute("""CREATE TABLE IF NOT EXISTS patient_and_examinations (
                        patient_id INT,
                        examination_id INT,
                        PRIMARY KEY(patient_id, examination_id),
                        FOREIGN KEY(examination_id) REFERENCES examinations(id),
                        FOREIGN KEY(patient_id) REFERENCES patients(id)
                    )""")




    print("База данных про госпиталь со всеми таблицами добавлена.")
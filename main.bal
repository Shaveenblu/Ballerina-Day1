
import ballerina/http;

service / on new http:Listener(8080) {
    resource function get .() returns string {
        return "Hello world!";
    }

    resource function get name/[string name] () returns string {
        return name;
    }

    resource function post jsonEcho(@http:Payload json j) returns json => j;

    resource function post bumpGrades(@http:Payload Student student) returns json {
        string name = student.name;
        int[] newGrades = student.Grades.map((i) => int:min(i + 10, 100));
        int sum = 0;
        foreach var i in newGrades {
            sum += i;
        }
        int avg = sum / newGrades.length();

        return { name: name, Grades: newGrades, Average: avg };
    }


}

type Student record {
    string name;
    int[] Grades;
};

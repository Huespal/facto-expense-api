# Adds default users.
# Adds an admin and an employee user for three Tenants.

User.find_or_create_by!(
  username: "admin-espardenya", password: "1234",
  role: "admin", tenant_id: "1")

User.find_or_create_by!(
  username: "employee-espardenya", password: "1234",
  role: "employee", tenant_id: "1"
)

User.find_or_create_by!(
  username: "admin-rodamons", password: "1234",
  role: "admin", tenant_id: "2")

User.find_or_create_by!(
  username: "employee-rodamons", password: "1234",
  role: "employee", tenant_id: "2"
)

User.find_or_create_by!(
  username: "admin-excursionistes", password: "1234",
  role: "admin", tenant_id: "3")

User.find_or_create_by!(
  username: "employee-excursionistes", password: "1234",
  role: "employee", tenant_id: "3"
)

roles = [
  { name: 'Administrador', role: 2 },
  { name: 'Empleado', role: 0 },
  { name: 'Gerente', role: 1 }
]

User.create!(
  email: "administrador1@example.com",
  username: "administrador_user1",
  phone: "1234567800",
  role: 2,
  password: 'Proyecto2024.ruby',
  password_confirmation: 'Proyecto2024.ruby'
)

User.create!(
  email: "empleado1@example.com",
  username: "empleado_user1",
  phone: "1234567801",
  role: 0,
  password: 'Proyecto2024.ruby',
  password_confirmation: 'Proyecto2024.ruby'
)

User.create!(
  email: "gerente1@example.com",
  username: "gerente_user1",
  phone: "1234567802",
  role: 1,
  password: 'Proyecto2024.ruby',
  password_confirmation: 'Proyecto2024.ruby'
)

47.times do |i|
  role = roles.sample

  User.create!(
    email: "#{role[:name].downcase}#{i + 4}@example.com",
    username: "#{role[:name].downcase}_user#{i + 4}",
    phone: "12345678#{format('%02d', i + 3)}",
    role: role[:role],
    password: 'Proyecto2024.ruby',
    password_confirmation: 'Proyecto2024.ruby'
  )
end
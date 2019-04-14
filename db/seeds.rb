unless Author.exists?
  Author.create(
    name: "J.K. Rowling",
    biography: "Joanne Kathleen Rowling atau lebih dikenal sebagai J.K. Rowling (lahir di Yate, Gloucestershire Utara, Inggris, 31 Juli 1965; umur 53 tahun). Sebagai seorang ibu tunggal yang tinggal di Edinburgh, Skotlandia, Rowling menjadi sorotan kesusasteraan internasional pada tahun 1999 saat tiga seri pertama novel remaja Harry Potter mengambil alih tiga tempat teratas dalam daftar New York Times best-seller setelah memperoleh kemenangan yang sama di Britania Raya. Kekayaan Rowling semakin bertambah saat seri ke-4, Harry Potter dan Piala Api diterbitkan pada bulan Juli tahun 2000. Seri ini menjadi buku paling laris penjualannya dalam sejarah."
  )
end

unless Author.exists?
  Author.create(
    name: "Finance",
    description: "All books about financial."
  )
end

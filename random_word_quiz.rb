require 'csv'
puts "Masukan nama file csv kumpulan kata yang akan menjadi soal anda :"
nama_file_soal = gets.chomp
begin
  csv_soal = File.open("./#{nama_file_soal}.csv")
  puts "Pilih level bermain anda : "
  level = gets.chomp
  if !level.nil?
    if level.to_i > 5 || level.to_i < 0
      puts "Level hanya tersedia 1 - 5"
    else
      semua_soal = CSV.parse(csv_soal).map {|soal| soal.first}
      if semua_soal.length > 15
        puts "Anda bermain pada level #{level.to_i}"
        level = level.to_i * 3
        puts "Anda menang jika poin anda mencapai #{level} poin"
        poin = 0
        while poin < level
          index_soal = rand(semua_soal.length)
          soal_sekarang = semua_soal[index_soal].split("").shuffle.join
          puts "Tebak kata: #{soal_sekarang}"
          puts "Jawab: "
          jawaban_user = gets.chomp
          if semua_soal[index_soal] == jawaban_user
            poin += 1
            puts "BENAR! Poin anda : #{poin}"
          else
            puts "SALAH! Silahkan coba kembali"
          end
        end
        if poin == level
          puts "Anda berhasil menang, SELAMAT!"
        end
      else
        puts "Minimum Jumlah Soal 15"
      end
    end
  end
rescue Errno::ENOENT => e
  puts "File tidak ditemukan, pastikan file berformat csv"
rescue ZeroDivisionError => e
  puts "Harap masukan angka 1 sampai 5 sebagai level bermain anda"
end

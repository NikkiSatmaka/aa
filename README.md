# Cara Remove & Restore Constraint Otomatis

Berikut adalah cara untuk menghapus (remove) constraints pada sebuah tabel di PostgreSQL sekaligus membuat backup, serta cara untuk merestorenya:

### 1. Remove Constraints dan Backup

Gunakan perintah berikut untuk menghapus constraints pada sebuah tabel tertentu di dalam schema tertentu. Proses ini juga akan membuat backup dari constraints yang dihapus.

```sql
SELECT remove_constraints_and_backup('nama_schema', 'nama_table');
```

### 2. Restore Constraints

Gunakan perintah berikut untuk merestore constraints yang telah dihapus sebelumnya menggunakan perintah di atas:

```sql
SELECT restore_constraints('nama_schema', 'nama_table');
```

### Catatan

- Pastikan fungsi `remove_constraints_and_backup` dan `restore_constraints` telah didefinisikan di dalam database PostgreSQL Anda.
- Ganti `nama_schema` dengan nama schema Anda dan `nama_table` dengan nama tabel yang sesuai.

--- 

Tambahkan detail tambahan tentang penggunaan fungsi ini atau cara setup-nya jika diperlukan!

--- 
by agus sedih

class CreateUsers < ActiveRecord::Migration[5.0]
  def change # метод change определяющий изменения которые необходимо внести в базу данных
    create_table :users do |t| # метод create_table - принимает блок t (table)
      t.string :name
      t.string :email

      t.timestamps # специальной командой, которая создает два волшебных столбца, называемые created_at и updated_at
    end
  end
end

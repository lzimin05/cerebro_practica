#ifndef CHIPMODEL_H
#define CHIPMODEL_H

#include <QAbstractListModel>
#include <QStringList>

class ChipModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged)

public:
    enum ChipRoles {
        TextRole = Qt::UserRole + 1
    };

    explicit ChipModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addChip(const QString &text);
    Q_INVOKABLE void removeChip(int index);
    Q_INVOKABLE void clear();

signals:
    void countChanged();

private:
    QStringList m_chips;
};


#endif // CHIPMODEL_H

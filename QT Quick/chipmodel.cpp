#include "chipmodel.h"

ChipModel::ChipModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int ChipModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_chips.size();
}

QVariant ChipModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_chips.size())
        return QVariant();

    if (role == TextRole)
        return m_chips.at(index.row());

    return QVariant();
}

QHash<int, QByteArray> ChipModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TextRole] = "text";
    return roles;
}

void ChipModel::addChip(const QString &text)
{
    if (text.isEmpty())
        return;

    beginInsertRows(QModelIndex(), m_chips.size(), m_chips.size());
    m_chips.append(text);
    endInsertRows();
    emit countChanged();
}

void ChipModel::removeChip(int index)
{
    if (index < 0 || index >= m_chips.size())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    m_chips.removeAt(index);
    endRemoveRows();
    emit countChanged();
}

void ChipModel::clear()
{
    if (m_chips.isEmpty())
        return;

    beginResetModel();
    m_chips.clear();
    endResetModel();
    emit countChanged();
}

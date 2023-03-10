"""empty message

Revision ID: cf04df649ca5
Revises: 087f7a59e956
Create Date: 2023-02-26 20:08:28.866838

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'cf04df649ca5'
down_revision = '087f7a59e956'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('drinksToTemp',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('drink', sa.String(length=50), nullable=True),
    sa.Column('drinkId', sa.Integer(), nullable=True),
    sa.Column('temp', sa.String(length=50), nullable=True),
    sa.Column('tempId', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['tempId'], ['temp.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_drinksToTemp_drink'), 'drinksToTemp', ['drink'], unique=False)
    op.create_index(op.f('ix_drinksToTemp_drinkId'), 'drinksToTemp', ['drinkId'], unique=False)
    op.create_index(op.f('ix_drinksToTemp_temp'), 'drinksToTemp', ['temp'], unique=False)
    op.create_index(op.f('ix_drinksToTemp_tempId'), 'drinksToTemp', ['tempId'], unique=False)
    op.alter_column('HalfCaf', 'acc_order',
               existing_type=mysql.TINYINT(display_width=1),
               type_=sa.Boolean(),
               existing_nullable=True)
    op.alter_column('drink', 'decaf',
               existing_type=mysql.TINYINT(display_width=1),
               type_=sa.Boolean(),
               existing_nullable=True)
    op.alter_column('favoriteDrinks', 'decaf',
               existing_type=mysql.TINYINT(display_width=1),
               type_=sa.Boolean(),
               existing_nullable=True)
    op.alter_column('menuItem', 'popular',
               existing_type=mysql.TINYINT(display_width=1),
               type_=sa.Boolean(),
               existing_nullable=True)
    op.alter_column('order', 'complete',
               existing_type=mysql.TINYINT(display_width=1),
               type_=sa.Boolean(),
               existing_nullable=True)
    op.alter_column('user', 'isActivated',
               existing_type=mysql.TINYINT(display_width=1),
               type_=sa.Boolean(),
               existing_nullable=True)
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.alter_column('user', 'isActivated',
               existing_type=sa.Boolean(),
               type_=mysql.TINYINT(display_width=1),
               existing_nullable=True)
    op.alter_column('order', 'complete',
               existing_type=sa.Boolean(),
               type_=mysql.TINYINT(display_width=1),
               existing_nullable=True)
    op.alter_column('menuItem', 'popular',
               existing_type=sa.Boolean(),
               type_=mysql.TINYINT(display_width=1),
               existing_nullable=True)
    op.alter_column('favoriteDrinks', 'decaf',
               existing_type=sa.Boolean(),
               type_=mysql.TINYINT(display_width=1),
               existing_nullable=True)
    op.alter_column('drink', 'decaf',
               existing_type=sa.Boolean(),
               type_=mysql.TINYINT(display_width=1),
               existing_nullable=True)
    op.alter_column('HalfCaf', 'acc_order',
               existing_type=sa.Boolean(),
               type_=mysql.TINYINT(display_width=1),
               existing_nullable=True)
    op.drop_index(op.f('ix_drinksToTemp_tempId'), table_name='drinksToTemp')
    op.drop_index(op.f('ix_drinksToTemp_temp'), table_name='drinksToTemp')
    op.drop_index(op.f('ix_drinksToTemp_drinkId'), table_name='drinksToTemp')
    op.drop_index(op.f('ix_drinksToTemp_drink'), table_name='drinksToTemp')
    op.drop_table('drinksToTemp')
    # ### end Alembic commands ###

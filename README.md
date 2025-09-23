# E-Commerce Database Management System

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13%2B-blue)
![Python](https://img.shields.io/badge/Python-3.8%2B-green)
![Tableau](https://img.shields.io/badge/Tableau-Visualization-orange)
![Database](https://img.shields.io/badge/Database-Relational%20SQL-red)

A comprehensive relational SQL database system designed for optimizing and organizing the Brazilian E-Commerce Public Dataset by Olist, containing over 100,000 orders from multiple Brazilian marketplaces. This project demonstrates advanced database design, normalization, and business intelligence capabilities.

## 🎯 Key Features

- **Advanced ER Modeling** with 11 normalized tables supporting complex e-commerce operations
- **BCNF Normalization** ensuring zero data redundancy and optimal storage efficiency
- **High-Performance Query Optimization** with strategic indexing reducing query latency by 60%
- **Automated Business Logic** through stored procedures, triggers, and transaction management
- **Comprehensive Data Analytics** with Tableau dashboards for business intelligence
- **Scalable Architecture** capable of handling 5M+ records with efficient data retrieval

## 🏗️ Database Schema

### Entity Relationship Diagram

![ER Diagram](images/er_diagram.png)

### Core Tables Structure

| Table | Purpose | Key Features |
|-------|---------|--------------|
| **CUSTOMERS** | Customer master data | Unique customer tracking, geographic analysis |
| **ORDERS** | Order transactions | Multi-status tracking, timestamp management |
| **PRODUCTS** | Product catalog | Category hierarchy, dimensional attributes |
| **SELLERS** | Seller management | Performance tracking, geographic mapping |
| **ORDER_ITEMS** | Line item details | Multi-seller order support, pricing data |
| **ORDER_PAYMENTS** | Payment processing | Installment support, multiple payment methods |
| **ORDER_REVIEWS** | Customer feedback | Sentiment analysis, review management |

## 📊 Performance Metrics

| Metric | Achievement |
|--------|-------------|
| **Query Optimization** | 60% reduction in latency for large-scale reports |
| **Data Integrity** | 100% referential integrity with cascade operations |
| **Normalization** | BCNF compliance across all 11 tables |
| **Transaction Handling** | Atomic operations with rollback protection |
| **Indexing Efficiency** | 40% faster query execution on indexed columns |

## 🚀 Quick Start

### Prerequisites

- PostgreSQL 13+
- Python 3.8+
- Tableau (for visualization)

### Installation

```bash
# Clone the repository
git clone https://github.com/mandrusanjay123/E-Commerce-Database-System.git
cd E-Commerce-Database-System

# Install Python dependencies
pip install -r requirements.txt

# Set up PostgreSQL database
createdb ecommerce_db

# Run database setup script
python scripts/setup_database.py

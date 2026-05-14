using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TeamSync.Helpers
{
    public static class DatabaseHelper
    {
        // Connection String
        private static readonly string connectionString =
            ConfigurationManager.ConnectionStrings["TaskManagerDB"].ConnectionString;

        // =====================================================
        // OPEN CONNECTION
        // =====================================================

        private static SqlConnection GetConnection()
        {
            SqlConnection con = new SqlConnection(connectionString);
            return con;
        }

        // =====================================================
        // INSERT / UPDATE / DELETE
        // =====================================================

        public static int ExecuteQuery(string query)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        public static int ExecuteQuery(string query, SqlParameter[] parameters)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    con.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        // =====================================================
        // EXECUTE SCALAR
        // =====================================================

        public static object ExecuteScalar(string query)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    return cmd.ExecuteScalar();
                }
            }
        }

        public static object ExecuteScalar(string query, SqlParameter[] parameters)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    con.Open();
                    return cmd.ExecuteScalar();
                }
            }
        }

        // =====================================================
        // GET DATA TABLE
        // =====================================================

        public static DataTable GetDataTable(string query)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public static DataTable GetDataTable(string query, SqlParameter[] parameters)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        // =====================================================
        // GET DATASET
        // =====================================================

        public static DataSet GetDataSet(string query)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                        return ds;
                    }
                }
            }
        }

        public static DataSet GetDataSet(string query, SqlParameter[] parameters)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                        return ds;
                    }
                }
            }
        }

        // =====================================================
        // CHECK RECORD EXISTS
        // =====================================================

        public static bool RecordExists(string query)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();

                    object result = cmd.ExecuteScalar();

                    return result != null;
                }
            }
        }

        public static bool RecordExists(string query, SqlParameter[] parameters)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    con.Open();

                    object result = cmd.ExecuteScalar();

                    return result != null;
                }
            }
        }

        // =====================================================
        // EXECUTE STORED PROCEDURE
        // =====================================================

        public static int ExecuteStoredProcedure(string procedureName, SqlParameter[] parameters)
        {
            using (SqlConnection con = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(procedureName, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    con.Open();

                    return cmd.ExecuteNonQuery();
                }
            }
        }

        // =====================================================
        // ERROR SAFE EXECUTION
        // =====================================================

        public static string TestConnection()
        {
            try
            {
                using (SqlConnection con = GetConnection())
                {
                    con.Open();

                    if (con.State == ConnectionState.Open)
                    {
                        return "Database Connected Successfully";
                    }
                    else
                    {
                        return "Database Connection Failed";
                    }
                }
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    }
}
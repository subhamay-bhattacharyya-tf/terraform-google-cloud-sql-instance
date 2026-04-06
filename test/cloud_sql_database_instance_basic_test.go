package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

// TestCloudSQLDatabaseInstanceBasic tests creating a basic Cloud SQL database instance.
func TestCloudSQLDatabaseInstanceBasic(t *testing.T) {
	t.Parallel()

	retrySleep := 10 * time.Second
	unique := strings.ToLower(random.UniqueId())
	baseName := fmt.Sprintf("tt-sql-basic-%s", unique)
	projectID := mustEnv(t, "GOOGLE_CLOUD_PROJECT")

	tfOptions := &terraform.Options{
		TerraformDir: "..",
		NoColor:      true,
		Vars: map[string]interface{}{
			"environment":  "devl",
			"project_code": "demo",
			"project_id":   projectID,
			"region":       "us-central1",
			"cloud_sql_database_instance_config": map[string]interface{}{
				"base_name": baseName,
				"location":  "us-central1",
			},
		},
	}

	defer terraform.Destroy(t, tfOptions)
	terraform.InitAndApply(t, tfOptions)

	time.Sleep(retrySleep)

	outputInstanceName := terraform.Output(t, tfOptions, "instance_name")
	require.NotEmpty(t, outputInstanceName)
	require.Contains(t, outputInstanceName, baseName)

	outputProject := terraform.Output(t, tfOptions, "instance_project")
	require.Equal(t, projectID, outputProject)
}

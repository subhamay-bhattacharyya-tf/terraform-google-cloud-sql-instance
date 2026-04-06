package test

import (
	"context"
	"os"
	"strings"
	"testing"

	"github.com/stretchr/testify/require"
	sqladmin "google.golang.org/api/sqladmin/v1"
)

// mustEnv retrieves a required environment variable, failing the test if absent.
func mustEnv(t *testing.T, key string) string {
	t.Helper()
	v := strings.TrimSpace(os.Getenv(key))
	require.NotEmpty(t, v, "Missing required environment variable %s", key)
	return v
}

// newSQLAdminService creates an authenticated Cloud SQL Admin API service.
func newSQLAdminService(t *testing.T) *sqladmin.Service {
	t.Helper()
	ctx := context.Background()
	svc, err := sqladmin.NewService(ctx)
	require.NoError(t, err, "Failed to create Cloud SQL Admin service")
	return svc
}

// instanceExists reports whether the named Cloud SQL instance exists in the given project.
func instanceExists(t *testing.T, svc *sqladmin.Service, projectID, instanceName string) bool {
	t.Helper()
	_, err := svc.Instances.Get(projectID, instanceName).Do()
	return err == nil
}

// fetchInstanceAttrs returns the DatabaseInstance resource for the named instance.
func fetchInstanceAttrs(t *testing.T, svc *sqladmin.Service, projectID, instanceName string) *sqladmin.DatabaseInstance {
	t.Helper()
	instance, err := svc.Instances.Get(projectID, instanceName).Do()
	require.NoError(t, err, "Failed to get Cloud SQL instance %s", instanceName)
	return instance
}

hmpps-delius-core-apacheds-bootstrap
=========

Bootstrap Ansible role to update our ApacheDS config


Role Variables
--------------

```yaml
# AWS
s3_dependencies_bucket: S3 bucket name containing artefacts, local filesystem will be used if not specified
s3_backups_bucket: S3 bucket name containing LDIF backups, local filesystem will be used if not specified

# ApacheDS
jvm_mem_args: Amount of memory (in MB) to allocate to the ApacheDS service
apacheds_version: This should match the version installed on the server
apacheds_install_directory: ApacheDS install directory
apacheds_lib_directory: ApacheDS lib+conf directory
workspace: Workspace location for storing temporary files during bootstrap
log_level: ApacheDS log level

# LDAP
ldap_protocol: Protocol to be used - ldap or ldaps 
ldap_port: Port to expose ldap on
bind_user: ApacheDS admin username
bind_password: Desired admin password
partition_id: Partition to create and load the schema into
is_consumer: Whether this node is a master (provider) or slave (consumer) node

# Data import
import_users_ldif: LDIF file to import from the s3_backups_bucket. This can be set to LATEST to retrieve the latest backup from S3.
sanitize_oid_ldif: Whether to remove Oracle-specific attributes from the LDIF
perf_test_users: Number of users to create to support performance testing. Default=0

```
See the full list of variable defaults in [defaults/main.yml](defaults/main.yml)

Dependencies
------------
There are some JARs included in the project that are used during the bootstrap:

* ldif-sort.jar - 
Built from the GitHub project at [nano-byte/ldif-sort](https://github.com/nano-byte/ldif-sort) and stored in the files directory. 
As migrated data from Oracle Internet Directory isn't guaranteed to be in the correct hierarchical order, this is used to correct it.
* NDelius-apacheds-lib-3.0.jar -
Provided by Beaumont Colson and provides interceptors for NDelius-specific LDAP attributes.

License
-------

MIT

Author Information
------------------

HMPPS Digital Studio

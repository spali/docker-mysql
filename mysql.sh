#!/bin/bash

trap 'mysqladmin -u root shutdown' EXIT

mysqld_safe

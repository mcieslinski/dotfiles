#!/bin/bash

xinput disable $(xinput | grep "ETPS" | grep -Eo "id=[0-9]{1,}" | grep -Eo "[0-9]{1,}")

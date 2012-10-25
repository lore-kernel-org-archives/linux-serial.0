From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 2/2] staging: dgrp: remove rawreadok module option
Date: Thu, 25 Oct 2012 12:46:22 -0400
Message-ID: <1351183582-13573-3-git-send-email-wfp5p@virginia.edu>
References: <1351183582-13573-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:43288 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759959Ab2JYQqe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2012 12:46:34 -0400
In-Reply-To: <1351183582-13573-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org

The functionality behind this option has been removed in the driver so
remove the config option to set/unset it.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 drivers/staging/dgrp/dgrp_common.h   |  1 -
 drivers/staging/dgrp/dgrp_driver.c   |  4 ----
 drivers/staging/dgrp/dgrp_specproc.c |  2 --
 drivers/staging/dgrp/dgrp_sysfs.c    | 18 ------------------
 4 files changed, 25 deletions(-)

diff --git a/drivers/staging/dgrp/dgrp_common.h b/drivers/staging/dgrp/dgrp_common.h
index 05ff338..0583fe9 100644
--- a/drivers/staging/dgrp/dgrp_common.h
+++ b/drivers/staging/dgrp/dgrp_common.h
@@ -31,7 +31,6 @@
  * All global storage allocation.
  ************************************************************************/
 
-extern int dgrp_rawreadok;  /* Allow raw writing of input */
 extern int dgrp_register_cudevices; /* enable legacy cu devices */
 extern int dgrp_register_prdevices; /* enable transparent print devices */
 extern int dgrp_poll_tick;          /* Poll interval - in ms */
diff --git a/drivers/staging/dgrp/dgrp_driver.c b/drivers/staging/dgrp/dgrp_driver.c
index 6e4a0eb..aa26258 100644
--- a/drivers/staging/dgrp/dgrp_driver.c
+++ b/drivers/staging/dgrp/dgrp_driver.c
@@ -39,14 +39,10 @@ MODULE_VERSION(DIGI_VERSION);
 struct list_head nd_struct_list;
 struct dgrp_poll_data dgrp_poll_data;
 
-int dgrp_rawreadok = 1;		/* Bypass flipbuf on input */
 int dgrp_register_cudevices = 1;/* Turn on/off registering legacy cu devices */
 int dgrp_register_prdevices = 1;/* Turn on/off registering transparent print */
 int dgrp_poll_tick = 20;	/* Poll interval - in ms */
 
-module_param_named(rawreadok, dgrp_rawreadok, int, 0644);
-MODULE_PARM_DESC(rawreadok, "Bypass flip buffers on input");
-
 module_param_named(register_cudevices, dgrp_register_cudevices, int, 0644);
 MODULE_PARM_DESC(register_cudevices, "Turn on/off registering legacy cu devices");
 
diff --git a/drivers/staging/dgrp/dgrp_specproc.c b/drivers/staging/dgrp/dgrp_specproc.c
index 24327c3..db91f67 100644
--- a/drivers/staging/dgrp/dgrp_specproc.c
+++ b/drivers/staging/dgrp/dgrp_specproc.c
@@ -629,8 +629,6 @@ static int info_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "version: %s\n", DIGI_VERSION);
 	seq_puts(m, "register_with_sysfs: 1\n");
-	seq_printf(m, "rawreadok: 0x%08x\t(%d)\n",
-		   dgrp_rawreadok, dgrp_rawreadok);
 	seq_printf(m, "pollrate: 0x%08x\t(%d)\n",
 		   dgrp_poll_tick, dgrp_poll_tick);
 
diff --git a/drivers/staging/dgrp/dgrp_sysfs.c b/drivers/staging/dgrp/dgrp_sysfs.c
index e5a3c88..8b513e9 100644
--- a/drivers/staging/dgrp/dgrp_sysfs.c
+++ b/drivers/staging/dgrp/dgrp_sysfs.c
@@ -55,23 +55,6 @@ static DEVICE_ATTR(register_with_sysfs, 0400,
 		   dgrp_class_register_with_sysfs_show, NULL);
 
 
-static ssize_t dgrp_class_rawreadok_show(struct device *c,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%d\n", dgrp_rawreadok);
-}
-static ssize_t dgrp_class_rawreadok_store(struct device *c,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
-{
-	sscanf(buf, "0x%x\n", &dgrp_rawreadok);
-	return count;
-}
-static DEVICE_ATTR(rawreadok, 0600, dgrp_class_rawreadok_show,
-		   dgrp_class_rawreadok_store);
-
-
 static ssize_t dgrp_class_pollrate_show(struct device *c,
 					struct device_attribute *attr,
 					char *buf)
@@ -91,7 +74,6 @@ static DEVICE_ATTR(pollrate, 0600, dgrp_class_pollrate_show,
 
 static struct attribute *dgrp_sysfs_global_settings_entries[] = {
 	&dev_attr_pollrate.attr,
-	&dev_attr_rawreadok.attr,
 	&dev_attr_register_with_sysfs.attr,
 	NULL
 };
-- 
1.7.12


Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F7C77B7F
	for <linux-serial@archiver.kernel.org>; Wed, 17 May 2023 15:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjEQP6h (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 May 2023 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjEQP6f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 May 2023 11:58:35 -0400
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27B91724
        for <linux-serial@vger.kernel.org>; Wed, 17 May 2023 08:58:29 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230517155826de848ee94e0e735b0f
        for <linux-serial@vger.kernel.org>;
        Wed, 17 May 2023 17:58:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=myO+P8WOEjna9leIj0Mi2o9ZV1FzreaUuCy/6birCxg=;
 b=h3OcECnT2RGiwr8E/X3Favf64LAC/N6yEQ2xq/npJpR5AyqhgZAu5fG3ZH8xpYBRo1jNlM
 747whGj63viyftONRAziDSdytMJNK+SJ97KtC6j0dQs9hSv+u9HPd5bHvzk/BRBO+pwWYQT7
 I3eOpTDThIN85c2OlwXNn5ZV4fx+E=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        felix-haase@siemens.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v5 01/10] tty: n_gsm: add restart flag to DLC specific ioctl config
Date:   Wed, 17 May 2023 17:56:55 +0200
Message-Id: <20230517155704.5701-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Currently, changing the parameters of a DLCI gives no direct control to the
user whether this should trigger a channel reset or not. The decision is
solely made by the driver based on the assumption which parameter changes
are compatible or not. Therefore, the user has no means to perform an
automatic channel reset after parameter configuration for non-conflicting
changes.

Add the parameter 'flags' to 'gsm_dlci_config' to force a channel reset
after ioctl setting regardless of whether the changes made require this or
not by setting this to 'GSM_FL_RESTART'.

Note that 'GSM_FL_RESTART' is currently the only allow flag to allow
additions here.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c         |  4 ++++
 include/uapi/linux/gsmmux.h | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

v4 -> v5:
Changed GSM_FL_RESTART comment to be more specific about its use as
suggested in the review comment.

Please note that I cannot response to emails until August 7th. Felix Haase
will take over from our side for questions regarding this patch series or
the n_gsm.

Link: https://lore.kernel.org/all/DB9PR10MB5881B63FBBA7912DF5A7A6A8E0789@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b411a26cc092..66edcf65a4dd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2532,6 +2532,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
 		return -EINVAL;
 	if (dc->k > 7)
 		return -EINVAL;
+	if (dc->flags & ~GSM_FL_RESTART)   /* allow future extensions */
+		return -EINVAL;
 
 	/*
 	 * See what is needed for reconfiguration
@@ -2546,6 +2548,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
 	/* Requires care */
 	if (dc->priority != dlci->prio)
 		need_restart = true;
+	if (dc->flags & GSM_FL_RESTART)
+		need_restart = true;
 
 	if ((open && gsm->wait_config) || need_restart)
 		need_open = true;
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index eb67884e5f38..e56e2d7ea6eb 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -2,10 +2,22 @@
 #ifndef _LINUX_GSMMUX_H
 #define _LINUX_GSMMUX_H
 
+#include <linux/const.h>
 #include <linux/if.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
+/*
+ * flags definition for n_gsm
+ *
+ * Used by:
+ * struct gsm_dlci_config.flags
+ */
+/* Forces a DLCI reset if set. Otherwise, a DLCI reset is only done if
+ * incompatible settings were provided. Always cleared on retrieval.
+ */
+#define GSM_FL_RESTART	_BITUL(0)
+
 struct gsm_config
 {
 	unsigned int adaption;
@@ -58,7 +70,8 @@ struct gsm_dlci_config {
 	__u32 priority;		/* Priority (0 for default value) */
 	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
 	__u32 k;		/* Window size (0 for default value) */
-	__u32 reserved[8];	/* For future use, must be initialized to zero */
+	__u32 flags;		/* DLCI specific flags. */
+	__u32 reserved[7];	/* For future use, must be initialized to zero */
 };
 
 #define GSMIOC_GETCONF_DLCI	_IOWR('G', 7, struct gsm_dlci_config)
-- 
2.34.1


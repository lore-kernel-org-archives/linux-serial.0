Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16659C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 07:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1ECA60F56
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 07:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKBHIj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Nov 2021 03:08:39 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23600 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhKBHIj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Nov 2021 03:08:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635836764; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5fEtNBfMOPuQvrIufJ+iE7zhzDqTILQAqeScWkbv0Rg=; b=pK/nCdqg5T91f4epB03AnpIqHuF0wb7P76RaKwcuUqCbp5JBTfTV3JHF9pptC+tX0n2+FYB2
 JqtUUgd4NlmMjSRJClf6RND8E3DEUg41VI9l6Jx9uwLSDCWi90tnjDKtA1VURgi3NK8j2BVg
 709db6mPwy0YdDvi/jjQ4d4Djjs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIzZmY0MiIsICJsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6180e32b648aeeca5c45cb7d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Nov 2021 07:05:15
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DA17C43616; Tue,  2 Nov 2021 07:05:15 +0000 (UTC)
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C9F2C4338F;
        Tue,  2 Nov 2021 07:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6C9F2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     robh@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, zijuhu@codeaurora.org,
        Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 1/3] serdev: Add interface serdev_device_ioctl
Date:   Tue,  2 Nov 2021 15:05:07 +0800
Message-Id: <1635836707-29341-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Zijun Hu <quic_zijuhu@quicinc.com>

For serdev_device which is mounted at virtual tty port, tty ioctl()
maybe be used to make serdev_device ready to talk with tty port, so
add interface serdev_device_ioctl().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/tty/serdev/core.c           | 13 +++++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 12 ++++++++++++
 include/linux/serdev.h              |  9 +++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index f1324fe99378..dee934203277 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -405,6 +405,19 @@ int serdev_device_set_tiocm(struct serdev_device *serdev, int set, int clear)
 }
 EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
 
+int serdev_device_ioctl(struct serdev_device *serdev, unsigned int cmd, unsigned long arg)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl)
+		return -ENOTTY;
+	else if	(!ctrl->ops->ioctl)
+		return -ENOSYS;
+	else
+		return ctrl->ops->ioctl(ctrl, cmd, arg);
+}
+EXPORT_SYMBOL_GPL(serdev_device_ioctl);
+
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index d367803e2044..66afad1eb1b7 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -247,6 +247,17 @@ static int ttyport_set_tiocm(struct serdev_controller *ctrl, unsigned int set, u
 	return tty->ops->tiocmset(tty, set, clear);
 }
 
+static int ttyport_ioctl(struct serdev_controller *ctrl, unsigned int cmd, unsigned long arg)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	if (!tty->ops->ioctl)
+		return -ENOSYS;
+
+	return tty->ops->ioctl(tty, cmd, arg);
+}
+
 static const struct serdev_controller_ops ctrl_ops = {
 	.write_buf = ttyport_write_buf,
 	.write_flush = ttyport_write_flush,
@@ -259,6 +270,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.wait_until_sent = ttyport_wait_until_sent,
 	.get_tiocm = ttyport_get_tiocm,
 	.set_tiocm = ttyport_set_tiocm,
+	.ioctl = ttyport_ioctl,
 };
 
 struct device *serdev_tty_port_register(struct tty_port *port,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 3368c261ab62..5804201fafb2 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -91,6 +91,7 @@ struct serdev_controller_ops {
 	void (*wait_until_sent)(struct serdev_controller *, long);
 	int (*get_tiocm)(struct serdev_controller *);
 	int (*set_tiocm)(struct serdev_controller *, unsigned int, unsigned int);
+	int (*ioctl)(struct serdev_controller *ctrl, unsigned int cmd, unsigned long arg);
 };
 
 /**
@@ -201,6 +202,7 @@ int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_
 void serdev_device_wait_until_sent(struct serdev_device *, long);
 int serdev_device_get_tiocm(struct serdev_device *);
 int serdev_device_set_tiocm(struct serdev_device *, int, int);
+int serdev_device_ioctl(struct serdev_device *serdev, unsigned int cmd, unsigned long arg);
 void serdev_device_write_wakeup(struct serdev_device *);
 int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, long);
 void serdev_device_write_flush(struct serdev_device *);
@@ -254,6 +256,13 @@ static inline int serdev_device_set_tiocm(struct serdev_device *serdev, int set,
 {
 	return -ENOTSUPP;
 }
+
+static inline int serdev_device_ioctl(struct serdev_device *serdev,
+				      unsigned int cmd, unsigned long arg)
+{
+	return -ENOSYS;
+}
+
 static inline int serdev_device_write(struct serdev_device *sdev, const unsigned char *buf,
 				      size_t count, unsigned long timeout)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project


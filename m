Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E2AC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 31 May 2022 04:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiEaEha (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 May 2022 00:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243857AbiEaEh2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 May 2022 00:37:28 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A929157F;
        Mon, 30 May 2022 21:37:27 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id DDF783740232; Tue, 31 May 2022 04:36:55 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH v2 2/6] serial: core: add sysfs attribute to suppress ready
 signalling on open
In-Reply-To: <20220531043356.8CAB637401A9@freecalypso.org>
References: <20220531043356.8CAB637401A9@freecalypso.org>
Message-Id: <20220531043655.DDF783740232@freecalypso.org>
Date:   Tue, 31 May 2022 04:36:55 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

Add a nordy sysfs attribute to suppress raising the modem-control lines
on open to signal DTE readiness.

This can be used to prevent undesirable side-effects on open for
applications where the DTR and RTS lines are used for non-standard
purposes such as generating power-on and reset pulses.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mychaela N. Falconia <falcon@freecalypso.org>
---
 Documentation/ABI/testing/sysfs-tty |  7 +++++++
 drivers/tty/serial/serial_core.c    | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index 820e412d38a8..98cb5cf0af75 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -161,3 +161,10 @@ Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 Description:
 		 Allows user to detach or attach back the given device as
 		 kernel console. It shows and accepts a boolean variable.
+
+What:		/sys/class/tty/ttyS0/nordy
+Date:		November 2020
+Contact:	Johan Hovold <johan@kernel.org>
+Description:
+		 Show and store the port NORDY flag which suppresses raising
+		 the modem-control lines on open to signal DTE readiness.
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9a85b41caa0a..a17ac4efaceb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2870,6 +2870,30 @@ static ssize_t console_store(struct device *dev,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t nordy_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", tty_port_nordy(port));
+}
+
+static ssize_t nordy_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct tty_port *port = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	tty_port_set_nordy(port, val);
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(uartclk);
 static DEVICE_ATTR_RO(type);
 static DEVICE_ATTR_RO(line);
@@ -2884,6 +2908,7 @@ static DEVICE_ATTR_RO(io_type);
 static DEVICE_ATTR_RO(iomem_base);
 static DEVICE_ATTR_RO(iomem_reg_shift);
 static DEVICE_ATTR_RW(console);
+static DEVICE_ATTR_RW(nordy);
 
 static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_uartclk.attr,
@@ -2900,6 +2925,7 @@ static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_iomem_base.attr,
 	&dev_attr_iomem_reg_shift.attr,
 	&dev_attr_console.attr,
+	&dev_attr_nordy.attr,
 	NULL
 };
 
-- 
2.9.0


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F573C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 27 May 2022 22:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354814AbiE0Wgq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 May 2022 18:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354787AbiE0Wgo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 May 2022 18:36:44 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC71C255AF;
        Fri, 27 May 2022 15:36:42 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id A369E3740211; Fri, 27 May 2022 22:27:13 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH 2/6] serial: core: add sysfs attribute to suppress raising DTR
 & RTS on open
Message-Id: <20220527222713.A369E3740211@freecalypso.org>
Date:   Fri, 27 May 2022 22:27:13 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a manual_rtsdtr sysfs attribute to suppress automatic raising of
DTR and RTS modem control signals on serial port open.

This special mode can be used to prevent undesirable side effects on
open for applications where these lines are used for non-standard
purposes such as generating power-on and reset pulses.

Co-developed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mychaela N. Falconia <falcon@freecalypso.org>
---
 Documentation/ABI/testing/sysfs-tty | 10 ++++++++++
 drivers/tty/serial/serial_core.c    | 27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index 820e412d38a8..3e666538451b 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -161,3 +161,13 @@ Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 Description:
 		 Allows user to detach or attach back the given device as
 		 kernel console. It shows and accepts a boolean variable.
+
+What:		/sys/class/tty/tty<x>/manual_rtsdtr
+Date:		May 2022
+Contact:	Mychaela N. Falconia <falcon@freecalypso.org>
+Description:
+		 Writing 1 into this flag attribute suppresses automatic
+		 assertion of DTR & RTS on serial port open, putting these
+		 signals under manual control (TIOCMBIS & TIOCMBIC).
+		 Writing 0 restores standard POSIX/SUS behaviour of
+		 automatically asserting both DTR and RTS on open.
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9a85b41caa0a..b47004a3fb77 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2870,6 +2870,31 @@ static ssize_t console_store(struct device *dev,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t manual_rtsdtr_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct tty_port *port = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", tty_port_manual_rtsdtr(port));
+}
+
+static ssize_t manual_rtsdtr_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct tty_port *port = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	tty_port_set_manual_rtsdtr(port, val);
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(uartclk);
 static DEVICE_ATTR_RO(type);
 static DEVICE_ATTR_RO(line);
@@ -2884,6 +2909,7 @@ static DEVICE_ATTR_RO(io_type);
 static DEVICE_ATTR_RO(iomem_base);
 static DEVICE_ATTR_RO(iomem_reg_shift);
 static DEVICE_ATTR_RW(console);
+static DEVICE_ATTR_RW(manual_rtsdtr);
 
 static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_uartclk.attr,
@@ -2900,6 +2926,7 @@ static struct attribute *tty_dev_attrs[] = {
 	&dev_attr_iomem_base.attr,
 	&dev_attr_iomem_reg_shift.attr,
 	&dev_attr_console.attr,
+	&dev_attr_manual_rtsdtr.attr,
 	NULL
 };
 
-- 
2.9.0


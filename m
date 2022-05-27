Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAA5C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 27 May 2022 22:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354818AbiE0Wgu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 May 2022 18:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354809AbiE0Wgq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 May 2022 18:36:46 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C952262130;
        Fri, 27 May 2022 15:36:44 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id 676313740227; Fri, 27 May 2022 22:27:23 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH 4/6] USB: serial: add sysfs attribute to suppress raising DTR
 & RTS on open
Message-Id: <20220527222723.676313740227@freecalypso.org>
Date:   Fri, 27 May 2022 22:27:23 +0000 (UTC)
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
 drivers/usb/serial/bus.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 9e38142acd38..f1559d082fad 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -29,6 +29,38 @@ static int usb_serial_device_match(struct device *dev,
 	return 0;
 }
 
+static ssize_t manual_rtsdtr_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct usb_serial_port *port = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", tty_port_manual_rtsdtr(&port->port));
+}
+
+static ssize_t manual_rtsdtr_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct usb_serial_port *port = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	tty_port_set_manual_rtsdtr(&port->port, val);
+
+	return count;
+}
+static DEVICE_ATTR_RW(manual_rtsdtr);
+
+static struct attribute *tty_attrs[] = {
+	&dev_attr_manual_rtsdtr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(tty);
+
 static int usb_serial_device_probe(struct device *dev)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
@@ -50,8 +82,8 @@ static int usb_serial_device_probe(struct device *dev)
 	}
 
 	minor = port->minor;
-	tty_dev = tty_port_register_device(&port->port, usb_serial_tty_driver,
-					   minor, dev);
+	tty_dev = tty_port_register_device_attr(&port->port,
+			usb_serial_tty_driver, minor, dev, port, tty_groups);
 	if (IS_ERR(tty_dev)) {
 		retval = PTR_ERR(tty_dev);
 		goto err_port_remove;
-- 
2.9.0


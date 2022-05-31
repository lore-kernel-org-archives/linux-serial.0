Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8FBC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 31 May 2022 04:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbiEaEhL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 May 2022 00:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbiEaEhJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 May 2022 00:37:09 -0400
Received: from freecalypso.org (freecalypso.org [195.154.163.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2AB522FB;
        Mon, 30 May 2022 21:37:08 -0700 (PDT)
Received: by freecalypso.org (Postfix, from userid 1001)
        id 13427374023E; Tue, 31 May 2022 04:37:07 +0000 (UTC)
From:   "Mychaela N. Falconia" <falcon@freecalypso.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
Subject: [PATCH v2 4/6] USB: serial: add sysfs attribute to suppress ready
 signalling on open
In-Reply-To: <20220531043356.8CAB637401A9@freecalypso.org>
References: <20220531043356.8CAB637401A9@freecalypso.org>
Message-Id: <20220531043707.13427374023E@freecalypso.org>
Date:   Tue, 31 May 2022 04:37:06 +0000 (UTC)
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
 drivers/usb/serial/bus.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 9e38142acd38..25f8218b2bce 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -29,6 +29,37 @@ static int usb_serial_device_match(struct device *dev,
 	return 0;
 }
 
+static ssize_t nordy_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct usb_serial_port *port = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", tty_port_nordy(&port->port));
+}
+
+static ssize_t nordy_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct usb_serial_port *port = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	tty_port_set_nordy(&port->port, val);
+
+	return count;
+}
+static DEVICE_ATTR_RW(nordy);
+
+static struct attribute *tty_attrs[] = {
+	&dev_attr_nordy.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(tty);
+
 static int usb_serial_device_probe(struct device *dev)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
@@ -50,8 +81,8 @@ static int usb_serial_device_probe(struct device *dev)
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


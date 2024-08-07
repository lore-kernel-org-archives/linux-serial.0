Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72953A1BF
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039737; cv=none; b=gojX9yQoC1ZXT/V64Qc6haJ5B8eIgYI4VXNXGWjvsT26nE8lkpC2UP/qz4bGclAnpIzJNL9eED7NcQzMr3Ycd9WfLlrdyTNzbRl08igfQAYA2SCjTNXX/86V7ECGh+iBFFAuoxXB4ZyCrA6nb23A/eUX5/OLZSjOTsCLbXuussk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039737; c=relaxed/simple;
	bh=FqhMOL8S6qzJXyNhiI+GMvBv2supAxih1MgpogK4of0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H2GeLvwkf741gTCu7anOTrNvZIZGECoxXyrgt2sViLKSDM+ycCxa3wnDqDVxdd50T1naMUV/6XWITCHX+jSxA6vnbQxOmYuq8dyQVXnuCd2LHv8g5mGkk8cHWez/YYopM/lQzer9AaNyWtKno1yYGiq4fr1zDHak4pYv9bZSVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1sbhLQ-0002E5-TW; Wed, 07 Aug 2024 16:08:52 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 07 Aug 2024 16:08:50 +0200
Subject: [PATCH 3/3] USB: serial: enable serdev support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-v6-10-topic-usb-serial-serdev-v1-3-ed2cc5da591f@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
In-Reply-To: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

Enable serdev support by using the serdev opt-in tty-port registration
helper.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/usb/serial/bus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index df0196a30f33..84eca07f83fa 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -33,6 +33,7 @@ static int usb_serial_device_probe(struct device *dev)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct usb_serial_driver *driver;
+	struct device *host_dev;
 	struct device *tty_dev;
 	int retval = 0;
 	int minor;
@@ -50,8 +51,9 @@ static int usb_serial_device_probe(struct device *dev)
 	}
 
 	minor = port->minor;
-	tty_dev = tty_port_register_device(&port->port, usb_serial_tty_driver,
-					   minor, dev);
+	host_dev = &port->serial->interface->dev;
+	tty_dev = tty_port_register_device_serdev(&port->port,
+			usb_serial_tty_driver, minor, host_dev, dev);
 	if (IS_ERR(tty_dev)) {
 		retval = PTR_ERR(tty_dev);
 		goto err_port_remove;
@@ -90,7 +92,7 @@ static void usb_serial_device_remove(struct device *dev)
 	autopm_err = usb_autopm_get_interface(port->serial->interface);
 
 	minor = port->minor;
-	tty_unregister_device(usb_serial_tty_driver, minor);
+	tty_port_unregister_device(&port->port, usb_serial_tty_driver, minor);
 
 	driver = port->serial->type;
 	if (driver->port_remove)

-- 
2.39.2


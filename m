Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725C39FFE
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039737; cv=none; b=tlhT+t9pmhxYqmtem/PkbmDEKUjV4KlhYACObCOPVJkhfdGGODeGqJ7T5HbN16GnEwnHWutMOjGYbgYuO7JvWA2wyeAFgtkPRgjqk+nBxWqEU1AsMLPuZL9YdiivxaJmDxksHWralFJNOQXD3W0sBocUqjpxKHLPVAZEv3ER5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039737; c=relaxed/simple;
	bh=9hXhq6Gzs+DxBDizJYR+Z6DeOqGq51BP6C6316J+VqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCqZJwym7e84t4KDi+65X/aUnV3WJMLpNYKrCxHtjIffhC090SUlJrMJ4bFCEUf16thQrWjXd6hBO+o+YKwn/9I3C7FGhvtGQLrUV+IC4dj7NN6UKZKd3vJ9beI07IbcaIQQKmSGe56yIK3xOBmQghokUI/jzpo0kdj+NLtGyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1sbhLQ-0002E5-Re; Wed, 07 Aug 2024 16:08:52 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 07 Aug 2024 16:08:49 +0200
Subject: [PATCH 2/3] USB: serial: cosmetic cleanup <space><tab> mix
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-v6-10-topic-usb-serial-serdev-v1-2-ed2cc5da591f@pengutronix.de>
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

Cosmetic cleanup: replace <space><tab> mix with <tab> only.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/usb/serial/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 6c812d01b37d..df0196a30f33 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -149,7 +149,7 @@ const struct bus_type usb_serial_bus_type = {
 	.match =	usb_serial_device_match,
 	.probe =	usb_serial_device_probe,
 	.remove =	usb_serial_device_remove,
-	.drv_groups = 	usb_serial_drv_groups,
+	.drv_groups =	usb_serial_drv_groups,
 };
 
 int usb_serial_bus_register(struct usb_serial_driver *driver)

-- 
2.39.2


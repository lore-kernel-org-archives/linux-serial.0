Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BF15CD76
	for <linux-serial@vger.kernel.org>; Thu,  9 May 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264169; cv=none; b=hKUn8+NGwVGQW7X3+Ge6sedbpsRFY4mHx7+mmY304bpdg6PN5o2sEv+6bCdlZc95qr/JVUD418Ao4Y4RnCEp8J/k41WfilaAtmGIeHhbD5vp53w2R2S3bm8KXJZ2IxybfVjYpSc9mIUSor2SS5QhJREYkpN3/16W1WuxMSwNGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264169; c=relaxed/simple;
	bh=iKI8B26jQgXC1gf6sjiv7uyRRarcbvb/adEB97oymRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+rd2AhXbaqKChDFmA3MtBDQs9yN5zD20bsLr81+ve4a+2pwNEzBRo1eDv0lSVigmDm5q1awyET2sRmZWlQ42aZWwa3x8wczDmt1mzITuvnv9fRQvqUQWvt9zHW5N8PsTh53F4JtyqsqAiOTj2AjLuSp+1ljn/APXGvYggfQhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVQPbmWh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVQPbmWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715264166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pjg2PKCpdxD/auehornrq3SKgRXBrYxahB9gVsCUM2k=;
	b=jVQPbmWho/yXg187iGR6smiKTWrGODXXAdZbYqWv8WW9OdFcGrlNc/sCzNochCZaXShuNT
	W4jx9OKQbVKws2UX8dlo+noKuVj6Lp8YkASOKSkFPjZxuxuXHYCOluyQW0d1uPYP31NpNf
	W3FuwJsi7hOqfxjkPQQMnG7eA3LifOw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-0FSzwytgP2iFufjAmQvDhw-1; Thu, 09 May 2024 10:16:03 -0400
X-MC-Unique: 0FSzwytgP2iFufjAmQvDhw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0E0E800206;
	Thu,  9 May 2024 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E9C91C8BECC;
	Thu,  9 May 2024 14:15:58 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Weifeng Liu <weifeng.liu.z@gmail.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] serial: Clear UPF_DEAD before calling tty_port_register_device_attr_serdev()
Date: Thu,  9 May 2024 16:15:49 +0200
Message-ID: <20240509141549.63704-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

If a serdev_device_driver is already loaded for a serdev_tty_port when it
gets registered by tty_port_register_device_attr_serdev() then that
driver's probe() method will be called immediately.

The serdev_device_driver's probe() method should then be able to call
serdev_device_open() successfully, but because UPF_DEAD is still dead
serdev_device_open() will fail with -ENXIO in this scenario:

  serdev_device_open()
  ctrl->ops->open()	/* this callback being ttyport_open() */
  tty->ops->open()	/* this callback being uart_open() */
  tty_port_open()
  port->ops->activate()	/* this callback being uart_port_activate() */
  Find bit UPF_DEAD is set in uport->flags and fail with errno -ENXIO.

Fix this be clearing UPF_DEAD before tty_port_register_device_attr_serdev()
note this only moves up the UPD_DEAD clearing a small bit, before:

  tty_port_register_device_attr_serdev();
  mutex_unlock(&tty_port.mutex);
  uart_port.flags &= ~UPF_DEAD;
  mutex_unlock(&port_mutex);

after:

  uart_port.flags &= ~UPF_DEAD;
  tty_port_register_device_attr_serdev();
  mutex_unlock(&tty_port.mutex);
  mutex_unlock(&port_mutex);

Reported-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/20240505130800.2546640-1-weifeng.liu.z@gmail.com/
Tested-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c476d884356d..b47a277978a0 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3211,6 +3211,9 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (uport->attr_group)
 		uport->tty_groups[1] = uport->attr_group;
 
+	/* Ensure serdev drivers can call serdev_device_open() right away */
+	uport->flags &= ~UPF_DEAD;
+
 	/*
 	 * Register the port whether it's detected or not.  This allows
 	 * setserial to be used to alter this port's parameters.
@@ -3221,6 +3224,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (!IS_ERR(tty_dev)) {
 		device_set_wakeup_capable(tty_dev, 1);
 	} else {
+		uport->flags |= UPF_DEAD;
 		dev_err(uport->dev, "Cannot register tty device on line %d\n",
 		       uport->line);
 	}
@@ -3426,8 +3430,6 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	if (ret)
 		goto err_unregister_port_dev;
 
-	port->flags &= ~UPF_DEAD;
-
 	mutex_unlock(&port_mutex);
 
 	return 0;
-- 
2.44.0


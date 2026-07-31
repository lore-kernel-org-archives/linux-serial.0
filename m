Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC6455170
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521077; cv=none; b=TPplKx7oyB/Xr09uU+UUh6dP6m3W8Lsbqw8QilkF10CqLZztTV2QjehTh2F8P6FQvLRvDFkGEzCZLtFmw6XuK5ia/c6PpQ8C/vHrIx1HN+zuK4ugVpUdDOYL7dRUul+sPsZWrRfOHe0m3y6wzA8LZLzyPMARTzM5yhxBmnv7L5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521077; c=relaxed/simple;
	bh=f2WgAKIx0zZc7BGy0VsUPDEiddYh46CfX4wE+IV1Le0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ei7E9qzlpFiqCNprkilNDi1ixkbSGdztiRJq+IyEvpEuolaW0oVaTI8GlIYBNGajkoy/W6bThlJRqqR5Q9qQRO4Me1Z72UhkO4Xmbukcoc1dS60GQ4WC0LHwN5UNmK3+0dmwQYsJI/Jxwd0pJCL/WTT+JfY+DVaUENGwl8N5xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjMsMfef; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjMsMfef"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fd66a094eso206010f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521061; x=1786125861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ou5GQthySEEBs7kf/0E67tbXvLbnV4y0XvYiP2W//3Q=;
        b=TjMsMfefLcT4NjosP4xj2Y1M6ZJe837Ti/l0Er9DJ462jm7ZOu5i+tvyLn8p6B/+/f
         t1oGt1T+0g4kWIazki98e56O2O3Wz8nF1T/Kc0gXrwootRtWAogz/V/TskSL9Vnivivk
         6Cgihi3FnSNFEM4sJ9qtsTY/Gc6SwMvPacBB+Ko6DsRO5sD1h/RnS72Nt4h6Cz7WVCB4
         UkWvqxv+Rrai2GnHZWPL3MwjNDyqZcTnJGWzzKWzLEbRkufd7yiyROstxys6Y4pOKakP
         5XNyMbR0Nrkepks9gVFgJqJAXxF+6XZNnIpaMt/3ehS/rWi5jI9hUV9WxVn2/v7oFxiJ
         lEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521061; x=1786125861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ou5GQthySEEBs7kf/0E67tbXvLbnV4y0XvYiP2W//3Q=;
        b=iUKw1YqXkNhdc2u9IELgE4qmA91fitwM07OzqRNnctQuO2T6MJNigk7bAmO8Cq2sAf
         BNC5D/xBnoM38vPlWs0/PQA9rUaAD85q82c4cn+flsDFrpJ6kan9wXUye8gYddduWmtx
         b7kkmKik08vLBME6nMH7FELe+gL0wbn2symAuQkDc0vTeFFxLJtB0CpDuyCc2B04CfWj
         rcGcNyrkfI1fZ7uu6+gIDSez6Xcy/S70esfIFj5v8uAsI0a8oZMHPr+RvaFdSyc3i88h
         wbgEe5sJ/flQK4L2hEfngkkThaxuyQ1B3kxEqQC3aLW2x05fdjfG+//7ch6TZtRjnQu+
         +9OQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMjm7dJJ5w6l8T8ITHgJ3PzWaHd8kBA3LDf8I4BDsN2cBX8w32B7vt+KQ+yudRfF7bxXwrdRagNh+drbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPtqIy2g+IBJvt+5ReJ+teil8ncs3H+jxGqCuitUDxtjtOguK
	nKhaPL81XcMY7ahgZ1pfprBBBYNzO1C8Z5uyllp1H8kr7uJKu4YONTH3u1Uyvs7r
X-Gm-Gg: AR+sD13+F7eDkTLiL1ayWioNWl0l1faz44OU5IP9xjwihAOHiQXOkJtoV5O6IzprO8S
	DwHSlh+4tHOSxiN0e27tpzU+6YLLyHveAL+coA/Q1keJexRIWrNkRthNDm9UHkBN3Tj/l//m85+
	L5EIqMOjSnR0M95P0tWpJP26yvcEaRWsAcamfYFqxSeDUMnVBOCBavN+yI8k7+iNTjT1MYJIbQW
	0j/htZmu+Jlz7hHI6Xa1Mv9ZfDfx1cWT2NcYHN7hnZRmbauFdkDk7/yD5tm6dB2Z0gjFIN394JL
	4N2BB3nQbu/VAxArb+449LKllsPoPSYRttraU2rbEwCFL2xQbLjlY9JtBGD69ifgbkFtVfavaV6
	71vQnR783Nkbf96EbY5MLoGT/J/ZTRoaKDlPuPCBa9jZIrfw0eZUhk3Y8wj0dzfXVq0F9jIQvkX
	I6zUGQJBL0KdQl77xXZLTYizqzSzIZ7K2wql4IFRUT026Gg3obQUWKGCX2PdfT0aA11808GTRwj
	sULIscuIoxF9ugd9hRx3VeoH/vHzWRvsIcJ6bDPa6jugYhxnUi3LZxeTk7CfDA386lcrEcczTaJ
	OKEDtlhF5M2oUrehd9PQWRwcckrAUhto3fk4npD1VvC3rxQVan8QJZtaORHhLUGVHJD2cTQzhZz
	9LdQ=
X-Received: by 2002:a05:6000:25fa:b0:47f:8f8f:e493 with SMTP id ffacd0b85a97d-47fd72ba69cmr1357621f8f.3.1785521060926;
        Fri, 31 Jul 2026 11:04:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2cf1sm7184041f8f.10.2026.07.31.11.04.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:04:20 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] serial: core: clear freed pointers on uart_register_driver() failure
Date: Fri, 31 Jul 2026 20:04:12 +0200
Message-Id: <20260731180412.10874-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_register_driver() leaves drv->state pointing to freed memory when
tty_alloc_driver() fails. If tty_register_driver() fails, drv->tty_driver
also retains a pointer after its reference is dropped.

Drivers that use drv->state as an "already registered" flag can then skip
registration on the next probe and pass the freed state to
uart_add_one_port().

This issue was found with failslab on QEMU's raspi1ap board by
failing registration and binding the PL011 port again.

Clear both pointers on their failure paths, as uart_unregister_driver()
already does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 9e845abfc8a8 ("serial: fix NULL pointer dereference")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 03ee3d038f4e..234976fb2a87 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2777,8 +2777,10 @@ int uart_register_driver(struct uart_driver *drv)
 	for (i = 0; i < drv->nr; i++)
 		tty_port_destroy(&drv->state[i].port);
 	tty_driver_kref_put(normal);
+	drv->tty_driver = NULL;
 out_kfree:
 	kfree(drv->state);
+	drv->state = NULL;
 out:
 	return retval;
 }
-- 
2.53.0

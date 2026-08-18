Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0744C2D6E5C
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079125; cv=none; b=o4mMaG8pzT/Vn7pl6W12/VEdqySCvJRa7D4dfW73RzuV8Cc9bcu1f5yC4SKPpuukA9Umwy9w7WIe0K3pXahDX66g8QcblQohQNDVMuDynD/PhRysY18fd4M5yeCL8pcR0yg44FtnQQCWljqgVViZ1nFsWIFOFa1/tdi3a8/L28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079125; c=relaxed/simple;
	bh=Hrs/9NMsr5HJTULUw2It4HagL6BuCS8FHkZ5uh6OwzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vc7Xd5G8uow2WZHezebwLiUs1qB5uUOORErrcBqonH09kzjjh4EhlyJ5ReAViIVU22WANAA3+ftRbYeNpxnyAS4giMQpYUDXAVfF35YDr+hLtIBVbUjt7QTbaPxCzt9PjGeLQMkawj2LordvGUzHbiOKO9m+fzaYxGk6rEk2siE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so1070905e9.2
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 11:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787079122; x=1787683922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZ5z7fwve5FMy5m1IMm5ZFxSUCweCqJ2mA7pSyCd4EE=;
        b=E9nU6eMrkuAnarK4OuKoutWqRlx4H5gtY0azLIY7fhYXbJ/bP+0IvVMtXvXwW7p3sk
         wz65oKPzjCy63zr0TbEfuIOreZ8DH+8j86TwZjHymHPv6DnuMj/AKsXwrA3l4azMDf4n
         FkTk3V5jfV6coeBvJXfnL2brpuUrfSQG0LjkUe5RNEsb+S3O82hknQbPWX8fGVRSb1pf
         hXMrOVOaNwwvCd0vu7Z8t5ohP4v8bGbgDDy0+gVdJKSoaBCfK5I3ikv/shTqqEIH7cjd
         BN4OpJid2/2/E+mjnjoPmht6YiYC3TMTvDTup0Zb+bRv8DqK7MHZHCU1jsVAFaYFS67m
         iiGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnvrYgqMbcB+x4PPVRlEoNTmaU2MIwC4TFobYKfVWf5TPRDq8oM/HbY2vMeJ1b9neaKuQLfCENR3rxQVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6uJYdbtEMP/dmtiY3Q32vzo6bjqCi3EfWqGFEkgnOcqts9e7g
	o3xwSy3r3tFVXmiR0HT0lvGo/zQzzFgHTlekkNgzoHTTpIWPaW3MI3Tz
X-Gm-Gg: AR+sD110NI8hCvmFzawkZ9JTxdoaVr7z1ct0aaA8ACCvSspQJk2ee0ATOYiRMkUvfP9
	3doau3YoW0Pf9xrFAtA5OYxwaxwlWkFbM+jSmHlCOiDBTNKMoRDFbSO7FiXuGy+YKE6MDWA7I9/
	aus0/Mu70Mb7Jb1d72OuMg364Szn14fufPJ5cdwNaGdQ+LHI0Sm63fDgxilv9rmunyOX7BtphX2
	f+xChwIivRgVSlC8gqy3MLIfr8C4xWsDIY2ZR0vAsA1QWBVgsupJysjSQg1KbBLzzo5haa0XmcT
	TqM7BguKOJQ6wosP+rx0j7HJZK2RXaRwSGEy4K+ihXJkTLsdqz95+JxILm5e0r78leeiqGTpGL0
	0/NucPssA+8hlDsi/fu6RCQZ9DZ9DWBEZzukp9fcAAZvbM0LTsLXIM0i9hK0d/zYeB5at+zD1rp
	hzF9ZO1ISqqTklGdmt5JrPnL7ONMel/1q/7miNeA3SaK8ciyKIa1pcZ1EifEXn+H9ukxls7Glac
	LizWufZMkSmR07EQVhLOITEbi4=
X-Received: by 2002:a05:600c:8b6f:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-499a8f62d13mr2823225e9.6.1787079122068;
        Tue, 18 Aug 2026 11:52:02 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b816c0sm14257310f8f.33.2026.08.18.11.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:52:01 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: don't register ports that have no hardware
Date: Tue, 18 Aug 2026 19:52:00 +0100
Message-ID: <20260818185200.10243-1-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 8250 driver creates a fixed set of port slots at boot and
registers a ttyS device for each one, even when the slot describes no
hardware. On device tree platforms those slots are empty, but they
still take the ttyS0..ttyS3 names.

New Amlogic SoCs (S4, T7) name their real UARTs ttyS as well. With
both drivers built in, as in arm64 defconfig, the real port fails to bind:

  sysfs: cannot create duplicate filename '/class/tty/ttyS0'
  meson_uart fe078000.serial: Cannot register tty device on line 0

Skip slots that have no I/O and no memory address. Legacy x86 slots
come with resources and are not affected.

Signed-off-by: Lucas Tanure <tanure@linux.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/tty/serial/8250/8250_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f49862d90eeb..e66e0cdbb210 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -378,6 +378,14 @@ void __init serial8250_register_ports(struct uart_driver *drv, struct device *de
 		if (up->port.dev)
 			continue;
 
+		/*
+		 * Skip slots that describe no hardware: they would only
+		 * take up ttyS<n> names. Real ports get their node when
+		 * they claim a slot in serial8250_register_8250_port().
+		 */
+		if (!up->port.iobase && !up->port.mapbase && !up->port.membase)
+			continue;
+
 		up->port.dev = dev;
 
 		if (uart_console_registered(&up->port))
-- 
2.55.0


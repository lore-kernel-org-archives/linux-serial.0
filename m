Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59F2571B8;
	Fri, 31 Jul 2026 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490793; cv=none; b=A67/FzI/I2ShkxNisUfSzeqNFTaLdsd7/nULl4d6nCGzx+ZrLgZ3tEwYh2QdLd7U4eT6dqEdHVapvV/JKSDe1f+WHwXtTn74+J5mNSsDI7nWbG8rIUdOqZio/QOrjHa37vCWVAOdd/gdk+amzqsPDJxeqd4yvDWkGxYOQ7aVlYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490793; c=relaxed/simple;
	bh=qpY7AgeLtloKboCTPUJdGHGeqUKP2v6Av7OeXI92rLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8gmM32DmaL3eZAU54YsA0adqmbsgaJ7RUK5I54bv4FzNO2X/tUJXiDTwwcEsmzeKQTWX2/Xg6Pt9gqbkcP9Y9/Hgp6F2iitTCiWCF75xfJMmBo0e/BwuFv80DtYKVaKtyY49OhvQ8K9S9Yxw5qsajZ5twggm6Is0qPtUHUQodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgODjDdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgODjDdu"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2205A1F00A3A;
	Fri, 31 Jul 2026 09:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490788;
	bh=gCnifO7YGokBDy4pddwRpI2M8VTQL87Sux7PhHHvXJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CgODjDdu+xTEn7jd2pY2iQ2fx3qyA9jezsF/hIf/0er39cDmS3O9qvvveidNcllku
	 e1jKj3AENIptIenuACJA4FLCq4JPgpHJrPYqs6wgW8V67kY6TnxtUhLpAEu0vBpJuD
	 RkaJpz0nT7Bb6apk8i5UqHN9we6r7HNAITQ7J2xmMYTgAQQH+to54v37urVAUYA79E
	 JBrQpcGz2W14az9QzzLLkpRqTTGqwtfuo8P85UFiv47xjWcizPQ7VOLopoGuD8CXVz
	 fNIoXPa2cqUFHrRvbcEIYzfQWRs0ratW8FhUYCZpyv4W2iTeVYPGAHeswRjbgL4C4O
	 wrsletjtQB53A==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	Kees Cook <kees@kernel.org>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 5/6] serial: 8250: hub6: Add cleanup code
Date: Fri, 31 Jul 2026 11:39:08 +0200
Message-ID:  <7f55243755253d7c76c5f2e188fd1df4f923a265.1785489518.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785489518.git.ukleinek@kernel.org>
References: <cover.1785489518.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=ukleinek@kernel.org; h=from:subject:message-id; bh=qpY7AgeLtloKboCTPUJdGHGeqUKP2v6Av7OeXI92rLk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqbG1MU1fbVCbY/yRGe54TazsRu2JJjc1Gdbw/V sDyqJj1Ss+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCamxtTAAKCRCPgPtYfRL+ TgbSCACQrruUuvTzPOOsk6DvCyBLQQPFgEmfO5kpz5XExmK6u5rgNWHd4O7qfl+a2cDEI6O0DpK P3D51oYbvbrYg3gzNS267PHpN3It93WSK+p9pQR/YYx7uLuuSOJbmmzs+Efgvi0nCJmmCHiV7sD ziOKk3QafkCQzhOaa8irAdqDeCM6vf7FDejRBJXDfaSP0ULSDFmzCqKUA7QNieJJZm3h4JpmnIu 0Jzf3oktY7UTcLlbgIuIwCbrWXVjep8BZ5pHT04yUcvLUd6Pe/9Br7XqX2+7LPKp+3+NeKBNjnp jepL058EMKSshfURc4LkdMTNb1bYE/19pSUal41PIiLpYtSZ
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

At module load time a platform device is registered. That should be
undone when the module is unloaded.

Fixes: ec9f47cd6a14 ("[PATCH] Serial: Split 8250 port table")
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/tty/serial/8250/8250.h          | 2 ++
 drivers/tty/serial/8250/8250_hub6.c     | 5 +++++
 drivers/tty/serial/8250/8250_platform.c | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 39d72f1480c0..01fed8d44b7b 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -317,8 +317,10 @@ static inline void serial8250_pnp_exit(void) { }
 
 #ifdef CONFIG_SERIAL_8250_HUB6
 int serial8250_hub6_init(void);
+void serial8250_hub6_exit(void);
 #else
 static inline int serial8250_hub6_init(void) { return 0; }
+static inline void serial8250_hub6_exit(void) { }
 #endif
 
 #ifdef CONFIG_SERIAL_8250_RSA
diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
index 3e548530ec4e..55320b794165 100644
--- a/drivers/tty/serial/8250/8250_hub6.c
+++ b/drivers/tty/serial/8250/8250_hub6.c
@@ -53,3 +53,8 @@ int __init serial8250_hub6_init(void)
 {
 	return platform_device_register(&hub6_device);
 }
+
+int __init_or_module serial8250_hub6_exit(void)
+{
+	return platform_device_unregister(&hub6_device);
+}
diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index e8524d545de9..72076ccb5bde 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -326,7 +326,7 @@ static int __init serial8250_init(void)
 	serial8250_isa_devs = platform_device_alloc("serial8250", PLAT8250_DEV_LEGACY);
 	if (!serial8250_isa_devs) {
 		ret = -ENOMEM;
-		goto unreg_pnp;
+		goto unreg_hub6;
 	}
 
 	ret = platform_device_add(serial8250_isa_devs);
@@ -342,6 +342,8 @@ static int __init serial8250_init(void)
 	platform_device_del(serial8250_isa_devs);
 put_dev:
 	platform_device_put(serial8250_isa_devs);
+unreg_hub6:
+	serial8250_hub6_exit();
 unreg_pnp:
 	serial8250_pnp_exit();
 unreg_uart_drv:
@@ -369,6 +371,7 @@ static void __exit serial8250_exit(void)
 	platform_driver_unregister(&serial8250_isa_driver);
 	platform_device_unregister(isa_dev);
 
+	serial8250_hub6_exit();
 	serial8250_pnp_exit();
 
 #ifdef CONFIG_SPARC
-- 
2.55.0.11.g153666a7d9bb


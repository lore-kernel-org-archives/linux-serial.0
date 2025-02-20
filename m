Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3020CCD7;
	Thu, 20 Feb 2025 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050205; cv=none; b=vCtIabA0HoFwpJHOgVTn/Gj/vutWTGtVhXGeGIGuv1jKLClp4Bbz1iU2LR3SjAHpQ7xBcZz2KTUZOpZEPZ8qhcbh03X0iAYYe6TcCEKkBiWXevjvrvCirWCVAHBICKD87l2l6wmqaELWK8gLSiULkfX4OC6X6gKEjVOvyMTDh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050205; c=relaxed/simple;
	bh=tPBF9LP8wAH3H57CScf2FsBy11Kw5FRN6WCAO0fbggk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAqT5/fDI91ljJ7duA/2tocNIj91tJ+Lrbpnso9Jl8opw/oagGyIy7Pl7YTxIV4xAZxg8wlhJmTgxRipJ8y/o+iUVh80EK6bLDtmDRMYnolhKqHEpoKbepXSNy72eRCZUNCWC3Gcau8/c+6Zw309QOiZ/FEVF3USOZfh7Oi9ep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRohVHA0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRohVHA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21C6C4CED1;
	Thu, 20 Feb 2025 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050205;
	bh=tPBF9LP8wAH3H57CScf2FsBy11Kw5FRN6WCAO0fbggk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lRohVHA0aA4Ema3KugqZoT7KSj2Hw/mvfiLf7yl+6nnDvhpBHjD4kWkkwRFmIBxbp
	 6vpS6JgCoyo/XzMZUnwAoErbN08kaO/9qRe0bZ6veWute3WwuHpkCzLEQMzLnj3dI4
	 Eq6L+Agy7Psg3GMy/Jb1Cq5J/YNIVm+CcyUmKA0DPUPCOfyKcuFOCvFuXSXEIqz0ok
	 t1LflpFIjNgPdnsLb0JYIoR5JY/Fq5H056Oblbt99t9oTg8R3y6Il1JYGN8rd0gH7T
	 TNop/1Bqy0zkK6rQ3ysLnjj63htPtYdvp3NQDvLxhgdM7bMPCT+Y2abIOuEb6bj96K
	 3v5CrVmN0OO3A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH 20/29] tty: srmcons: fix retval from srmcons_init()
Date: Thu, 20 Feb 2025 12:15:57 +0100
Message-ID: <20250220111606.138045-21-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value returned from srmcons_init() was -ENODEV for over 2 decades.
But it does not matter, given device_initcall() ignores retvals.

But to be honest, return 0 in case the tty driver was registered
properly.

To do that, the condition is inverted and a short path taken in case of
error.

err_free_drv is introduced as it will be used from more places later.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 62 ++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 3e61073f4b30..b9cd364e814e 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -196,40 +196,44 @@ static const struct tty_operations srmcons_ops = {
 static int __init
 srmcons_init(void)
 {
+	struct tty_driver *driver;
+	int err;
+
 	timer_setup(&srmcons_singleton.timer, srmcons_receive_chars, 0);
-	if (srm_is_registered_console) {
-		struct tty_driver *driver;
-		int err;
-
-		driver = tty_alloc_driver(MAX_SRM_CONSOLE_DEVICES, 0);
-		if (IS_ERR(driver))
-			return PTR_ERR(driver);
-
-		tty_port_init(&srmcons_singleton.port);
-
-		driver->driver_name = "srm";
-		driver->name = "srm";
-		driver->major = 0; 	/* dynamic */
-		driver->minor_start = 0;
-		driver->type = TTY_DRIVER_TYPE_SYSTEM;
-		driver->subtype = SYSTEM_TYPE_SYSCONS;
-		driver->init_termios = tty_std_termios;
-		tty_set_operations(driver, &srmcons_ops);
-		tty_port_link_device(&srmcons_singleton.port, driver, 0);
-		err = tty_register_driver(driver);
-		if (err) {
-			tty_driver_kref_put(driver);
-			tty_port_destroy(&srmcons_singleton.port);
-			return err;
-		}
-		srmcons_driver = driver;
-	}
 
-	return -ENODEV;
+	if (!srm_is_registered_console)
+		return -ENODEV;
+
+	driver = tty_alloc_driver(MAX_SRM_CONSOLE_DEVICES, 0);
+	if (IS_ERR(driver))
+		return PTR_ERR(driver);
+
+	tty_port_init(&srmcons_singleton.port);
+
+	driver->driver_name = "srm";
+	driver->name = "srm";
+	driver->major = 0;	/* dynamic */
+	driver->minor_start = 0;
+	driver->type = TTY_DRIVER_TYPE_SYSTEM;
+	driver->subtype = SYSTEM_TYPE_SYSCONS;
+	driver->init_termios = tty_std_termios;
+	tty_set_operations(driver, &srmcons_ops);
+	tty_port_link_device(&srmcons_singleton.port, driver, 0);
+	err = tty_register_driver(driver);
+	if (err)
+		goto err_free_drv;
+
+	srmcons_driver = driver;
+
+	return 0;
+err_free_drv:
+	tty_driver_kref_put(driver);
+	tty_port_destroy(&srmcons_singleton.port);
+
+	return err;
 }
 device_initcall(srmcons_init);
 
-
 /*
  * The console driver
  */
-- 
2.48.1


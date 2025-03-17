Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBA227EA0;
	Mon, 17 Mar 2025 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194883; cv=none; b=kPvT2h75HFugUQQjDUicJTyYXQNchAGuU6XdmB0zmBUv2nuIClGaXnwb5Nk3ZR6M8hYnu8qQyghf/1Prt8DfVlGZn9/DmtR8fSQfLm5v2V1U2VURcgv+dF0VqAgBNAIG8ghyGWtYZi1hAUsUNlgQwgaAENfXYUTqIz5ikkwZiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194883; c=relaxed/simple;
	bh=v8oZT0IKC5IPe84sRzSPnPuvDgwhp1nOfVg8uzoJ0I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LycyfGatAuXQGK6nE3J5/pR9TEWmrEXjrSFKLePs4AxFYAJVagl+saqdzZXedVcCuHbEpyxZPV6yKC7L6cu8G40vhnEXiE1lBIoQo7O2GqYrI2WwsCkByytKZwCWuoFtUQbfN5fJVcm8H4iaFnfx8AnD4JrASHI4Wl9RgpGfE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7j8waX7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7j8waX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE10FC4CEE3;
	Mon, 17 Mar 2025 07:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194883;
	bh=v8oZT0IKC5IPe84sRzSPnPuvDgwhp1nOfVg8uzoJ0I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7j8waX70V9pOoAhkeCEcFIc109MLth1Bmd/tPCedJN9AAFDyWnuXRAf605sDYYz+
	 iQ4CmsB7axXUKDBmHwfS3DeVFGVnRODw0z3I+IqmZkUyXBtde+i/oeC4yA+Osoo8Sk
	 UF1i1TQi/PqybfOmBnOmx+l/FSNFxkWQp3eEnI9pCBLSfItGDomQR0Bceq+iIyhmWt
	 KEnrdXO+aJBhVB59yioDykSxlPzimi6MJyny6utgzoUjCLtFZn6SaMzT7rSG3KYpq1
	 uRZdHfEMZAX8BBwWhopeANO5FiPkf7TlpI8DwmVI8divMNpNAk8paREZmWCw7pwZFf
	 NlSamAYmCmrmA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	linux-alpha@vger.kernel.org
Subject: [PATCH v2 21/31] tty: srmcons: fix retval from srmcons_init()
Date: Mon, 17 Mar 2025 08:00:36 +0100
Message-ID: <20250317070046.24386-22-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
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
Tested-by: Magnus Lindholm <linmag7@gmail.com>
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
2.49.0


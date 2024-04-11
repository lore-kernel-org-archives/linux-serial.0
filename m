Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00425664DD
	for <linux-serial@vger.kernel.org>; Thu, 11 Apr 2024 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822807; cv=none; b=pd7CCK7xZoMIH8mLiBuQWHhHxeHDDKLJwbMU5pRa/Fxt8feIN3yNNWHdu2vkae1W78+uS3+X3I3ZVzhPOQea1/9Cp56GtelH2ReFQyXFvPkamGKErBPqLPvtnN9RwfHCjP9/JHsqzUheHVjSMV978MqG0vYT2gSiUYwykSwnySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822807; c=relaxed/simple;
	bh=JIuWOZnE9EBJOzdNbrzfgvDB7J6q0T3p/XWTIbJVfuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzbaBcX4vsAD89OoXeMlXwKnv9vQouj+Kr1k1qzBJNT0u78YlWajlGacTpDrv5hNH2IdNgSrjY7GWM8e1jCrmBWjbjd2/IxKGhIfR1jWz4pjf2Mm0kD52tYLgBhLwbmpqy/mN+hFOEfL3t8ySanC8j3QI0WklSa0MTFjUefvpWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=WEMYDofl; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="WEMYDofl"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 728B160368;
	Thu, 11 Apr 2024 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712822799;
	bh=JIuWOZnE9EBJOzdNbrzfgvDB7J6q0T3p/XWTIbJVfuo=;
	h=From:To:Cc:Subject:Date:From;
	b=WEMYDoflyrbwOghrn91lbSliGzJa7FWXw/Qway3/+qYg84mxlOUZwjKgoitExH41f
	 dhiJjSCRKyb9ztrSIJuVwOumW6W+UaFYGTBeqjGmdEVMlWWD4PBnu1uaL+a4ToFy1/
	 jvDDDL86YqB1MT1sfVBzKvv8guLUHMqqYeiKlMysrs1fei42yG4J3hEitT/u4wM2nU
	 xYbiqL7C6Rr7kSmeQj5WBGaxjziVZWwZxryB5U6+duGFjhoBFLbUBBo0HiUBbbUY3u
	 XtsTt+ARdgmydp/4k8xWeZrO2M/aKtTUNhefbbaPJ+tYcf0jGIWOTuK/BJNfyGNonh
	 eWFYF/K8T4rlw==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: Fix add preferred console for serial8250_isa_init_ports()
Date: Thu, 11 Apr 2024 11:06:20 +0300
Message-ID: <20240411080622.11929-1-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to inline serial_base_add_isa_preferred_console()  based on
CONFIG_SERIAL_8250_CONSOLE and not based on CONFIG_SERIAL_CORE_CONSOLE.
Otherwise we can get the follwoing error as noted by Stephen:

ERROR: modpost: "serial_base_add_isa_preferred_console"
[drivers/tty/serial/8250/8250.ko] undefined!

We also have a duplicate inlined serial_base_add_isa_preferred_console(),
in serial_base_bus.c added by the same commit by accident, let's drop it.

Fixes: a8b04cfe7dad ("serial: 8250: Add preferred console in serial8250_isa_init_ports()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base.h     | 10 ++++++++--
 drivers/tty/serial/serial_base_bus.c | 11 ++---------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -51,8 +51,6 @@ void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port
 int serial_base_add_preferred_console(struct uart_driver *drv,
 				      struct uart_port *port);
 
-int serial_base_add_isa_preferred_console(const char *name, int idx);
-
 #else
 
 static inline
@@ -62,6 +60,14 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 	return 0;
 }
 
+#endif
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+
+int serial_base_add_isa_preferred_console(const char *name, int idx);
+
+#else
+
 static inline
 int serial_base_add_isa_preferred_console(const char *name, int idx)
 {
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -219,6 +219,8 @@ static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
 	return ret;
 }
 
+#endif
+
 #ifdef __sparc__
 
 /* Handle Sparc ttya and ttyb options as done in console_setup() */
@@ -329,15 +331,6 @@ int serial_base_add_isa_preferred_console(const char *name, int idx)
 	return serial_base_add_prefcon(name, idx);
 }
 
-#else
-
-int serial_base_add_isa_preferred_console(const char *name, int idx)
-{
-	return 0;
-}
-
-#endif
-
 #endif
 
 static int serial_base_init(void)
-- 
2.44.0

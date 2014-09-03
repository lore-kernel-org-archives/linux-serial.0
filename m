From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 3.17-rc3] serial: kgdb_nmi: No CON_ENABLED by default
Date: Wed,  3 Sep 2014 12:57:52 +0100
Message-ID: <1409745472-2830-1-git-send-email-daniel.thompson@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55927 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbaICL6T (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Sep 2014 07:58:19 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so748116wiv.7
        for <linux-serial@vger.kernel.org>; Wed, 03 Sep 2014 04:58:18 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

At present this console is optionally registered by NULL checking
arch_kgdb_ops.enable_nmi. In practice this requires the architecture
dependant code to implement some kind of control (e.g. module arguments)
to enable/disable this feature.

The kernel already provides us the perfectly adequate console= argument
to enable/disable consoles. Let's use that instead!

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/kgdb_nmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 6ec7501..129dc5b 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -46,6 +46,8 @@ static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);

 static int kgdb_nmi_console_setup(struct console *co, char *options)
 {
+	arch_kgdb_ops.enable_nmi(1);
+
 	/* The NMI console uses the dbg_io_ops to issue console messages. To
 	 * avoid duplicate messages during kdb sessions we must inform kdb's
 	 * I/O utilities that messages sent to the console will automatically
@@ -77,7 +79,7 @@ static struct console kgdb_nmi_console = {
 	.setup  = kgdb_nmi_console_setup,
 	.write	= kgdb_nmi_console_write,
 	.device	= kgdb_nmi_console_device,
-	.flags	= CON_PRINTBUFFER | CON_ANYTIME | CON_ENABLED,
+	.flags	= CON_PRINTBUFFER | CON_ANYTIME,
 	.index	= -1,
 };

@@ -354,7 +356,6 @@ int kgdb_register_nmi_console(void)
 	}

 	register_console(&kgdb_nmi_console);
-	arch_kgdb_ops.enable_nmi(1);

 	return 0;
 err_drv_reg:
--
1.9.3


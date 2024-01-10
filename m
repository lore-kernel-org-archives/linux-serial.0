Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4154A992
	for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:b0d9:a4e2:30ba:1f13])
	by albert.telenet-ops.be with bizsmtp
	id Z2Dn2B0071LwnfP062DntR; Wed, 10 Jan 2024 15:13:48 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rNZKK-00F4Hl-UA;
	Wed, 10 Jan 2024 15:13:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rNYWm-007fie-3M;
	Wed, 10 Jan 2024 14:21:52 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Philip Blundell <philb@gnu.org>,
	Kars de Jong <jongk@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] serial: 8250: Move hp300_setup_serial_console() to <linux/serial_8250.h>
Date: Wed, 10 Jan 2024 14:21:46 +0100
Message-Id: <c17469f8e47b2ef49234a85a7a14882ddf374e41.1704892597.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If CONFIG_SERIAL_8250_HP300=y and CONFIG_SERIAL_8250_CONSOLE=y (e.g.
m68k/allyesconfig):

    drivers/tty/serial/8250/8250_hp300.c:91:12: error: no previous prototype for ‘hp300_setup_serial_console’ [-Werror=missing-prototypes]
       91 | int __init hp300_setup_serial_console(void)
	  |            ^~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by moving the existing prototype in arch/m68k/hp300/config.c to
<linux/serial_8250.h>, so it is visible to both caller and implementor.
While at it, provide a dummy in case CONFIG_SERIAL_8250_CONSOLE is not
enabled, to reduce #ifdef clutter in the caller.

Exposed by commit 0fcb70851fbfea17 ("Makefile.extrawarn: turn on
missing-prototypes globally").

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/hp300/config.c    | 6 +-----
 include/linux/serial_8250.h | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/hp300/config.c b/arch/m68k/hp300/config.c
index e4bd6913f50e9ef3..1a27398523517a65 100644
--- a/arch/m68k/hp300/config.c
+++ b/arch/m68k/hp300/config.c
@@ -10,6 +10,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/serial_8250.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/console.h>
@@ -67,9 +68,6 @@ static char *hp300_models[] __initdata = {
 static char hp300_model_name[13] = "HP9000/";
 
 extern void hp300_reset(void);
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-extern int hp300_setup_serial_console(void) __init;
-#endif
 
 int __init hp300_parse_bootinfo(const struct bi_record *record)
 {
@@ -263,7 +261,5 @@ void __init config_hp300(void)
 	} else {
 		panic("Unknown HP9000 Model");
 	}
-#ifdef CONFIG_SERIAL_8250_CONSOLE
 	hp300_setup_serial_console();
-#endif
 }
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index be65de65fe612007..fd59ed2cca53e967 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -210,6 +210,12 @@ int serial8250_console_exit(struct uart_port *port);
 void serial8250_set_isa_configurator(void (*v)(int port, struct uart_port *up,
 					       u32 *capabilities));
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+extern int hp300_setup_serial_console(void) __init;
+#else
+static inline int hp300_setup_serial_console(void) { return 0; }
+#endif
+
 #ifdef CONFIG_SERIAL_8250_RT288X
 int rt288x_setup(struct uart_port *p);
 int au_platform_setup(struct plat_serial8250_port *p);
-- 
2.34.1


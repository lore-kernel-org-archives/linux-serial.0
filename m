From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/4] earlycon: mark earlycon code as __used iif the caller is built-in
Date: Mon,  6 Jun 2016 18:41:00 +0900
Message-ID: <1465206063-1018-2-git-send-email-yamada.masahiro@socionext.com>
References: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Paul Burton <paul.burton@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Keep earlycon related symbols only when CONFIG_SERIAL_EARLYCON is
enabled and the driver is built-in.  This will be helpful to clean
up ifdefs surrounding earlycon code in serial drivers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/serial_core.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a3d7c0d..2f44e20 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -352,9 +352,15 @@ struct earlycon_id {
 extern const struct earlycon_id __earlycon_table[];
 extern const struct earlycon_id __earlycon_table_end[];
 
+#if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
+#define EARLYCON_USED_OR_UNUSED	__used
+#else
+#define EARLYCON_USED_OR_UNUSED	__maybe_unused
+#endif
+
 #define OF_EARLYCON_DECLARE(_name, compat, fn)				\
 	static const struct earlycon_id __UNIQUE_ID(__earlycon_##_name)	\
-	     __used __section(__earlycon_table)				\
+	     EARLYCON_USED_OR_UNUSED __section(__earlycon_table)	\
 		= { .name = __stringify(_name),				\
 		    .compatible = compat,				\
 		    .setup = fn  }
-- 
1.9.1

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] serial: 8250: describe CONFIG_SERIAL_8250_RSA
Date: Sat, 05 Mar 2016 18:35:30 +0100
Message-ID: <56DB18E2.5010503@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Kiyokazu SUTO <suto@ks-and-ks.ne.jp>
List-Id: linux-serial@vger.kernel.org

CONFIG_SERIAL_8250_RSA has waited for a long
time to have meaningful help text so let's
finally describe what this option actually does.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/tty/serial/8250/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 67ad6b0d595b..48976cbedafd 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -262,7 +262,12 @@ config SERIAL_8250_RSA
 	bool "Support RSA serial ports"
 	depends on SERIAL_8250_EXTENDED
 	help
-	  ::: To be written :::
+	  Say Y here if you have a IODATA RSA-DV II/S ISA card and
+	  would like to use its >115kbps speeds.
+	  You will need to provide module parameter "probe_rsa", or boot-time
+	  parameter 8250.probe_rsa with I/O addresses of this card then.
+
+	  If you don't have such card, or if unsure, say N.
 
 config SERIAL_8250_ACORN
 	tristate "Acorn expansion card serial port support"

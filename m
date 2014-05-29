From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH tty-next v2 1/4] serial: cpm_uart: No LF conversion in put_poll_char()
Date: Thu, 29 May 2014 09:48:43 +0100
Message-ID: <1401353326-14148-2-git-send-email-daniel.thompson@linaro.org>
References: <20140528200344.GA2750@kroah.com>
 <1401353326-14148-1-git-send-email-daniel.thompson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401353326-14148-1-git-send-email-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, linux-serial@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Colin Cross <ccross@android.com>, kernel-team@android.com, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, Jiri Slaby <jslaby@suse.cz>, Dirk Behme <dirk.behme@de.bosch.com>, Doug Anderson <dianders@chromium.org>, Christophe Leroy <christophe.leroy@c-s.fr>
List-Id: linux-serial@vger.kernel.org

In (c7d44a02a serial_core: Commonalize crlf when working w/ a non open
console port) the core was modified to make the UART poll_put_char()
automatically convert LF to CRLF. This driver's poll_put_char() adds a
CR itself and this was not disabled by the above patch meaning
currently it sends two CR characters.

The code to issue a character is shared by the console write code (where
driver must do LF to CRLF conversion, although it can make use of the
uart_console_write() helper function) and the poll_put_char (where
driver must not do the conversion). For that reason we add a flag rather
than simply rip out the conversion code.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 7d76214..aa60e6d 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -971,7 +971,7 @@ static void cpm_uart_config_port(struct uart_port *port, int flags)
  * Note that this is called with interrupts already disabled
  */
 static void cpm_uart_early_write(struct uart_cpm_port *pinfo,
-		const char *string, u_int count)
+		const char *string, u_int count, bool handle_linefeed)
 {
 	unsigned int i;
 	cbd_t __iomem *bdp, *bdbase;
@@ -1013,7 +1013,7 @@ static void cpm_uart_early_write(struct uart_cpm_port *pinfo,
 			bdp++;
 
 		/* if a LF, also do CR... */
-		if (*string == 10) {
+		if (handle_linefeed && *string == 10) {
 			while ((in_be16(&bdp->cbd_sc) & BD_SC_READY) != 0)
 				;
 
@@ -1111,7 +1111,7 @@ static void cpm_put_poll_char(struct uart_port *port,
 	static char ch[2];
 
 	ch[0] = (char)c;
-	cpm_uart_early_write(pinfo, ch, 1);
+	cpm_uart_early_write(pinfo, ch, 1, false);
 }
 #endif /* CONFIG_CONSOLE_POLL */
 
@@ -1275,7 +1275,7 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 		spin_lock_irqsave(&pinfo->port.lock, flags);
 	}
 
-	cpm_uart_early_write(pinfo, s, count);
+	cpm_uart_early_write(pinfo, s, count, true);
 
 	if (unlikely(nolock)) {
 		local_irq_restore(flags);
-- 
1.9.0

From: Maxime COQUELIN <maxime.coquelin@st.com>
Subject: [PATCH 1/2] serial: st-asc: Don't call BUG in asc_console_setup()
Date: Thu, 24 Jul 2014 14:02:55 +0200
Message-ID: <1406203376-18203-2-git-send-email-maxime.coquelin@st.com>
References: <1406203376-18203-1-git-send-email-maxime.coquelin@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406203376-18203-1-git-send-email-maxime.coquelin@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Srinivas Kandagatla <srinivas.kandagatla@linaro.com>, Patrice Chotard <patrice.chotard@st.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com
List-Id: linux-serial@vger.kernel.org

In order to prevent an asc instance to be used as early console, BUG_ON is
used on either mapbase or membase being NULL.

Problem is that this condition is also true when we set console to be a ttyASx
different to the first asc instance being probed.

Instead of calling BUG_ON, it now returns -ENXIO when either mapbase or
membase is NULL.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/tty/serial/st-asc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index f48b1cc..2369bc0 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -849,7 +849,8 @@ static int asc_console_setup(struct console *co, char *options)
 	 * this to be called during the uart port registration when the
 	 * driver gets probed and the port should be mapped at that point.
 	 */
-	BUG_ON(ascport->port.mapbase == 0 || ascport->port.membase == NULL);
+	if (ascport->port.mapbase == 0 || ascport->port.membase == NULL)
+		return -ENXIO;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-- 
1.9.1

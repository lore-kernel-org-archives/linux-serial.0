From: =?iso-8859-1?Q?Christoph_Vogtl=E4nder?=
        <Christoph.Vogtlaender@sigma-surface-science.com>
Subject: [PATCH] serial: max310x: Properly set flags in AutoCTS mode
Date: Fri, 30 Aug 2019 09:58:34 +0000
Message-ID: <47a1918df72a4b28b124a53e055e045a@SSSDEEX.i.sigma-surface-science.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?iso-8859-1?Q?Christoph_Vogtl=E4nder?= <Christoph.Vogtlaender@sigma-surface-science.com>
List-Id: linux-serial@vger.kernel.org

Commit 391f93f2ec9f ("serial: core: Rework hw-assisted flow control
support") has changed the way the AutoCTS mode is handled.

According to that change, serial drivers which enable H/W AutoCTS mode must
set UPSTAT_AUTORTS, UPSTAT_AUTOCTS and UPSTAT_AUTOXOFF to prevent the
serial core from inadvertently disabling RX or TX. This patch adds proper
handling of UPSTAT_AUTORTS, UPSTAT_AUTOCTS and UPSTAT_AUTOXOFF flags.

Signed-off-by: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>
---
 drivers/tty/serial/max310x.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0e24235..fb5a7e0 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -859,15 +859,23 @@ static void max310x_set_termios(struct uart_port *port,
 /* Configure flow control */
 max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
 max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
-if (termios->c_cflag & CRTSCTS)
+
+port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
+
+if (termios->c_cflag & CRTSCTS) {
+/* Enable AUTORTS and AUTOCTS */
+port->status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 flow |= MAX310X_FLOWCTRL_AUTOCTS_BIT |
 MAX310X_FLOWCTRL_AUTORTS_BIT;
+}
 if (termios->c_iflag & IXON)
 flow |= MAX310X_FLOWCTRL_SWFLOW3_BIT |
 MAX310X_FLOWCTRL_SWFLOWEN_BIT;
-if (termios->c_iflag & IXOFF)
+if (termios->c_iflag & IXOFF) {
+port->status |= UPSTAT_AUTOXOFF;
 flow |= MAX310X_FLOWCTRL_SWFLOW1_BIT |
 MAX310X_FLOWCTRL_SWFLOWEN_BIT;
+}
 max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);

 /* Get baud rate generator configuration */
--
2.7.4


Sigma Surface Science GmbH, Idsteiner Str. 78, 65232 Taunusstein. Amtsgericht Wiesbaden, HRB 27422. Geschäftsführer: Norbert Nold

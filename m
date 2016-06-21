From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 2/4] serial: sh-sci: Stop transfers in sci_shutdown()
Date: Tue, 21 Jun 2016 07:35:57 +0000
Message-ID: <SG2PR06MB0919E8B97E88EC68B14DF106D82B0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1464286718-10745-1-git-send-email-geert+renesas@glider.be>
 <1464286718-10745-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1464286718-10745-3-git-send-email-geert+renesas@glider.be>
Content-Language: ja-JP
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi, Geert-san,

> From: Geert Uytterhoeven
> Sent: Friday, May 27, 2016 3:19 AM
> 
> Make sure the transmitter and receiver are stopped when shutting down
> the port, and related interrupts are disabled.
> 
> Without this:
>   - New input data may be received into the RX FIFO, possibly
>     triggering a new RX DMA completion,
>   - Transfers will still be enabled on a subsequent startup of the UART,
>     before the UART's FIFOs have been reset, causing reading of stale
>     data.
> 
> Inspired by a patch in the BSP by Koji Matsuoka
> <koji.matsuoka.xm@renesas.com>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Extracted from "[PATCH/RFC v3 0/4] serial: sh-sci: Add DT DMA support".
> The issues with the serial console seen before on r8a7740/armadillo and
> sh73a0/kzm9g seem to be gone.
> 
> Changes after resurrection:
>   - Write zero to also disable related interrupts, as suggested by
>     Laurent Pinchart,

If we write zero to the register, we cannot use the port as a console after it is called.
In fact, I have an issue while rc scripts are running on my root filesystem.
When rc scripts is running, "shutdown" is called a lot.
After the "shutdown", if the kernel will put strings using a console, it cannot put strings
because the register is zero (TE and CKE are 0). So, we have to consider it.

FYI, I made a patch to fix this issue.
(Perhaps, both the CKE and TE should be set in the serial_console_write(), but I don't know how to set the CKE for now :) )

Best regards,
Yoshihiro Shimoda
---
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index afa25ec..b5b1b38 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1989,6 +1989,7 @@ static void sci_shutdown(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
 	unsigned long flags;
+	unsigned int ctrl;
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
@@ -1998,8 +1999,12 @@ static void sci_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 	sci_stop_rx(port);
 	sci_stop_tx(port);
-	/* Stop RX and TX, disable related interrupts */
-	serial_port_out(port, SCSCR, 0);
+	/* Stop RX and TX, disable related interrupts, keep clock source */
+	ctrl = serial_port_in(port, SCSCR);
+	ctrl = (s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0)) |
+		    (ctrl & (SCSCR_CKE1 | SCSCR_CKE0));
+	serial_port_out(port, SCSCR, ctrl);
+
 	spin_unlock_irqrestore(&port->lock, flags);
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
@@ -2801,6 +2806,8 @@ static void serial_console_write(struct console *co, const char *s,
 	ctrl = serial_port_in(port, SCSCR);
 	ctrl_temp = (sci_port->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0)) |
 		    (ctrl & (SCSCR_CKE1 | SCSCR_CKE0));
+	ctrl_temp |= SCSCR_TE;	/* FIXME: while "break ctl" is on */
+
 	serial_port_out(port, SCSCR, ctrl_temp);
 
 	uart_console_write(port, s, count, serial_console_putchar);

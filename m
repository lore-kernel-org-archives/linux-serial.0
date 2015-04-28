From: Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v3 1/3] tty: serial: 8250: export early_serial8250_setup function
Date: Tue, 28 Apr 2015 21:40:32 +0800
Message-ID: <1430228434-31779-2-git-send-email-eddie.huang@mediatek.com>
References: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: srv_heupstream@mediatek.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jiri Slaby <jslaby@suse.cz>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Wang Long <long.wanglong@huawei.com>, Kevin Cernekee <cernekee@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Cox <alan@linux.intel.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.orgSascha Hauer <kern>
List-Id: linux-serial@vger.kernel.org

8250-like uart driver may call early_serial8250_setup to
reuse 8250_early.c character output function.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/tty/serial/8250/8250_early.c | 2 +-
 include/linux/serial_8250.h          | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 6c0fd8b..771dda2 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -131,7 +131,7 @@ static void __init init_port(struct earlycon_device *device)
 	serial8250_early_out(port, UART_LCR, c & ~UART_LCR_DLAB);
 }
 
-static int __init early_serial8250_setup(struct earlycon_device *device,
+int __init early_serial8250_setup(struct earlycon_device *device,
 					 const char *options)
 {
 	if (!(device->port.membase || device->port.iobase))
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 78097e7..f0c68d8 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -137,6 +137,8 @@ extern int early_serial_setup(struct uart_port *port);
 
 extern unsigned int serial8250_early_in(struct uart_port *port, int offset);
 extern void serial8250_early_out(struct uart_port *port, int offset, int value);
+extern int early_serial8250_setup(struct earlycon_device *device,
+					 const char *options);
 extern void serial8250_do_set_termios(struct uart_port *port,
 		struct ktermios *termios, struct ktermios *old);
 extern int serial8250_do_startup(struct uart_port *port);
-- 
1.8.1.1.dirty

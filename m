From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/9] serial: arc_uart: Fix out-of-bounds access through DT
 alias
Date: Fri, 23 Feb 2018 14:38:29 +0100
Message-ID: <1519393117-31998-2-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, Barry Song <baohua@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Vineet Gupta <vgupta@synopsys.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The arc_uart_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_ARC_NR_PORTS), so this can even be triggered using a
legitimate DTB.

Fixes: ea28fd56fcde69af ("serial/arc-uart: switch to devicetree based probing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference,
  - Use ARRAY_SIZE().
---
 drivers/tty/serial/arc_uart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 2599f9ecccfe7769..d904a3a345e74785 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -593,6 +593,11 @@ static int arc_serial_probe(struct platform_device *pdev)
 	if (dev_id < 0)
 		dev_id = 0;
 
+	if (dev_id >= ARRAY_SIZE(arc_uart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", dev_id);
+		return -EINVAL;
+	}
+
 	uart = &arc_uart_ports[dev_id];
 	port = &uart->port;
 
-- 
2.7.4

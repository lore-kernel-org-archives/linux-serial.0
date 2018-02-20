From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/9] serial: samsung: Fix out-of-bounds access through DT alias
Date: Tue, 20 Feb 2018 10:40:21 +0100
Message-ID: <1519119624-1268-7-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
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

The s3c24xx_serial_ports[] array is indexed using a value derived from
the "serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SAMSUNG_UARTS), so this can even be triggered using a
legitimate DTB.

Fixes: 3ac337e76a1c637b ("serial: samsung: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/samsung.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index f9fecc5ed0cee826..9ea42197ceefabba 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1818,6 +1818,10 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 
 	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
 
+	if (index >= CONFIG_SERIAL_SAMSUNG_UARTS) {
+		dev_err(&pdev->dev, "serial%d out of range\n", index);
+		return -EINVAL;
+	}
 	ourport = &s3c24xx_serial_ports[index];
 
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
-- 
2.7.4

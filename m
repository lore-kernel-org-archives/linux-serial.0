From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/9] serial: mxs-auart: Fix out-of-bounds access through DT
 alias
Date: Tue, 20 Feb 2018 10:40:19 +0100
Message-ID: <1519119624-1268-5-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, Barry Song <baohua@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Vineet Gupta <vgupta@synopsys.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The auart_port[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: cabf23e7aa00b145 ("serial: mxs-auart: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/mxs-auart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 079dc47aa142d8e1..7ec1298512facfc8 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1663,6 +1663,10 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		s->port.line = pdev->id < 0 ? 0 : pdev->id;
 	else if (ret < 0)
 		return ret;
+	if (s->port.line >= MXS_AUART_PORTS) {
+		dev_err(&pdev->dev, "serial%d out of range\n", s->port.line);
+		return -EINVAL;
+	}
 
 	if (of_id) {
 		pdev->id_entry = of_id->data;
-- 
2.7.4

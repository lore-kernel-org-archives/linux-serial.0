From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v3 5/8] ehci-atmel: Power down during suspend is normal
Date: Wed, 27 Sep 2017 10:35:52 +0200
Message-ID: <20170927083555.16580-6-romain.izard.pro@gmail.com>
References: <20170927083555.16580-1-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170927083555.16580-1-romain.izard.pro@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Alan Stern <stern@rowland.harvard.edu>, Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>, linux-clk@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When an Atmel SoC is suspended with the backup mode, the USB bus will be
powered down. As this is expected, do not return an error to the driver
core when ehci_resume detects it.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/usb/host/ehci-atmel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 7440722bfbf0..2a8b9bdc0e57 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -205,7 +205,8 @@ static int __maybe_unused ehci_atmel_drv_resume(struct device *dev)
 	struct atmel_ehci_priv *atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
 
 	atmel_start_clock(atmel_ehci);
-	return ehci_resume(hcd, false);
+	ehci_resume(hcd, false);
+	return 0;
 }
 
 #ifdef CONFIG_OF
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial/imx: improve error diagnosics for clock and pinctrl failures
Date: Mon, 20 Aug 2012 09:57:04 +0200
Message-ID: <1345449424-24075-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

These error paths are used more often now after deep changes to the
clock code and pinctrl is still new for imx. So help debugging and give
clues in the boot log.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d5c689d6..ce44de7 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1505,18 +1505,21 @@ static int serial_imx_probe(struct platform_dev=
ice *pdev)
 	pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl)) {
 		ret =3D PTR_ERR(pinctrl);
+		dev_err(&pdev->dev, "failed to get default pinctrl: %d\n", ret);
 		goto unmap;
 	}
=20
 	sport->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(sport->clk_ipg)) {
 		ret =3D PTR_ERR(sport->clk_ipg);
+		dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
 		goto unmap;
 	}
=20
 	sport->clk_per =3D devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(sport->clk_per)) {
 		ret =3D PTR_ERR(sport->clk_per);
+		dev_err(&pdev->dev, "failed to get per clk: %d\n", ret);
 		goto unmap;
 	}
=20
--=20
1.7.10.4

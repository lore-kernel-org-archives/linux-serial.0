From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] tty: msm_serial: remove static clk rate setting in probe
Date: Mon,  7 Mar 2016 02:46:40 +0000
Message-ID: <1457318800-26090-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-serial@vger.kernel.org

The issue with setting up a fixed clock rate at probe is that it would
overwrite the console rate set by the bootloader for its console device=
=2E
This would result in serial out corruption or missing log when we syste=
m
is booted with earlycon. This is not a issue if we boot system without
earlycon.

This setup is at least not required with the mainline driver, this code
used to be required because the clk_enable() call would fail if
clk_set_rate() wasn't called first.

Originally the issue was noticed on DB410c which is based on APQ8016
chipset.

Without this patch the console log with earlycon would look like:
=2E..
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr_cpu=
_ids=3D1
[    0.000000] NR_IRQS:64 nr_irqs:64 0
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD+HH=EF=BF=BD=EF=BF=BD0.699378] cons=
ole [ttyMSM0] enabled
[    0.699378] console [ttyMSM0] enabled
[    0.702003] bootconsole [uart0] disabled
[    0.702003] bootconsole [uart0] disabled
=2E..

with this patch I can see all the skipped lines on the console

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v1:
	- removed empty line suggested by Greg KH
	- added reviewed-by=20
	- added extra comment suggested by Stephen Boyd.

 drivers/tty/serial/msm_serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_s=
erial.c
index dcde955..3bf41ab 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1579,8 +1579,6 @@ static int msm_serial_probe(struct platform_devic=
e *pdev)
 		msm_port->pclk =3D devm_clk_get(&pdev->dev, "iface");
 		if (IS_ERR(msm_port->pclk))
 			return PTR_ERR(msm_port->pclk);
-
-		clk_set_rate(msm_port->clk, 1843200);
 	}
=20
 	port->uartclk =3D clk_get_rate(msm_port->clk);
--=20
1.9.1

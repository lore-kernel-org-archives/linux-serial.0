From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] tty: msm_serial: remove static clk rate setting in probe
Date: Tue,  1 Mar 2016 11:22:53 +0000
Message-ID: <1456831373-14839-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-serial@vger.kernel.org

The issue with setting up a fixed clock rate at probe is that it would
overwrite the console rate set by the bootloader for its console device=
=2E
This would result in serial out corruption or missing log when we syste=
m
is booted with earlycon. This is not a issue if we boot system without
earlycon.

This setup is ateast not required with the mainline driver.

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

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_s=
erial.c
index dcde955..0a31b3e 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1580,7 +1580,6 @@ static int msm_serial_probe(struct platform_devic=
e *pdev)
 		if (IS_ERR(msm_port->pclk))
 			return PTR_ERR(msm_port->pclk);
=20
-		clk_set_rate(msm_port->clk, 1843200);
 	}
=20
 	port->uartclk =3D clk_get_rate(msm_port->clk);
--=20
1.9.1

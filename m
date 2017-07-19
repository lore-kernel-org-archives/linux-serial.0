From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 084/102] serial: 8250_dw: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:26:28 +0200
Message-ID: <20170719152646.25903-85-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 787b1160d3a53..7e638997bfc2c 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -529,7 +529,7 @@ static int dw8250_probe(struct platform_device *pdev)
 		}
 	}
 
-	data->rst = devm_reset_control_get_optional(dev, NULL);
+	data->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(data->rst)) {
 		err = PTR_ERR(data->rst);
 		goto err_pclk;
-- 
2.11.0

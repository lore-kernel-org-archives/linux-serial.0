From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] serial: mxs-auart: fix build failure due to broken goto statement
Date: Tue, 10 Mar 2015 13:57:57 -0400
Message-ID: <1426010277-5910-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Janusz Uzycki <j.uzycki@elproma.com.pl>, linux-serial@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-serial@vger.kernel.org

fix mxs-auart build failure. got -> goto and wrong jump target.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Seems this was introduced in 343fda95481a ("serial: mxs-auart: properly handle 
mctrl_gpio failing")

This was only compile tested for mxs_defconfig

Patch is against 4.0-rc3 (localversion-next is -next-20150310)

 drivers/tty/serial/mxs-auart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 9abdccf..a17abca 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1279,7 +1279,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	ret = mxs_auart_init_gpios(s, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
-		got out_free_irq;
+		goto out_free_gpio_irq;
 	}
 
 	/*
-- 
1.7.10.4

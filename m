Return-Path: <SRS0=Gen4=44=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25880C10F27
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D468E20848
	for <linux-serial@archiver.kernel.org>; Wed, 11 Mar 2020 08:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PibujZ4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgCKIbq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:31:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33151 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgCKIbq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Mar 2020 04:31:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id f13so1341795ljp.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Mar 2020 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQoSi/YFyapwSOjfRWwkqch7DqHT/esrNFEh6FS5S5o=;
        b=PibujZ4ToUzMV30bGwB3BtbPOKVOoGBzbFL9h1fR37EF9rF7dPLpeMOWu+hlFpHhNt
         zqPMalb2bAmTXREr4CfJLrfbk2EDmzMMuU9EAhRFq8gWifx6CMy/fkCjanLWvBv2J2L6
         U8DIigM5FyIg56lY6qOog/oMsSAvxzc/CVhVU9Vsk8M4dTLk4qMMizTe/G7BrQWPLX/P
         PBRsZ/G3+aM+PwyYINsoLiM8o4/Up9wlKIiXA4KWGrUVf79UMLQrExTSMgFqFhcemAc8
         VsHkkWGw+P0Msx0BE25g7c4DloooQ+QruBhATi9ZEYxxgI0tdBaqrqKx+hfTofnXmCSR
         FdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQoSi/YFyapwSOjfRWwkqch7DqHT/esrNFEh6FS5S5o=;
        b=e7xN6bktL788qCkda4z7h5u9XIfIJCN7gLydjPzbNgJgexF69eQiu2243FDjs0HEtM
         glDcIv594vWUn38r/TtntTbP7nD2y3Z3MYViaFGN9e5pHTJ2mjhqUFEZ6jYe4DyQLxV9
         J8y2XPtyLSMSiASZrKGXfyE14Sq0XFRHfGf//+rYDSIsF34GCMd25qrg7JZD1L6TB3JH
         l4ZsWAK5w4rJzznU9oaZk7NhPucPho1c7aqLMa7cMKd4eD3bUbD2Zb4roplsKhTIhXr/
         PyqwYD4xp9+pFWMD41UMLeGfxyR/RaUVbL5s+HmO/XFqXiKE/ZKKWhFL0E6Qm+Kj2cl7
         jUCw==
X-Gm-Message-State: ANhLgQ0k51fzh+W/tarx53c5p+99/p5ilSm1iPvt9fxSegW4iftZyfeh
        d5MAQiUJX8nwM3jYap+2YyTEZtvqITZ9rQ==
X-Google-Smtp-Source: ADFU+vvNpqnHiRUtP3WyYuQ5BvDNM8gnMl1Aw1cTe2P+L/mpwqWISVHAa4KxtnAXCNSQRkHKHSxgwQ==
X-Received: by 2002:a05:651c:1190:: with SMTP id w16mr1426857ljo.119.1583915503241;
        Wed, 11 Mar 2020 01:31:43 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z84sm6315339lfa.6.2020.03.11.01.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:31:42 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russ Gorby <russ.gorby@intel.com>
Subject: [PATCH 2/2 v2] tty: serial: ifx6x60: Convert to GPIO descriptors
Date:   Wed, 11 Mar 2020 09:31:31 +0100
Message-Id: <20200311083131.693908-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200311083131.693908-1-linus.walleij@linaro.org>
References: <20200311083131.693908-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This driver for the Intel MID never seems to have been properly
integrated upstream: the platform data in <linux/spi/ifx_modem.h>
is not used anywhere in the kernel and haven't been since it was
merged into the kernel in 2010.

There might be out-of-tree users, so I don't want to delete the
driver, but I will refactor it to use GPIO descriptors, which
means that out-of-tree users will need to adapt.

There are several examples in the kernel of how to provide the
resources necessary for using GPIO descriptors to pass in the
GPIO lines, for the MID platform in particular, it will suffice
to inspect the code in files like:
arch/x86/platform/intel-mid/device_libs/platform_bt.c

This refactoring transfers all GPIOs in the driver, including
a hard-coded "PMU reset" in the driver to use GPIO descriptors
instead.

The following named GPIO descriptors need to be supplied:
- reset
- power
- mrdy
- srdy
- rst_out
- pmu_reset

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Russ Gorby <russ.gorby@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Resend with the preparation patch adding the local
  dev variable.
---
 drivers/tty/serial/ifx6x60.c  | 170 ++++++++++++----------------------
 drivers/tty/serial/ifx6x60.h  |  13 ++-
 include/linux/spi/ifx_modem.h |   5 -
 3 files changed, 65 insertions(+), 123 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 32a0ccef9339..7d16fe41932f 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -39,7 +39,7 @@
 #include <linux/fs.h>
 #include <linux/ip.h>
 #include <linux/dmapool.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/wait.h>
@@ -61,7 +61,6 @@
 #define IFX_SPI_HEADER_F		(-2)
 
 #define PO_POST_DELAY		200
-#define IFX_MDM_RST_PMU	4
 
 /* forward reference */
 static void ifx_spi_handle_srdy(struct ifx_spi_device *ifx_dev);
@@ -81,7 +80,7 @@ static struct notifier_block ifx_modem_reboot_notifier_block = {
 
 static int ifx_modem_power_off(struct ifx_spi_device *ifx_dev)
 {
-	gpio_set_value(IFX_MDM_RST_PMU, 1);
+	gpiod_set_value(ifx_dev->gpio.pmu_reset, 1);
 	msleep(PO_POST_DELAY);
 
 	return 0;
@@ -107,7 +106,7 @@ static int ifx_modem_reboot_callback(struct notifier_block *nfb,
  */
 static inline void mrdy_set_high(struct ifx_spi_device *ifx)
 {
-	gpio_set_value(ifx->gpio.mrdy, 1);
+	gpiod_set_value(ifx->gpio.mrdy, 1);
 }
 
 /**
@@ -117,7 +116,7 @@ static inline void mrdy_set_high(struct ifx_spi_device *ifx)
  */
 static inline void mrdy_set_low(struct ifx_spi_device *ifx)
 {
-	gpio_set_value(ifx->gpio.mrdy, 0);
+	gpiod_set_value(ifx->gpio.mrdy, 0);
 }
 
 /**
@@ -244,7 +243,7 @@ static inline void swap_buf_32(unsigned char *buf, int len, void *end)
  */
 static void mrdy_assert(struct ifx_spi_device *ifx_dev)
 {
-	int val = gpio_get_value(ifx_dev->gpio.srdy);
+	int val = gpiod_get_value(ifx_dev->gpio.srdy);
 	if (!val) {
 		if (!test_and_set_bit(IFX_SPI_STATE_TIMER_PENDING,
 				      &ifx_dev->flags)) {
@@ -691,7 +690,7 @@ static void ifx_spi_complete(void *ctx)
 	clear_bit(IFX_SPI_STATE_IO_IN_PROGRESS, &(ifx_dev->flags));
 
 	queue_length = kfifo_len(&ifx_dev->tx_fifo);
-	srdy = gpio_get_value(ifx_dev->gpio.srdy);
+	srdy = gpiod_get_value(ifx_dev->gpio.srdy);
 	if (!srdy)
 		ifx_spi_power_state_clear(ifx_dev, IFX_SPI_POWER_SRDY);
 
@@ -898,7 +897,7 @@ static irqreturn_t ifx_spi_srdy_interrupt(int irq, void *dev)
 static irqreturn_t ifx_spi_reset_interrupt(int irq, void *dev)
 {
 	struct ifx_spi_device *ifx_dev = dev;
-	int val = gpio_get_value(ifx_dev->gpio.reset_out);
+	int val = gpiod_get_value(ifx_dev->gpio.reset_out);
 	int solreset = test_bit(MR_START, &ifx_dev->mdm_reset_state);
 
 	if (val == 0) {
@@ -954,14 +953,14 @@ static int ifx_spi_reset(struct ifx_spi_device *ifx_dev)
 	 * to reset properly
 	 */
 	set_bit(MR_START, &ifx_dev->mdm_reset_state);
-	gpio_set_value(ifx_dev->gpio.po, 0);
-	gpio_set_value(ifx_dev->gpio.reset, 0);
+	gpiod_set_value(ifx_dev->gpio.po, 0);
+	gpiod_set_value(ifx_dev->gpio.reset, 0);
 	msleep(25);
-	gpio_set_value(ifx_dev->gpio.reset, 1);
+	gpiod_set_value(ifx_dev->gpio.reset, 1);
 	msleep(1);
-	gpio_set_value(ifx_dev->gpio.po, 1);
+	gpiod_set_value(ifx_dev->gpio.po, 1);
 	msleep(1);
-	gpio_set_value(ifx_dev->gpio.po, 0);
+	gpiod_set_value(ifx_dev->gpio.po, 0);
 	ret = wait_event_timeout(ifx_dev->mdm_reset_wait,
 				 test_bit(MR_COMPLETE,
 					  &ifx_dev->mdm_reset_state),
@@ -1080,107 +1079,68 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 		goto error_ret;
 	}
 
-	ifx_dev->gpio.reset = pl_data->rst_pmu;
-	ifx_dev->gpio.po = pl_data->pwr_on;
-	ifx_dev->gpio.mrdy = pl_data->mrdy;
-	ifx_dev->gpio.srdy = pl_data->srdy;
-	ifx_dev->gpio.reset_out = pl_data->rst_out;
-
-	dev_info(dev, "gpios %d, %d, %d, %d, %d",
-		 ifx_dev->gpio.reset, ifx_dev->gpio.po, ifx_dev->gpio.mrdy,
-		 ifx_dev->gpio.srdy, ifx_dev->gpio.reset_out);
-
-	/* Configure gpios */
-	ret = gpio_request(ifx_dev->gpio.reset, "ifxModem");
-	if (ret < 0) {
-		dev_err(dev, "Unable to allocate GPIO%d (RESET)",
-			ifx_dev->gpio.reset);
+	ifx_dev->gpio.reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ifx_dev->gpio.reset)) {
+		dev_err(dev, "could not obtain reset GPIO\n");
+		ret = PTR_ERR(ifx_dev->gpio.reset);
 		goto error_ret;
 	}
-	ret += gpio_direction_output(ifx_dev->gpio.reset, 0);
-	ret += gpio_export(ifx_dev->gpio.reset, 1);
-	if (ret) {
-		dev_err(dev, "Unable to configure GPIO%d (RESET)",
-			ifx_dev->gpio.reset);
-		ret = -EBUSY;
-		goto error_ret2;
-	}
-
-	ret = gpio_request(ifx_dev->gpio.po, "ifxModem");
-	ret += gpio_direction_output(ifx_dev->gpio.po, 0);
-	ret += gpio_export(ifx_dev->gpio.po, 1);
-	if (ret) {
-		dev_err(dev, "Unable to configure GPIO%d (ON)",
-			ifx_dev->gpio.po);
-		ret = -EBUSY;
-		goto error_ret3;
-	}
-
-	ret = gpio_request(ifx_dev->gpio.mrdy, "ifxModem");
-	if (ret < 0) {
-		dev_err(dev, "Unable to allocate GPIO%d (MRDY)",
-			ifx_dev->gpio.mrdy);
-		goto error_ret3;
-	}
-	ret += gpio_export(ifx_dev->gpio.mrdy, 1);
-	ret += gpio_direction_output(ifx_dev->gpio.mrdy, 0);
-	if (ret) {
-		dev_err(dev, "Unable to configure GPIO%d (MRDY)",
-			ifx_dev->gpio.mrdy);
-		ret = -EBUSY;
-		goto error_ret4;
+	gpiod_set_consumer_name(ifx_dev->gpio.reset, "ifxModem reset");
+	ifx_dev->gpio.po = devm_gpiod_get(dev, "power", GPIOD_OUT_LOW);
+	if (IS_ERR(ifx_dev->gpio.po)) {
+		dev_err(dev, "could not obtain power GPIO\n");
+		ret = PTR_ERR(ifx_dev->gpio.po);
+		goto error_ret;
 	}
-
-	ret = gpio_request(ifx_dev->gpio.srdy, "ifxModem");
-	if (ret < 0) {
-		dev_err(dev, "Unable to allocate GPIO%d (SRDY)",
-			ifx_dev->gpio.srdy);
-		ret = -EBUSY;
-		goto error_ret4;
+	gpiod_set_consumer_name(ifx_dev->gpio.po, "ifxModem power");
+	ifx_dev->gpio.mrdy = devm_gpiod_get(dev, "mrdy", GPIOD_OUT_LOW);
+	if (IS_ERR(ifx_dev->gpio.mrdy)) {
+		dev_err(dev, "could not obtain mrdy GPIO\n");
+		ret = PTR_ERR(ifx_dev->gpio.mrdy);
+		goto error_ret;
 	}
-	ret += gpio_export(ifx_dev->gpio.srdy, 1);
-	ret += gpio_direction_input(ifx_dev->gpio.srdy);
-	if (ret) {
-		dev_err(dev, "Unable to configure GPIO%d (SRDY)",
-			ifx_dev->gpio.srdy);
-		ret = -EBUSY;
-		goto error_ret5;
+	gpiod_set_consumer_name(ifx_dev->gpio.mrdy, "ifxModem mrdy");
+	ifx_dev->gpio.srdy = devm_gpiod_get(dev, "srdy", GPIOD_IN);
+	if (IS_ERR(ifx_dev->gpio.srdy)) {
+		dev_err(dev, "could not obtain srdy GPIO\n");
+		ret = PTR_ERR(ifx_dev->gpio.srdy);
+		goto error_ret;
 	}
-
-	ret = gpio_request(ifx_dev->gpio.reset_out, "ifxModem");
-	if (ret < 0) {
-		dev_err(dev, "Unable to allocate GPIO%d (RESET_OUT)",
-			ifx_dev->gpio.reset_out);
-		goto error_ret5;
+	gpiod_set_consumer_name(ifx_dev->gpio.srdy, "ifxModem srdy");
+	ifx_dev->gpio.reset_out = devm_gpiod_get(dev, "rst_out", GPIOD_IN);
+	if (IS_ERR(ifx_dev->gpio.reset_out)) {
+		dev_err(dev, "could not obtain rst_out GPIO\n");
+		ret = PTR_ERR(ifx_dev->gpio.reset_out);
+		goto error_ret;
 	}
-	ret += gpio_export(ifx_dev->gpio.reset_out, 1);
-	ret += gpio_direction_input(ifx_dev->gpio.reset_out);
-	if (ret) {
-		dev_err(dev, "Unable to configure GPIO%d (RESET_OUT)",
-			ifx_dev->gpio.reset_out);
-		ret = -EBUSY;
-		goto error_ret6;
+	gpiod_set_consumer_name(ifx_dev->gpio.reset_out, "ifxModem reset out");
+	ifx_dev->gpio.pmu_reset = devm_gpiod_get(dev, "pmu_reset", GPIOD_ASIS);
+	if (IS_ERR(ifx_dev->gpio.pmu_reset)) {
+		dev_err(dev, "could not obtain pmu_reset GPIO\n");
+		ret = PTR_ERR(ifx_dev->gpio.pmu_reset);
+		goto error_ret;
 	}
+	gpiod_set_consumer_name(ifx_dev->gpio.pmu_reset, "ifxModem PMU reset");
 
-	ret = request_irq(gpio_to_irq(ifx_dev->gpio.reset_out),
+	ret = request_irq(gpiod_to_irq(ifx_dev->gpio.reset_out),
 			  ifx_spi_reset_interrupt,
 			  IRQF_TRIGGER_RISING|IRQF_TRIGGER_FALLING, DRVNAME,
 			  ifx_dev);
 	if (ret) {
 		dev_err(dev, "Unable to get irq %x\n",
-			gpio_to_irq(ifx_dev->gpio.reset_out));
-		goto error_ret6;
+			gpiod_to_irq(ifx_dev->gpio.reset_out));
+		goto error_ret;
 	}
 
 	ret = ifx_spi_reset(ifx_dev);
 
-	ret = request_irq(gpio_to_irq(ifx_dev->gpio.srdy),
+	ret = request_irq(gpiod_to_irq(ifx_dev->gpio.srdy),
 			  ifx_spi_srdy_interrupt, IRQF_TRIGGER_RISING, DRVNAME,
 			  ifx_dev);
 	if (ret) {
 		dev_err(dev, "Unable to get irq %x",
-			gpio_to_irq(ifx_dev->gpio.srdy));
-		goto error_ret7;
+			gpiod_to_irq(ifx_dev->gpio.srdy));
+		goto error_ret2;
 	}
 
 	/* set pm runtime power state and register with power system */
@@ -1191,7 +1151,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	/* no outgoing tty open at this point, this just satisfies the
 	 * modem's read and should reset communication properly
 	 */
-	srdy = gpio_get_value(ifx_dev->gpio.srdy);
+	srdy = gpiod_get_value(ifx_dev->gpio.srdy);
 
 	if (srdy) {
 		mrdy_assert(ifx_dev);
@@ -1200,18 +1160,8 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 		mrdy_set_low(ifx_dev);
 	return 0;
 
-error_ret7:
-	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
-error_ret6:
-	gpio_free(ifx_dev->gpio.srdy);
-error_ret5:
-	gpio_free(ifx_dev->gpio.mrdy);
-error_ret4:
-	gpio_free(ifx_dev->gpio.reset);
-error_ret3:
-	gpio_free(ifx_dev->gpio.po);
 error_ret2:
-	gpio_free(ifx_dev->gpio.reset_out);
+	free_irq(gpiod_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
 error_ret:
 	ifx_spi_free_device(ifx_dev);
 	saved_ifx_dev = NULL;
@@ -1235,14 +1185,8 @@ static int ifx_spi_spi_remove(struct spi_device *spi)
 	pm_runtime_disable(&spi->dev);
 
 	/* free irq */
-	free_irq(gpio_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
-	free_irq(gpio_to_irq(ifx_dev->gpio.srdy), ifx_dev);
-
-	gpio_free(ifx_dev->gpio.srdy);
-	gpio_free(ifx_dev->gpio.mrdy);
-	gpio_free(ifx_dev->gpio.reset);
-	gpio_free(ifx_dev->gpio.po);
-	gpio_free(ifx_dev->gpio.reset_out);
+	free_irq(gpiod_to_irq(ifx_dev->gpio.reset_out), ifx_dev);
+	free_irq(gpiod_to_irq(ifx_dev->gpio.srdy), ifx_dev);
 
 	/* free allocations */
 	ifx_spi_free_device(ifx_dev);
diff --git a/drivers/tty/serial/ifx6x60.h b/drivers/tty/serial/ifx6x60.h
index cacca5be7390..ecb841d928a7 100644
--- a/drivers/tty/serial/ifx6x60.h
+++ b/drivers/tty/serial/ifx6x60.h
@@ -10,6 +10,8 @@
 #ifndef _IFX6X60_H
 #define _IFX6X60_H
 
+struct gpio_desc;
+
 #define DRVNAME				"ifx6x60"
 #define TTYNAME				"ttyIFX"
 
@@ -94,11 +96,12 @@ struct ifx_spi_device {
 
 	struct {
 		/* gpio lines */
-		unsigned short srdy;		/* slave-ready gpio */
-		unsigned short mrdy;		/* master-ready gpio */
-		unsigned short reset;		/* modem-reset gpio */
-		unsigned short po;		/* modem-on gpio */
-		unsigned short reset_out;	/* modem-in-reset gpio */
+		struct gpio_desc *srdy;		/* slave-ready gpio */
+		struct gpio_desc *mrdy;		/* master-ready gpio */
+		struct gpio_desc *reset;	/* modem-reset gpio */
+		struct gpio_desc *po;		/* modem-on gpio */
+		struct gpio_desc *reset_out;	/* modem-in-reset gpio */
+		struct gpio_desc *pmu_reset;	/* PMU reset gpio */
 		/* state/stats */
 		int unack_srdy_int_nb;
 	} gpio;
diff --git a/include/linux/spi/ifx_modem.h b/include/linux/spi/ifx_modem.h
index 694268c78d5d..6d19b09139d0 100644
--- a/include/linux/spi/ifx_modem.h
+++ b/include/linux/spi/ifx_modem.h
@@ -3,12 +3,7 @@
 #define LINUX_IFX_MODEM_H
 
 struct ifx_modem_platform_data {
-	unsigned short rst_out;		/* modem reset out */
-	unsigned short pwr_on;		/* power on */
-	unsigned short rst_pmu;		/* reset modem */
 	unsigned short tx_pwr;		/* modem power threshold */
-	unsigned short srdy;		/* SRDY */
-	unsigned short mrdy;		/* MRDY */
 	unsigned char modem_type;	/* Modem type */
 	unsigned long max_hz;		/* max SPI frequency */
 	unsigned short use_dma:1;	/* spi protocol driver supplies
-- 
2.24.1


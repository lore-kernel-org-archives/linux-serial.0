Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCCDC432BE
	for <linux-serial@archiver.kernel.org>; Wed, 11 Aug 2021 11:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5424D60FC4
	for <linux-serial@archiver.kernel.org>; Wed, 11 Aug 2021 11:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhHKLtF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Aug 2021 07:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbhHKLtD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Aug 2021 07:49:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C011AC0617BE
        for <linux-serial@vger.kernel.org>; Wed, 11 Aug 2021 04:48:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k9so3250871edr.10
        for <linux-serial@vger.kernel.org>; Wed, 11 Aug 2021 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15yds4+NLfeqfOc0EF0N+t+Hv6YtwmRG2QxE75vv5f4=;
        b=jkT2rtkVdgasC3tyUdbd1tbCUdx1RXHtzUZCBPcFXGcEhf01ZOFnIE64UnipIiTcGX
         HmvG4YBN471wXSAr7KMLL6y3FRFITbu9a/4wtR6lH4TjD1gOMtKTUYBnx/6rf+EGf7dg
         NPmMG7y6OYLFI5EJ7akmZFxrETNN3iS5kggvrhGkRu8Or0rmkJNcePCsjBRzAmvs2UnO
         9doFEhD/rhaFRN8fgZClAR0lyN3P6HjU8hv9+J85OlXxJS6iA87zat9gyDyck7tsQIFG
         MYHeDd6cy612qvZ9roWnjodApngSXIsxAkCdSi2LtZrRZKykdtler30kTS3X4zqUzLhX
         CI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15yds4+NLfeqfOc0EF0N+t+Hv6YtwmRG2QxE75vv5f4=;
        b=k8YiPeyeQyGtLumnl/Um/S4yKqVSfr0OVqwKOw1xNyZJ5QQXBPuRTcWj8w9JKEb5lT
         2AB2qWHEor3OahNjsw52Tzn/qFWIdY+uImv/IMCr3Y+cL94WTloflqQX7NJP8A4POIIO
         QLdMD7STB61uD3150fdx44aogKY/vpKP/yOwQCLl0mIyuhY3S3wpkKMnr7xvqm/wQwOB
         Mj8wPzTAJPaYWbu54HM+c+iHtYav4L1KITm8cbdryoG7GOGaKTicKAt1K5YhyYzO8p1k
         vkYtMPguKVOwNdtjnHq+6VKf6HyG+ZG0mErSCFHdI//o9CwpL52WZKDFf+ONREPiBRXu
         CNhA==
X-Gm-Message-State: AOAM531aW/qkRwrp44DutHneqDk9VMmbqVXLDTTvfyk8kN4T/rC0494I
        SLiqCbLUbCkTACRSSzFb3ppF5g==
X-Google-Smtp-Source: ABdhPJz038sdr1rjjB+o6/m46kT4f9qSZlZKsdZbtj+suCBUP0Gd7koAM0sf8tb6RJqbzGSWWiY7fw==
X-Received: by 2002:aa7:de14:: with SMTP id h20mr10761170edv.43.1628682515357;
        Wed, 11 Aug 2021 04:48:35 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id r2sm6705051edv.78.2021.08.11.04.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 04:48:34 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 4/7] tty: serial: samsung: Init USI to keep clocks running
Date:   Wed, 11 Aug 2021 14:48:24 +0300
Message-Id: <20210811114827.27322-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811114827.27322-1-semen.protsenko@linaro.org>
References: <20210811114827.27322-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

UART block is a part of USI (Universal Serial Interface) IP-core in
Samsung SoCs since Exynos9810 (e.g. in Exynos850). USI allows one to
enable one of three types of serial interface: UART, SPI or I2C. That's
possible because USI shares almost all internal circuits within each
protocol. USI also provides some additional registers so it's possible
to configure it.

One USI register called USI_OPTION has reset value of 0x0. Because of
this the clock gating behavior is controlled by hardware (HWACG =
Hardware Auto Clock Gating), which simply means the serial won't work
after reset as is. In order to make it work, USI_OPTION[2:1] bits must
be set to 0b01, so that HWACG is controlled manually (by software).
Bits meaning:
  - CLKREQ_ON = 1: clock is continuously provided to IP
  - CLKSTOP_ON = 0: drive IP_CLKREQ to High (needs to be set along with
                    CLKREQ_ON = 1)

USI is not present on older chips, like s3c2410, s3c2412, s3c2440,
s3c6400, s5pv210, exynos5433, exynos4210. So the new boolean field
'.has_usi' was added to struct s3c24xx_uart_info. USI registers will be
only actually accessed when '.has_usi' field is set to "1".

This feature is needed for further serial enablement on Exynos850, but
some other new Exynos chips (like Exynos9810) may benefit from this
feature as well.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - Added Reviewed-by tag by Krzysztof

Changes in v2:
  - Non-intrusive modification of USI registers
  - Improved comments
  - Rearranged USI register definitions to conform with existing style

 drivers/tty/serial/samsung_tty.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/serial_s3c.h       |  9 +++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 9fbc61151c2e..b8034c1168e0 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -65,6 +65,7 @@ enum s3c24xx_port_type {
 struct s3c24xx_uart_info {
 	char			*name;
 	enum s3c24xx_port_type	type;
+	unsigned int		has_usi;
 	unsigned int		port_type;
 	unsigned int		fifosize;
 	unsigned long		rx_fifomask;
@@ -1352,6 +1353,28 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 	return ret;
 }
 
+static void exynos_usi_init(struct uart_port *port)
+{
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	struct s3c24xx_uart_info *info = ourport->info;
+	unsigned int val;
+
+	if (!info->has_usi)
+		return;
+
+	/* Clear the software reset of USI block (it's set at startup) */
+	val = rd_regl(port, USI_CON);
+	val &= ~USI_CON_RESET_MASK;
+	wr_regl(port, USI_CON, val);
+	udelay(1);
+
+	/* Continuously provide the clock to USI IP w/o gating (for Rx mode) */
+	val = rd_regl(port, USI_OPTION);
+	val &= ~USI_OPTION_HWACG_MASK;
+	val |= USI_OPTION_HWACG_CLKREQ_ON;
+	wr_regl(port, USI_OPTION, val);
+}
+
 /* power power management control */
 
 static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
@@ -1379,6 +1402,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 		if (!IS_ERR(ourport->baudclk))
 			clk_prepare_enable(ourport->baudclk);
 
+		exynos_usi_init(port);
 		break;
 	default:
 		dev_err(port->dev, "s3c24xx_serial: unknown pm %d\n", level);
@@ -2102,6 +2126,8 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	if (ret)
 		pr_warn("uart: failed to enable baudclk\n");
 
+	exynos_usi_init(port);
+
 	/* Keep all interrupts masked and cleared */
 	switch (ourport->info->type) {
 	case TYPE_S3C6400:
@@ -2750,10 +2776,11 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_ARCH_EXYNOS)
-#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
+#define EXYNOS_COMMON_SERIAL_DRV_DATA_USI(_has_usi)		\
 	.info = &(struct s3c24xx_uart_info) {			\
 		.name		= "Samsung Exynos UART",	\
 		.type		= TYPE_S3C6400,			\
+		.has_usi	= _has_usi,			\
 		.port_type	= PORT_S3C6400,			\
 		.has_divslot	= 1,				\
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
@@ -2773,6 +2800,9 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.has_fracval	= 1,				\
 	}							\
 
+#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
+	EXYNOS_COMMON_SERIAL_DRV_DATA_USI(0)
+
 static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
 	EXYNOS_COMMON_SERIAL_DRV_DATA,
 	.fifosize = { 256, 64, 16, 16 },
diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index f6c3323fc4c5..cf0de4a86640 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -27,6 +27,15 @@
 #define S3C2410_UERSTAT	  (0x14)
 #define S3C2410_UFSTAT	  (0x18)
 #define S3C2410_UMSTAT	  (0x1C)
+#define USI_CON		  (0xC4)
+#define USI_OPTION	  (0xC8)
+
+#define USI_CON_RESET			(1<<0)
+#define USI_CON_RESET_MASK		(1<<0)
+
+#define USI_OPTION_HWACG_CLKREQ_ON	(1<<1)
+#define USI_OPTION_HWACG_CLKSTOP_ON	(1<<2)
+#define USI_OPTION_HWACG_MASK		(3<<1)
 
 #define S3C2410_LCON_CFGMASK	  ((0xF<<3)|(0x3))
 
-- 
2.30.2


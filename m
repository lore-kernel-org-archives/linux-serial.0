Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77469C04E69
	for <linux-serial@archiver.kernel.org>; Tue,  8 Aug 2023 17:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjHHRpy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjHHRp1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B8C8A76
        for <linux-serial@vger.kernel.org>; Tue,  8 Aug 2023 09:20:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26814e27a9eso3071693a91.0
        for <linux-serial@vger.kernel.org>; Tue, 08 Aug 2023 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691511597; x=1692116397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQFUtOqa2Nuhn55ogQXJygZpI6oY6Vmrz17l7AHTGDA=;
        b=L1FnnFhvzpSOGFZDwTMgXRviLV39ac5sl3LNz/KywycEDZqtZDgn2kd2ymBoC6OTet
         82AWGwQ1R3He4GbhIyEqHSMA8J3GFdHE7qeGFk+gUBgOhcjgSmk3wN+3ZPwSAx0LNFLM
         fmDuf9z0dJrlAfDe5Mo8gUhoXvcs/a6jev3oEBUXhe9LpyuhCVy/uTy60BubkVCAH+Bj
         9x+oJqBsOyVm/KixWCzaaKepcQFAgNh5W37/hTtUS9CLwU6/QtUb13nXfaShLJ2K7+xA
         i4cks8KGYcgH0wtLZS2fZaVfCaSYToWO+5qm2thHa+l67NnO9Gapvx23WAciKcmJs37v
         i5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511597; x=1692116397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQFUtOqa2Nuhn55ogQXJygZpI6oY6Vmrz17l7AHTGDA=;
        b=cb+CAtOlGB7f7MtMvB7sbPKWJFOEbO/UEAl++u/tUrvFv4+12RZuZxG5ceiTeA/3C+
         ylokSVSVKlGcLUTl/zyqBfVH/+yns7/+GJ9O0YuBvao08z2RWH+9AeIda6njlTOg4L2y
         ST/D+EPRbWd6Y/WVl2+NntHrsjThYyRyR++EoB7MOfigGIdfygc7ECbm1547SgoFqK3i
         hRS0VBr5DRkUgwL7WoZkakEjslzSltJ5UNoY4J0zYKlIsPpfmk2AhUv0nqYF3/vIWb2c
         CA3yO7BHRqrvmXzQXeLVEK4l2OlRSVK2jWRlJgK207cSAZf6O39BKsuK/7yqKos/MGI/
         H6RA==
X-Gm-Message-State: AOJu0YxBVtvo6EYyIFHLPZJ4oEjftfch+moUMkomJFVnyONRjT4gurVS
        mM+cky9PCq7H5jGtpNAThi9xzgNEUK2JWcPMVuMMfg==
X-Google-Smtp-Source: AGHT+IFn9Tv/1Wua6tBM7YiRpsrFK5gtBkXS5hRzWJuEds2zGjCrzk2Zh5O6jxInrCtOG/wLVGM/yg==
X-Received: by 2002:a17:902:c20d:b0:1bb:9bc8:d22d with SMTP id 13-20020a170902c20d00b001bb9bc8d22dmr9696186pll.16.1691479591137;
        Tue, 08 Aug 2023 00:26:31 -0700 (PDT)
Received: from work.. (1-161-169-231.dynamic-ip.hinet.net. [1.161.169.231])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b001bb24cb9a40sm8357436pli.39.2023.08.08.00.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 00:26:30 -0700 (PDT)
From:   Nick Hu <nick.hu@sifive.com>
To:     nick.hu@sifive.com, zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] serial: sifive: Add suspend and resume operations
Date:   Tue,  8 Aug 2023 15:26:25 +0800
Message-Id: <20230808072625.2109564-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If the Sifive Uart is not used as the wake up source, suspend the uart
before the system enter the suspend state to prevent it woken up by
unexpected uart interrupt. Resume the uart once the system woken up.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/sifive.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index a19db49327e2..87994cb69007 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -1022,6 +1022,31 @@ static int sifive_serial_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int sifive_serial_suspend(struct device *dev)
+{
+	int ret = 0;
+	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
+
+	if (ssp && ssp->port.type != PORT_UNKNOWN)
+		ret = uart_suspend_port(&sifive_serial_uart_driver, &ssp->port);
+
+	return ret;
+}
+
+static int sifive_serial_resume(struct device *dev)
+{
+	int ret = 0;
+	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
+
+	if (ssp && ssp->port.type != PORT_UNKNOWN)
+		ret = uart_resume_port(&sifive_serial_uart_driver, &ssp->port);
+
+	return ret;
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
+			 sifive_serial_resume);
+
 static const struct of_device_id sifive_serial_of_match[] = {
 	{ .compatible = "sifive,fu540-c000-uart0" },
 	{ .compatible = "sifive,uart0" },
@@ -1034,6 +1059,7 @@ static struct platform_driver sifive_serial_platform_driver = {
 	.remove		= sifive_serial_remove,
 	.driver		= {
 		.name	= SIFIVE_SERIAL_NAME,
+		.pm = pm_sleep_ptr(&sifive_uart_pm_ops),
 		.of_match_table = of_match_ptr(sifive_serial_of_match),
 	},
 };
-- 
2.34.1


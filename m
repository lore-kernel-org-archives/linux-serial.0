Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9BFC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Mar 2022 16:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbiCJQXV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244226AbiCJQW5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Mar 2022 11:22:57 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E7F13C9D4
        for <linux-serial@vger.kernel.org>; Thu, 10 Mar 2022 08:20:44 -0800 (PST)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 4A7A4CF244
        for <linux-serial@vger.kernel.org>; Thu, 10 Mar 2022 16:17:08 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D781FC0010;
        Thu, 10 Mar 2022 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646929022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FPCSyHd7wkuRRyYu2juVlQEYNZijKkKxdQfMbYXWDos=;
        b=Yc5tsTQC2tsD3R1Nxu1KKab3oHy1kAXFfdc7MytzOdO44xiwC4Fkg6kFRsqpGS1PFJN/PR
        +dZIllOMm2a5wweNCIhZuAp/gC8dSMyfjNvCuRYs1NB8uVEHLE808vpkKuUaMP3+izvAgs
        rYAh0KMERNv+O+tz0gtR1qpYnBLKfmNfirJ3Gq19y40bSCc8MOMoEfcS0669GtUZZj+FL7
        IQ4/3cuO+lfrT5OgNkP5Ah3oo+w0iinA+jhZvWipWazhsH9pjbV2a9VeSN5VByZ9qnEHtQ
        9P194hravE96WtdsmURc0zNO/SLwYPwLOKW5RyHkZQ2FBTvNn28mxgUdPZw/Kg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4/7] serial: 8250_dw: Provide the RZN1 CPR register value
Date:   Thu, 10 Mar 2022 17:16:47 +0100
Message-Id: <20220310161650.289387-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220310161650.289387-1-miquel.raynal@bootlin.com>
References: <20220310161650.289387-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On the RZN1 SoC, the DW serial IP has been synthesized without CPR
support. In order to continue being able to parse the hardware
capabilities, provide the equivalent register value as platform data.

Suggested-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/tty/serial/8250/8250_dw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ee7562a9ec76..1f7a423d6ef2 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -677,11 +677,15 @@ static const struct dev_pm_ops dw8250_pm_ops = {
 	SET_RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
 };
 
+static const struct dw8250_platform_data rzn1_pdata = {
+	.cpr = 0x00012f32,
+};
+
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart" },
 	{ .compatible = "cavium,octeon-3860-uart" },
 	{ .compatible = "marvell,armada-38x-uart" },
-	{ .compatible = "renesas,rzn1-uart" },
+	{ .compatible = "renesas,rzn1-uart", .data = &rzn1_pdata },
 	{ .compatible = "starfive,jh7100-uart" },
 	{ /* Sentinel */ }
 };
-- 
2.27.0


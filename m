Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADECDCCA479
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jun 2022 12:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbiFTMNE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242536AbiFTMMh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Jun 2022 08:12:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75B18E34
        for <linux-serial@vger.kernel.org>; Mon, 20 Jun 2022 05:12:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a13so7072631lfr.10
        for <linux-serial@vger.kernel.org>; Mon, 20 Jun 2022 05:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uab/2HO4VZKS1xT506icMdtE4fNwoDlTTwoN0m1b7PY=;
        b=ey0kfhCEuOTLZdukxlfLw+Ij23qOFjvay6zcA4VgG0LK9+f5awx4v7C9VlCJHHRmff
         lBc164wfYx7L0R8ofjF1dNEQlPk83qSSTLKt6FjsAEfI+eCETWwTlpTxlynkdIC1vZB4
         39/WCMsqUvT3rdlJ61p6oNURhAyVl9DrD+9qCWslTaYzSuPcqQB/83DmVrZbK1gRFqwB
         eKRTsQHEHHIlLrB9xf47kqMxkllUv7q/ol//3V3b8+E7WR/pavpV7ErnRmxFqd4ckpaS
         rN8cKeNZ4B9vwGTMvgFIggrsb5OJrTvr0+KZLMrNI/ItCGiZqQ0Pq6BshfbiZ5Pn35QQ
         hDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uab/2HO4VZKS1xT506icMdtE4fNwoDlTTwoN0m1b7PY=;
        b=jEATsnNu8V96cnadRMPWqbtFokMjaftnSjBAe7m6PD2X9FBZ/WChYVgM8wFpmB7J7m
         oMeI3df6tLhMBNxyADu38cqiE8jOgBFvc6iJc6xrfUnn1cw1eCiLyNuxbxlJfYkjCong
         wfdGmPXYvGTuYpvbtUSyLdsQajcssCYovlMQ2mcWWAQ70VeIuD0BWCfqAEhlyVRe2CKO
         SQ4+xXl2jeHJJSrfOYlK5mGGJIuXjjNlT4XhsvAldA7INnm/saU/a6hWHbYbYvo5rR+7
         CdJo+1p+TlVRFsxvoasoJFLwroEQcgfUwhUafYJBOt8UiOe4xp30AjSAA7L20pBGvhuM
         5BfA==
X-Gm-Message-State: AJIora+enyDgC6FcunxoNHUAIC0Vijgaldpv4GN3UXtBj7CxHhJp51yI
        +EgKLpFPe51b/P8agrH4uqtC4A==
X-Google-Smtp-Source: AGRyM1tBYuf4F4p5cA9ECpQSeqMK+UoNTzDgMsHfYvx/ecuvA836+ueq/saRrTHwBRN3ZPPxa7mbCw==
X-Received: by 2002:ac2:442d:0:b0:478:ed89:927f with SMTP id w13-20020ac2442d000000b00478ed89927fmr13898482lfl.545.1655727128462;
        Mon, 20 Jun 2022 05:12:08 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id v13-20020a05651203ad00b00478f3ecd062sm1745074lfp.167.2022.06.20.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:12:07 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org, miquel.raynal@bootlin.com, mw@semihalf.com,
        jaz@semihalf.com, upstream@semihalf.com,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] serial: 8250: dw: enable using pdata with ACPI
Date:   Mon, 20 Jun 2022 14:10:46 +0200
Message-Id: <20220620121046.1307412-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit ffd381445eac ("serial: 8250: dw: Move the USR register to pdata")
caused NULL-pointer dereference when booting with ACPI by unconditional
usage of the recently added pdata.

In order to fix that and prevent similar issues in future, hook the
default version of this structure in dw8250_acpi_match table.
While at it, sort all entries alphabetically.

Fixes: ffd381445eac ("serial: 8250: dw: Move the USR register to pdata")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changelog v1->v2
* Sort all dw8250_acpi_match entries alphabetically,
* fix commit id in the log,
* Add R-B of Ilpo and Andy


 drivers/tty/serial/8250/8250_dw.c | 24 ++++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f57bbd32ef11..b1ab088fbe6e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -773,18 +773,18 @@ static const struct of_device_id dw8250_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
 
 static const struct acpi_device_id dw8250_acpi_match[] = {
-	{ "INT33C4", 0 },
-	{ "INT33C5", 0 },
-	{ "INT3434", 0 },
-	{ "INT3435", 0 },
-	{ "80860F0A", 0 },
-	{ "8086228A", 0 },
-	{ "APMC0D08", 0},
-	{ "AMD0020", 0 },
-	{ "AMDI0020", 0 },
-	{ "AMDI0022", 0 },
-	{ "BRCM2032", 0 },
-	{ "HISI0031", 0 },
+	{ "80860F0A", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "APMC0D08", (kernel_ulong_t)&dw8250_dw_apb},
+	{ "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "HISI0031", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT33C4", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.29.0


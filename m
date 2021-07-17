Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FB2C636CE
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 12:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF61613E3
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 12:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhGQMlq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Jul 2021 08:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhGQMlp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Jul 2021 08:41:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76FF3613D9;
        Sat, 17 Jul 2021 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626525528;
        bh=Ke1OwpWSzbImBXh38I5IeSSNi+Q5RSfaXaZ9pXeQzBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7iIELCi9OM8fPWEL6qjIfvY6whY/MBi/7JREp06TUt87IClGjLslAwT6izfkPOb0
         4hbZCKeF+KarYUW8akH743hSEB5WST2KhpTHRfRs9SAW5DYSfBnLbi6oaQo72vckLj
         zRzj2VffMMZDOpSeCN4Jhmty7V0lWwiO5IuSWK6/rYMc6x4z1ddxtrd/xYWdGBeXPA
         ehN7R1ET1NBNB9Iszt7NEC3USsSF2FLPUt+2j0mOm9/s34nwWg5IMXBioSfG7tkOuH
         /yjirHAj7acsfmOJ+9PJo158EPM+1B4dIil+2FESPD0xBtIIbeG7IENtW+pdcM0lC6
         3NoxT9Y0opuMg==
Received: by pali.im (Postfix)
        id 944F0EEB; Sat, 17 Jul 2021 14:38:46 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Vladimir Vid" <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/5] math64: New DIV_U64_ROUND_CLOSEST helper
Date:   Sat, 17 Jul 2021 14:38:25 +0200
Message-Id: <20210717123829.5201-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210717123829.5201-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210717123829.5201-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Provide DIV_U64_ROUND_CLOSEST helper which uses div_u64 to perform
division rounded to the closest integer using unsigned 64bit
dividend and unsigned 32bit divisor.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/math64.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 2928f03d6d46..a14f40de1dca 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -300,6 +300,19 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 #define DIV64_U64_ROUND_CLOSEST(dividend, divisor)	\
 	({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
 
+/*
+ * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 32bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 32bit divisor
+ * and round to closest integer.
+ *
+ * Return: dividend / divisor rounded to nearest integer
+ */
+#define DIV_U64_ROUND_CLOSEST(dividend, divisor)	\
+	({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
+
 /*
  * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
  * @dividend: signed 64bit dividend
-- 
2.20.1


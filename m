Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44CBC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 08:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91106142A
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 08:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244615AbhI2IYe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 04:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244590AbhI2IYd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 04:24:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AC52613A5;
        Wed, 29 Sep 2021 08:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632903773;
        bh=pFht2crJ58fEPAb0efcLhPOBTsC8scTXAQlpfMeAVoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NE0W7RT1jcYVcpIAlzvMmZd6a92lZSJWgdIA0bWsVhZF0khaC2FuATVFlwg1j/AmG
         nCyKNQf9gwzuuhJg4m195i1ot/K1jqDxc+xwa/OPFM/9jqiGvUhWiADtfifftW0F8K
         DlN3VRYHgQD0ra+jGWz4gwSR1lYNHljNF6uxfjyZA+fKE2USBL++8znkmYcu8Z8QkH
         NY8fUyjCRpzWoztyUeziNi4ywJ2Px5AQEHjKCZ/5Eb2htVpl/A41YH0YEft7k0I44V
         yUWAW/PRrcARzXB4+do9RTXrtAqaFJDqQEsGY0fiZqAEqf9vuOVx00DuaVy3SoGQ6A
         e9vGVYvHxRH2Q==
Received: by pali.im (Postfix)
        id 2A5811A0B; Wed, 29 Sep 2021 10:22:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 1/6] math64: New DIV_U64_ROUND_CLOSEST helper
Date:   Wed, 29 Sep 2021 10:20:29 +0200
Message-Id: <20210929082034.15098-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929082034.15098-1-pali@kernel.org>
References: <20210929082034.15098-1-pali@kernel.org>
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


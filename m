Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC6C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 09:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB6D61882
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 09:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349644AbhI3KAu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349618AbhI3KAr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 06:00:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B44D617E6;
        Thu, 30 Sep 2021 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995944;
        bh=pFht2crJ58fEPAb0efcLhPOBTsC8scTXAQlpfMeAVoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3u6vAjExZV/slEx0BljKTqytQT0i1Xc2U1rhiCaKdNtohO5GUJmsDU3AQAifR8Kw
         wLW6BnhQa+C8Sp2XafdeFqbkhiMOUrvz7Z4a0hHht7jbM2eV/fh00wngRkPESSFBZ2
         RIZgx+DHPKCQjs1gSHejAjYZSX0Ucv5jI4khI8C+mnaOYU3EoM8sQl0j8VxzHqUuol
         QD/KorZ0Srs6z3IfdMrR46BdSqNJVeATJ0idVx4Oy3rP7e1JK/4RPzMt37+hEsVScA
         gaOdfRrxDDgHZHUq04cCMyPL5gDWh6p7Sgjij1M38bPsfDY76IgIuSxNuQfJac6niX
         WQ9JNWpWA8hlQ==
Received: by pali.im (Postfix)
        id AEEF0169E; Thu, 30 Sep 2021 11:59:02 +0200 (CEST)
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
Subject: [PATCH v7 1/6] math64: New DIV_U64_ROUND_CLOSEST helper
Date:   Thu, 30 Sep 2021 11:58:33 +0200
Message-Id: <20210930095838.28145-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930095838.28145-1-pali@kernel.org>
References: <20210930095838.28145-1-pali@kernel.org>
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


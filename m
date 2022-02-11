Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D313C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 11 Feb 2022 19:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344794AbiBKTMs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:12:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbiBKTMr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Feb 2022 14:12:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC85CE7;
        Fri, 11 Feb 2022 11:12:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCD0E61F35;
        Fri, 11 Feb 2022 19:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C94BC340E9;
        Fri, 11 Feb 2022 19:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644606765;
        bh=/kRr5IqKtgAB6PuFxk7QjfVSXaEzJJ5qpIyJSbD3iEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wj+9Wb+CZtHszzgJ+ck+1SkW0c4aQ8Pox7l5ywg2DmQlaPfXOUTSKbuMBNIcTXCRo
         W8KQvmDXlQO7fHSBE9l2XXC1MWvVBjZ4c21RMHWnretX0Q71qtKTQbL7szMxgUMzNQ
         4gUYfcwuMiu6LFY/ZGMS529OY9aUnc0FR5Gn7B25FywTlLAkzQzu6Nca6+jt5YUiOZ
         DER+Sat5I1j9eecxwZL1cu+JHVn9s13aY8tTHZeZ2dXAg9lZwdJCAyi5Vbbyu0o4Kt
         CemlHDyDk4afLe7Hfn1s6Y+Mmr6B/F3rEQE9HiP19pYeRw53iyUPRqAhw67vofN6aI
         sV6GCYN9loMew==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v8 1/6] math64: New DIV_U64_ROUND_CLOSEST helper
Date:   Fri, 11 Feb 2022 20:12:33 +0100
Message-Id: <20220211191238.2142-2-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211191238.2142-1-kabel@kernel.org>
References: <20220211191238.2142-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Provide DIV_U64_ROUND_CLOSEST helper which uses div_u64 to perform
division rounded to the closest integer using unsigned 64bit
dividend and unsigned 32bit divisor.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Changes since v7:
- added Marek's Reviewed-by tag
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
2.34.1


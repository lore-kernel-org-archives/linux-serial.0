Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E347C433ED
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 19:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643FA6145D
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 19:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhENTYp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 May 2021 15:24:45 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:21510 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233952AbhENTYg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 May 2021 15:24:36 -0400
X-IronPort-AV: E=Sophos;i="5.82,300,1613401200"; 
   d="scan'208";a="81343858"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 May 2021 04:23:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 362584010906;
        Sat, 15 May 2021 04:23:20 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH 04/16] soc: renesas: Add ARCH_R9A07G044{L,LC} for the new RZ/G2{L,LC} SoC's
Date:   Fri, 14 May 2021 20:22:06 +0100
Message-Id: <20210514192218.13022-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514192218.13022-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210514192218.13022-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add ARCH_R9A07G044{L,LC} as a configuration symbol for the new Renesas
RZ/G2{L,LC} SoC's.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index b70bbc38efc6..61968bbd2ed2 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -279,6 +279,16 @@ config ARCH_R8A774B1
 	help
 	  This enables support for the Renesas RZ/G2N SoC.
 
+config ARCH_R9A07G044L
+	bool "ARM64 Platform support for RZ/G2L SoC"
+	help
+	  This enables support for the Renesas RZ/G2L SoC.
+
+config ARCH_R9A07G044LC
+	bool "ARM64 Platform support for RZ/G2LC SoC"
+	help
+	  This enables support for the Renesas RZ/G2LC SoC.
+
 endif # ARM64
 
 config RST_RCAR
-- 
2.17.1


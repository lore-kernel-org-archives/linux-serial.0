Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5C6C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 Oct 2022 17:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJERO6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Oct 2022 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiJEROu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Oct 2022 13:14:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75405596;
        Wed,  5 Oct 2022 10:14:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E35BB81DEE;
        Wed,  5 Oct 2022 17:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E61C43470;
        Wed,  5 Oct 2022 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664990073;
        bh=8Xp7kAM5LFTUlTIW2fFuG237a9Rp9DQyu+qIH5FHc8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AvKcXrht676yYvQGDJdFCIUTXKRsGrYCoZPMTheAR/Bp+QIOs2kxqDHMCXVe+qQ0X
         zjh1I627d0plUQfjSNnXCn9ZVw6rKjgLpDV/aQGFJ4agaMlhfFi8KBEUUP2xRRZpLp
         8xi0SCil0nsoVHlqm2Z5BkI8/WQr0pej4QQKD0mN9nlH2ilsIkUrkJWagS69e6Ob8A
         yJgBl2kgh/hXjE29IM5hYrobHOOXH7FPowVtL5upSr3XSVxu+eBzWppbvceKBmOQm1
         7aZns+2xJljwJb4Bw0yE3dOb2kKSkUdAc6MHc2HF8Gr+Od2itxfP71Bu85vX79ViCs
         3UPQ1eLM+TFoA==
From:   Conor Dooley <conor@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 4/6] riscv: stop selecting the PolarFire SoC clock driver
Date:   Wed,  5 Oct 2022 18:13:47 +0100
Message-Id: <20221005171348.167476-5-conor@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005171348.167476-1-conor@kernel.org>
References: <20221005171348.167476-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The driver is now enabled by default if SOC_MICROCHIP so there is no
longer a need to select it in Kconfig.socs

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.socs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..83f14afd4086 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -2,7 +2,6 @@ menu "SoC selection"
 
 config SOC_MICROCHIP_POLARFIRE
 	bool "Microchip PolarFire SoCs"
-	select MCHP_CLK_MPFS
 	select SIFIVE_PLIC
 	help
 	  This enables support for Microchip PolarFire SoC platforms.
-- 
2.37.3


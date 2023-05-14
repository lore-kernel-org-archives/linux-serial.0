Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7088C7EE22
	for <linux-serial@archiver.kernel.org>; Sun, 14 May 2023 17:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbjENRJ1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 14 May 2023 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbjENRJC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 May 2023 13:09:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329624EEF;
        Sun, 14 May 2023 10:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C6A60E84;
        Sun, 14 May 2023 17:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D42C43442;
        Sun, 14 May 2023 17:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084116;
        bh=Y6wp2lfk73IXtZCQpUDT1aZp/tHzlT5TxGlvlcAf9+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEocH1HnkFFZiRo8KrZfdAd4+8Xfac2zWY3mdb6PcFPqWZo8LfaK7cFADFxARuE2z
         /RKaWc723VdOoVaaKBvFAYG+Zst0IzLp1bWbr8J7aTMlD/qahvwAXsORMXrW9HtUfc
         z+lt9FkL1CoT1GmEsuY0Z7APXWzobAbK+9MvUkDhsKXh3UZYGm2YntAjevY3cBD1UY
         XBOrsVNLhTTRJthNoljcLqpiN1+eLF0DTwU1B9SLq8CX/hhdduOtm8u1r6Xgtp9Z9j
         7FvcsUdRKw5LMju2U1bZ0KUiHTs34ytfXsSO/zDIgbobAU3wlgKXRd3lkmWf9I3yuO
         NfzTXeX6xqi2w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3 09/10] MAINTAINERS: riscv: add entry for Bouffalolab SoC
Date:   Mon, 15 May 2023 00:56:50 +0800
Message-Id: <20230514165651.2199-10-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230514165651.2199-1-jszhang@kernel.org>
References: <20230514165651.2199-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add Jisheng Zhang as Bouffalolab SoC maintainer.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..0ae136f2656f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18115,6 +18115,13 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RISC-V BOUFFALOLAB SOC SUPPORT
+M:	Jisheng Zhang <jszhang@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	arch/riscv/boot/dts/bouffalolab/
+F:	drivers/tty/serial/bflb_uart.c
+
 RISC-V MICROCHIP FPGA SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
-- 
2.40.0


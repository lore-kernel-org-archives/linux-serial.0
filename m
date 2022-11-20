Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7380CC4332F
	for <linux-serial@archiver.kernel.org>; Sun, 20 Nov 2022 08:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKTIcU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 20 Nov 2022 03:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKTIcC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Nov 2022 03:32:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D812A1A11;
        Sun, 20 Nov 2022 00:31:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1058B8094E;
        Sun, 20 Nov 2022 08:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D33AC4347C;
        Sun, 20 Nov 2022 08:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668933084;
        bh=grijmqoHTJYjCp5qjuNh40Hgwmae/3KEnER8TAO+wRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIJE47kOURni8xZ8dkY8MaIKIn77gfMCCqh1SJ8f+4Yta7naxGF/D77W4tFSISNyh
         yo1kRBCeGTwv5t+A4uOpoabv3fxQARGXiTMOqG2vmfqcYdbvot2iVtpRtVZ7vpw8HP
         Bk5qrApDdSrVWVGALcTSK5ROn6VDht/OHfmMj6EOlMvFfuBuqStoBREy3UQsHe4zLG
         yoSIjcp9qVPuTrWPi3TjYM6YPHHPTGkEpVyxyXzqy2bsd2UG/3vcvYvmXkBqGHKFvn
         zEsPegRHpANNadLeRv2yVhf+UVKgmKM2gn9SQCCZvSXbW5VRpkgBrh44zxDoqg+9AT
         dt7iV4a6SeRYw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 7/7] MAINTAINERS: add myself as Bouffalolab SoC entry maintainer
Date:   Sun, 20 Nov 2022 16:21:14 +0800
Message-Id: <20221120082114.3030-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221120082114.3030-1-jszhang@kernel.org>
References: <20221120082114.3030-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I want to maintain this Bouffalolab riscv SoC entry from now on.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92451834b940..3564b27d7da4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17738,6 +17738,12 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RISC-V BOUFFALOLAB SOC SUPPORT
+M:	Jisheng Zhang <jszhang@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	arch/riscv/boot/dts/bouffalolab/
+
 RISC-V MICROCHIP FPGA SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
-- 
2.37.2


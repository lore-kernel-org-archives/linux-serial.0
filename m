Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F9C4332F
	for <linux-serial@archiver.kernel.org>; Sun, 27 Nov 2022 13:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiK0Ney (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Nov 2022 08:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiK0Nex (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Nov 2022 08:34:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A779A1004F;
        Sun, 27 Nov 2022 05:34:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64091B80B01;
        Sun, 27 Nov 2022 13:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821D5C433D6;
        Sun, 27 Nov 2022 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669556090;
        bh=U1BBZe96a/tTQWl6eRpC2brtXLC0B1aCss8DfwQWm5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYFxDEK1GpNY7U8Lsg8VPWSi//ri1THgjsu2MKQp/e8LedIJHigaZHuxb5yN8ekTG
         1HhcAlVcTp5GxJX8JMoxw7rIDlEp1DeSdAk4nor1pnPLEBbfUUplbyZ0mo7F3wUOVQ
         zHA7EHm0HOJB79YcrKMZhgBJc+fxvjE74eIzf7+2SlIMm/KulqkVol6g4nYgiSK/tH
         /K/qdcjvUNZTdB0uO+xks6ZkkWSSOcE1oB0/ibaoyFhyiJ7g0YdJ/lF1rCQ24eIS4A
         Npjvipr//7Ms10m/M25yTNa5tzudfvSgKLG2A8bCtUPdjFfre8rHK1v+Mq9SYaalLw
         9g09jh0u5wXtw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 3/9] riscv: add the Bouffalolab SoC family Kconfig option
Date:   Sun, 27 Nov 2022 21:24:42 +0800
Message-Id: <20221127132448.4034-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221127132448.4034-1-jszhang@kernel.org>
References: <20221127132448.4034-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Bouffalolab bl808 SoC contains three riscv CPUs, namely M0, D0 and
LP. The D0 is 64bit RISC-V GC compatible, so can run linux.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig.socs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..90256f44ed4a 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -1,5 +1,11 @@
 menu "SoC selection"
 
+config SOC_BOUFFALOLAB
+	bool "Bouffalolab SoCs"
+	select SIFIVE_PLIC
+	help
+	  This enables support for Bouffalolab SoC platforms.
+
 config SOC_MICROCHIP_POLARFIRE
 	bool "Microchip PolarFire SoCs"
 	select MCHP_CLK_MPFS
-- 
2.38.1


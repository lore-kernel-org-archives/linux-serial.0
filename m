Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAFCC7EE26
	for <linux-serial@archiver.kernel.org>; Sun, 14 May 2023 17:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjENRI2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 14 May 2023 13:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjENRIO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 May 2023 13:08:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88C04220;
        Sun, 14 May 2023 10:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 495EC618FA;
        Sun, 14 May 2023 17:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F43BC433EF;
        Sun, 14 May 2023 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084089;
        bh=QsS0GqTEpUgIOl9D4Ma8N/Z521IB8RVwhJGktfvNTz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXyhrJbbT/SozDGrfC1Jj3qqZw6mERdNANW6weX6tlGuHGQcj3/hqqSAqhThSyPv2
         SQ3Nj8WegpEH4uLsa1GzpUAYdmIggVjY5KCYwImIJ3QforBF4bkdKfrRrbHRV3lu5G
         ItGW5XyY4yZMe17x9uvhItNgB5hqBbOGpgk9ZP5Eh2YcBge/hCBT60pdjUPlDJ3xav
         Wne+NMUi+u04kS46E/sq8FWyTONJ0en6uA2CRnDE2tIsUcCP7pXuZqhTbHicGjz+5R
         liPYpb4qqkiP0AmEq6gv4Tm+SLt+bSTPZjhpzKtxHSOuqpZPtf+nZJV+K7yfBdYjCS
         NHC2SFumzTIqw==
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
        linux-serial@vger.kernel.org
Subject: [PATCH v3 02/10] dt-bindings: interrupt-controller: Add bouffalolab bl808 plic
Date:   Mon, 15 May 2023 00:56:43 +0800
Message-Id: <20230514165651.2199-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230514165651.2199-1-jszhang@kernel.org>
References: <20230514165651.2199-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add compatible string for bouffalolab bl808 plic.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index f75736a061af..3f9439b0c163 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -65,6 +65,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
+              - bouffalolab,bl808-plic
           - const: thead,c900-plic
       - items:
           - const: sifive,plic-1.0.0
-- 
2.40.0


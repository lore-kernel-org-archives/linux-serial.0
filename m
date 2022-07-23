Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD32C433EF
	for <linux-serial@archiver.kernel.org>; Sat, 23 Jul 2022 20:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbiGWUox (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 23 Jul 2022 16:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbiGWUow (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 23 Jul 2022 16:44:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA35D1B7BF
        for <linux-serial@vger.kernel.org>; Sat, 23 Jul 2022 13:44:51 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q16so7082855pgq.6
        for <linux-serial@vger.kernel.org>; Sat, 23 Jul 2022 13:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QVGUGb8CKotf1INyoHtVPTbvbGHrouTipBeJg0RyviM=;
        b=C952au4kP2fHzBsISV0jnK+fE5GuiDIrWFFUoEqvpJWznM0IKLR9Rx7gdPwT1HoCJX
         yp48lmkuXZ5BliWtOKj5nJSeX1mQq2MvgQPYmIXWwWfGpiBvihqPbRU5fNxNFsRuZw07
         2AumDiKlfswtIKmb7eCkKwIkv/9lbonI/W3tm9mVpsGohMFec0aNXZmFZLkxGNezRxGP
         JX96Yxiaphm1Xn789MYfML8tVk2FJ7AsSZCWtJRPfarRzzzckofzg1Z2bA6V/XMdafsP
         IJesWtpFQas4WAomlLT6C0qy0ySfr9HOekOZVlf3iXbxW3PsKbmCok0WTed3I86Hj8Xy
         q1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVGUGb8CKotf1INyoHtVPTbvbGHrouTipBeJg0RyviM=;
        b=SmxC73mJWFjjpAgGylBPCngavnLXSY5Rnh908N3847x0uGuDot6/2L5bFDWEpF22q2
         T9UsgePdTrLdcA9caXH9ivis7KYi+Wty6w26RJMh4EfPKmvrFjYQH01OG5S6fw61cr02
         1clCO0e7TuGMYi3j4IMOGjfhr4UB/6rBQmN2dxRQJ52T/FCSSSmZgKKb/0Gh2lNGhtYl
         MOz1Fs6BtkTc+ANZwY2dpsI0KolZBFj0ilnxej5zUpGukMnVGjv5D6ewdrJbDwTTTiIR
         E+fzI0PEyzHDVikdj0qDR2ti+MlcKJ3Trv+W6R5rKBWv/oWH1qpVf/cN519d0lNASmC4
         DwAg==
X-Gm-Message-State: AJIora+X9UxQjEkdgjbETm5A81ajdwon4Ciejyjcf0Oqbp1sxSi4aLIu
        sqEjNWaLsmtOV0dF13h4Fv86Ng==
X-Google-Smtp-Source: AGRyM1vnkOdFiFE+GmThkbCNapsdUpE3R0cWy4UyW+Uyxq9LVHEvdVJxEBQ5Nw6N7aZ2mwkXtwjnww==
X-Received: by 2002:a05:6a00:16cb:b0:52b:cc59:9468 with SMTP id l11-20020a056a0016cb00b0052bcc599468mr6058338pfc.46.1658609091313;
        Sat, 23 Jul 2022 13:44:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a073:a406:cc30:f4ec:f10a])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e80e00b0016a6caacaefsm6187950plg.103.2022.07.23.13.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 13:44:51 -0700 (PDT)
From:   Jagan Teki <jagan@edgeble.ai>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Jagan Teki <jagan@edgeble.ai>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 12/22] dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RV1126
Date:   Sun, 24 Jul 2022 02:13:25 +0530
Message-Id: <20220723204335.750095-13-jagan@edgeble.ai>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220723204335.750095-1-jagan@edgeble.ai>
References: <20220723204335.750095-1-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Document compatible string for Rockchip RV1126 SoC.

Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 12137fe80acf..4f47d4e4dd94 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -34,6 +34,7 @@ properties:
               - rockchip,rk3399-uart
               - rockchip,rk3568-uart
               - rockchip,rv1108-uart
+              - rockchip,rv1126-uart
           - const: snps,dw-apb-uart
       - items:
           - enum:
-- 
2.25.1


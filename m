Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F37C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 24 Mar 2022 12:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350268AbiCXMqI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350255AbiCXMqC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Mar 2022 08:46:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F253A730
        for <linux-serial@vger.kernel.org>; Thu, 24 Mar 2022 05:44:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g9-20020a17090ace8900b001c7cce3c0aeso558809pju.2
        for <linux-serial@vger.kernel.org>; Thu, 24 Mar 2022 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMLkcxx+n1ArS2RqcTBzK629rFDC4Wj9OjjlSjnYeys=;
        b=TokHDTdXWsgf05xnA8MYSVPp7G5Lzf+SJZt0QibiGJOAYLYCIcGmjK1uLCSRNecipc
         ZRwI0W2W8QtfWWYJVRmBCdYL4BKx/3czhJDLsRAj22xBPu2dK/lhTHcR9HAarFkfaoDx
         ARy/sd1AgCWOKhfu2ix0doMBpL212yCzvirB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMLkcxx+n1ArS2RqcTBzK629rFDC4Wj9OjjlSjnYeys=;
        b=eahOeh2v2fe1RHZORyenlOtz6/CKkQO2RcZZSwceq5u5ye116NJFCQcWl3N4F3mkYw
         KZHijDFVlxGuZ160xA7ToBgEN+TNupeyD9KoX6LSLtKhZZGcAjtLr6CinBHAHy/ItfFs
         WcnqhPldkRhFtuJ298bwWEay4ea6LA2VsQO85aituIAAvQrEpYuiRpxvUlUFP3hEuZgr
         i0pjiYWSwILXfELgDW811rZx72ACEPznN7LUt/JbE4gCcPbpSCf0DOzPBETDxeiaW6HQ
         G6KoutScsEJuk685rOLrLbfs8xgQ5yzHNoTNQr+CWnLGZWeZ1FaR7vOJUkkwPbp83/HB
         wj5Q==
X-Gm-Message-State: AOAM5317uTgqaO09Rj78aFLK8rxAb4Tu9U1K+1J+SsW4xQpc7kVy3Le5
        r+a9+ornz5topmhrwLhhyx6PFQ==
X-Google-Smtp-Source: ABdhPJxR5oI994cwYDr7DiON56A05ru42hSIYYblDm7LVcmMi8P8kvbt2WLe9fswPW8g+j8z9VdW2g==
X-Received: by 2002:a17:902:c40c:b0:154:837c:5b2 with SMTP id k12-20020a170902c40c00b00154837c05b2mr5779342plk.46.1648125869833;
        Thu, 24 Mar 2022 05:44:29 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm3786924pfg.89.2022.03.24.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:44:29 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/4] ARM: dts: mstar: Switch pm_uart to mstar,msc313-uart
Date:   Thu, 24 Mar 2022 21:44:01 +0900
Message-Id: <20220324124402.3631379-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324124402.3631379-1-daniel@0x0f.com>
References: <20220324124402.3631379-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The UART used in these SoCs is actually a variant of the dw apb uart.
Now there is a compatible string in that driver to handle the quirks
switch the compatible for pm_uart over to mstar,msc313-uart.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index c26ba9b7b6dd..8464a8f1b136 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -175,7 +175,7 @@ gpio: gpio@207800 {
 			};
 
 			pm_uart: uart@221000 {
-				compatible = "ns16550a";
+				compatible = "mstar,msc313-uart", "snps,dw-apb-uart";
 				reg = <0x221000 0x100>;
 				reg-shift = <3>;
 				interrupts-extended = <&intc_irq GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.35.1


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8943C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 24 Mar 2022 12:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350325AbiCXMqR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350296AbiCXMqP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Mar 2022 08:46:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8CD3B542
        for <linux-serial@vger.kernel.org>; Thu, 24 Mar 2022 05:44:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x2so4576706plm.7
        for <linux-serial@vger.kernel.org>; Thu, 24 Mar 2022 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3tFbH35BFupdR5bw1hQ7Wrji66feBlGYcQAWCV7aQM=;
        b=ceyT+O0AlPmogMlbBEf0jmw/Z26cnyOFpgkiYjvQXlXJoHkP8J4lAjcaMJIqY+EBTY
         y5AYcKxoM0O+vEtt4C60iahHShQ9MeHn7EVXj4LTs4JIfw9c9et361Uhy/nUAXJW+/xT
         +sbe0c9Tzke8XuUiPnnO6pXrp0TwLsjlFskgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3tFbH35BFupdR5bw1hQ7Wrji66feBlGYcQAWCV7aQM=;
        b=eOQL5ONyY5hbKSUhCPdI4oMD3eqaxXPAVqaUjyOaHECKhx8VZCBZ/fsBCKaa2d8AK4
         h/ynA5kgIf3ho0FBq8On6CLas5R+qr05V9SoG93ZQqUmay+YM0QlOax6NInIeY5RxjZd
         rWAq0pTTOhCVwAQTR7mwfi2k4cgC7tROcKS0yd1SBn2+uLCL6sewNXTWMw9D5PV/Ke77
         wOowC5ROJgTJ9uqvQT6MNObIRMrv+v790o4PF6YFBKYkb+2dAvOfcQ/sSjtgHrqpULGh
         dPBLP6Y/iifSfKQM8a2N0NYvvDbltdq2AQR2JpscxYE3hfR5uDFurigx9H5JPlvRADf8
         AtwA==
X-Gm-Message-State: AOAM531jRhz+cGTRRSDHUTz74vobvvp1Boo9b229Cc/a0aTt+WNvsnYo
        LJWeprqhV/jfkBzmdQNQYQJXVw==
X-Google-Smtp-Source: ABdhPJxP42NMb0GQrTrXWtdr66SfCJdveNo9QEKIWJol7H+ZIpB+Eao3a8ALGd36qKQJGXCtv+cUHA==
X-Received: by 2002:a17:902:f291:b0:153:caaf:17fd with SMTP id k17-20020a170902f29100b00153caaf17fdmr5655877plc.89.1648125872376;
        Thu, 24 Mar 2022 05:44:32 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm3786924pfg.89.2022.03.24.05.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:44:32 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 4/4] ARM: dts: mstar: Add second UART to base dtsi.
Date:   Thu, 24 Mar 2022 21:44:02 +0900
Message-Id: <20220324124402.3631379-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324124402.3631379-1-daniel@0x0f.com>
References: <20220324124402.3631379-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the second UART to the base dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 8464a8f1b136..baf2422b9854 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -182,6 +182,14 @@ pm_uart: uart@221000 {
 				clock-frequency = <172000000>;
 				status = "disabled";
 			};
+
+			uart1: uart@221200 {
+				compatible = "mstar,msc313-uart", "snps,dw-apb-uart";
+				reg = <0x221200 0x100>;
+				reg-shift = <3>;
+				interrupts-extended = <&intc_irq GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		imi: sram@a0000000 {
-- 
2.35.1


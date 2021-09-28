Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963E7C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 09:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817ED6023B
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 09:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbhI1Jyc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbhI1Jy2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Sep 2021 05:54:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB488C061765;
        Tue, 28 Sep 2021 02:52:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k17so18460634pff.8;
        Tue, 28 Sep 2021 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwrPB7/WhhrZkW7d4JGqXy3l5E+bv7rNR9qRm3aM5OA=;
        b=Lu08+DCXMnnnS6lr0VtH+iey7k7F8ivndbeQcymmW+3YfWXX6Dh0B+DAHgxv1oWwlc
         FSjWuQUF7M2qOVtH0YD0pgq7e4d2HvC9CJ6ISHrrGosF9e6axETjQStZBpbcOYD217bv
         7zh7efdLbf7NzxdgxwBmmLzOyEcu1kYwnh9aokRROzmUsTyKq/0qhfcNEGQiej9nI9oK
         nz7CZfZ2CzIXzR6Iqgm3YgZ8xNmD2n2ADiau6oKhLechMaseoBCmNbYANo4mDUdZL4Jt
         01yjoMZKPngDwR83jTlz58b1imrmB+QXALMJFo5R9pKR3DqaKOrKq+X2apyis/rmgIQq
         /3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwrPB7/WhhrZkW7d4JGqXy3l5E+bv7rNR9qRm3aM5OA=;
        b=kGAZVqTvkiDHYPw+FgmQrSNeMqGXiHNsApt6GwyZUlIEf49tX/3hRXFISc5YuNvKoq
         ax55LXNx3+hoiceNfczsoYkZtSV8DnUS91KYzeT57gKZtmfLKoBNVxVuKmNgZNaKWP8K
         A2YTEo4WPF/vBMYuR6VP3ycdWFQWcPY95nk7Gv3Puvvlgn4CxxJOLqw96uEt6OUh9UR7
         bSsOC/Rm7MmKAuuYJjjWgCM1X8BIjeddlPG7U4N/i//mqNDsJthBq2i4Kbc6snTEAc6C
         rAFjDqSUXBmIEesVcCSbOeEolbF7JtCzyUPlQLfGydc/SarsdWsYoABABbudCFD6PqkN
         vwQA==
X-Gm-Message-State: AOAM533IZQtvITc5D47eh+/iFxqZaPwPnmteXZk7JmknfvJMlsXDRtzr
        kaAop4uyKGhdEcuHxk/03Gc=
X-Google-Smtp-Source: ABdhPJydrsfDCG1rVbZNbVIcXP5ATAxEP7v6UWideFRQdaucgjjohGO0ggQKl2L0KzNKV4EYXW6LOA==
X-Received: by 2002:aa7:98c7:0:b0:44b:b92b:4c90 with SMTP id e7-20020aa798c7000000b0044bb92b4c90mr285581pfm.42.1632822769285;
        Tue, 28 Sep 2021 02:52:49 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v7sm1950517pjk.37.2021.09.28.02.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 02:52:48 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: serial: Add a new compatible string for UMS512
Date:   Tue, 28 Sep 2021 17:52:28 +0800
Message-Id: <20210928095229.233572-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928095229.233572-1-zhang.lyra@gmail.com>
References: <20210928095229.233572-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The UMS512 also uses the same serial device with SC9836.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 Documentation/devicetree/bindings/serial/sprd-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
index 09f6283f3cae..a444bebd2c1a 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
@@ -19,6 +19,7 @@ properties:
           - enum:
               - sprd,sc9860-uart
               - sprd,sc9863a-uart
+              - sprd,ums512-uart
           - const: sprd,sc9836-uart
       - const: sprd,sc9836-uart
 
-- 
2.25.1


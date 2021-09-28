Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47544C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 09:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322CE610A2
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 09:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbhI1Jy0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbhI1JyZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Sep 2021 05:54:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712CCC06176A;
        Tue, 28 Sep 2021 02:52:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c4so13798901pls.6;
        Tue, 28 Sep 2021 02:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJpmhaTlz5lOfYOPGwphzHqmhRqYqk76TrdATbuAeY4=;
        b=Jx0scggiDuYN+R77yco/N0P+amVtWFit5JujyTkjunMWEvgKrWQmDpZ7W0+fEbd4tY
         +I6GSA5UCROudDdJGZ8rYU9mlZHGJaDmrIoj/I+cZ6caVX7GHop2Kd82cpxb5C/T7aq1
         H16vy/MdR4JXexCHMZ/MgfUt+ezxXJwq3ukzDOUoq9IvmWnKwnaxblLE33XVRjAFD0Ll
         eHD2D9heSGc4NucudComHZdJRAJe7KWzOh+P8quUSQw+w6ZBMFkpEc2att1OoYxik0UE
         HWeG2X2eOvuno6NzFkY5DAEi5UMIrhDGdl2jicOpgwBtYYTMMahtwaR6tpqXv2gx22XK
         0MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJpmhaTlz5lOfYOPGwphzHqmhRqYqk76TrdATbuAeY4=;
        b=zqgZ1kVR5l2LZC5EcZFVcyhx7s67CJLfu5HT3hhS1Q7mLi4atACP/zqncjS07h9VlH
         l86ZVFZ6IkEjPqogSF/yPzVcVhaZwuko1Hpq+PpwixsM9NxmX6Bh1/b4/BvFTWGwjVRn
         ZOj/j+Hbwp9Q51NEoVH7Ru+U8e/6gezdD7ikuCpDtIggbumQx7dct5WCzOzB05MGQBge
         x+wQEC6TUGgQ3EQXPAzMJZO3ojc4FiG9PRcgzOh4dUxgmk/pNzM+A8QfloCQJ40JSLiK
         4OcZqspYRUcgGuDXwnWI7ceCm7kjYzbQvmiMs3F0u+yTp2a/sak/818zEnU3ZEIP2e1l
         HWlg==
X-Gm-Message-State: AOAM530R5iLkZtCNnbicKXcqwG+i823ShlMCYCsEEutGNal5VC79Or+Z
        2EiFdWq5u+t3b+ZB813yZPo=
X-Google-Smtp-Source: ABdhPJzQlBEaaItgfdtpwJe0YTvwMAyHmsHp4k88oSTeNHF9hiHfjXTFi8U3FWjk0BsdHNJK6CIfSQ==
X-Received: by 2002:a17:902:7144:b0:13c:9821:75cb with SMTP id u4-20020a170902714400b0013c982175cbmr4338353plm.33.1632822763992;
        Tue, 28 Sep 2021 02:52:43 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v7sm1950517pjk.37.2021.09.28.02.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 02:52:43 -0700 (PDT)
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
Subject: [PATCH 1/3] dt-bindings: arm: Add bindings for Unisoc's UMS512
Date:   Tue, 28 Sep 2021 17:52:27 +0800
Message-Id: <20210928095229.233572-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928095229.233572-1-zhang.lyra@gmail.com>
References: <20210928095229.233572-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add bindings for Unisoc's ums512-1h10 board and ums512 SoC.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 Documentation/devicetree/bindings/arm/sprd/sprd.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sprd/sprd.yaml b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
index 7b6ae3070396..2c12e571394b 100644
--- a/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
+++ b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
@@ -30,6 +30,11 @@ properties:
               - sprd,sp9863a-1h10
           - const: sprd,sc9863a
 
+      - items:
+          - enum:
+              - sprd,ums512-1h10
+          - const: sprd,ums512
+
 additionalProperties: true
 
 ...
-- 
2.25.1


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE7DC4332B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DE464EC4
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCOJo6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCOJox (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 05:44:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80EFC061574;
        Mon, 15 Mar 2021 02:44:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q12so4550536plr.1;
        Mon, 15 Mar 2021 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8pkO9yAZnwW7J9QjEa+yYi7bDNBj14jH5hur2WWahHc=;
        b=dHGJ7Lkm/PwiD8nnzH6zF/RtsuCmOeBtcsIJBN4j3oRtAxoeJ/9bJt/H80gZXYt2Tr
         id/8c9wrJQ73z6rXoaljsgfC0EZoqoNcdBDcq3SIMucWjC9/YY5gVb1PUOIt1I8e23aT
         XX1xDi29mCpyptfpgV9waLelyZoPVaWCQKOmVgwzkgPROVznb0mClIuZ89cg3ZhSLzER
         1xIe/0xaOhdsdRakMGNIJyXFnE6WvtqvtIg1tvlpjcrs0HVrqf1oSTZvpi9oQpOqHycs
         gO+hPjwf5ljglM08eOgCC1Q3oZWfL+V35C+Fh0ekmQLae1ag3Y6z8sgQXFVjBnsS7mwv
         07GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8pkO9yAZnwW7J9QjEa+yYi7bDNBj14jH5hur2WWahHc=;
        b=UOC6/UODtNlsM9Le6FbBzWoFs3PFdn/2R0ZTLN/zjJFHWfm7vVnXUXaGLTdI0YZ2rX
         CwKA6ho5kzZjaMqpl09DMMFIqKsVCb32JyBHA5hZhEnXNIhqs7qZwiKohdVIsNbX3ebF
         8FMoNSKVyuJEz3E59lJp2MciJQpfu14xPx/ZGKhOwUH+zNv0PXMs1pdNKHZXrFKzEwpp
         xIAvM3GgY23ZhN+ujxcRH/ibC/eN9IhZgaar8lgh64FER19HM31M5zXL5qevsRx/Q+VG
         hf/s/AYBF4eh6wJQs2wd3u6BdCsUPtkgdShieuJAJ8AGLTUK1rSZSxCMVshzhktiCgJ+
         b1xw==
X-Gm-Message-State: AOAM533kQRb/2azfm2xVR4X2jQJl9nMvDmCHbVqIstdB/bmrFsCXQ7GB
        bFuJB1W6ablVhemmeLDDHwE=
X-Google-Smtp-Source: ABdhPJyalTFyuCcjruKNM+P6ACpB25POCsvC1cOS4JJZ0v0TY8QmqusChXUCxsjKM7qXH89+aGNWjw==
X-Received: by 2002:a17:90b:94c:: with SMTP id dw12mr11947537pjb.119.1615801492598;
        Mon, 15 Mar 2021 02:44:52 -0700 (PDT)
Received: from localhost.localdomain ([120.245.122.54])
        by smtp.gmail.com with ESMTPSA id 14sm12780811pfy.55.2021.03.15.02.44.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:44:52 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@st.com, erwan.leray@foss.st.com,
        linux-serial@vger.kernel.org
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 3/9] dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
Date:   Mon, 15 Mar 2021 17:43:50 +0800
Message-Id: <1615801436-3016-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch intend to add pinctrl configuration support for
stm32h750 value line

The datasheet of stm32h750 value line can be found at:
https://www.st.com/resource/en/datasheet/stm32h750ib.pdf

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
index 72877544ca78..59f33cbe8f48 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
@@ -24,6 +24,7 @@ properties:
       - st,stm32f746-pinctrl
       - st,stm32f769-pinctrl
       - st,stm32h743-pinctrl
+      - st,stm32h750-pinctrl
       - st,stm32mp157-pinctrl
       - st,stm32mp157-z-pinctrl
 
-- 
1.9.1


Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7510FC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  2 Feb 2022 15:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiBBPNf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Feb 2022 10:13:35 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51532
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235187AbiBBPNc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Feb 2022 10:13:32 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4FF3440305
        for <linux-serial@vger.kernel.org>; Wed,  2 Feb 2022 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643814811;
        bh=duSAVgvelNICvdKrcx93NtKcQsfey6iTKnfcyqiY3yY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Glw3FTXzWUWX+Qx+Y5dsWBc6dTEGpgNCoHy3GNWFfFmhhOWrjdZBsGZ9TJ1BKeAJ6
         KFZ6/Z7nvcDVhS7m8S1BMwmloW+6bwGTOPynzJW5qPdo4Ek+oex0aKvJ6p40it17kU
         PGpPdg8hTfQIeGsnIQOR6fFI20kp1cPQFmB7wK2FfFYbSmmwVBxP3SjMopLT7ZNYEh
         6GcTUwBdtSJ2Cd0S96J6gEhY4XZtG1TFreSJmKbHZM6w9YQCkmWW8jAnNnCxeAvqV3
         ibT2aIDWZzF4SBfXT8f3rhndFvp9mjQPVC1HeIicMMVuOQMSahWKB0ue6pK7Jf7+BX
         2+isMMI2k5cCQ==
Received: by mail-wm1-f70.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso2613353wmb.6
        for <linux-serial@vger.kernel.org>; Wed, 02 Feb 2022 07:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=duSAVgvelNICvdKrcx93NtKcQsfey6iTKnfcyqiY3yY=;
        b=ziwFmS1Zak3T0qvrfYRhPwa1l06WZWlw7jXlXnSSEqjm/9MeqGUSAbZE52egY1X3zJ
         5UTu4pjZcewxprsOLvO4jCXaq5lr8eWM8J9AMwv1NlIrw/+sw1MnsziQtCogjKTggkmv
         ssuXwzGbUm0H29wORQkLsBZSf7nzdVnxFfSA4DmwYixovHrYQVKSFdHyKTUOJxaMbF9V
         WslYEaYEz//ivmL06RxeK5gMbXnDivzpWgYu0+mB6eQbIXHPJHF1b8ggsc7bdQ7lNosl
         86lgaffeQTT2Cn6YLYoxdoLVwYhNNdL0/i6ycWC9icgXa5CwfqYXnFanx1t3tbIU2N10
         Yjew==
X-Gm-Message-State: AOAM530lK4FPYjpvWquHSrR1G2Ef5Qbz8VSV85iCAK7KT/RR0pCBP3OE
        5uto8mEbE4K7tMu3XzolyBpe45BcYo6ryL37A9XFfw5jYAL/5bPGWUawPMVdmh2FRy3TqBWFC4T
        XKMGRIcboLzQLQvTkwunj8QhG7KgVzlW48xRKE5kVSg==
X-Received: by 2002:a5d:5986:: with SMTP id n6mr25028469wri.574.1643814810955;
        Wed, 02 Feb 2022 07:13:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcQvlGtuGDsOAUNuOny5cBjriPqSZIg0IJGHnbFOwypEQNWRpEICVNmvDV+loDy3xq4zaoPw==
X-Received: by 2002:a5d:5986:: with SMTP id n6mr25028444wri.574.1643814810787;
        Wed, 02 Feb 2022 07:13:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p7sm5098872wmq.20.2022.02.02.07.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:13:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 2/3] mfd: exynos-lpass: Drop unneeded syscon.h include
Date:   Wed,  2 Feb 2022 16:13:09 +0100
Message-Id: <20220202151310.285561-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202151310.285561-1-krzysztof.kozlowski@canonical.com>
References: <20220202151310.285561-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

syscon regmap is not used since commit addebf1588ab ("mfd: exynos-lpass:
Remove pad retention control").

Fixes: addebf1588ab ("mfd: exynos-lpass: Remove pad retention control")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mfd/exynos-lpass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 99bd0e73c19c..166cd21088cd 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-- 
2.32.0


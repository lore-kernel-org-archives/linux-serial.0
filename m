Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB3DC433EB
	for <linux-serial@archiver.kernel.org>; Wed, 31 Mar 2021 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161B661962
	for <linux-serial@archiver.kernel.org>; Wed, 31 Mar 2021 08:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhCaI3h (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 Mar 2021 04:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhCaI32 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Mar 2021 04:29:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF46C061574;
        Wed, 31 Mar 2021 01:29:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id p12so9032948pgj.10;
        Wed, 31 Mar 2021 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GeaHQT584yJS6al/D36INfw/UWOuETaMHBUlhwpXItw=;
        b=VcfHHqi9f0y4MFgC5bZrE+KiYMyVH2qWFzw3v7k5kiy0yQxGuQRUsvrLJE1LUpQIJ5
         a6aAO1w0BJ9VUbkmOhEcb+C0z/kH6MPc36u715MDWkPuYIpfKHBlFahNpjYOowmbdGI4
         /wlGkTy4iSkel1KXggsL9/v2nc61ZODHO3zpKpN45YAtjT2j8mHghdhtuId9plqHauTg
         w/nq8qgtw7dVeKTUrOFTLaHhayI+UqTQy6cvP7qQ5OZVTCgMq1ii7Ewx2SpuNgdRmXys
         RFtG/posXytKUrMClfkt+y/3N6z91DqJ8uCfFpWTfE7exl6gD66XgmIIOlSQdonWfcGl
         JVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GeaHQT584yJS6al/D36INfw/UWOuETaMHBUlhwpXItw=;
        b=GGv8wBmoicgWLWrzHwG6vjAITveCsXVlCW+vri7J6GB8bF6B8ldIpW+qU2B2Mkas1v
         DW5ITEO2JwUvRJH94ubEuGvVl3sNj26NYS2rH7xOzV+/A55Ser/C8VdHqY6XM1enhyfQ
         SCpeb9j58sa7I5tgmOfoNBJF/LR0+ervj27Kd8pk6iMsrWZorq72rzBnFkvBH/OaFW5+
         rPHyuSJJQCdxWWwvS5O1S2r0r2AOYOytGyuq6cIlyn+WWmw5mSaPGXJlQVXzBhK+x/vh
         MoMeqYGenH5p8bJgVJtXoJ2qz3fp6ae1xz5t4cXBArcnY/4slYI85n0x2cRsoAe3R/Ft
         UWig==
X-Gm-Message-State: AOAM533tzzd6pS5parQY3UhhOAVfqfFbxM47fUDGnkKK+JVPGqvnt/Ht
        LjGl95Qi+1akzVZ8aSAuyAg=
X-Google-Smtp-Source: ABdhPJwB7vaNXAVDacTO37U5OfOzmFEGWb5cs+DY68MHB9+uO3kj8ytq7mr2cNLvyJ4wyNdIO7e09g==
X-Received: by 2002:a05:6a00:2cd:b029:1f4:c3db:4191 with SMTP id b13-20020a056a0002cdb02901f4c3db4191mr1869209pft.71.1617179367324;
        Wed, 31 Mar 2021 01:29:27 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id v1sm1420991pjt.1.2021.03.31.01.29.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Mar 2021 01:29:26 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh@kernel.org, valentin.caron@foss.st.com,
        Alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, afzal.mohd.ma@gmail.com,
        gregkh@linuxfoundation.org, erwan.leray@foss.st.com,
        erwan.leray@st.com, linux-serial@vger.kernel.org, lkp@intel.com,
        patrice.chotard@foss.st.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, pali@kernel.org,
        mchehab+huawei@kernel.org, andrew@lunn.ch
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v9 6/6] dt-bindings: serial: stm32: Use 'type: object' instead of false for 'additionalProperties'
Date:   Wed, 31 Mar 2021 16:28:45 +0800
Message-Id: <1617179325-6383-7-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617179325-6383-1-git-send-email-dillon.minfei@gmail.com>
References: <1617179325-6383-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

To use additional properties 'bluetooth' on serial, need replace false with
'type: object' for 'additionalProperties' to make it as a node, else will
run into dtbs_check warnings.

'arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800:
'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: af1c2d81695b ("dt-bindings: serial: Convert STM32 UART to json-schema")
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: dillon min <dillon.minfei@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1616757302-7889-8-git-send-email-dillon.minfei@gmail.com
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v9: no changes, this patch was merged to tty-next by Greg Kroah-Hartman

 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 8631678283f9..865be05083c3 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -80,7 +80,8 @@ required:
   - interrupts
   - clocks
 
-additionalProperties: false
+additionalProperties:
+  type: object
 
 examples:
   - |
-- 
2.7.4


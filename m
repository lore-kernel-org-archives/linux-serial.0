Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5364C433EA
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F58061A49
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZLPu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCZLPl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 07:15:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1745C0613AA;
        Fri, 26 Mar 2021 04:15:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x26so4710057pfn.0;
        Fri, 26 Mar 2021 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ioUVrq22UmzpyRrEEDvYTk5HDeFP8YOT2+8IMC1K0uU=;
        b=gOD0I1pRNyONW/xXRl8dt4+/st8jADont9iazDC7dfBAmcLVSkyP7ZxJRBC/1yQJwv
         6RuuOnOkW/y3Uwe/+oPyOnNNazrl/J+T8CVzj0aMqY45VNnx57iqcE/PZKCYWSgOOkiK
         0jXg3c6Cm8/VGgmxv4r/k2teNmy8CcpoJxmrAkdJrgowzr5i9Z/G7xZnqDujszYPqvj5
         PqvTycRBP0A2nME6Am7yCVvZbgL/tdeU5tWyh78hMNhzhPeVksadfs2QC41U6BTWng38
         jDmn209/l8FeuIziDqamX8ZG/N+f3gyxECGcAJsHdZqM0Qw6uGRDkdO98g1dTJWg1VrJ
         2B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ioUVrq22UmzpyRrEEDvYTk5HDeFP8YOT2+8IMC1K0uU=;
        b=QK2ql8EQUDgYazrprqff49pNfx1ezNzLe2KBn1mzck7Eag4XE+OptCq+sF7fI4MbNa
         qt9jQW0PcDmOkYKPgWIfwtVecdwfhy1OkpRuCIjBLOqhQ8RZp4WOH+GwSY6i6FUUIolM
         CXiNfP1bmX85v7Hrn0Su1WxkpDAvW29uS0eA1vH7p1MfChobdlDsXf4nJp5xEUzklIU4
         Et0DhBY7UJQVxZnsa8pWxSXI9E7fJfkPv4pG29nP1Vk4cK+Z1Z/DztluRr7YYE9tFhkC
         +Xk/N9x4srGGrpvprwUkh0VV0REn3IcWDXPGHKpJsI7P+45bWCN6ertxCyHt+Hqd8u8l
         gVow==
X-Gm-Message-State: AOAM531r4YubQ189b3TF4sFoApTGceP2oWbQ/aNr8KniYz9l9VO1xJ8r
        Uwox6SIO2kKzQTlgSMb4Hdk=
X-Google-Smtp-Source: ABdhPJygZqLH08IY9AUgbpjaTPpUsohQHVfAon9iSpi97ZOyGUyiIvy5UmRVEtvAdDxc0CVKKiwpKQ==
X-Received: by 2002:a62:bd03:0:b029:21d:b680:db15 with SMTP id a3-20020a62bd030000b029021db680db15mr11940509pff.25.1616757341247;
        Fri, 26 Mar 2021 04:15:41 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id l3sm8108414pfc.81.2021.03.26.04.15.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 04:15:40 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh@kernel.org, valentin.caron@foss.st.com,
        Alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, erwan.leray@st.com,
        linux-serial@vger.kernel.org, lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v6 9/9] dt-bindings: serial: stm32: Use 'type: object' instead of false for 'additionalProperties'
Date:   Fri, 26 Mar 2021 19:15:02 +0800
Message-Id: <1616757302-7889-8-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
References: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
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
---

v6: no changes

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


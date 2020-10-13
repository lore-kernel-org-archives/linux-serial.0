Return-Path: <SRS0=HiSo=DU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E923C433E7
	for <linux-serial@archiver.kernel.org>; Tue, 13 Oct 2020 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B249324893
	for <linux-serial@archiver.kernel.org>; Tue, 13 Oct 2020 14:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="vJzCHegg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbgJMOpe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388880AbgJMOpe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Oct 2020 10:45:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B06C0613D5
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2020 07:45:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b1so19049581lfp.11
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2020 07:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jlIMHmRJzRdhdiHnj8E8zCbvxaVzpiEGp2QpRRia+RU=;
        b=vJzCHeggFHVLBcDajiEGnH9kPwV0axI0dKUEtK3EgLI6EdXYAU7/mWGlFLi/H3QNp5
         c1S6oWHuRfxPHqyx4h0B5PNAWE1l5mBOG1M7gQYT+fcdE/T8IG2b1JliGtCbKIejTHcq
         Y5K9wAQNgHBeCrceN3NBoKgcDzcjBr9O3JGkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jlIMHmRJzRdhdiHnj8E8zCbvxaVzpiEGp2QpRRia+RU=;
        b=I8vBs6AV1ezqBLe8p3n3ky60c1l10xTydPUe5ZTyewJmcrrOf0n4VGaljG4ljuqngJ
         692KOFkPYTqc34YK8MIpoSUdzTSg6ojSuM20I+bXvvev9Q+WOBn5Tc/asWRTMwFTLwCw
         CIC48Fqh1S0k/k+iH0xCvZhbvUn6+2PzcV8JPcgNxqQRd8Zmc8/CIV4x4xVO1ETR1D5p
         b7k3jhD9//xfvz+o5evxhtTep/9PbKyQWy80HzRZEKYWSMrteD1R+Qf3wxFUCrzSMlpl
         kHrTzfo9cSXwtJinm4yfWgDhuMmIF1xMTCV0VUtBjFnAZIUMhcgwp9Ty+uIzeRs2U+Rz
         Uo1Q==
X-Gm-Message-State: AOAM5335MKXD1uUVXRnTrxQdPM8kTjaJKBJ3uejBo6C2YCDplIpLY/Om
        oQdn+JNdxlJJ46NP4G5c21KSWQ==
X-Google-Smtp-Source: ABdhPJw7dq7jgtXKc/GuCVJ2dgz7UjE/8XjamhQlnHEOveKXv/uAZKy91+OxOuQ0PmgFc/JNiH0p4Q==
X-Received: by 2002:a19:3859:: with SMTP id d25mr11166271lfj.179.1602600332185;
        Tue, 13 Oct 2020 07:45:32 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id l129sm4452924lfd.191.2020.10.13.07.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:45:31 -0700 (PDT)
Date:   Tue, 13 Oct 2020 16:45:24 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v12 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20201013164454.2002023-1-mholenko@antmicro.com>
References: <20201013164454.2002023-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013164454.2002023-0-mholenko@antmicro.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Filip Kokosinski <fkokosinski@antmicro.com>

Add vendor prefix for LiteX SoC builder.

Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    No changes in v12.

    No changes in v11.

    No changes in v10.

    No changes in v9.

    No changes in v8.

    No changes in v7.

    No changes in v6.

    No changes in v5.

    No changes in v4.

    Changes in v3:
    - added Acked-by tag
    
    No changes in v2.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..9aae6c56d7a3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -571,6 +571,8 @@ patternProperties:
     description: Linux-specific binding
   "^linx,.*":
     description: Linx Technologies
+  "^litex,.*":
+    description: LiteX SoC builder
   "^lltc,.*":
     description: Linear Technology Corporation
   "^logicpd,.*":
-- 
2.25.1


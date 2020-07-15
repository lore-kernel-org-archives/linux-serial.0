Return-Path: <SRS0=G31y=A2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7879EC433E2
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jul 2020 11:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CB720720
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jul 2020 11:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="iGIaQkXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgGOLHX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgGOLHV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jul 2020 07:07:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72855C061755
        for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2020 04:07:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o4so831146lfi.7
        for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2020 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pdpyDKWlzuaMU2ht3Q+igXAxvM9HrHqG+4QvM2jlT+c=;
        b=iGIaQkXiShFfnr9nnsBVqiHLyDV2i/diGsGdxbdsb0W4hI/d27WGuJm0qiXhrQrsOv
         e0CpENdGqh6nDa/vMZ/LZ13ZtcCBsHmu+2bSPFGVhZeHlaNzIgDu6acDW7Hx9D3Nm0J2
         nZNKMmOiUQuK+fOBeP6qsDxKMQ4zzWyG191+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdpyDKWlzuaMU2ht3Q+igXAxvM9HrHqG+4QvM2jlT+c=;
        b=dJgt/C4FPbQUqSAAPtPDCIdxZ5uXD69j//XmoKlK5Qlu3vATCTSsoaxTb72lh9CImS
         CdjTa3eQ3bKJYtQbmYOzMMvYQYj+Hm+OlxrwRraUF/0Hx1EHpiCjq+FhZRbVp0kprUDT
         vpTqEt02Pql0g4f1dGo0BkhAPORPgDKvhE+RdMIfKAvqIkW9NZVJKe2RJntDTfr7Jw+b
         IYqiBs7RcwcAy/v+SCfzwy0+e/h5Sl7OpDua5YWCZc75tWP5hIMboBb2dnKYVHLQiHd9
         WNC2h3tWhzZ1gUqXsKaMQpNyl3sN/Sd1PaiiZ8pJUPESkkMXw/A0qqKYm9RzUNDIc3Bq
         bRlw==
X-Gm-Message-State: AOAM5328J7wpd2bWnf4gJP8ZX3NEqslED3p8LYMA0rTjs+RRAd5tch2G
        hCEGSFmk/ULzpOge7iWpWKUPtg==
X-Google-Smtp-Source: ABdhPJy67K3axBXP6mrRYj1MC8LtQasUqF1tjbZab+wInn3H9AUQjtmFctH5+hZmxMUFYBwGUCw+3g==
X-Received: by 2002:a19:ad41:: with SMTP id s1mr4549314lfd.191.1594811239973;
        Wed, 15 Jul 2020 04:07:19 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id l5sm513327lfp.9.2020.07.15.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 04:07:19 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:07:12 +0200
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
Subject: [PATCH v8 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200715130641.1953227-1-mholenko@antmicro.com>
References: <20200715130641.1953227-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715130641.1953227-0-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
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


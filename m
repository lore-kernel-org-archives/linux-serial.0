Return-Path: <SRS0=pZl0=7J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497AAC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 27 May 2020 16:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D7E20899
	for <linux-serial@archiver.kernel.org>; Wed, 27 May 2020 16:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="p5RaWs4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390905AbgE0Q0R (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 May 2020 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389716AbgE0Q0R (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 May 2020 12:26:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE5C03E97D
        for <linux-serial@vger.kernel.org>; Wed, 27 May 2020 09:26:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a25so18054023ljp.3
        for <linux-serial@vger.kernel.org>; Wed, 27 May 2020 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NGxN51AQqztcyfn3BiBc00+QK/qVzhsSjQFFAAJJPdc=;
        b=p5RaWs4Kz5ihoV1zi6MiQwoe/iA+eISPpBLiQy51yd2LsKvii+gTGoZyanYKzG5Uax
         F4e7t8RBbzpcRyuXsTchPLmkzAVlzODr7VQMw5BCSt0Qvy0OG8T7CYO9hcdo38ZUZvi4
         90HdLxvQtYFrwdG8e5JO0/h7ZlISHwDrKdMHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NGxN51AQqztcyfn3BiBc00+QK/qVzhsSjQFFAAJJPdc=;
        b=QbGeF4QCuDnCfCOU7zz9CBYpMh3uAbTD7vpLB25vOg5LAANtbV75lH7GfcJmtw7ruo
         JqxHaP3Po3kCI4ZZatWezt42LtQl/Da6khe4Z5FBCosCnLBVA5N+3j4PLGioYJFCsHF7
         d6XJH8rNRiIrKffEqFG1E2x4mtRwF+3Yv15ep6Gbo1B39AW7x5p2vsfQETyAOb9+RJVE
         whn6ZTBH2uBPArTrgVHCAiE1HDap/zW73/Tjf/MDg21FC/36VXU6HW1TMoeSPjc1rPrY
         A+yM2hfMn59bmlBCsv60QDiVBXFNGutZlylBaHMLb4Wo6ivuEQi8ifVpd6Br/igY99wp
         pqZQ==
X-Gm-Message-State: AOAM533e7pqweWuH3UapW6ZxZYbuvzNITycmYxWm5ZkhuLvJjzD8wGp7
        RnG17YWdzk1Uw76QXi8/4XO60Q==
X-Google-Smtp-Source: ABdhPJy6b7SXdu38UyYKHoPPN47aH8U59t6YMiO3QKwT95eJ2ZYPViquJBWFqZzclAKXW9p6SxMRMA==
X-Received: by 2002:a2e:7614:: with SMTP id r20mr3276762ljc.394.1590596775507;
        Wed, 27 May 2020 09:26:15 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id j14sm877779lji.63.2020.05.27.09.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:26:14 -0700 (PDT)
Date:   Wed, 27 May 2020 18:26:09 +0200
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
Subject: [PATCH v6 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200527182545.3859622-1-mholenko@antmicro.com>
References: <20200527182545.3859622-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527182545.3859622-0-mholenko@antmicro.com>
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


Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17718C2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 10:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBD82145D
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 10:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="O6iUG/KN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgIWKIw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgIWKIv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 06:08:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D0CC0613CE
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2020 03:08:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y2so21401496lfy.10
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2020 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Ll9U6XrekbR5N3wlwKdoF0YKO9JdUUYPqiXJDeJs4c=;
        b=O6iUG/KN2HvKkUXkbGE3fNwU8S3Rt/ohW6Eyp0wCBl8tY4Q6vMkRKgX8EfgmId2kCk
         tubtFIHXJz9ELsf4Te9Mo+1zHQp+Afx45nyhGoSKThC22xgpifvXKw99W8pEwhqNDf9c
         IqY1OeS5KojgrZonBO4eXIdMiDSgWEEqgOBQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Ll9U6XrekbR5N3wlwKdoF0YKO9JdUUYPqiXJDeJs4c=;
        b=n6ajx/QEtqHSXNEPWnjSyq0ODz9Hzd4K32TqLLADS9d7w9wM12Nw0GAb2KY9jd0ptA
         YXw+SqSljAZoqOQCQil01ZqTju52L9SruDSlqgmhocJxQ/zBlKOoEuKmoFg5oSeM/LFA
         JDojY2MH03W0QQN4YKsPXzHSY0gR8F/J+qDYlk0/iYYL9jEXK6ea4FJZdjh1gj1spatF
         8jvMs5exSJxo5ld3pfQuiv5BRFIKqg1L8yC2VZLR4PtLGx88PWq0Zy0KyRgGi9VimjOb
         pOTWi9W0AJL8uJtFVab6SBRD8WOCCZMGgrTzoJvtdEVVHDmgawVxXW1ZQyjSu6GlUmyb
         Vu9w==
X-Gm-Message-State: AOAM5316xhZ9YlYSwnBu6RH9wxDD+gYeFMhkO+JQkDFgkfreGaPVQ+2D
        3HklTKKhgwo5gayCPEWpTIKQdw==
X-Google-Smtp-Source: ABdhPJykDnr4AHhFLrBFZZTYH/AlZyw2KDRT9Q4hNGss2vPY67UUrpL5j/7cloUMalVS83MiVnQSnA==
X-Received: by 2002:a05:6512:1090:: with SMTP id j16mr2867180lfg.3.1600855729829;
        Wed, 23 Sep 2020 03:08:49 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id b13sm4569584lfa.92.2020.09.23.03.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:08:49 -0700 (PDT)
Date:   Wed, 23 Sep 2020 12:08:43 +0200
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
Subject: [PATCH v11 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200923120817.1667149-1-mholenko@antmicro.com>
References: <20200923120817.1667149-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923120817.1667149-0-mholenko@antmicro.com>
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


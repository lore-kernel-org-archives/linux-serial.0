Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B73C10F26
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 06:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084B820784
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 06:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="GK4g2Jx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgDBGpv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:45:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34575 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgDBGpu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 02:45:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id e7so1801869lfq.1
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2020 23:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4CjSgmyUEPIt3O31cWrwOEE7XeZE7E2oORRQ5C+3/30=;
        b=GK4g2Jx6P0z2UfAlYKUMIhkcPKwVcDa1+LyodBYg/FUU/Z9GFl43m4OYilsvjf9zIZ
         aGm2M2r6ncLMOxIG75gn0WFaqYmHJ3oT2wtGKyT4o5lByGL1JmX5yHFj3FDGCCcbZWyj
         mLkICF2cQs+syzMN5cqyhvuK7++sUghoSeQZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4CjSgmyUEPIt3O31cWrwOEE7XeZE7E2oORRQ5C+3/30=;
        b=Fem8qWJSV4X0qzI/0zKOfxIpBJvDg5p3REBl3wZP5u5A0N6CQJyEzXzpXKmwWHvrGk
         2/3zo44A/Z2gUqBdEIDBz5HXBZ9NPREDeZI+a/ouLXwzJtptMWxVf9Axgzx9RunKzuo4
         grgakFr0CM6SUKC0CHQUjKxCpi6xW9RHy8ly/FNd4GJeVS7ts5E/lBWzxY+NuELZgA7M
         DbZvrAPttOxJA5zG0OJkHevPR+AzfM+70F/EvQ20X3xycmTJ8QI7/leTYfMbATcdHfqA
         EeAsVDJGrtJouS3ovrNB5Bm7eHOrtwC4NRl2LhsOprdNc31l+0S+mR1CzgylAxAMILFy
         c/Ow==
X-Gm-Message-State: AGi0PubjcQqJdsq3pK3RfAI5snd9iSnGAHuq2vieQJI1qP9KfNIgyEMC
        cC68W/jYSJKVxUiJpkSHKb+QsQ==
X-Google-Smtp-Source: APiQypJr/or0hyCKdH0VgqGfjDy+LBvKnoG6wgwqQHJg/Iq1jjpKEpSlGa99wojWGLqAYgTqWceEZg==
X-Received: by 2002:ac2:42d8:: with SMTP id n24mr1161497lfl.12.1585809948068;
        Wed, 01 Apr 2020 23:45:48 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id c23sm3182825lfc.69.2020.04.01.23.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 23:45:47 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:45:42 +0200
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200402084513.4173306-1-mholenko@antmicro.com>
References: <20200402084513.4173306-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402084513.4173306-0-mholenko@antmicro.com>
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
    No changes in v4.

    Changes in v3:
    - added Acked-by tag

    No changes in v2.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944bec9c..d9107f0fed2e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -549,6 +549,8 @@ patternProperties:
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


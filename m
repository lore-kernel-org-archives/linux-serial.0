Return-Path: <SRS0=mx0D=6J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E5C55185
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 11:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75F2206EC
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 11:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="Px4YzmFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDYLls (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Apr 2020 07:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDYLlr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Apr 2020 07:41:47 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC63C09B04C
        for <linux-serial@vger.kernel.org>; Sat, 25 Apr 2020 04:41:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 198so9918600lfo.7
        for <linux-serial@vger.kernel.org>; Sat, 25 Apr 2020 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OiMtQl4O5D9nRmT6eFXl93LYXEdoTDy7wY7Ib2iuQe4=;
        b=Px4YzmFS2XqU4JO3S7wagGLD+GXwhDsX20InG2CaFLgiQgKWg5dl5cYt8O7IKOQ/3R
         nwZZUgo+wszRBNHfCrxHzDNIcEqvQbyXdiPYvW5AtJb8m7hkzEOdRA4vRZJM9w1JeynW
         F05WNaYg+y6shLn7fDfHnVUB+OtB5YQ1nbcmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OiMtQl4O5D9nRmT6eFXl93LYXEdoTDy7wY7Ib2iuQe4=;
        b=qaOrcxhT8KHXXtTEXf4P+ZleRSg7GaMsdgVNzDPFHsADJ7mUzKscSIh0EHHQ5FRGcX
         oe0fAM623h5I6wKI+ssBFWkRP+L0zMrFG1Nc6NtqtUhGpNRSmIAt87htEb+8f+Q4Z38N
         X95aT1JDdrl7Kp+3bP2bD/tdQw5RhS4Zb5fRebstS9bS40DDZZeM8KXq/aK49HN9/7n4
         jRDmglbkgECN8JHXBvrYzaUWnoWYt0hnNFF8XhLjkqAO3ajv8P08At4x2XYltwBB2mkJ
         qP32zyE7XXDUqW/2tt7gQOBEblsPZlcOTqGC+QwMBPZP2qiL+//r2ASN1z0+zgfHpUJM
         LLRQ==
X-Gm-Message-State: AGi0PubHtNQ6jX/0DFbEhaoXSE7YmcPjKKYKOHfBMR4EWpS9i5sKmks/
        rwjFf3TvADj0NK9TdafRWdGb7w==
X-Google-Smtp-Source: APiQypK8YbxMYbnNolFWmkf59HEtAQpgnn99OD8kJm38xxwPBrKopHm0tPALLLiegBnwRIyfUOMGGA==
X-Received: by 2002:ac2:4c39:: with SMTP id u25mr9542823lfq.54.1587814905900;
        Sat, 25 Apr 2020 04:41:45 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id b25sm5641308ljp.105.2020.04.25.04.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 04:41:45 -0700 (PDT)
Date:   Sat, 25 Apr 2020 13:41:40 +0200
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
Subject: [PATCH v5 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200425133939.3508912-1-mholenko@antmicro.com>
References: <20200425133939.3508912-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425133939.3508912-0-mholenko@antmicro.com>
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
    No changes in v5.

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


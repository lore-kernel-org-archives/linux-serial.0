Return-Path: <SRS0=P72y=BW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C2AC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 12:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A1E2080C
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 12:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="vyER/vRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHLMeT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgHLMeR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 08:34:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB54C061787
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 05:34:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id t23so2040199ljc.3
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 05:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vRsgpWlrVrAeF+nyXlaCfqr74kFavuamyQhp5nZhvi8=;
        b=vyER/vRrat855EEo97VUfuvsVjpZIDdDTeYVf9cFwUz0hMLDtB0fG10+y+3cDMZVBv
         bKX01SSQMed1a8GpBC/XAq1iggczWA1d+fwcbQX3Y7qbAyDQZPLWYTrCP8H14Q55Aykp
         RMC36FfOeRsjCt6a2LXfIM5FxQU7WE4yWDnsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vRsgpWlrVrAeF+nyXlaCfqr74kFavuamyQhp5nZhvi8=;
        b=JupkhT1r1NR9FQAxAnDMYbzB7fVFKZNjOzzNhQ/x+6a8ExTSePWySdaT9PP2onMHlH
         LAfvyVDfOb0xKgbCV+bcCBajtrdTAzQRSn1/IH3lzQBoDuOe0qOmGw8mPBkYaDQ8SZDA
         i/uV9u8nEAIWBLs9buSAuQ9er/oOjbeyh39BxNH5ZRjiJIa40rtc9TLzK56qlsOwDCy+
         rSOsDxQjMmB5lYYH55e77FAPEsavcYALC0R4z4rg2jkcKJpPM+qNu6+Rb8dc4K/DIs0F
         Hez0lb8d2veMbAI3lRo3MVdjVZdr+meWDj/AQ8X99imtScw7k2idampsVRQH2EwEA3WD
         CRFA==
X-Gm-Message-State: AOAM533+7YadN4K85l5MKV9g9IPjmKjlp0q5f37FxNIxoDFzjwsLgjw2
        xQV2p7dQS85zozUQ91uGxedcmQ==
X-Google-Smtp-Source: ABdhPJw0fk6/6Osk2A/0AAAhovM8IKAPgjhnZgC4o/dkjjb8TezQnlLbJdMPkhDLkauuHAlZpBDqXw==
X-Received: by 2002:a2e:720f:: with SMTP id n15mr5155305ljc.73.1597235653681;
        Wed, 12 Aug 2020 05:34:13 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id q22sm445593lfc.33.2020.08.12.05.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 05:34:13 -0700 (PDT)
Date:   Wed, 12 Aug 2020 14:34:06 +0200
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
Subject: [PATCH v10 1/5] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20200812143324.2394375-1-mholenko@antmicro.com>
References: <20200812143324.2394375-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812143324.2394375-0-mholenko@antmicro.com>
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


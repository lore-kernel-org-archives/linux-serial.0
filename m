Return-Path: <SRS0=tOPF=XZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56722C32792
	for <linux-serial@archiver.kernel.org>; Mon, 30 Sep 2019 13:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282B321924
	for <linux-serial@archiver.kernel.org>; Mon, 30 Sep 2019 13:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro-com.20150623.gappssmtp.com header.i=@antmicro-com.20150623.gappssmtp.com header.b="GJHOt5ZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfI3NET (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:04:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34732 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbfI3NET (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Sep 2019 09:04:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19so9413444lja.1
        for <linux-serial@vger.kernel.org>; Mon, 30 Sep 2019 06:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wAmsq1ZRjAy0Dy4hMBe94TXzxJb/3I02Gi7CAmHEC18=;
        b=GJHOt5ZJCob5AOYOFNDmBvLuTGz/01PKndvnW99jFT5LG3Mu4ZEwEvy1cY+IH2VlYn
         1fmK9jIFvISsCbyqjM+faIdSgGrvb7pkaX0f3NWmkvy0BPTadP2fXoq5Yh+BmEUZZmHj
         RnFNykhxCz2HcEuxOGjC/KKnM2cmU/jPE6JPbsUiiP6N3X5FnMw0bLK5ww/mSrEfR2X5
         IildYAvxuvySKj1xNFidFzuUZ1YuZuFkUKuBxq7PBJzahHh/OMUwRkpcEfNgcnotXOKR
         dfQkBKh5jXoS/t0Vni55ey+QO7Pvbj5lu7HI5aFX+1jRC5XuP6zn9Vmr8oX/sSRC/lsK
         1qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wAmsq1ZRjAy0Dy4hMBe94TXzxJb/3I02Gi7CAmHEC18=;
        b=RhjMDiqjQIssbCVcJAVisuNz3eX+IRkTXZNYmISiJ7F6VVoIJuTOk7uGSn3TCafW45
         M5Ox+d8Il7JspjnGPV7KOMR94/jdSFx44XGhwYgaQinCTLXOYJ/2nhsIXDmvlzf0hgwy
         EFL7Fm8ZH5RR9wFufp5R02wa8EFRutWyrydoRTDhKuID3oxC2+JHY0S0f0zY2WamnRHP
         UST+gXOz7GkW7leFNts8iVL6ke8shnH4rN2mCM37j+9hvR33NG0lWYZloEKBF37vyOhV
         +SBoesEIfdvO7zwSLSkWx/MCzmTYzXotSAnfPkMfIls8J+yz1zVE45K0pEtXDdcF8G3g
         hWKA==
X-Gm-Message-State: APjAAAUQ/LdXnKr8sFEfCW3cBJbMQ9EsHe8N4+JyYwDFdjO30gct/jMf
        2GjCL1w7uQHMTmv3fObdsVtjoA==
X-Google-Smtp-Source: APXvYqw0uKUhs9OxqzC42P/Kf2Rn9e00fau/7D2/YvGAN+Wkv+FMrYaUf5TyMdwJRcNlVDlswQdmtg==
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr11973026ljm.93.1569848657561;
        Mon, 30 Sep 2019 06:04:17 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id s26sm3060394lfc.60.2019.09.30.06.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:04:16 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:04:11 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 1/3] dt-bindings: vendor: add vendor prefix for LiteX
Message-ID: <20190930130411.GA8312@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
Message-ID: <20190930130411.L4oeUDrDdJQrjnXgVg5y4Yaby2mkPmdqQen467uherA@z>

From: Filip Kokosinski <fkokosinski@internships.antmicro.com>

Add vendor prefix for LiteX SoC builder.

Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 329b668da..4143c52a8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -533,6 +533,8 @@ patternProperties:
     description: Linux-specific binding
   "^linx,.*":
     description: Linx Technologies
+  "^litex,.*":
+    description: LiteX SoC builder
   "^lltc,.*":
     description: Linear Technology Corporation
   "^logicpd,.*":
-- 
2.23.0


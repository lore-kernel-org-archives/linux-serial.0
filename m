Return-Path: <SRS0=tOPF=XZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC5EC35280
	for <linux-serial@archiver.kernel.org>; Mon, 30 Sep 2019 13:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A0A2086A
	for <linux-serial@archiver.kernel.org>; Mon, 30 Sep 2019 13:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro-com.20150623.gappssmtp.com header.i=@antmicro-com.20150623.gappssmtp.com header.b="l3Nvt/bL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfI3NEl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:04:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46501 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbfI3NEk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Sep 2019 09:04:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id d1so9347972ljl.13
        for <linux-serial@vger.kernel.org>; Mon, 30 Sep 2019 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VeoaIKGJb/61Ov+yB9zveHlqXZTEnNdTJ6NCEWY/+7A=;
        b=l3Nvt/bLf/BeU5VnuKN3QrlxayW110zSMz+Omal6lVqbPWnUZ1gRvteEndYHlv2K/e
         Kt3vk2g0TTVpySFJrFfaPyDMKae3t7mIxwR5n/squlLevrTksNW0QJc0ir09lNHPybw5
         SXTt4gUX4NFBfK0zokhPR5vmrQifykB4nWgNQ7gxUFf7DyfUsH90kPo/mOcLeLDIEz9a
         GbW5XtcelR6sery85SAAw3Anqvk3tl4QfkY+ZP/fP2svUAtwuo8p09zZ2M62j4LfwjSA
         F/19QdNEJiKEqb0lF8viBvdZCw68BsKCLR76s4aSOygoEHfomgBJ0XvbbY9f/r3bQz8V
         RziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VeoaIKGJb/61Ov+yB9zveHlqXZTEnNdTJ6NCEWY/+7A=;
        b=bPV7rH90Y8S25huS9/i8jokHpc/lumfUM94X+4gLyJ0HxMV13YRFrWuEFXj6UETg9m
         lrK6ZEkpbm3Ul7aab039flaPIlHgQafgL5IZNWa6XrLiHrucdHbnaGnZaA/yiiqJpZWJ
         lmydwcfpdZpK66jl1S3pvGbn64t4BLb/WmSRB5/jDWQ+uhrsFCuEIK8KRVqYdVGGcqwh
         1y9xDuSvfip/8Usc6cxmIMXYOuDQBesIueGJuFWodU9admbY70pqsmNkyCm0HdZT2V1O
         yRvjr13eloIzWK+M3qtr9+uRQR72NR+Dh1z5bMSrEewzNZlQ3BOcZ+B0NDjAeg5IF9O+
         yRrw==
X-Gm-Message-State: APjAAAUz7VARBNPxiiALcsHcU2894ZdHz7tXQN+vGMDeW/D4L9zQb0C5
        2J2xbzk8ESjPEip0ItFuy8qYUA==
X-Google-Smtp-Source: APXvYqyCjXJY28l2+1mzvUJg1TYUmquAGr+sqV9Av/SyxGcE7N9rRX4Pr7ENgnIqoNmODxGr7QRqsQ==
X-Received: by 2002:a2e:42c9:: with SMTP id h70mr11803035ljf.88.1569848676849;
        Mon, 30 Sep 2019 06:04:36 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id b15sm3220379lfj.84.2019.09.30.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:04:36 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:04:30 +0200
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
Subject: [PATCH 2/3] dt-bindings: serial: document LiteUART bindings
Message-ID: <20190930130430.GA9080@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
Message-ID: <20190930130430.S9Q_x2dUnXT6ZpWd01XkrMWJDZoE7ry2975Wc0U-aJI@z>

From: Filip Kokosinski <fkokosinski@internships.antmicro.com>

Add documentation for LiteUART devicetree bindings.

Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
---
 .../devicetree/bindings/serial/litex,liteuart.txt    | 12 ++++++++++++
 MAINTAINERS                                          |  6 ++++++
 2 files changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.txt

diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.txt b/Documentation/devicetree/bindings/serial/litex,liteuart.txt
new file mode 100644
index 000000000..13c71a0c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/litex,liteuart.txt
@@ -0,0 +1,12 @@
+LiteUART serial controller
+
+Required properties:
+- compatible: should be "litex,liteuart"
+- reg: base address and length of the register set for this device
+
+Example:
+
+uart0: serial@f0001000 {
+	compatible = "litex,liteuart";
+	reg = <0xe0001800 0x100>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index b2326dece..65a6cf296 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9462,6 +9462,12 @@ F:	Documentation/misc-devices/lis3lv02d.rst
 F:	drivers/misc/lis3lv02d/
 F:	drivers/platform/x86/hp_accel.c
 
+LITEX PLATFORM
+M:	Karol Gugala <kgugala@antmicro.com>
+M:	Mateusz Holenko <mholenko@antmicro.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/litex,liteuart.txt
+
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Jiri Kosina <jikos@kernel.org>
-- 
2.23.0


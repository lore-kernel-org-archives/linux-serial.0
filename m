Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A416C35DF9
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 08:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109FD21556
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 08:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="eA5d0csJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgBYIrO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:47:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45488 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgBYIrO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 03:47:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id z5so9083592lfd.12
        for <linux-serial@vger.kernel.org>; Tue, 25 Feb 2020 00:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ocmI9tdr8pveZCkd1YiAB9vTArYU0/qTMSHDA5ZniK4=;
        b=eA5d0csJ2TjAuJNQoQ9ZTtrBjIws3eb4TVYG5/Ueek/ID8vfM9de9ehmET1DlwMPxM
         yZN+nh1g3JiN5RON4NifGemVoVZ5KevdSeeAgLtiAgYQzTEm2RAOmp7F7XY4NDDOKm8o
         xNsHsTWouHHpD5IcrF3domf9eh8YTEcO0FesI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ocmI9tdr8pveZCkd1YiAB9vTArYU0/qTMSHDA5ZniK4=;
        b=VU3AIHrcOArPYfCRgBcB2s4CIsfsWsEHH77gM1i4NcWbT3ndha2/BYoVM8detl297K
         C/mHqPPqEcgcHvfpWtYcfJ59MGXMqMXHONJcjBRpEElZNkvyMhFCLQ1jZnxIYS6IBiHw
         kSbmSeipvH6Pvfz85D/YKO8k1uZWLw3xCvBXhgsKsSZlES6uoFsQK6upgk7xz4ANNvhU
         I0i/B50rNgBoXv8AyND3yi11kJy+NevxvDPxrpk8tDNEiHccWkROMW26RZvlRB/afw2A
         baZwDemj6A4R3AyeLEb3E1pT7CGMYSRzM5otz4WwGF87OpUEARMu/ObF7Rigg5T2X5XH
         xKEA==
X-Gm-Message-State: APjAAAXLYxx8hgKiiN2LxwSZTHMUZYmpidQW5MmwzyAKKViBmZJzr7VZ
        WIuRiQNVUESWxaP4mDyJ7IHZ7Q==
X-Google-Smtp-Source: APXvYqysKwDew1juuRaq2uQ+jD4QRHbUPE8nYx+dcMDVRKmUUNgliX66MLFu2k8V+k7C0vM5FEmRDQ==
X-Received: by 2002:a05:6512:3082:: with SMTP id z2mr3376019lfd.72.1582620432492;
        Tue, 25 Feb 2020 00:47:12 -0800 (PST)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id v15sm6954620lfa.68.2020.02.25.00.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:47:11 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:47:07 +0100
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
Subject: [PATCH v3 4/5] dt-bindings: serial: document LiteUART bindings
Message-ID: <20200225094437.4170502-4-mholenko@antmicro.com>
References: <20200225094437.4170502-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225094437.4170502-0-mholenko@antmicro.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Filip Kokosinski <fkokosinski@antmicro.com>

Add documentation for LiteUART devicetree bindings.

Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v3:
    - added Reviewed-by tag
    - patch number changed from 3 to 4
    - removed changes in MAINTAINERS file (moved to patch #2)
    
    Changes in v2:
    - binding description rewritten to a yaml schema file
    - added interrupt line
    - fixed unit address
    - patch number changed from 2 to 3

 .../bindings/serial/litex,liteuart.yaml       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml

diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.yaml b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
new file mode 100644
index 000000000000..87bf846b170a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/litex,liteuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LiteUART serial controller
+
+maintainers:
+  - Karol Gugala <kgugala@antmicro.com>
+  - Mateusz Holenko <mholenko@antmicro.com>
+
+description: |
+  LiteUART serial controller is a part of LiteX FPGA SoC builder. It supports
+  multiple CPU architectures, currently including e.g. OpenRISC and RISC-V.
+
+properties:
+  compatible:
+    const: litex,liteuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    uart0: serial@e0001800 {
+      compatible = "litex,liteuart";
+      reg = <0xe0001800 0x100>;
+      interrupts = <2>;
+    };
-- 
2.25.0


Return-Path: <SRS0=YLjw=4T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47777C3F2D2
	for <linux-serial@archiver.kernel.org>; Mon,  2 Mar 2020 13:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C84621D56
	for <linux-serial@archiver.kernel.org>; Mon,  2 Mar 2020 13:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxQHiOKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgCBNjV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:39:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43881 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbgCBNjV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Mar 2020 08:39:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id e10so11184978wrr.10;
        Mon, 02 Mar 2020 05:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y30GtIKkLuXdZ608Vv+U7ffueQj6lNYrKY5cOlCGJWA=;
        b=CxQHiOKFe7ZzXJLcK5wp6OzvJvmZhhnV3uPVF6sEObJThCvTywHm8YZkYstRXorFtY
         7mU6xsDnjrR/6k3jR1AYFAQn5Uwiuja6zn8KU7YoC5n0uduGhqpcVvP2Dba76Ppwbi0R
         9NxBAMor0dOD2dR1HJ6BNmuB1cf3aFMAxmkufUXxY4h6g8i3JZFL4iHkMgrLS0SPMj/u
         WKUfh9XLzYr30ODN+dvZawdfLcFiFWe6OopI7ymd+ctdnc6NbgWiY1spwu2b0HLTrb9T
         DuBhLhtea87ZQc6j/cCB9rndfb3eZ4sJn+3jEY1kUuuWSdPlkM1oYNy/QWv/B6qhS8Lq
         926A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y30GtIKkLuXdZ608Vv+U7ffueQj6lNYrKY5cOlCGJWA=;
        b=sVoHrQkmDs8g/UqUILnMhL1p1HJ3D/bwSfsF/nE72KqLyHdVW04sZhW8SHMIVEgeU9
         DdOBWSjjZO0GHDx49QGBAfWGCNAN4/pnrjkitdprMCak7tvOFCmQNAAXZj+Sb1fCaFgh
         xsN9Zi5ZWJIiXE/EUMT+zAwcoU8SvpFy1CvBayma/bw/Dv+FrURaJHwDK54fHkT003ou
         YUVVEi1Wyr4GVZ5B3wbqSiacVFmCTcCIkOWmSr6muP13Wffz3vjUejO2x6VGDS7ZWhHn
         VCaV5Le2FtP3ZGBYvoXsjMmW1w9874Ald5pOMCpu7m4w02Tth+zqkCSgSFxTYxhQZigJ
         sydA==
X-Gm-Message-State: APjAAAWnEt+rbF/Bs8ohdCHjQjUUQohon1a+DfbkJn7XYYQULHcbYks9
        OV4QUSI1OXuuNZ4NmVLhHFNYhn54
X-Google-Smtp-Source: APXvYqz0713bLlc6REVU5kywq15hHrHb7olDzMQo8OCB1Bf4rscbNsPKwBFQkUjKwLNK1Tn05DNDhg==
X-Received: by 2002:adf:de83:: with SMTP id w3mr22815692wrl.275.1583156357691;
        Mon, 02 Mar 2020 05:39:17 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j12sm28710917wrt.35.2020.03.02.05.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 05:39:17 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: snps-dw-apb-uart: add compatible property for rk3308 uart
Date:   Mon,  2 Mar 2020 14:39:10 +0100
Message-Id: <20200302133910.10942-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A test with the command below gives these errors:

arch/arm64/boot/dts/rockchip/rk3308-evb.dt.yaml: serial@ff0d0000: compatible:
['rockchip,rk3308-uart', 'snps,dw-apb-uart']
is not valid under any of the given schemas
arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dt.yaml: serial@ff0a0000: compatible:
['rockchip,rk3308-uart', 'snps,dw-apb-uart']
is not valid under any of the given schemas

The compatible property for the Rockchip rk3308 uart was somehow never
added to the documention. Fix this error by adding 'rockchip,rk3308-uart'
to snps-dw-apb-uart.yaml.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/
snps-dw-apb-uart.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index b42002542..b962f8db4 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -27,6 +27,7 @@ properties:
               - rockchip,rk3066-uart
               - rockchip,rk3188-uart
               - rockchip,rk3288-uart
+              - rockchip,rk3308-uart
               - rockchip,rk3328-uart
               - rockchip,rk3368-uart
               - rockchip,rk3399-uart
-- 
2.11.0


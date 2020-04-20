Return-Path: <SRS0=2nXW=6E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25884C54FC9
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 01:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF79B20882
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 01:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Jz+akebx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDTBdd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:33:33 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:52632 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgDTBdc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Apr 2020 21:33:32 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200420013329epoutp01b991bc10a2fd2cab29b763ed43ca0dc9~HYyY7x-bf2899028990epoutp01K
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2020 01:33:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200420013329epoutp01b991bc10a2fd2cab29b763ed43ca0dc9~HYyY7x-bf2899028990epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587346409;
        bh=OnGzkKawmgNmEQLHo3fXe9Xbamb/f0idQAQPFcFTxIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jz+akebxfRoLmOYnOgEfBjs3zVUROSaQAIapVtDMOrgGD0+w9mzTE0WbMXfhOa7ak
         VhcGwprV2tFsCEGqrhymfJ/DlvCFLMbBnDv4BIq9zi5zrgqoG73SUOYVhvZjy8Bny2
         yCPSVVDDlJh3gZkwucJNhFQxJ3pHBl5RkPCPx9Is=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200420013329epcas2p289c162de878c738033ef1f2f5a2d3762~HYyYi2A6I1982219822epcas2p2F;
        Mon, 20 Apr 2020 01:33:29 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.188]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4958NR4ZFMzMqYkh; Mon, 20 Apr
        2020 01:33:27 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.BE.04704.6EBFC9E5; Mon, 20 Apr 2020 10:33:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200420013325epcas2p13f65e6bc8ba68f89c805704830144870~HYyVjLZFM1887218872epcas2p1U;
        Mon, 20 Apr 2020 01:33:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200420013325epsmtrp2fa48cc1179d525f988a9a24db1389934~HYyViXjeZ0884408844epsmtrp2u;
        Mon, 20 Apr 2020 01:33:25 +0000 (GMT)
X-AuditID: b6c32a46-811ff70000001260-b7-5e9cfbe6100c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.2A.04024.5EBFC9E5; Mon, 20 Apr 2020 10:33:25 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200420013325epsmtip189419b8020c8cbae5db3e699cba44081~HYyVXlGxZ2205622056epsmtip1x;
        Mon, 20 Apr 2020 01:33:25 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hyunki00.koo@samsung.com
Subject: [PATCH v8 2/3] dt-bindings: serial: Add reg-io-width compatible
Date:   Mon, 20 Apr 2020 10:32:57 +0900
Message-Id: <20200420013300.17249-2-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200420013300.17249-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmhe6z33PiDF7OU7aYf+Qcq0Xz4vVs
        FquW3mC2uLxrDpvFmcW97Bate4+wO7B5bFrVyeaxf+4ado++LasYPT5vkgtgicqxyUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMDQs0CtOzC0uzUvXS87PtTI0MDAyBapMyMlYt/Ule8Fs
        9oqbjzezNDC+Ze1i5OSQEDCR6G+ezNjFyMUhJLCDUeLThdfMEM4nRomDJ3+xQzjfGCWW/bsO
        VMYB1rJgox1EfC9Q0ZLzbBDOD0aJ41NmsYPMZRPQlnjzfSbYKBGBjYwSazc+YARJMAvISPzY
        fo8JxBYW8JBY+fQeM4jNIqAqsendXxYQm1fAVuL03s9QBypLXHi3hBVkM6eAncT35WYgMyUE
        prBJHD10mBmixkVi+ck7jBC2sMSr41vYIWwpic/v9rJB2PUS+9omskM09zBK/PzwFGqBscSs
        Z+1grzELaEqs36UP8aWyxJFbLBAn80l0HP7LDhHmlehoE4JoVJNY9+0FE4QtI7Hm6S6oEg+J
        mVf1IEEyERiiq9ewTGCUm4UwfwEj4ypGsdSC4tz01GKjAiPkCNvECE5cWm47GJec8znEKMDB
        qMTDyzB7TpwQa2JZcWXuIUYJDmYlEd6DbjPjhHhTEiurUovy44tKc1KLDzGaAsNxIrOUaHI+
        MKnmlcQbmhqZmRlYmlqYmhlZKInzbuK+GSMkkJ5YkpqdmlqQWgTTx8TBKdXAODngzJr/a7fF
        Lqp721qqa/Z4YcSiWVM/lFx0dtNd1MJ+SiFqnknzsuKY2qfvnp5Y8bzFP3szJ+OmQFeuedIB
        v2we6mzgidt/xfvy+Uqe2dyLnVgcz4Yve+4+a/WKmO3744/srVwy0ViqY4LXBI1DggxzXm4r
        8v8U/6LrvaHmFpNZq5SDGhL2tCqxFGckGmoxFxUnAgAXHG0fcgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsWy7bCSnO7T33PiDCZsMraYf+Qcq0Xz4vVs
        FquW3mC2uLxrDpvFmcW97Bate4+wO7B5bFrVyeaxf+4ado++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKWLf1JXvBbPaKm483szQwvmXtYuTgkBAwkViw0a6LkYtDSGA3o8TBg9cYuxg5geIy
        EhNeLGGGsIUl7rccYYUo+sYo0dj8nwUkwSagLfHm+0xmkISIwFZGie33J7KCJJiBun9sv8cE
        YgsLeEisfHoPbBKLgKrEpnd/wZp5BWwlTu/9zAqxQVniwrslYBdxCthJfF9uBhIWAiq5enoV
        8wRGvgWMDKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYIDTEtzB+PlJfGHGAU4GJV4
        eBlmz4kTYk0sK67MPcQowcGsJMJ70G1mnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE
        0hNLUrNTUwtSi2CyTBycUg2MetNSd1kZrvI8Kiy97dFv69SM8Et/+T+qTUvU7C3m/fpSKiJ0
        xqtnN1ziRJTNHsiucFu5JHbOepfA234HdvnE2rs9y0lv2Wgb8Tlpb+iXbKZnR86ZzXvTf+Ww
        4Mn2556fXl0/JOnaw8Qu6O3IeCQ+9rfvpwtnl23ZM5ep+vZ2rg55l+U/DBzLlViKMxINtZiL
        ihMBb53XDCwCAAA=
X-CMS-MailID: 20200420013325epcas2p13f65e6bc8ba68f89c805704830144870
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200420013325epcas2p13f65e6bc8ba68f89c805704830144870
References: <20200420013300.17249-1-hyunki00.koo@samsung.com>
        <CGME20200420013325epcas2p13f65e6bc8ba68f89c805704830144870@epcas2p1.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a description for reg-io-width options for the samsung serial
UART peripheral.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 9d2ce347875b..a57b1233c691 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -29,6 +29,14 @@ properties:
   reg:
     maxItems: 1
 
+  reg-io-width:
+    description: |
+      The size (in bytes) of the IO accesses that should be performed
+      on the device.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [ 1, 4 ]
+
   clocks:
     minItems: 2
     maxItems: 5
-- 
2.15.0.rc1


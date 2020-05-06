Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1A0C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 07:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97D120936
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 07:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NaRPnfKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgEFHAi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 03:00:38 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:24544 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgEFHAh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 03:00:37 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200506070028epoutp02a6dd2a10ef3e174992504d32f50134cb~MXkcpTi4-2191721917epoutp02H
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 07:00:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200506070028epoutp02a6dd2a10ef3e174992504d32f50134cb~MXkcpTi4-2191721917epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588748428;
        bh=OnGzkKawmgNmEQLHo3fXe9Xbamb/f0idQAQPFcFTxIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaRPnfKVC2JS2gQzWD01AdG+UeaUBMjDKcWYpB9DG87U7m31betE5ZUJNtB0v/JLA
         +TPUPQuvuV2HKi+YGR0fVpEWvS6j2VpOJc1fLJ/tH8QPLpOgfoWKpn2WF+hSPOY0Xy
         5ZdAw3lwsJNobDwqOYi7sahmY9H3ZiYbvJYvZWT0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200506070027epcas2p4f66459a82f3655018136d6476fb9eb6d~MXkcQ2K6J2850728507epcas2p4I;
        Wed,  6 May 2020 07:00:27 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.186]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49H6tL2wK9zMqYl3; Wed,  6 May
        2020 07:00:26 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.D9.49908.98062BE5; Wed,  6 May 2020 16:00:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200506070024epcas2p2868e11349d2fee83d340df7fa181f704~MXkZTMzT_2155521555epcas2p2H;
        Wed,  6 May 2020 07:00:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200506070024epsmtrp28ceac7245e1f22ea758df179d2824b55~MXkZSXYMD1581515815epsmtrp2u;
        Wed,  6 May 2020 07:00:24 +0000 (GMT)
X-AuditID: b6c32a45-af9ff7000000c2f4-c2-5eb260899e06
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.E8.18461.88062BE5; Wed,  6 May 2020 16:00:24 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200506070024epsmtip1b7a5d6c791c41164f80f91ae40c4f940~MXkZCsbdb2679526795epsmtip1V;
        Wed,  6 May 2020 07:00:24 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>
Subject: [PATCH v9 2/3] dt-bindings: serial: Add reg-io-width compatible
Date:   Wed,  6 May 2020 16:00:06 +0900
Message-Id: <20200506070009.16809-2-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200506070009.16809-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmqW5nwqY4g2tX2CzmHznHatG8eD2b
        xaqlN5gtLu+aw2ZxZnEvu0Xr3iPsDmwem1Z1snnsn7uG3aNvyypGj8+b5AJYonJsMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKDA0L9IoTc4tL89L1kvNzrQwNDIxMgSoTcjLWbX3JXjCb
        veLm480sDYxvWbsYOTkkBEwkrjXMALK5OIQEdjBK7GjczwThfGKU+PW/E8r5xijxffFcJpiW
        u6vfsUEk9jJKfO7axwjh/GCUmH6zBayKTUBb4s33mcwgCRGBjYwSazc+YARJMAtoSvw4cANs
        u7CAh0T/th1Aozg4WARUJfYc8QcJ8wrYSjR3L4Dapixx4d0SsHJOATuJN12PwY6VENjFLvFn
        AcgyDiDHRaK/3xyiXlji1fEt7BC2lMTnd3vZIOx6iX1tE9khensYJX5+eAoNAWOJWc/aGUHm
        gNy2fpc+xEhliSO3WCAu5pPoOPyXHSLMK9HRJgTRqCax7tsLqCtlJNY83QW11UNizrRt7JAg
        mQgMkr67rBMY5WYhLFjAyLiKUSy1oDg3PbXYqMAQOcY2MYJTl5brDsYZ53wOMQpwMCrx8Bq4
        b4wTYk0sK67MPcQowcGsJMLL8wMoxJuSWFmVWpQfX1Sak1p8iNEUGI4TmaVEk/OBaTWvJN7Q
        1MjMzMDS1MLUzMhCSZx3M/fNGCGB9MSS1OzU1ILUIpg+Jg5OqQZGoyPLrl8v7f/6NUlVVuPc
        4uPbfl/NjnBdE3UoblKCaJikedSs2IVvrnx2mFDoHRu3JO3YtRmVkUJ2J1bNiOjid7IxNJi5
        yaS0trNpXurkxTmv/65eXZQpmd/T8bv82bX0l6d/ZmW+2mJhLe9SvPx7lFVMxOqNc20u6aw5
        e09dQ2L+jONPNv5XU2Ipzkg01GIuKk4EAFqdC1BzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJTrcjYVOcwdHZihbzj5xjtWhevJ7N
        YtXSG8wWl3fNYbM4s7iX3aJ17xF2BzaPTas62Tz2z13D7tG3ZRWjx+dNcgEsUVw2Kak5mWWp
        Rfp2CVwZ67a+ZC+YzV5x8/FmlgbGt6xdjJwcEgImEndXv2PrYuTiEBLYzShx//FpNoiEjMSE
        F0uYIWxhifstR1ghir4xSsw69YsFJMEmoC3x5vtMZpCEiMBWRont9yeCjWUW0JT4ceAGmC0s
        4CHRv20H0FQODhYBVYk9R/xBwrwCthLN3QuYIBYoS1x4twSsnFPATuJN12MwWwioZkffK6YJ
        jHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEh5iW5g7G7as+6B1iZOJgPMQo
        wcGsJMLL82NjnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeG4UL44QE0hNLUrNTUwtSi2CyTByc
        Ug1MFY4MOd+CpebIOZWpvtud/0U8tDj7aW2n0JKtDmkNNZ3f323JcJz0tHZdRq2w/eUZN+uc
        mG1i3vLIzlJ4wHfz8vyFht8W5K2ISXr2fqOO/13Pa52VYi4//kSfuxLWurdTd+KDdW/+SnQe
        /LRKu2uX2lx9vQUGnzRj+i+eS6pP+HDqVp5ToH6h3m2NF8enz9J6ePboc5XniRxsfbbraj+m
        bXLVm3GQIWI9d5rBziMv/+ozsHhZavjMecsyTebiz9RwibxuicxHU7sC/1tMK8uW4OOUvixw
        0O3Q4vqZpy6UbXvauqDA3lCx9NZOkTfnospT9q3Sc2OsaItO23NQf2L95Jsb2OcnbP5Ue6sl
        8sh2JZbijERDLeai4kQAOemH5KACAAA=
X-CMS-MailID: 20200506070024epcas2p2868e11349d2fee83d340df7fa181f704
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506070024epcas2p2868e11349d2fee83d340df7fa181f704
References: <20200506070009.16809-1-hyunki00.koo@samsung.com>
        <CGME20200506070024epcas2p2868e11349d2fee83d340df7fa181f704@epcas2p2.samsung.com>
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


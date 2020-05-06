Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3487CC4CECC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 08:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A38620661
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 08:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QgL8Ks7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgEFIDE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 04:03:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21820 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgEFIDA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 04:03:00 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200506080257epoutp0392cb131508ebb35c5007f3e9e6a8096b~MYbAF7FjP0824908249epoutp03K
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 08:02:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200506080257epoutp0392cb131508ebb35c5007f3e9e6a8096b~MYbAF7FjP0824908249epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588752177;
        bh=WQxhQAXtu4xKEkaXj9l2A6PTUue9TVZdXiYo7uQZEr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgL8Ks7fOr6MO5g3LcRk08bB1uyQI8d+HXIy66Xvsw8zBiUIvwHP2hZaryi+dVMB/
         EG5p/bqt8xjv4WLGUPV0rxxRc/XdfKcWaIPdDTB6MQQY04MbHzyEdPUi2qKdBEfcHk
         utG2SoWQfLUjTwamuO+jjxkVkFKKfjAbnXHjMHg4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200506080256epcas2p4287cdfbae823a43f1e99c230ee420b22~MYa-2YnPi1326713267epcas2p4n;
        Wed,  6 May 2020 08:02:56 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.186]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49H8GR4qHdzMqYkb; Wed,  6 May
        2020 08:02:55 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.53.04647.F2F62BE5; Wed,  6 May 2020 17:02:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200506080255epcas2p2bbaae2e0f3fa181bafa5012f069200be~MYa_QhJ0p1824218242epcas2p2N;
        Wed,  6 May 2020 08:02:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200506080255epsmtrp2e3120e224c68c4847fb769893b1a3fcd~MYa_P1kIW1615416154epsmtrp2K;
        Wed,  6 May 2020 08:02:55 +0000 (GMT)
X-AuditID: b6c32a48-8a5ff70000001227-68-5eb26f2f1ff6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.3F.18461.F2F62BE5; Wed,  6 May 2020 17:02:55 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200506080255epsmtip14134b7b0b1b41313549365a34ae6f706~MYa_FKBFQ2178121781epsmtip19;
        Wed,  6 May 2020 08:02:55 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>
Subject: [PATCH v10 2/3] dt-bindings: serial: Add reg-io-width compatible
Date:   Wed,  6 May 2020 17:02:39 +0900
Message-Id: <20200506080242.18623-2-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200506080242.18623-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmqa5+/qY4g1e7lC3mHznHatG8eD2b
        xaqlN5gtLu+aw2ZxZnEvu0Xr3iPsDmwem1Z1snnsn7uG3aNvyypGj8+b5AJYonJsMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKDA0L9IoTc4tL89L1kvNzrQwNDIxMgSoTcjI+HpvNWnCc
        vWLmr1csDYxT2LoYOTgkBEwk5m8x72Lk4hAS2MEosXj1bHYI5xOjxNxHXawQzjdGiVPLbwN1
        cIJ1bF90nA0isZdR4u6eu8wQzg9Gib6Tk5hBqtgEtCXefJ8JlhAR2MgosXbjA0aQBLOApsSP
        AzdYQWxhAU+JXZ9aweIsAqoSLzdeAlvBK2Ar0f70JtQ6ZYkL75awghzLKWAnsfqSJ8hMCYFd
        7BJzn55ihKhxkXj/6jU7hC0s8er4FihbSuLzu71Qc+ol9rVNZIdo7mGU+PnhKStEwlhi1rN2
        RpAFIMet36UPCRhliSO3WCBO5pPoOPyXHSLMK9HRJgTRqCax7tsLJghbRmLN011QWz0kTl8D
        GQgKk4mMEm0HWxgnMMrNQliwgJFxFaNYakFxbnpqsVGBCXKMbWIEpy4tjx2MB875HGIU4GBU
        4uE1cN8YJ8SaWFZcmXuIUYKDWUmEl+cHUIg3JbGyKrUoP76oNCe1+BCjKTAgJzJLiSbnA9Nq
        Xkm8oamRmZmBpamFqZmRhZI47ybumzFCAumJJanZqakFqUUwfUwcnFINjAq38nJPmO3gUPz+
        f+eEBYLaAq7C08PKz+R31wbFSHtcsltu0Z06S3LvBdEt0+t7or7xus1u/ZK0R7y6dUrA+wmT
        t/ydONOq+nTmxkilJobQwOl8PQFnGdercgWqHjM8e3bHyuf81gahrrIbb7Hbs+9fuiL/2Icd
        q46W14Y4Bu20vMTQcYW7VYmlOCPRUIu5qDgRAA8Wy+5zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJTlc/f1Ocwe0XnBbzj5xjtWhevJ7N
        YtXSG8wWl3fNYbM4s7iX3aJ17xF2BzaPTas62Tz2z13D7tG3ZRWjx+dNcgEsUVw2Kak5mWWp
        Rfp2CVwZH4/NZi04zl4x89crlgbGKWxdjJwcEgImEtsXHQeyuTiEBHYzSqy48oURIiEjMeHF
        EmYIW1jifssRVoiib4wSE2buZAdJsAloS7z5PpMZJCEisJVRYvv9iawgCWYBTYkfB26A2cIC
        nhK7PrWCTWURUJV4ufES2GpeAVuJ9qc3oc5QlrjwbglQPQcHp4CdxOpLniBhIaCSTS8Ps05g
        5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4xLQ0dzBuX/VB7xAjEwfjIUYJ
        DmYlEV6eHxvjhHhTEiurUovy44tKc1KLDzFKc7AoifPeKFwYJySQnliSmp2aWpBaBJNl4uCU
        amAq+Sarpn44dq39zH3fYloDZQ7tEJn76boS2xI2iSVeom5nGVPvxB567BJ2JMX01t1W6WX+
        SruvPTbdm3BD/4n1u98LX1VPXrZr92PDsnlHvuuuUE3XsTobxLv0U1m9Ou9G9vlRp2d7M0x5
        f3xSbfOeNPks1epniR1lPX8+fHGe8e6jxZYv6fdVbDV0riiY5RmcuuPYz3/Rpe5ar8zk/q1L
        l+i/UL6tOb099NueyAzfJSwBZdvsm4733X28Os90fyYve+mV13EaNw0aK04E8BSFub11cN7k
        3W6U9yjtx8lXf7acM5rTLXc+Lfd7ln98o/jLgEQV5q8GtcKTswLe7duoe8D4rUXWt1PPNO4u
        3SuvxFKckWioxVxUnAgAlQia5aACAAA=
X-CMS-MailID: 20200506080255epcas2p2bbaae2e0f3fa181bafa5012f069200be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506080255epcas2p2bbaae2e0f3fa181bafa5012f069200be
References: <20200506080242.18623-1-hyunki00.koo@samsung.com>
        <CGME20200506080255epcas2p2bbaae2e0f3fa181bafa5012f069200be@epcas2p2.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a description for reg-io-width options for the samsung serial
UART peripheral.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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


Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55884C2BA19
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F9206F5
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EEmeYUed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgDFKcM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:32:12 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37339 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgDFKcM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 06:32:12 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200406103210epoutp04d0155a44e0e2ac59b9489b099016fba0~DNGudSGaZ1008810088epoutp04p
        for <linux-serial@vger.kernel.org>; Mon,  6 Apr 2020 10:32:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200406103210epoutp04d0155a44e0e2ac59b9489b099016fba0~DNGudSGaZ1008810088epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586169130;
        bh=OnGzkKawmgNmEQLHo3fXe9Xbamb/f0idQAQPFcFTxIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEmeYUedPXbHAHjfjYcEuYCL6qY7znHSBv6uICw8X1dckLI4MsDl9SmedxW56ZHAE
         /bPfnu+TQXs/JmkSOHssmSoXtPZ87Y7WnD19zrR/UbEQNvURFjb1v6o+Rs8c6TtrR0
         AcrzyRRNdt2pHYcBXzUfjjk2WvaFETIur1T1xkVE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200406103209epcas2p4ed8a2e953c7c56df5f81753b6a80b265~DNGt5a2qx0500905009epcas2p44;
        Mon,  6 Apr 2020 10:32:09 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48wn0S5hZGzMqYkb; Mon,  6 Apr
        2020 10:32:08 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.E3.04647.6250B8E5; Mon,  6 Apr 2020 19:32:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200406103206epcas2p2bf3c65f96d94cc91fcdcd3e6db75e2a3~DNGqrwMGN0510705107epcas2p2D;
        Mon,  6 Apr 2020 10:32:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200406103206epsmtrp21bfeb2939e70e290578a5efc3e3cecc2~DNGqq8YSU2109121091epsmtrp2g;
        Mon,  6 Apr 2020 10:32:06 +0000 (GMT)
X-AuditID: b6c32a48-8a5ff70000001227-94-5e8b05267725
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.6D.04024.6250B8E5; Mon,  6 Apr 2020 19:32:06 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200406103206epsmtip19e78cb68e61115a8d3156b8b420fbcdc~DNGqcP4Xf1685116851epsmtip1q;
        Mon,  6 Apr 2020 10:32:06 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     gregkh@linuxfoundation.org, krzk@kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: serial: Add reg-io-width compatible
Date:   Mon,  6 Apr 2020 19:31:26 +0900
Message-Id: <20200406103127.17105-2-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200406103127.17105-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmha4aa3ecwZoP+hbzj5xjtWhevJ7N
        YtXSG8wW589vYLe4vGsOm8WZxb3sFq17j7A7sHtsWtXJ5rF/7hp2j74tqxg9Pm+SC2CJyrHJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgaFigV5yYW1yal66XnJ9rZWhgYGQKVJmQk7Fu
        60v2gtnsFTcfb2ZpYHzL2sXIySEhYCLRvmAVSxcjF4eQwA5GiVOXp7NBOJ8YJT4/OwKV+cYo
        cfViFyNMy80n+9lBbCGBvYwSm2fxQdg/GCVuL0sCsdkEtCXefJ/J3MXIwSEioC/xZKsHyBxm
        geWMEqcXvQKLCwt4SPTcygEpZxFQldjyoZsFJMwrYCsxba8lxCZliQvvloAdyilgJ3F9y1N2
        kDESAjPYJL7sXcoGUeQicXv+EajThCVeHd/CDmFLSXx+txeqpl5iX9tEqOYeRomfH55CvW8s
        MetZOyPIYmYBTYn1u/RBTJDFR26xgFQwC/BJdBz+yw4R5pXoaBOCaFSTWPftBROELSOx5uku
        qBIPiaYHjpBAO8oo8X5hG+MERrlZCPMXMDKuYhRLLSjOTU8tNiowQY6tTYzg5KXlsYPxwDmf
        Q4wCHIxKPLwrbnTGCbEmlhVX5h5ilOBgVhLhleoFCvGmJFZWpRblxxeV5qQWH2I0BYbjRGYp
        0eR8YGLNK4k3NDUyMzOwNLUwNTOyUBLn3cR9M0ZIID2xJDU7NbUgtQimj4mDU6qB0dvrwr+o
        4LygNjHBv8HKpw7xFb4Vub5v1UK7e3cTfsbPcWE7HNipG7ep2OaMwz5n3y6pK7ZXOT8emlDQ
        c0BaveXi29qVqT/M9uiHTXq4mqe6o+7VBb8DId1HJJ/MzPhvocd/zTVepP/Rqt/lF/73CZ/v
        5Th67UrK+YIXJ47YhB02+Z67dLH/RSWW4oxEQy3mouJEABe878p0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSnK4aa3ecwf1ucYv5R86xWjQvXs9m
        sWrpDWaL8+c3sFtc3jWHzeLM4l52i9a9R9gd2D02repk89g/dw27R9+WVYwenzfJBbBEcdmk
        pOZklqUW6dslcGWs2/qSvWA2e8XNx5tZGhjfsnYxcnJICJhI3Hyyn72LkYtDSGA3o8SyJS0s
        EAkZiQkvljBD2MIS91uOsEIUfWOUeLt1JRtIgk1AW+LN95lgRSIChhJf7vSzgBQxC6xmlHj9
        YwqQw8EhLOAh0XMrB6SGRUBVYsuHbrAwr4CtxLS9lhDzlSUuvFsCdhCngJ3E9S1P2UFKhAQK
        JR4sVJ7AyLeAkWEVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwoGlp7mC8vCT+EKMA
        B6MSDy/D7c44IdbEsuLK3EOMEhzMSiK8Ur1AId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845F
        CgmkJ5akZqemFqQWwWSZODilGhhjpIrirtY4eYQZ2K9Zt2/vQUPmBTah+yYpH0z8v++y/JyQ
        QpaH9/6/PH+747nZ0SdeNiFrlS7d3J4WviI9OG2S9JrYeTFu0XUz9d60t50Q5+2+a/etdrld
        x975X6fdvfkpWDTrgkT/atVE39b1HeeeT327+brhxa+SknKhEwyfzzlj9clMVdBKiaU4I9FQ
        i7moOBEALbjdczACAAA=
X-CMS-MailID: 20200406103206epcas2p2bf3c65f96d94cc91fcdcd3e6db75e2a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200406103206epcas2p2bf3c65f96d94cc91fcdcd3e6db75e2a3
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <20200406103127.17105-1-hyunki00.koo@samsung.com>
        <CGME20200406103206epcas2p2bf3c65f96d94cc91fcdcd3e6db75e2a3@epcas2p2.samsung.com>
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


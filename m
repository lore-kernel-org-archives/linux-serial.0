Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7974DC2BA1A
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 23:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C4320768
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 23:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IMMfv5wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDFXJM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:09:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:10858 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgDFXJM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 19:09:12 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200406230910epoutp02d600870a9b484243932990e4ba187ba4~DXbrHs1xm2441824418epoutp02E
        for <linux-serial@vger.kernel.org>; Mon,  6 Apr 2020 23:09:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200406230910epoutp02d600870a9b484243932990e4ba187ba4~DXbrHs1xm2441824418epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586214550;
        bh=Oyy8GSRtEGb4j6pnM0cKP+mEu/lSYBx7es05N7ZvSyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMMfv5wo1Wy3luOftdi3f4SXeCvjyT2E7wYB+wIgmBVgavx5egDdOBz7OncXlqVsA
         FxSxUq6eqcVYPJ2YGr+vaaIWaPpuM27GSAbTn0M4ZtUlZMlGedF6egspvd/QiaXBL3
         LM+5klE+QpbWJikXbgeWeyx6EW0Pp0Ge2Y7rS+fU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200406230910epcas2p280f714fd89d96230425220ebebd1e737~DXbquwSps1756717567epcas2p2s;
        Mon,  6 Apr 2020 23:09:10 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48x5nw4yzHzMqYkf; Mon,  6 Apr
        2020 23:09:08 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.DB.04598.296BB8E5; Tue,  7 Apr 2020 08:09:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20200406230906epcas2p3f5703f7f9f00cd1cf7dbe5cfd304481f~DXbnKFX4w2087620876epcas2p3z;
        Mon,  6 Apr 2020 23:09:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200406230906epsmtrp28a8a24b78a9c73f6326ab42e442631a3~DXbnJVtk60348103481epsmtrp2Z;
        Mon,  6 Apr 2020 23:09:06 +0000 (GMT)
X-AuditID: b6c32a45-ea1ff700000011f6-cd-5e8bb692a63b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.1E.04024.296BB8E5; Tue,  7 Apr 2020 08:09:06 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200406230906epsmtip2820abc144cd863527dfa2f94cee9fcb8~DXbm6UmB_2465024650epsmtip2L;
        Mon,  6 Apr 2020 23:09:06 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     gregkh@linuxfoundation.org, krzk@kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: serial: Add reg-io-width compatible
Date:   Tue,  7 Apr 2020 08:08:50 +0900
Message-Id: <20200406230855.13772-2-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200406230855.13772-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+Xm33VktL5vWcYmsa0oPdLurzZukBWVMM7H8o4hw3dxts/bq
        3i2yBxmSlWbvyI3K0sIS0/DFUExxRkQPA0FNKIkyQtQsoRe9tt1F/fflnM/3cF5STP5arJQW
        2V0sZ2espGSWqN2/JDX5fHtFgcbzNJGu7nsmpktrmyR0/a1hjO7vv4fTAx1XJPST2kqcPtbV
        h6/BDc31JyWG7qsNuOF0az0yzDTH54m2WVdZWMbEcirWXugwFdnN6eSGfONao06voZKplXQq
        qbIzNjadXJeTl7y+yBrogFTtY6zuQCiP4XlSnbGKc7hdrMri4F3pJOs0WZ0U5UzhGRvvtptT
        Ch22NEqj0eoC5A6rpbWkFXf24Pv9j3QlqFJSjiKlQKyA1wOlqBzNksoJH4LOqe5QQk58QnDt
        4hEh8RlBb92QuBxJQ466D2kC04XgzmicwHxFcHq6OmSWEMtg4osHC/LRhBrethmCDEbUIXhc
        M44FGQVhgEFfizioRUQi/PrtDWkZkQ4/vo+KhO4S4PnUzVA8ksiAmks/8GAhIKok8MrzJQyt
        A3/3oFjQChh/2IoLWgkzU13hMY/A/bJzYfMpBN+mx8KG5eB9dxwFO8WIJdDUoRaGTIC+kVB5
        jJgLJ/w/cSEsgxNlcsGYBI2f30cIOg4axjrCiAGOtiwSVvIAQcvkm4izKN77r/51hOrRPNbJ
        28wsr3VS/1+rGYXea2mmD1U9y+lFhBSRc2RbIysK5GJmH19s60UgxchombLyZIFcZmKKD7Cc
        w8i5rSzfi3SBRZ7DlDGFjsCz2l1GSqfV6zUrdbROr6XJ+bKW2S+2ywkz42L3sKyT5f76IqSR
        yhK0uELRjob3Gj1a/11ul+ewTXWVy5ob+3PsUNxw1sIarbhiUKX8/U7dpXjZafFVZZrSbl2+
        YElSpMLquIO1xOQW1W3/heyNPfnalImGxWp22JeAOmNzVeqkqMY3evf45o6YnSMfi6PMu7PN
        m9rO5N9YQA15riyv7fQOUrlDMwpSxFsYainG8cwf1hU9gnQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSvO6kbd1xBu92c1nMP3KO1aJ58Xo2
        i1VLbzBbnD+/gd3i8q45bBZnFveyW7TuPcLuwO6xaVUnm8f+uWvYPfq2rGL0+LxJLoAlissm
        JTUnsyy1SN8ugStjS8MW9oID7BWHT5o2MPaydTFycEgImEgsf2/VxcjFISSwm1Fi7urtLF2M
        nEBxGYkJL5YwQ9jCEvdbjrBCFH1jlHh1cDojSIJNQFvizfeZYEUiAoYSX+70s4AUMQusZpR4
        /WMK2CRhAQ+Jazs2s4LYLAKqEv/+zwKzeQVsJf78ug+1TVniwrslYHFOATuJRVP/sIPYQgKF
        Eq/23maZwMi3gJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcKhpae5gvLwk/hCj
        AAejEg8vA3t3nBBrYllxZe4hRgkOZiURXqnezjgh3pTEyqrUovz4otKc1OJDjNIcLErivE/z
        jkUKCaQnlqRmp6YWpBbBZJk4OKUaGKOSLCdGO2/p0uQ1/2DyXiC3RuJ2vuu9ZaYffIr2vPL3
        frumbYbRpCd77nlGuKvWlx1Rv3cq6kKVUvyyIFVx7xkSNq9feuzccs378mONyeJHTY8r8Crp
        rjsYNTsrav0x0awOS1Ovo+F3f85beoRluo8v8w/XucxiE4omXQ92ZbQ1tb+0umhbnxJLcUai
        oRZzUXEiAEpSdCIxAgAA
X-CMS-MailID: 20200406230906epcas2p3f5703f7f9f00cd1cf7dbe5cfd304481f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200406230906epcas2p3f5703f7f9f00cd1cf7dbe5cfd304481f
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <20200406230855.13772-1-hyunki00.koo@samsung.com>
        <CGME20200406230906epcas2p3f5703f7f9f00cd1cf7dbe5cfd304481f@epcas2p3.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a description for reg-io-width options for the samsung serial
UART peripheral.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
v5: first added in this series
v6: clean description of reg-io-width
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 9d2ce347875b..1a0bb7619e2e 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -29,6 +29,12 @@ properties:
   reg:
     maxItems: 1
 
+  reg-io-width:
+    description:
+      The size (in bytes) of the IO accesses that should be performed
+      on the device. If omitted, default of 1 is used.
+      - enum: [ 1, 4 ]
+
   clocks:
     minItems: 2
     maxItems: 5
-- 
2.15.0.rc1


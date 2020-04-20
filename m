Return-Path: <SRS0=2nXW=6E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC58C54FCB
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 23:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B17D20722
	for <linux-serial@archiver.kernel.org>; Mon, 20 Apr 2020 23:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RDEQDu8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDTXgR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:36:17 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:14142 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTXgQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Apr 2020 19:36:16 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200420233612epoutp04912eec171bb96392d394fad92adf554b~Hq1Rr29zt2658826588epoutp04g
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2020 23:36:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200420233612epoutp04912eec171bb96392d394fad92adf554b~Hq1Rr29zt2658826588epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587425772;
        bh=0zV61XXniqLf2n8cMb5JLDQF3gb5g9WkC9SZj/+F8OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDEQDu8bd9gVUZfU+vch0hYptlEwOCbt4yjq0eNOfX2k4TSDoQHp2FH3WaUdcoZ3t
         mv6YTkb56hhY3Y31G6HOfGmlWsEG4I45wiVMBuhnCdmw1PZIK/qL8XQkNfqhGeVfjc
         QtGAnNeD/qYc4yUPN9HB6i0daKAsVCGgYuRsfP1k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200420233612epcas2p3e95ac138558dc3ec0157374f8ec75506~Hq1RG7yi42716027160epcas2p3m;
        Mon, 20 Apr 2020 23:36:12 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.188]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 495jkd2M5xzMqYlm; Mon, 20 Apr
        2020 23:36:09 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.9B.04647.7E13E9E5; Tue, 21 Apr 2020 08:36:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20200420233607epcas2p305dbd652ab73592a32c17773c1fce329~Hq1M79Nwu2716027160epcas2p3a;
        Mon, 20 Apr 2020 23:36:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200420233607epsmtrp2ab089dbb4b8ed5914ef86b905ae5aacd~Hq1M7La5X1923519235epsmtrp2G;
        Mon, 20 Apr 2020 23:36:07 +0000 (GMT)
X-AuditID: b6c32a48-8a5ff70000001227-a6-5e9e31e79788
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.7A.04158.7E13E9E5; Tue, 21 Apr 2020 08:36:07 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200420233607epsmtip18c43d887d0ed83dbf56dd6aa462a4bd3~Hq1M0vIrW2181121811epsmtip1j;
        Mon, 20 Apr 2020 23:36:07 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hyunki00.koo@samsung.com
Subject: [PATCH v8 0/3] 32-bit access for TX/RX hold registers for
 samsung_tty driver
Date:   Tue, 21 Apr 2020 08:35:58 +0900
Message-Id: <20200420233558.11879-1-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
In-Reply-To: <20200420013300.17249-1-hyunki00.koo@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUgTcRjm5+1upzW75ke/REIuktTMnXrrFCdRFoP8Y2AgZDUPd0xp263d
        ZllQkh81MckgLLMValZmakNStGXpKCqTyEgLMrOUKSKh+dGH0eYp9d/zPu/zvM/L7/fiiPwT
        GobnmaycxcQaSCxA8qA3ion1UI7DCnclylx396NMUV0LxjTeHEKYgc4ajOmrOy9lSlxu6U5M
        7Wy0Y+rua01SdUVbI1DPOjdpJAcMKbkcq+MsEZwph9flmfQqcl+GdreWViqoWCqJ2UFGmFgj
        pyLT0jWxe/MM3nAyIp812LyUhhUEMi41xcLbrFxELi9YVSRn1hnMFGXeLrBGwWbSb8/hjcmU
        QhFPe5XZhtw/PbUS87v1x5vsVVghaA4sA/44JBLhyMslpAwE4HKiA8ChJ3ZULGYAHKgdXCnm
        Afwy+QZZtYx+/YiJDReA917e9hOLRQCvvmjBfCqMiIFTC1eWBwcTFQAWOvqX7QgRDhfbh70O
        HA8iMmH9eKaPlhBb4P0+J+rDMkIFi5of+olpm+Hr6XrUJ/cnUuHCLaVvJCQuYLC5uxeImjTo
        mZuQijgITj5rW8FhcHbahYn4NHxUWikVzeUA/vg2hoqNBFg9fhb4AhAiCrZ0xvmgL9f9QSJu
        HAjP9S5JRVoGz5XKRWMkbJ73rGwZDpvGOldS1XCqu2vZKicqAXwwv+0C2FT9b/4NABpBKGcW
        jHpOiDcn/v9hTrB8XNHqDvC4P70HEDgg18paQx2H5SibLxQYewDEETJYxkR7KZmOLTjBWXit
        xWbghB5Ae9+xEgkLyeG9p2qyaik6XqlUJNEMrYxnyA0y55r3B+WEnrVyRzjOzFlWfX64f1gh
        gBeXNK7BODt9hmfrSt7S5ZJUBU28CvxZnmK7u1NaP9HvMrFl7kvDlrnvWG3WumOlIdTlLptn
        cOshR/iMSjFaqEN/T/MF9oTR4oWYPb8yNqbNVzWcUqd/npgI9JRpO/V1rY6qhqNZ2SOt7XyC
        NHlkV871O/uji09W1GCRz5+SEiGXpaIRi8D+BURg7HtyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSnO5zw3lxBjteq1jMP3KO1aJ58Xo2
        i1VLbzBbXN41h83izOJedovWvUfYHdg8Nq3qZPPYP3cNu0ffllWMHp83yQWwRHHZpKTmZJal
        FunbJXBl/Du0iKXgmmDFms7pbA2M6/i6GDk5JARMJB49ucvWxcjFISSwm1Fi+uavTBAJGYkJ
        L5YwQ9jCEvdbjrBCFH1jlNjwv5kFJMEmoC3x5vtMZpCEiMAkRomTy+aygSSYgbp/bL8HNklY
        IFRiw6c9YDaLgKrExjObWEFsXgFbieZ1e6C2KUtceLcEKM7BwSlgJ/F9uRlIWAio5OrpVcwT
        GPkWMDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDjEtrR2MJ07EH2IU4GBU4uHd
        IDYvTog1say4MvcQowQHs5IIr4UWUIg3JbGyKrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS
        1OzU1ILUIpgsEwenVAOj9Ob46Q8LSz97Mjz7kncs90aO+pXuBa/Xmc5b/zt72+oVvffCZy55
        cjkhaZ2hwYHzDcWzD11aapHC92XK/KlV+hNtpm38+Dsh9/Ie1totRcc65u+46qb8bveqdVmz
        c19rVcq3zVQQKo1YfmnR9U9PLvMJPXL5yccudWfzqd7M9tnm2SaOwanHepRYijMSDbWYi4oT
        AT0/d7stAgAA
X-CMS-MailID: 20200420233607epcas2p305dbd652ab73592a32c17773c1fce329
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200420233607epcas2p305dbd652ab73592a32c17773c1fce329
References: <20200420013300.17249-1-hyunki00.koo@samsung.com>
        <CGME20200420233607epcas2p305dbd652ab73592a32c17773c1fce329@epcas2p3.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Change in v8:
- spit into 3 patch
  [1/3] create the new functions with no functional change to the code as-is.
  Replace rd_regb/wr_regb with rd_reg/wr_reg for general usage.
  [2/3] add the new binding reg-io-width in device tree
  [3/3] add the new funtinality of rd_reg / wr_reg and wr_reg_barrier 
        to support 32-bit access for the TX/RX hold registers UTXH and URXH.

Change in v7:
- [1/2] correct build error on running 'make dt_binding_check' 
Documentation/devicetree/bindings/serial/samsung_uart.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 36, column 13
  Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/serial/samsung_uart.example.dts' failed
  make[1]: *** [Documentation/devicetree/bindings/serial/samsung_uart.example.dts] Error 1
  make[1]: *** Waiting for unfinished jobs....
  Makefile:1262: recipe for target 'dt_binding_check' failed
  make: *** [dt_binding_check] Error 2
- [2/2] add commit message of reviewed by and tested by in commit message
  Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
  Tested on Odroid HC1 (Exynos5422):
  Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Change in v6:
- [2/2] clean description of reg-io-width
  allOf is not needed. Just enum [1, 2] is enough.

Changes in v5:
- spit into 2 patch, newly added patch for dt-binding
  [1/2] newly added dt-binding and go as first patch in this series.
  [2/2] go as second patch in this series.

Changes in v4:
- correct variable types and change misleading function name

Changes in v3:
- line 2031: remove redundant init value  for ourport->port.iotype

Changes in v2:
- line 954 : change rd_regl to rd_reg in for backward compatibility.
- line 2031: Add init value for ourport->port.iotype  to UPIO_MEM


Hyunki Koo (3):
  serial: samsung: Replace rd_regb/wr_regb with rd_reg/wr_reg
  dt-bindings: serial: Add reg-io-width compatible
  tty: samsung_tty: 32-bit access for TX/RX hold registers

 .../devicetree/bindings/serial/samsung_uart.yaml   |  8 +++
 drivers/tty/serial/samsung_tty.c                   | 76 ++++++++++++++++++----
 2 files changed, 72 insertions(+), 12 deletions(-)

-- 
2.15.0.rc1


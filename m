Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13570C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 06:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CE3206E6
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 06:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a6mx5bM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEFG7n (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 02:59:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:23053 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgEFG7n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 02:59:43 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200506065939epoutp04e14ff6aa5cc42173e50a449e31f20ace~MXjvmtqyj2206822068epoutp04P
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 06:59:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200506065939epoutp04e14ff6aa5cc42173e50a449e31f20ace~MXjvmtqyj2206822068epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588748379;
        bh=lV2O+8iZ2/46R5+QG5laRwy2by68RqeSALI8AS4Fc/A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=a6mx5bM24fDQD3a/VEqChD9sXCtscW9jdE2NEmhLoMG1/aMmberpPyw0v34tQNJTl
         iVne9tBs1U9cRF4DIWhCzIih/4ZiVIFOIp6pJ69bT0YtyioGsIQvZkYJjyFncM+5Lo
         ZiWQFtyS7v8nJXRrJi05fxNSFxKYcValPC5qO1Q4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200506065939epcas2p338187b35d7e399b1400de1b8d3fff8c9~MXju-kI3Q2161321613epcas2p3A;
        Wed,  6 May 2020 06:59:39 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.188]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49H6sN68BxzMqYm1; Wed,  6 May
        2020 06:59:36 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.39.49908.85062BE5; Wed,  6 May 2020 15:59:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200506065936epcas2p4dec87b4a038006c26d8c66c151694cdb~MXjsT5Ybh1915819158epcas2p4l;
        Wed,  6 May 2020 06:59:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200506065936epsmtrp17aae55cf1ad37c66d5e89f9f2cb72ab7~MXjsTEpZu2782027820epsmtrp1j;
        Wed,  6 May 2020 06:59:36 +0000 (GMT)
X-AuditID: b6c32a45-af9ff7000000c2f4-a7-5eb260581abe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.B8.18461.85062BE5; Wed,  6 May 2020 15:59:36 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200506065936epsmtip14160593c2788d15c268561091017ee03~MXjsI8YjG2294722947epsmtip1m;
        Wed,  6 May 2020 06:59:36 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     krzk@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hyunki Koo <hyunki00.koo@samsung.com>
Subject: [PATCH v9 0/3] 32-bit access for TX/RX hold registers for
 samsung_tty driver
Date:   Wed,  6 May 2020 15:59:31 +0900
Message-Id: <20200506065931.16648-1-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29l2jtbiOK2+RHIcK8lSN2t2tBaBmoMkxKJCqnnSg0q7sbPZ
        hSDNmiapyYx0apo6wmGpc4pJGql0I3Vd1pUgzbSLhHaxGQltO4v897zP+z48z/t9L4YIG/nB
        WK5aT+vUlJLg+3O7B9dLIw9k2A6LzwxGkvVDIzyysKmNT1otLxGysn2GQ46OtqOk7f1zHvm0
        t5ZPVo32c8hHTaUoea5vCN3hL7dZz/Plt+taUXln82l5md0K5G12J1f+3bY6lZ+u3JZDU1m0
        TkSrMzVZuepsGbFrjyJBIY0VSyIlceQWQqSmVLSMSExJjdyZq3QnI0R5lNLgplIphiGit2/T
        aQx6WpSjYfQygtZmKbUSiTaKoVSMQZ0dlalRxUvE4hipezJDmdM/40S0rsDjw3PznHzQjJcA
        Pwzim2HFk7OgBPhjQrwHwL7xd1y2+AZg8dO3fLaYA/Btyx/uP4nT+B5hG30ALpyZ9UlcADZ/
        vgQ8U3x8A5z+VY14cBC+DxZYXvA8Qwg+AqCx4yrH0wjE98OOkkdezMXXwgnXL9SDBbgMVo40
        IKxdGHR8beaxfAB8UD3hjYHgobCwq8YbA+IFGLzWcIvHChLhmNEBWBwIP9+zoywOhp/KjT58
        GvYbK1BWfAHA+ZkPPvEmaJ4scosxt8N62NYb7YGeEEOvfb7LYPHgAsrSAlhsFLLCdfDG3EcO
        i0Ng64den5McVnzq8a4ixA/BadNP3kUQal60jXnRNub/vg0AsYIVtJZRZdNMjFay+FttwHuf
        EUk9oGokZQDgGCCWCsTJHYeFPCqPOaEaABBDiCDBUpebEmRRJ07SOo1CZ1DSzACQuh+7Agle
        nqlxX7tar5BIY2JjxXFSUhobQxIrBZ1LXh0U4tmUnj5K01pa90/HwfyC80F4SVKGo8wpqrPY
        ZnscRfEb/e7n1gtrTPawhsKmqbYE03Xb5cdv9v++c6orQDGeAYju+WrN5O7G4VNjS+SHTLKu
        lU5Z2qqbJmJ8a9BYeuuEA9xdM/dD/SCiHD0X0jKVZyf8BqMNX7TO2qBjpYay8OG9lcL8Z1ei
        LLfSXEcWHiYTXCaHkkQgOob6C8DSmWi1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSnG5EwqY4g1lHhSzmHznHatG8eD2b
        xaqlN5gtpmz4wGRx/vwGdotNj6+xWlzeNYfNYsb5fUwWZxb3slu07j3C7sDlsWlVJ5vH/rlr
        2D02L6n36NuyitFj/ZarLB6fN8kFsEVx2aSk5mSWpRbp2yVwZez7cJW54IdwxdlvP5kaGJcI
        dDFyckgImEhcbXvM3MXIxSEksJtR4sCjS2wQCRmJCS+WMEPYwhL3W46wQhR9Y5R4u/QxK0iC
        TUBb4s33mUBFHBwiAlESez76g9QwC1xhlFj4fgsjSI2wQKjE6xtLWUBsFgFViSc/vrOD2LwC
        thJTzi2AWqAsceHdElaIuKDEyZlPWEBmMguoS6yfJwQSZhaQl2jeOpt5AiP/LCRVsxCqZiGp
        WsDIvIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzjwtTR3MG5f9UHvECMTB+MhRgkO
        ZiURXp4fG+OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ894oXBgnJJCeWJKanZpakFoEk2Xi4JRq
        YEpOvCLx5Gj7UrWIRXpWF1Z0O6x5azpl7tuS6ZEXCx6oB1qovlvqp1rg6yV5ccbW579PV6XM
        WO58i/PkvPTV4tNCjRb7+5xb7a5r9ajtekvZTkHu/u1TfRobkpviGZm2vCz2Us769uD7j6bj
        h30VYvMFbfqtEjUE1qQ4tHDPWeqh7dWZXapQ/Lhj06aTjK2TZ5x7O/HD98NRrnvv5zn/vl01
        Xbhm3ZNq8/y/js8mJOSHLRdLyJoefG3yVwUvb/WlDqxq2nGdSd+uKBW2VyrbZsy77Lp1Qejb
        x1oLH5frGi5JjtNUckkMN3+/Z+LaskjvT9/99N/FfHBwn8miN62lpFX1Q0pptNDrZ8/iN6bG
        KrEUZyQaajEXFScCAFOw1ojrAgAA
X-CMS-MailID: 20200506065936epcas2p4dec87b4a038006c26d8c66c151694cdb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506065936epcas2p4dec87b4a038006c26d8c66c151694cdb
References: <CGME20200506065936epcas2p4dec87b4a038006c26d8c66c151694cdb@epcas2p4.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Change in v9:
- move wr_reg_barrier into ifdef of CONFIG_SERIAL_SAMSUNG_CONSOLE
  to fix following build error for x86 build
  CC [M]  drivers/tty/serial/samsung_tty.o
  drivers/tty/serial/samsung_tty.c:186:13: warning: ‘wr_reg_barrier’
  defined but not used [-Wunused-function]

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


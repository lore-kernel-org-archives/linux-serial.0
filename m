Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5EDC47259
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 08:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129B7206D5
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 08:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I7/e6n0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgEFICQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 04:02:16 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:13016 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgEFICQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 04:02:16 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200506080212epoutp01b1dd565836c5cd1f4825cefc8b0f9f76~MYaWziFRJ2258022580epoutp01N
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 08:02:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200506080212epoutp01b1dd565836c5cd1f4825cefc8b0f9f76~MYaWziFRJ2258022580epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588752132;
        bh=kzOrUDnA47Fa796XI3n9wX8Cjb3+4V30NIZwUCokYas=;
        h=From:To:Cc:Subject:Date:References:From;
        b=I7/e6n0rTd2l9aNg0OphVL6WDJEZpCBLdL+LPlfxEN0scbsOkLq/sgtNL8WO+ADyW
         Gv5sJigEEvwvUkc0CdIfypVHs9LpcLnfyOIfLOnup9VbahbE7xIWwQ3ZRtkdlN38ZV
         ySd1D7/NMOfaC2kSASyoPQZa2y7M4PtjYQmoOYPU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200506080211epcas2p3e2b1e2d59a8b3553af74e5b8dd1a4873~MYaV45Anr2705127051epcas2p3B;
        Wed,  6 May 2020 08:02:11 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.184]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49H8FY3BDSzMqYkp; Wed,  6 May
        2020 08:02:09 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.6E.04393.00F62BE5; Wed,  6 May 2020 17:02:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200506080208epcas2p2b5038265370e21bd38c21002d236b5fe~MYaSrHUal2929829298epcas2p2w;
        Wed,  6 May 2020 08:02:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200506080208epsmtrp2eca4602d7c276b8fb9f2d4f8bf53d9a7~MYaSqMMuc1615416154epsmtrp2u;
        Wed,  6 May 2020 08:02:08 +0000 (GMT)
X-AuditID: b6c32a47-667ff70000001129-e0-5eb26f0033e9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.2F.18461.00F62BE5; Wed,  6 May 2020 17:02:08 +0900 (KST)
Received: from ishtar.dsn.sec.samsung.com (unknown [12.36.155.159]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200506080208epsmtip2ef2f53091999c2426884fb6c7c6786da~MYaSbu6G72751227512epsmtip2H;
        Wed,  6 May 2020 08:02:08 +0000 (GMT)
From:   Hyunki Koo <hyunki00.koo@samsung.com>
To:     krzk@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hyunki Koo <hyunki00.koo@samsung.com>
Subject: [PATCH v10 0/3] 32-bit access for TX/RX hold registers for
 samsung_tty driver
Date:   Wed,  6 May 2020 17:02:01 +0900
Message-Id: <20200506080201.18560-1-hyunki00.koo@samsung.com>
X-Mailer: git-send-email 2.15.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1ddqZoVoda9Ub3JpRjBvQgoXRWKPRSBM1khCNMQqOdFII3dJp
        idUPqygiokJcwOJaMdEGBQolhogLxRiVgAYobomJisEdxQ33tlMjf+fed8475753SUzuwWPJ
        XLOds5lZI41LxY2Bmanxwyy+TNW+YDJzsrVdwhScqcEZ79n7GHOotl/EdHTUEozvWVDCdDYd
        w5mKjisipu3MPoLZ1dxKLJLqfN49uO7q8WpCV1+1Tbe/wYt0NQ3dYt2Ab3I6vs64IIdj9ZxN
        yZmzLfpcs0FLL8/IWpKlSVGp49XzmFRaaWZNnJZeuiI9flmuMZSMVuazRkeolc7yPJ24cIHN
        4rBzyhwLb9fSnFVvtKrV1gSeNfEOsyEh22Kar1apkjQh5kZjzr1gJW5tUWx+9PKyyIUeUcUo
        hgRqLvQdcWPFSErKqUsIXHVvJULxEcFjfxEhFF8QHPixU/xP4nnWG2U1I9jbVi4Wim8Irg2U
        icIsnJoNb74excJYQa2B7Wd7IgqMakdQWHc6QhpDrYU2/wU8jMVUHNz45IkIZJQWXL0lhGA3
        Fe6+q5II/dFw6+jzSAyMmgIF/spIcqC2k3D7/GeRIFgKpU/PRfEYeHWzIXpRLAy8a8YFvA2u
        FJYRgrgEwWB/r0Q4SAb3i92oGJEhh5lQ05QYhuEQrQ+jviOhKPCLENoyKCqUC8LpcPFLX9R1
        IlT3NkVddfD6zi0UxnJqAwx2D4pL0RT3kGncQ6Zx//c9hTAvGsdZeZOB45OsyUO/1Yci+zkr
        7RJqbF/RgigS0SNkqrS6TLmEzeedphYEJEYrZCO+hVoyPevcwtksWTaHkeNbkCb02GVY7Nhs
        S2jbzfYstSYpJUU1T8NoUpIYerzMN/zBejllYO1cHsdZOds/nYiMiXWhUQcTVx5e5VxcM1bf
        peArvx8r6ZKs7umOyx+wldF/ymO0HUFj449k57UPzQYvk7v1Z+fyWs/nVLnVdX/OuE2Nv0+k
        KR39984pLnftGDXN769w581IXU/MpzKrpE9KJzyXXnd6AsGEvklV5QXQV/++03mzLuPu1sDh
        wMqePMfr7OO0mM9h1bMwG8/+BbBO9du1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvC5D/qY4g4l9ghbzj5xjtWhevJ7N
        YtXSG8wWUzZ8YLI4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72S1a9x5hd+Dy2LSqk81j/9w1
        7B6bl9R79G1ZxeixfstVFo/Pm+QC2KK4bFJSczLLUov07RK4Mi5em81WcEik4vbLPUwNjLcF
        uhg5OSQETCQWPX7KCmILCexmlPi+qAQiLiMx4cUSZghbWOJ+yxGgGi6gmm+MEheW/mcBSbAJ
        aEu8+T4TqIiDQ0QgSmLPR3+QGmaBK4wSC99vYQSpERYIk5j55QU7iM0ioCpx9MsisKG8ArYS
        DU972CEWKEtceLeEFSIuKHFy5hMWkJnMAuoS6+cJgYSZBeQlmrfOZp7AyD8LSdUshKpZSKoW
        MDKvYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDnstzR2M21d90DvEyMTBeIhRgoNZ
        SYSX58fGOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8NwoXxgkJpCeWpGanphakFsFkmTg4pRqY
        RA3Elti87y5yfbB+xplJ71ytpbTOBJbksl3a0MurHGH7QSHVnm3yudIJb94kznV9vPGerW77
        tw7ne4xPPufcY+N58Uiy7xV3eaSlscHPAymTt4hqPpUoF53ffI1XZoJM68mW9sdlGRNvZk+T
        vzLnvk591JUQ5+5klsk56Y/rjXqnW5vFnJ6irZ76njHo6+L5njPVfr3dsVUp7Xsn75U9CXtZ
        JwZxKU2ezTznhevhqnTzb0oH+H6qLOOpsVxcfqTyMf/hxVOfidv4SUY/VTa6ucv75NF+zlPb
        TxaFFmhovF/qvnq6VkJh2LEf72yLfL8WfMso8V/YnrrpubDlWRYvCZ9fv/d8Sl9YeOao1ZLf
        SizFGYmGWsxFxYkA0wVJ/uoCAAA=
X-CMS-MailID: 20200506080208epcas2p2b5038265370e21bd38c21002d236b5fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506080208epcas2p2b5038265370e21bd38c21002d236b5fe
References: <CGME20200506080208epcas2p2b5038265370e21bd38c21002d236b5fe@epcas2p2.samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Change in v10:
- add reviewd by and tested by in commit of each patch

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


Return-Path: <SRS0=qPbX=6I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA5C54FCB
	for <linux-serial@archiver.kernel.org>; Fri, 24 Apr 2020 00:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9690420724
	for <linux-serial@archiver.kernel.org>; Fri, 24 Apr 2020 00:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mae4kqhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgDXAka (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:40:30 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22028 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXAk3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Apr 2020 20:40:29 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200424004024epoutp01c9855bf68ebf47226beaca71ee45b48c~ImpMH0Fwv1984719847epoutp01c
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2020 00:40:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200424004024epoutp01c9855bf68ebf47226beaca71ee45b48c~ImpMH0Fwv1984719847epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587688824;
        bh=z1DjASnzmZjhWgA6fqSQi8O3q5c108VWFHZ9HW6vE2A=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=mae4kqhn4zT5Y98Q4pd+cRrV9l2/pj0809V3+Q/6d6m0TVHPXtO9cWnWg5c/j+f7G
         VQwCqC5mZD2NUTx3K4MOUsfB3GzvMdA/Yh3wmLicE72RBfUesYaVECXKrxVnNcDhda
         +r0AodpxNv6/tMUJbQrAF38DHZxFDuKNrrFeU8lo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200424004024epcas2p2e9b9fcdfb2ed558a013c2beee264218d~ImpL2zLZW0205402054epcas2p2S;
        Fri, 24 Apr 2020 00:40:24 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.185]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 497b1L2sLrzMqYkX; Fri, 24 Apr
        2020 00:40:22 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.7C.04647.47532AE5; Fri, 24 Apr 2020 09:40:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200424004019epcas2p46c2178a379ca520d0d0e983e2d1c725a~ImpHJD6Be0867508675epcas2p4V;
        Fri, 24 Apr 2020 00:40:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200424004019epsmtrp10edd200aec1b0f7dae869a3c020e1fee~ImpHIJXKy0209302093epsmtrp1N;
        Fri, 24 Apr 2020 00:40:19 +0000 (GMT)
X-AuditID: b6c32a48-8a5ff70000001227-9b-5ea23574789a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.E5.18461.37532AE5; Fri, 24 Apr 2020 09:40:19 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.165.196]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200424004019epsmtip15b11731486086ba2a45fbd67f0651066~ImpG67r680601606016epsmtip1A;
        Fri, 24 Apr 2020 00:40:19 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20200420233558.11879-1-hyunki00.koo@samsung.com>
Subject: RE: [PATCH v8 0/3] 32-bit access for TX/RX hold registers for
 samsung_tty driver
Date:   Fri, 24 Apr 2020 09:40:18 +0900
Message-ID: <000a01d619d0$ee167730$ca436590$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLkGOxny2DlkaWSmHdwQHeE1CDJ+wFPPr0wAw52+mymSHYncA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++1uu1dr8XPOOqyIdXuQhrqZd03R6EUMkpD6r9R51ZsOt7ux
        O6WCyqjmgx76R69ZqRkVyx6Ihs3MfICEpZBBZe9o+WhJK4wkhTbvIv/7nN/5nt/5Hs6hCGWN
        XE2ZeSfn4FkLLY+U3uuJ1cc7mSs52sBolKGud0BmONp4R24Y8l6UG540niQNxzt6yY0yY7On
        Um7svNREGn82L8skdlvSiji2gHNoOD7fVmDmC9Pp7btMW0yMXquL16UY1tManrVy6fTWjMz4
        bWZLsCWtKWUtJcGnTFYQ6MQNaQ5biZPTFNkEZzrN2Qssdp3OniCwVqGEL0zIt1lTdVptEhNU
        5lqKXlb/JOxHYvb1TPRJytAIrkIRFOBkGBx+Kq1CkZQStyG4eOucRAx+ILj55hkSg18Izvor
        pf9KvGX94UQHAneLixCDMQTXu35LQio5joehxs+zf6nweQT9rbfIKkRREXgDeD5RIU003gNH
        RxqIEEvxKpjxv0MhVuAUmO65JBE5Ch5f+DzbmcBr4VrDV0J0oYEp3zVZiFV4M0w/aJSLGhXU
        VrrCmm8kVNdLRN4KQ13fkMjRMN7XQoqshrHTrjAfhoeuGjLkGfAJBFPffTIxsQ7cX8pRyD+B
        Y+GONzGEgFdA73DY2kKo6JkhxWcFVLiUYuFquP1rNOxgKTT5vOFORvB3tkur0XL3nCHdc4Z0
        zxnG/b9vPZJ60CLOLlgLOSHJnjx32c1o9hzjjG3o0UBGN8IUohcoXjoacpQytlTYb+1GQBG0
        SnH34+UcpaKA3X+Ac9hMjhILJ3QjJriDGkIdk28LHjfvNOmYJL1em8IYGH2SgV6saJ7/KkuJ
        C1knV8xxds7xr05CRajL0Flt4H23r3YvqTVOTU5e5dtTI2tnPJPKeYE/stzUAF/HTFeYN03c
        zvogT2xNH/Gb1UwsKn9+I2ZP7figajgwcuKF9Mi2umjTKfz2VHHxadPBvPyst2kS78yK7YHX
        718ceq5pup/3Z8eZ0Vdlvh20J2pMmSg5thJl+9fYyrOX7KSlQhGriyMcAvsXvbmqPKQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnG6x6aI4g8cXpCzmHznHatG8eD2b
        xeVdc9gszizuZbdo3XuE3YHVY9OqTjaP/XPXsHt83iQXwBzFZZOSmpNZllqkb5fAlTH7zV+m
        goMiFf+e32RsYFwu0MXIySEhYCKxq+E0YxcjF4eQwG5GieOXPzNDJGQkJrxYAmULS9xvOcIK
        UfScUeLe+w52kASbgK7E5cVPmEASIgJzGCW+TO5igqg6yCgx69NHIIeDg1PATmLVIw6QBmGB
        SIkph0+BTWURUJX4++YeI4jNK2Ap8efwXCYIW1Di5MwnLCA2s4C2RO/DVkYYe9nC11AXKUj8
        fLqMFcQWEXCS+LNnMRtEjYjE7M425gmMQrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDA
        MC+1XK84Mbe4NC9dLzk/dxMjOCK0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHeDQ/nxQnxpiRWVqUW
        5ccXleakFh9ilOZgURLnvVG4ME5IID2xJDU7NbUgtQgmy8TBKdXAJBm/c8ov095o3jNqZa6r
        Q+qCtgvOu1vCY6mhsNbRpfXjfrergVfWOp/S0o2LS//frmj5/NDhSkOrW8cP5xpUV3+LOvh5
        dexrgbM1tbd/pIpk+B71uVHnvdGrxGbu/jUTHiYemv+76+snq5Ipq9iWnrv2YfL523Ja4r+/
        W9Wq/44MmjSjtP/21Gd1bf9XTlk6vzdvD6ez0MRDDTdLLk8KyP8fdPFWsHzo/u9ilrJC3O0/
        6l+qqi9ll22ZGW3r9GbOp7aHcrUvKyuOZf6LP7X0f5zbc+n78d4r5RkeMPVq3ztQtCnj0i4x
        f8PmbDsjo86Spy2XQkrND87w/B729KDMlh/Of3iNj85x4P2otyg2SImlOCPRUIu5qDgRALHf
        Yjz3AgAA
X-CMS-MailID: 20200424004019epcas2p46c2178a379ca520d0d0e983e2d1c725a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200420233607epcas2p305dbd652ab73592a32c17773c1fce329
References: <20200420013300.17249-1-hyunki00.koo@samsung.com>
        <CGME20200420233607epcas2p305dbd652ab73592a32c17773c1fce329@epcas2p3.samsung.com>
        <20200420233558.11879-1-hyunki00.koo@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, April 21, 2020 at 08:36:00 AM +0900, Hyunki Koo wrote:
>=20
> Change in v8:
> - spit into 3 patch
>   =5B1/3=5D create the new functions with no functional change to the cod=
e as-
> is.
>   Replace rd_regb/wr_regb with rd_reg/wr_reg for general usage.
>   =5B2/3=5D add the new binding reg-io-width in device tree
>   =5B3/3=5D add the new funtinality of rd_reg / wr_reg and wr_reg_barrier
>         to support 32-bit access for the TX/RX hold registers UTXH and UR=
XH.
>=20
> Change in v7:
> - =5B1/2=5D correct build error on running 'make dt_binding_check'
> Documentation/devicetree/bindings/serial/samsung_uart.yaml:  mapping
> values are not allowed in this context
>   in =22<unicode string>=22, line 36, column 13
>   Documentation/devicetree/bindings/Makefile:12: recipe for target
> 'Documentation/devicetree/bindings/serial/samsung_uart.example.dts'
> failed
>   make=5B1=5D: ***
> =5BDocumentation/devicetree/bindings/serial/samsung_uart.example.dts=5D
> Error 1
>   make=5B1=5D: *** Waiting for unfinished jobs....
>   Makefile:1262: recipe for target 'dt_binding_check' failed
>   make: *** =5Bdt_binding_check=5D Error 2
> - =5B2/2=5D add commit message of reviewed by and tested by in commit
> message
>   Reviewed-by: Krzysztof Kozlowski <krzk=40kernel.org>
>   Tested on Odroid HC1 (Exynos5422):
>   Tested-by: Krzysztof Kozlowski <krzk=40kernel.org>
>=20
> Change in v6:
> - =5B2/2=5D clean description of reg-io-width
>   allOf is not needed. Just enum =5B1, 2=5D is enough.
>=20
> Changes in v5:
> - spit into 2 patch, newly added patch for dt-binding
>   =5B1/2=5D newly added dt-binding and go as first patch in this series.
>   =5B2/2=5D go as second patch in this series.
>=20
> Changes in v4:
> - correct variable types and change misleading function name
>=20
> Changes in v3:
> - line 2031: remove redundant init value  for ourport->port.iotype
>=20
> Changes in v2:
> - line 954 : change rd_regl to rd_reg in for backward compatibility.
> - line 2031: Add init value for ourport->port.iotype  to UPIO_MEM
>=20
>=20
> Hyunki Koo (3):
>   serial: samsung: Replace rd_regb/wr_regb with rd_reg/wr_reg
>   dt-bindings: serial: Add reg-io-width compatible
>   tty: samsung_tty: 32-bit access for TX/RX hold registers
>=20
>  .../devicetree/bindings/serial/samsung_uart.yaml   =7C  8 +++
>  drivers/tty/serial/samsung_tty.c                   =7C 76 ++++++++++++++=
++++---
> -
>  2 files changed, 72 insertions(+), 12 deletions(-)
>=20
> --
> 2.15.0.rc1

Hi Greg KH

Can I ask is this series patch are acceptable or not?
Do you think, I have to do any further action  for this patch?


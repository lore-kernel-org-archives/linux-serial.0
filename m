Return-Path: <SRS0=ZUfo=6K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A168CC54FCB
	for <linux-serial@archiver.kernel.org>; Sun, 26 Apr 2020 23:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C4F2070A
	for <linux-serial@archiver.kernel.org>; Sun, 26 Apr 2020 23:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DcUWKOT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgDZXPK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Apr 2020 19:15:10 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:17691 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgDZXPJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Apr 2020 19:15:09 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200426231505epoutp012b8182b9a0f710ffe950bf572794d334~JgajHo5B-0684706847epoutp01V
        for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2020 23:15:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200426231505epoutp012b8182b9a0f710ffe950bf572794d334~JgajHo5B-0684706847epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587942905;
        bh=cvNmp41/296JfLyww5sqs0RBNkEyWA2TmxYFpGfDdRE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DcUWKOT03GCsWw0fa+yJYbv4yuekhpTeuEtSYO5MfyheJ7xrGKSX5AD+QHWMrM9Nh
         Q16rJJ4wYaBREWgm3M6KJB1hdTTpFQNrv1Wm6fu7770pQk+gM/KhqFoUVVxrrmBz8B
         Pvm3Kd+qbaMWTDn1/s8NNfI/x+WpaPHbGc6CmwfI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200426231505epcas2p4a39e84353b3d847ec8eb0169a0d0ead0~Jgai8XNWs2703627036epcas2p4H;
        Sun, 26 Apr 2020 23:15:05 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 499NzW1ZZfzMqYlr; Sun, 26 Apr
        2020 23:15:03 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.80.04647.7F516AE5; Mon, 27 Apr 2020 08:15:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200426231502epcas2p4b2482716833122c6b7cf314a9e094ad5~JgagnSQY72841328413epcas2p4y;
        Sun, 26 Apr 2020 23:15:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200426231502epsmtrp16d77d3184c36f5e8159390e3e7724613~JgagmL9XQ2945029450epsmtrp1Q;
        Sun, 26 Apr 2020 23:15:02 +0000 (GMT)
X-AuditID: b6c32a48-88dff70000001227-71-5ea615f788e0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.C1.25866.6F516AE5; Mon, 27 Apr 2020 08:15:02 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.155.199]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200426231502epsmtip12e6873a59c6ccb67b81ad35276b3f96f~Jgagdy_Qj2067720677epsmtip1Q;
        Sun, 26 Apr 2020 23:15:02 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <robh+dt@kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200424053711.GB103562@kroah.com>
Subject: RE: [PATCH v8 0/3] 32-bit access for TX/RX hold registers for
 samsung_tty driver
Date:   Mon, 27 Apr 2020 08:15:02 +0900
Message-ID: <000001d61c20$837914d0$8a6b3e70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLkGOxny2DlkaWSmHdwQHeE1CDJ+wFPPr0wAw52+mwDJ5UScQCvjpF1pi5nRLA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm82w7R2vxNbVeRtQ4UaClbubWsdSuhJGEpFCkqCd3Umm3ztks
        Lcqw1pQuCoW1btrSqERzdl1UMoVKLLqAdC9IbSaBJWUWUTueRf573ud9n+99nu/7KEJVo1BT
        JRY7x1tYE62IkF3rjFkYNxrdlKf98ZRiznQ9kjOVnlYF88x3UsH0eA6SzL7bXeRSebr3YpUi
        /e6pZjJ9xDszk9hoSinmWCPHazhLodVYYilKpddk5a/I1xu0ujhdMrOQ1lhYM5dKr8zIjFtV
        YgqupDWlrMkRpDJZQaAT0lJ4q8POaYqtgj2V5mxGk02ns8ULrFlwWIriC63mRTqtNlEfnCww
        FXue30e2RvV2/812VIGORFWjcApwErRcOiyvRhGUCt9AcNUTIKXiKwLvvv0KqRhB8Me5l/wn
        qWiuD0l8CNrOHwkTGyo8iKDxrUbEChwHzzx943wUng+unvsyERN4O4zU/Brnw7EWHt9qQyKO
        xDlQ+bGBELEMz4GmXmdwhqKUOBmqnywWaSWeCg+O94WOmQdNDUOE5EcDY/1NcmnVWghcrldI
        M1FwospJiD4BfyGh6s2HkGAl3KrsRRKOhE/3roSCqWHwsDOEd8MdZy0piQ8gGBvul0uNBeAe
        2I9EcwSOgVZfgggBz4aulyFvU8DV+ZuUaCW4nCpJOBdavgfCJDwDmvt9ZA2i3ROSuSckc09I
        4P6/qx7JLqJpnE0wF3FCoi1p4lt70fhvjE2/gToeZfgRphA9WUldb8xTydlSoczsR0ARdJQy
        1342T6U0smXlHG/N5x0mTvAjffDeawl1dKE1+Lct9nydPtFg0CbrGb0hkaGnK72TXuSqcBFr
        57ZwnI3j/+nCqHB1Beqm+EWrgXIddZS1+vzbNmhfmzYZXhhfBd5scl1/T+5o33p0RcbPWeu3
        UptjPzQHynuzWETqRuuWre8//TA7afHwtCR11QBlGIrGhwoeJOe21XWHpZ2r/bxzaI/+x0hN
        /Gjf4LEDdcsv5ERnrdqx6xufzUR0DDi53HXvJq9eUjZrKS0TilldLMEL7F+hmZv1owMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnO430WVxBof+6VnMP3KO1aJ58Xo2
        i8u75rBZnFncy27RuvcIuwOrx6ZVnWwe++euYff4vEkugDmKyyYlNSezLLVI3y6BK2P93E7G
        gheSFV2LVjE2MF4V7mLk5JAQMJFoWLOAtYuRi0NIYAejxJN389ggEjISE14sYYawhSXutxyB
        KnrOKHHr6xawIjYBXYnLi58wgdgiAjoSHWdOsIDYzAI1Er+OH2SEaJjMJLHkaSPYJE4BA4kL
        uzcygtjCApESUw6fAouzCKhKLLvWBjSIg4NXwFKi66I1SJhXQFDi5MwnUDO1JZ7efApnL1v4
        Guo4BYmfT5exQtzgJ/FiwwI2iBoRidmdbcwTGIVnIRk1C8moWUhGzULSsoCRZRWjZGpBcW56
        brFhgVFearlecWJucWleul5yfu4mRnCcaGntYNyz6oPeIUYmDsZDjBIczEoivDEli+KEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ836dtTBOSCA9sSQ1OzW1ILUIJsvEwSnVwDRBOPG1pjpHW0T7
        wr3G1YuE+yx2CxSInfnyPbqYqdvTILpncoKgU4uyA0Mi9+kETfkoB+2KN7fz+RXaflbsKQnI
        PnKr5/jsdI2dLTtz9qgb1dWn7pRUZy+PPNLQeNnjfXDoClfWlEQmZTnPfr/zc1tD1zXHlk3j
        ilr7WNr4m+abAjuD7x++32C/tHryMzZ5x+3JX05LPRGMfLNhgnxaQXbaVtXt8wQb2naUxj2O
        3Pkpzu3LJ6YTX5OcZv+90D6N40KpAqfmxOKbXuwKC1epT2juMVza2s55n3eR0A+OCQ2nm1Yk
        eUw5dKT57rKems+B1nHsSp8tBE8n5DdqZXE6WJQcyihP9eW2uKKr3qLEUpyRaKjFXFScCAAA
        MqBSAgMAAA==
X-CMS-MailID: 20200426231502epcas2p4b2482716833122c6b7cf314a9e094ad5
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
        <000a01d619d0$ee167730$ca436590$@samsung.com>
        <20200424053711.GB103562@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 24, 2020 at 02:37:18PM +0900, Greg KH wrote:
> On Fri, Apr 24, 2020 at 09:40:18AM +0900, Hyunki Koo wrote:
> > On Sat, April 21, 2020 at 08:36:00 AM +0900, Hyunki Koo wrote:
> > >
> > > Change in v8:
> > > - spit into 3 patch
> > >   =5B1/3=5D create the new functions with no functional change to the
> > > code as- is.
> > >   Replace rd_regb/wr_regb with rd_reg/wr_reg for general usage.
> > >   =5B2/3=5D add the new binding reg-io-width in device tree
> > >   =5B3/3=5D add the new funtinality of rd_reg / wr_reg and wr_reg_bar=
rier
> > >         to support 32-bit access for the TX/RX hold registers UTXH an=
d
> URXH.
> > >
> > > Change in v7:
> > > - =5B1/2=5D correct build error on running 'make dt_binding_check'
> > > Documentation/devicetree/bindings/serial/samsung_uart.yaml:
> mapping
> > > values are not allowed in this context
> > >   in =22<unicode string>=22, line 36, column 13
> > >   Documentation/devicetree/bindings/Makefile:12: recipe for target
> > >
> 'Documentation/devicetree/bindings/serial/samsung_uart.example.dts'
> > > failed
> > >   make=5B1=5D: ***
> > >
> =5BDocumentation/devicetree/bindings/serial/samsung_uart.example.dts=5D
> > > Error 1
> > >   make=5B1=5D: *** Waiting for unfinished jobs....
> > >   Makefile:1262: recipe for target 'dt_binding_check' failed
> > >   make: *** =5Bdt_binding_check=5D Error 2
> > > - =5B2/2=5D add commit message of reviewed by and tested by in commit
> > > message
> > >   Reviewed-by: Krzysztof Kozlowski <krzk=40kernel.org>
> > >   Tested on Odroid HC1 (Exynos5422):
> > >   Tested-by: Krzysztof Kozlowski <krzk=40kernel.org>
> > >
> > > Change in v6:
> > > - =5B2/2=5D clean description of reg-io-width
> > >   allOf is not needed. Just enum =5B1, 2=5D is enough.
> > >
> > > Changes in v5:
> > > - spit into 2 patch, newly added patch for dt-binding
> > >   =5B1/2=5D newly added dt-binding and go as first patch in this seri=
es.
> > >   =5B2/2=5D go as second patch in this series.
> > >
> > > Changes in v4:
> > > - correct variable types and change misleading function name
> > >
> > > Changes in v3:
> > > - line 2031: remove redundant init value  for ourport->port.iotype
> > >
> > > Changes in v2:
> > > - line 954 : change rd_regl to rd_reg in for backward compatibility.
> > > - line 2031: Add init value for ourport->port.iotype  to UPIO_MEM
> > >
> > >
> > > Hyunki Koo (3):
> > >   serial: samsung: Replace rd_regb/wr_regb with rd_reg/wr_reg
> > >   dt-bindings: serial: Add reg-io-width compatible
> > >   tty: samsung_tty: 32-bit access for TX/RX hold registers
> > >
> > >  .../devicetree/bindings/serial/samsung_uart.yaml   =7C  8 +++
> > >  drivers/tty/serial/samsung_tty.c                   =7C 76
> ++++++++++++++++++---
> > > -
> > >  2 files changed, 72 insertions(+), 12 deletions(-)
> > >
> > > --
> > > 2.15.0.rc1
> >
> > Hi Greg KH
> >
> > Can I ask is this series patch are acceptable or not?
> > Do you think, I have to do any further action  for this patch?
> >
>=20
> It's been 3 days, give us a chance please...
>=20
> Also, I need to wait for the dt patch to be reviewed first before I can t=
ake
> any of this, so that's up to the DT maintainers.
>=20
> thanks,
>=20
> greg k-h

Sorry to disturb you and Thank you for your answer,
I will wait.


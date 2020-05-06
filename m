Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11B0C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 08:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D75420661
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 08:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jBCzyR16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgEFIIC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 04:08:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:13694 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgEFIIB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 04:08:01 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200506080758epoutp02782b12b5925a1deb2c068ff1b1700120~MYfYd34Dr2119321193epoutp025
        for <linux-serial@vger.kernel.org>; Wed,  6 May 2020 08:07:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200506080758epoutp02782b12b5925a1deb2c068ff1b1700120~MYfYd34Dr2119321193epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588752478;
        bh=dJ+lGakL3NnhgWqJ7Zs4VGKOinDZ9u2r6c1y7AICafc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jBCzyR16DkZ3LzfFBHPiynTstJEiOTrIiapb4tYb4vINNquAkDoHntyOl+a6PLK76
         yYcHhGf8hy8LK6d/BOf2w2Cf2maM/PQt5WcXueh0/roB0o5F+m0ISLo6O3R+ugWp9A
         g9nt5pQ77zyjXwyl9u4NsEAv/yAS5MLPe8b9w/jI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200506080757epcas2p16878918b5b943ebb355d2bcb0fa34e7f~MYfYKR0uz3190931909epcas2p1G;
        Wed,  6 May 2020 08:07:57 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.189]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49H8ND2gX1zMqYkv; Wed,  6 May
        2020 08:07:56 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.41.04393.85072BE5; Wed,  6 May 2020 17:07:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200506080752epcas2p1e80cecb729dd7ccd6ef39d6b2d8bbdb9~MYfTTj0V43171431714epcas2p18;
        Wed,  6 May 2020 08:07:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200506080752epsmtrp22b80f01a987392a194db8e387e3402d1~MYfTSc8lI1944219442epsmtrp2j;
        Wed,  6 May 2020 08:07:52 +0000 (GMT)
X-AuditID: b6c32a47-67fff70000001129-a3-5eb27058e826
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.3D.25866.85072BE5; Wed,  6 May 2020 17:07:52 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.155.199]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200506080752epsmtip23c12373581a928cc417cad11630e97fd~MYfTFU-uw2843328433epsmtip2F;
        Wed,  6 May 2020 08:07:52 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20200506073253.GB2336830@kroah.com>
Subject: RE: [PATCH v9 2/3] dt-bindings: serial: Add reg-io-width compatible
Date:   Wed, 6 May 2020 17:07:52 +0900
Message-ID: <007001d6237d$70aeb3f0$520c1bd0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLUZ2If+0iSeSXbGQNX+L7hdLFc3gKqIFw+AnRTUeUArj7eRKZvxX5Q
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++1u914fi59z1UFK1k2CLN2mbV5DpUjSyGgU/pFFetHLlPZi
        d1YalOWjaQkaITSzB4ZQmbYlMlYavoqshPKPWASVZOuB9pAki0Wb18r/Puf8zvd8z/n9fjSh
        aCbj6DKLg7dbOBNDRkp7h9bpk/baPAc0Dbck7KXhMRlb3d5NsuO+CyT7uL2RYmv7hqnNslzP
        9Xoy915bJ5U744k3EAWmjFKeK+HtKt5SbC0psxgzmR17CrcW6vQabZI2nU1jVBbOzGcy2XmG
        pG1lppAlozrEmcpDKQMnCIw6K8NuLXfwqlKr4MhkeFuJyabV2pIFziyUW4zJxVbzJq1Gk6IL
        VRaZSvvv9xM2P3nk5W11Fbota0ARNOCNcH7iNWpAkbQCexGMtDqlYvANwY2xKUoMZhB0PQ38
        k4xOfVuQ+BAEPzWg8IECf0AwU7M7zCROgvH2t5IwK3EatL15MN+JwE4EN3tG5jtFYC38bjw3
        XxSL82D8RgsRZilOgN4hHxlmOU6H+lm/ROQYeHj+rTTMBF4PHVc+EeJEKpib7JCJZtsg8OwV
        EmuU0FpfR4SNAX+n4Gu7E4mCbGh9OE2KHAsfH/RQIsfBzHTfQv449Nc1U6L4DIK5L5ML+6eC
        692pUCM65LAOun3qMAJeA8MvFmZbCs6hICWm5eCsU4jCtdA1+14i8kronPRRTYhxLdrMtWgz
        16INXP+9LiPpdbSctwlmIy+k2FIXP7YHzX/HxBwv6h3LG0SYRky0XJPjPqCQcYeECvMgAppg
        lPLoH6GUvISrqOTt1kJ7uYkXBpEudPHNRNyyYmvoc1schVpdil6vSdexOn0Ky6yQe6L8+xXY
        yDn4gzxv4+1/dRI6Iq4K5atZ05bgaNRUdYcnOHGiTo3uwUmF9+yAZQO217QSXje6+vhOR8HY
        z9WGd6Nup3MwqnJnMHn70104RulbUl+06sk1j6HGL3800XJU33Is1fiKeb7610RB2WHlEtfh
        R7UJWQNkD1FsuHg3uK878Pq0X5NaoHQnB+im+Ln8zx8ZqVDKaRMJu8D9AT3KHi6kAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvG5EwaY4g8Ndqhbzj5xjtWhevJ7N
        4vKuOWwWZxb3slu07j3C7sDqsWlVJ5vH/rlr2D0+b5ILYI7isklJzcksSy3St0vgynj+cAVr
        wRW2ivVT5jM2MK5h7WLk5JAQMJE49fYTYxcjF4eQwA5GiTfr+pghEjISE14sgbKFJe63HGGF
        KHrOKPF87yEmkASbgK7E5cVPwGwRAXOJuQ+Ps4PYzAI9jBKfXyeC2EICzxglbj6oA7E5BQwl
        /vVOAasXFvCRuLx6GtgCFgEViW2Hd7GB2LwClhKd324yQdiCEidnPmGBmKkt0fuwlRHGXrbw
        NdRxChI/ny5jhbjBTeL5pftQNSISszvbmCcwCs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTc
        YsMCo7zUcr3ixNzi0rx0veT83E2M4DjR0trBuGfVB71DjEwcjIcYJTiYlUR4eX5sjBPiTUms
        rEotyo8vKs1JLT7EKM3BoiTO+3XWwjghgfTEktTs1NSC1CKYLBMHp1QDE+v65+LzcxP1/90s
        zBKTWLnl77OgvUe2i/zOPXN+8rk959LXLr+w8xP/jqqNV7n9fJ7KrJj+X6tqe/T3588n7JG4
        UBg0X7zPbVqMReA+iZlhDxteZex8y+Hk9t2ddWflUbYU657pRS3tvuknU1X+lr85eNv2lsm+
        tElXN69cuMBuaf5vf+NL0rdWGt2sk1ugJtCs2PSf4dpr+WM/r6qslWld7OSzaL1pcoPGK7Xd
        Yj87TAoeHf/Ft8hE+k13WXE4m7L0LM/fz30Nn3T1Cq5xytzPc6DtcWE7Twqvc7XN7I83ZGXf
        vf+mka7iYR98fffVI/lTFpz4xXbJ7/KRjgaTPXp3L6576dluF3Giq4anxlOJpTgj0VCLuag4
        EQCH7h+FAgMAAA==
X-CMS-MailID: 20200506080752epcas2p1e80cecb729dd7ccd6ef39d6b2d8bbdb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200506070024epcas2p2868e11349d2fee83d340df7fa181f704
References: <20200506070009.16809-1-hyunki00.koo@samsung.com>
        <CGME20200506070024epcas2p2868e11349d2fee83d340df7fa181f704@epcas2p2.samsung.com>
        <20200506070009.16809-2-hyunki00.koo@samsung.com>
        <20200506073253.GB2336830@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tuesday, May 5, 2020 at 2020 4:33:00 PM +0900, Greg Kroah-Hartman
> On Wed, May 06, 2020 at 04:00:06PM +0900, Hyunki Koo wrote:
> > Add a description for reg-io-width options for the samsung serial UART
> > peripheral.
> >
> > Signed-off-by: Hyunki Koo <hyunki00.koo=40samsung.com>
> > ---
> >  Documentation/devicetree/bindings/serial/samsung_uart.yaml =7C 8
> > ++++++++
> >  1 file changed, 8 insertions(+)
>=20
> You dropped the reviewed-by tag that Rob gave on the previous version
> of this patch.
>=20
> Please put that back and resend.
>=20
> thanks,
>=20
> greg k-h

Thank you for your comment
I add review tag by Krzysztof Kozlowski  in all other patches not only patc=
h2/3

Reviewed-by: Krzysztof Kozlowski <krzk=40kernel.org>
Tested on Odroid HC1 (Exynos5422):
Tested-by: Krzysztof Kozlowski <krzk=40kernel.org>


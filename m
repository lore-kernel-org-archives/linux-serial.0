Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06508C43334
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jun 2022 00:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiF2AaO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 20:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiF2AaM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 20:30:12 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7A2B190
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 17:30:07 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220629003002epoutp04c50f81b02da6eac6bad5ad0dcbd555d9~87-X5sBuQ2217722177epoutp040
        for <linux-serial@vger.kernel.org>; Wed, 29 Jun 2022 00:30:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220629003002epoutp04c50f81b02da6eac6bad5ad0dcbd555d9~87-X5sBuQ2217722177epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656462602;
        bh=RCT9O8q2k+aVrdvpyyII4wNB8PekhyTijb9GQ6sFNeg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=bXckLCDGF2cbC7al17jtlciUpdiDsaZ6NzGRe23c6NdIQJYy255VQgS8P3qTQqMCa
         K35ZYdQbKZz7qjEyTrsJwSr3U/pk00Hm+uqmI8LomU+3lbAWnzEL5EmAFzNar0h9TA
         h4dvvzYWROp0z7uEkuE8Ljcf5+KbgZGuojibImHQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220629003001epcas2p1fac056d425b366f2369b28a45957bf5b~87-W_ncnV0474004740epcas2p1f;
        Wed, 29 Jun 2022 00:30:01 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LXj610k2Sz4x9Q0; Wed, 29 Jun
        2022 00:30:01 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.64.09642.80D9BB26; Wed, 29 Jun 2022 09:30:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220629003000epcas2p1285b1a7d7fe74efdae6bae9c8886007b~87-Vx4Xwm0473304733epcas2p1Z;
        Wed, 29 Jun 2022 00:30:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220629003000epsmtrp129d2ef67a582b7a9517e5d463a65b09d~87-Vw0PVT0743907439epsmtrp1R;
        Wed, 29 Jun 2022 00:30:00 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-95-62bb9d08b8a3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.4C.08905.80D9BB26; Wed, 29 Jun 2022 09:30:00 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220629003000epsmtip283526fcc161ba0ec44364975c7e9d7f6~87-Vlkvcw0746407464epsmtip2g;
        Wed, 29 Jun 2022 00:30:00 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     =?iso-8859-1?Q?'Ilpo_J=E4rvinen'?= <ilpo.jarvinen@linux.intel.com>
Cc:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Jiri Slaby'" <jirislaby@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Hector Martin'" <marcan@marcan.st>,
        "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'Vincent Whitchurch'" <vincent.whitchurch@axis.com>,
        <linux-samsung-soc@vger.kernel.org>,
        "'linux-serial'" <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <fb89ea18-f381-a514-e4a7-942c3fa27985@linux.intel.com>
Subject: RE: [PATCH v2] tty: serial: samsung_tty: loopback mode support
Date:   Wed, 29 Jun 2022 09:29:59 +0900
Message-ID: <012401d88b4f$5ddd2180$19976480$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQLQReUt4gszEHpOmY4yS3t4neww3AL4ITK4Ah5+OAmrTV0CUA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmuS7H3N1JBvt7rC0ezNvGZtG8eD2b
        ReeOHhaLHQ1HWC3ezZWx2Pt6K7vFpsfXWC1mnN/HZHFmcS+7xelrC9gtzm/zd+D2uL4uwGPT
        qk42jzvX9rB5zDsZ6LF/7hp2j81L6j0WL9vJ5tG3ZRWjx+dNcgGcUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCXKimUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM/Zs+MVccIar4sGla0wN
        jMc4uxg5OSQETCTaP21h62Lk4hAS2MEo8fLlMlYI5xOjxOSrt6Ey3xgldq76wgTT8mHlF6jE
        XkaJmxues0M4Lxglbj27zg5SxSagL/GyYxsriC0i4CbRt+MZC0gRs8AVZomTm06zgSQ4BZwl
        vix/zQhiCwu4S9w48gesgUVAVWL3g0csIDavgKVEw8IGJghbUOLkzCdgcWYBPYkbU6ewQdja
        EssWvmaGOE9B4ufTZawQcRGJ2Z1tzBBHOElM+70a7GwJgSMcEisvTGWDaHCROHFzGyOELSzx
        6vgWdghbSuJlfxuUXSyxdNYnJojmBkaJy9t+QTUbS8x61g7UzAFkK0scuQV1HJ9Ex+G/7BBh
        XomONiGIanWJA9uns0DYshLdcz6zTmBUmoXktVlIXpuF5LVZSN5ZwMiyilEstaA4Nz212KjA
        GB7hyfm5mxjBCVnLfQfjjLcf9A4xMnEwHmKU4GBWEuFdeGZnkhBvSmJlVWpRfnxRaU5q8SFG
        U2BoT2SWEk3OB+aEvJJ4QxNLAxMzM0NzI1MDcyVxXq+UDYlCAumJJanZqakFqUUwfUwcnFIN
        TKtutqtJ1qovYVrQ9uJoomDMG8fkJff/R8w+ULHk/ewZuyyDrM28X2vfnlk779yEkvXJ87jY
        mBPaJrbm+a5sdfeV+OQtzfYi92urQOgMc/9vTLuqcpaVTfT6b1oYfE19tcGG6wqWnN1b5rBY
        PlT5cbKufffMwIRon/n6+YtvOmx46Bt2Ttanimk5u3YR97XjK6YseSBce4vrl3qpoOXP3TXz
        WB5ZSeTw/pXbpZwXNafab9s6poeTPbaJSKrPC/Xf4WdySDxX6fOj5anOYsd4n9S/umJW/G/u
        lsQCmW9OIvcq97WezvpzL/rNp322T+e/eVXy9+6aW/Fxh6WS1/qY3XpYvbqE6Wdr2qvLR5Yc
        6lBiKc5INNRiLipOBAA0SyxWUQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvC7H3N1JBr8miVo8mLeNzaJ58Xo2
        i84dPSwWOxqOsFq8mytjsff1VnaLTY+vsVrMOL+PyeLM4l52i9PXFrBbnN/m78DtcX1dgMem
        VZ1sHneu7WHzmHcy0GP/3DXsHpuX1HssXraTzaNvyypGj8+b5AI4o7hsUlJzMstSi/TtErgy
        Ti6+zFxwiqNixu1PzA2M99m6GDk5JARMJD6s/AJkc3EICexmlNi0YB5UQlbi2bsd7BC2sMT9
        liOsEEXPGCXuHv3BCJJgE9CXeNmxjRXEFhFwk+jb8YwFpIhZ4BazRMf+DVAdJxglljbfBOvg
        FHCW+LL8NZgtLOAucePIH7BuFgFVid0PHrGA2LwClhINCxuYIGxBiZMzn4DFmQUMJO4f6mCF
        sLUlli18zQxxnoLEz6fLoOIiErM725ghLnKSmPZ7NdsERuFZSEbNQjJqFpJRs5C0L2BkWcUo
        mVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyZWpo7GLev+qB3iJGJg/EQowQHs5II78Iz
        O5OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYDqi8Fv9
        XMFL/vzDEfVTmp6tLMkMnNfjeOVO/CWlA8ssKsutT/74PJfHwLYxbscBwd++InVB/C18ps8+
        7ml/dPtXR37f29U7TVrbd6s7b2qTN2N2/KZ64OPiSRGcM81ydC2e7tri2caQf8XOt2DrzPea
        VgJ7DgqnKz0I4GNcFxIs8u9a0MowRl6z46d1+udpvrOJ6Nwn0vewMF3W/5TSEbkDavdke9bs
        OLzq4J8+Xder+o8XnZBtuB4e/1ultH1iWv9b17wtP/yjQ606pJa9f+nwW5I//fRSjaiP0tu1
        CnQPv62pzqt6wCZw5IlT63PzS9tOH2FRfzPtQ1rG3ma27B9bFsVb1DafXbJa3eOAtBJLcUai
        oRZzUXEiADvx1oM7AwAA
X-CMS-MailID: 20220629003000epcas2p1285b1a7d7fe74efdae6bae9c8886007b
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220628124300epcas2p45f1e3a7051bb93ecba778cf7d96720d3
References: <CGME20220628124300epcas2p45f1e3a7051bb93ecba778cf7d96720d3@epcas2p4.samsung.com>
        <20220628124050.144398-1-chanho61.park@samsung.com>
        <fb89ea18-f381-a514-e4a7-942c3fa27985@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > Internal loopback mode can be supported by setting UCON register's
> > Loopback Mode bit. The mode & bit can be supported since
> > s3c2410 and later SoCs. The prefix of LOOPBACK / BIT(5) naming should
> > be also changed to S3C2410_ to avoid confusion.
> >
> > We can test it by linux-serial-test program with -k option. The tool
> > will set TIOCM_LOOP mode when the option is specified.
> > -k, --loopback     Use internal hardware loop back
> >
> > Signed-off-by: Chanho Park <chanho61.park=40samsung.com>
>=20
> Reviewed-by: Ilpo J=E4rvinen=20<ilpo.jarvinen=40linux.intel.com>=0D=0A=0D=
=0AThanks=20for=20your=20review.=0D=0A=0D=0A>=20=0D=0A>=20You=20should=20ha=
ve=20included=20Krzysztof's=20Reviewed-by=20when=20you=20sent=20this=20next=
=0D=0A>=20version=20so=20that=20it=20won't=20get=20lost.=0D=0A=0D=0AI=20tho=
ught=20the=20codes=20have=20been=20changed=20since=20v1=20so=20I'm=20not=20=
convinced=20I=20can=0D=0Aput=20his=20R-B=20tag.=0D=0A=0D=0A>=20=0D=0A>=20I=
=20suspect=20Greg=20will=20again=20complain=20that=20you=20didn't=20address=
=20his=20comment=0D=0A>=20about=20the=20out=20of=20the=20place=20=22-k,=20-=
-loopback=20...=22=20line.=0D=0A=0D=0AThe=20commit=20messages=20seems=20to=
=20be=20not=20necessary.=20I'll=20remove=20them=20next=20patch.=0D=0A=0D=0A=
Best=20Regards,=0D=0AChanho=20Park=0D=0A=0D=0A

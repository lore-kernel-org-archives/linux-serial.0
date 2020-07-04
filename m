Return-Path: <SRS0=vj7b=AP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36BDC433E0
	for <linux-serial@archiver.kernel.org>; Sat,  4 Jul 2020 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1C920936
	for <linux-serial@archiver.kernel.org>; Sat,  4 Jul 2020 14:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TQHRysxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGDO0I (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 4 Jul 2020 10:26:08 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:10084 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGDO0H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 4 Jul 2020 10:26:07 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200704142604epoutp0290a429a0a626639c5c947fa3f83df658~ektWd-duq2909229092epoutp02T
        for <linux-serial@vger.kernel.org>; Sat,  4 Jul 2020 14:26:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200704142604epoutp0290a429a0a626639c5c947fa3f83df658~ektWd-duq2909229092epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593872764;
        bh=g024nBw65V+jQc3zGElxh1aWZIKVCwXeNs9GXBythh8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=TQHRysxrrLkmYclubFWWuF9MDqshVJs7Zl9RqgoD6gI0DzTdWTE7pXzgjPyf9wcy0
         61TU3s1+dA3bNCkV9yNlOQ0agfI6KHcV5Z8PlP5q4EEwJ8b5wvxy2DvS9jRxcO1+fT
         x+x/HxcWPouOsrH+5PPbBoR2CHICeh84FBiHD7Cg=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200704142603epcas5p3e2253714492a263e0eca697ba532a971~ektWBYy0j1568615686epcas5p3j;
        Sat,  4 Jul 2020 14:26:03 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.FE.09475.B71900F5; Sat,  4 Jul 2020 23:26:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200704142603epcas5p47d591e62a4c6914476ca3254b7a78ab0~ektVs0eik1125311253epcas5p4O;
        Sat,  4 Jul 2020 14:26:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200704142603epsmtrp157b36d3c0353dc8e630b060ba3258081~ektVsDjjO2555925559epsmtrp1i;
        Sat,  4 Jul 2020 14:26:03 +0000 (GMT)
X-AuditID: b6c32a4b-389ff70000002503-6a-5f00917b83f8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.9C.08382.B71900F5; Sat,  4 Jul 2020 23:26:03 +0900 (KST)
Received: from mshams01 (unknown [107.122.43.244]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200704142601epsmtip2fdcb4038a783818f4b4433ac58a42553~ektTk6G7-2161321613epsmtip2F;
        Sat,  4 Jul 2020 14:26:01 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     <kgene@kernel.org>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>
In-Reply-To: <20200629083553.GA14028@kozik-lap>
Subject: RE: [PATCH v2] serial: samsung: Re-factors UART IRQ resource for
 various Samsung SoC
Date:   Sat, 4 Jul 2020 19:55:47 +0530
Message-ID: <046901d6520f$0bd565d0$23803170$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI6aq/f5OGM4WvcDSK12mGjbdwEpQGtqyKCAmf4LUOoDpsC4A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmum71RIZ4g49/dS0ezNvGZtG8eD2b
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72R04PTat6mTz2D93DbvH5iX1
        Hn1bVjF6rN9ylcXj8ya5ALYoLpuU1JzMstQifbsEroz7y3pYC6YJVnRO+8bcwNjA18XIySEh
        YCLx7eBBpi5GLg4hgd2MEsuWzmODcD4xSlya+hXK+cYosXvbfuYuRg6wljPnzSHiexklljZP
        ZoRwnjNKTL+/hg1kLpuArsSkg23MILYIkL35xnJ2kCJmga+MEqe2fgAr4hTQl/h4YxMTiC0s
        EC/x7upNRpANLAIqEg8askDCvAKWEr+vHmCBsAUlTs58AmYzC2hLLFv4mhniBwWJn0+XsULs
        cpK4sfQOVI24xMujR8D2Sgis5JDY8XkqG0SDi8S0bU2MELawxKvjW9ghbCmJl/1tUHa+xPx5
        q6AWVEisvPAGyraXOHBlDgvIncwCmhLrd+lD7OKT6P39hAkSQLwSHW1CENWKEv9390NNFJd4
        t2IKK4TtIbH5yCymCYyKs5B8NgvJZ7OQfDALYdkCRpZVjJKpBcW56anFpgXGeanlesWJucWl
        eel6yfm5mxjBKUrLewfjowcf9A4xMnEwHmKU4GBWEuFNUP0XJ8SbklhZlVqUH19UmpNafIhR
        moNFSZxX6ceZOCGB9MSS1OzU1ILUIpgsEwenVANTaNmJZWaGNm+e1Df/yLrV5GHYo/Tsvav4
        hqMyYVsMzjeILHj958qzAMtZk9fuCrE64Tfr9/S22RLxtY+qbi89xu7eX2DHHzcpQH5ldH1S
        tOzf4Hmbv4Sz+sp7T+vnYtePD/qQeOzM9phW060X+uev/LfZI6F853km3wmxuo5P5TTnZkaf
        4jX44H4wtHGG79x74eqx7ZOeRXZn2+z8bDTlVWZQyZ/jjsV/jR/NFNWM3rDWZLL+tgmF9S8O
        cAc7bnS24bfxXb3Y4JdORzr3Bedq6U0it1m+p9kKPGV1ienXnH03/ZIjU7tf/zY7jc7OSVwJ
        hSHsPWe3XtTlUmQ9Wrl3XtmnzQHbt/xN3GU43VOJpTgj0VCLuag4EQDRn9Q/wAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvG71RIZ4g6/HxS0ezNvGZtG8eD2b
        xZQNH5gs+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLM4t72R04PTat6mTz2D93DbvH5iX1
        Hn1bVjF6rN9ylcXj8ya5ALYoLpuU1JzMstQifbsEroxzEx+wFnQKVlzuWcvSwPiWt4uRg0NC
        wETizHnzLkYuDiGB3YwSL39eZeti5ASKi0tM+7WfEcIWllj57zk7iC0k8JRRYuNDJhCbTUBX
        YtLBNmYQWwTI3nxjOTvIIGaBv4wSb1ouskFMXcsoMXH7KrBuTgF9iY83NoF1CwvESrx4sZ4d
        5AoWARWJBw1ZIGFeAUuJ31cPsEDYghInZz4Bs5kFtCWe3nwKZy9b+JoZ4jgFiZ9Pl7FCHOEk
        cWPpHagacYmXR4+wT2AUnoVk1Cwko2YhGTULScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWl
        eel6yfm5mxjBkaaluYNx+6oPeocYmTgYDzFKcDArifAmqP6LE+JNSaysSi3Kjy8qzUktPsQo
        zcGiJM57o3BhnJBAemJJanZqakFqEUyWiYNTqoFpx4a951xn7AhUN3Sq/GepMOP6li0HPu4o
        8T6Z1Wi2xdrS0f7lxpsaYcbKRxoCnq/fWypZXPXcu7Lmm9EOXlcPrX1bPpjdaIzYuVfdcK/u
        KZ4PF4801E1fo/Sw5vMxh089Kw/opv7b+td7+/O+x3F3/JxDjNKubPNeExubZc/U/kO39cbW
        9zU/1mhxXFqZolx1vYDbQV6niTHv/mHxZvN5PB/bzbkCu54kTz/I/Zk1mkXZVtCS8887ZyXD
        pYwss1y55769tz/y3t6khumzvRx1hEp/bS/PZrAWtKz21J0nfXWnaMXqG4rd594wbjTS6q0U
        OXfsxuOgSauO9fZuSlx8RbbyuPhrl39b/pezm4srsRRnJBpqMRcVJwIAXaTl8CMDAAA=
X-CMS-MailID: 20200704142603epcas5p47d591e62a4c6914476ca3254b7a78ab0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200628071932epcas5p175059c085421a95de76202767bd132cf
References: <CGME20200628071932epcas5p175059c085421a95de76202767bd132cf@epcas5p1.samsung.com>
        <20200628070007.36222-1-m.shams@samsung.com>
        <20200629083553.GA14028@kozik-lap>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> On Sun, Jun 28, 2020 at 12:30:07PM +0530, Tamseel Shams wrote:
> > In few older Samsung SoCs like s3c2410, s3c2412 and s3c2440, UART IP
> > is having 2 interrupt lines.
> > However, in other SoCs like s3c6400, s5pv210, exynos5433, and
> > exynos4210 UART is having only 1 interrupt line. Due to this,
> > =22platform_get_irq(platdev, 1)=22
> > call in the driver gives the following warning:
> > =22IRQ index 1 not found=22 on recent platforms.
> >
> > This patch re-factors the IRQ resources handling for each platform and
> > hence fixing the above warnings seen on some platforms.
> >
> > Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> > ---
> > Removed the RFC tag and using 'platform_get_irq_optional'
> > instead of 'platform_get_irq' as per comment received from Robin
> > Murphy.
> >
> >  drivers/tty/serial/samsung_tty.c =7C 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 6ef614d8648c..60554f42e208 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > =40=40 -60,6 +60,7 =40=40 struct s3c24xx_uart_info =7B
> >  	char			*name;
> >  	unsigned int		type;
> >  	unsigned int		fifosize;
> > +	unsigned int		irq_cnt;
>=20
> No, it's duplicating the logic.
>=20
> The driver already checks whether SoC has two or one interrupt line with
> s3c24xx_serial_has_interrupt_mask() so there is no point to have two of s=
uch
> methods.
>=20
> Instead unify it please. Probably entire
> s3c24xx_serial_has_interrupt_mask() and s3c24xx_serial_type() should be
> removed and switched into *serial_drv_data.
>=20
> Best regards,
> Krzysztof

Hi Krzysztof,
Thanks for letting me know about duplication of logic.
I will remove my logic of checking of number of interrupt line
and replace it with check using s3c24xx_serial_has_interrupt_mask().

I will come up with another patch regarding the suggestion of removal=20
of the two functions s3c24xx_serial_has_interrupt_mask() and=20
s3c24xx_serial_type() and moving it to *serial_drv_data.

Thanks & Regards,
Tamseel


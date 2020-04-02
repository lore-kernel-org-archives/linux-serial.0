Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC82C2BA13
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBCD2077D
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 09:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vgw5r2xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgDBJpJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:45:09 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23486 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387736AbgDBJpI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 05:45:08 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200402094505epoutp02f6e93309a01d7e38a4ce66541720a0ee~B94eBEWoJ0077800778epoutp02L
        for <linux-serial@vger.kernel.org>; Thu,  2 Apr 2020 09:45:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200402094505epoutp02f6e93309a01d7e38a4ce66541720a0ee~B94eBEWoJ0077800778epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585820705;
        bh=EpaEeqrIy/TvLIw7RPtSVT3L0MGSm+6vhhdnmt64iGI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Vgw5r2xClabWG3t7GseUEH5CwXIS98x0H78RK/vd7ebN0f6HBUy0ytTquEtXZrvIp
         ufJdUC3XS8iF8fB3sPLAUyZYEQrHmgQL6GYe4heDKsmeiiyvfhrgToSjPx6g5kUs6a
         FxcJ03Fcx1Kwu1Gi5l4hg+OChY0FiZmHAw1KuE68=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200402094504epcas2p3123844323638847f1378465a38096e14~B94dkPpKa1153911539epcas2p3y;
        Thu,  2 Apr 2020 09:45:04 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48tJ7y0KD6zMqYkg; Thu,  2 Apr
        2020 09:45:02 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.D4.04105.C14B58E5; Thu,  2 Apr 2020 18:45:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200402094459epcas2p1af4cf104eb6d7ea0d602a562fd9c8c8f~B94Ynuvsi2495524955epcas2p19;
        Thu,  2 Apr 2020 09:44:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200402094459epsmtrp2290072ed74ede8f4dee0985e7745efe9~B94Ym6D7i1921419214epsmtrp2X;
        Thu,  2 Apr 2020 09:44:59 +0000 (GMT)
X-AuditID: b6c32a47-15bff70000001009-46-5e85b41c927e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.C4.04158.B14B58E5; Thu,  2 Apr 2020 18:44:59 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.165.196]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200402094459epsmtip2514fcb526d9aedcb40e5f5ebdf565563~B94YdOf5n3121331213epsmtip2G;
        Thu,  2 Apr 2020 09:44:59 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     <hyunki00.koo@gmail.com>, "'Kukjin      Kim'" <kgene@kernel.org>,
        "'Jiri Slaby'" <jslaby@suse.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401091952.GA14425@kozik-lap>
Subject: RE: [PATCH] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Thu, 2 Apr 2020 18:44:58 +0900
Message-ID: <000001d608d3$5faa8260$1eff8720$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIlrsPG99gFy1AqjplcrZ0ldcCfeQKEs4Y1AmydwKICM8VWpaeNHlJA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUgTcRjH++1ud5u2uKbV04gYVwga6raanaFhJLko0pCCIlyHu9TaW7tp
        L3+k9LJ0aiZW1HpRMUrEss5lZqXhJAtKKTGy6F3DEmpmWRZF287I/z7P83y/PC+/nwxTNhMq
        WZ7VyTmsrJkmwvAWX/TS2HneQ1ma099o5kBdE8H07/9MMMeu+CVMxbsRjOntvUIywrsnUqav
        7QzBnOxtlzAP6srJFLnhhucFaRAaSghDx9lG0tB8vtDQ5O3HDWPC/Axiszkpl2NNnEPNWbNt
        pjxrTjK9JtO40qhP0GhjtYnMUlptZS1cMp26NiN2VZ45MBStLmDN+YFUBsvzdPzyJIct38mp
        c228M5nm7CazXau1x/Gshc+35sRl2yzLtBqNTh9QbjXnltR9x+xVit3dby5iRWhM7kYyGVBL
        oMPLuJFcpqRaEbhuprhRWIC/ICitqsXFYBxBTdk3LKgKGvxuQSIWbiNoffgGE4MPCCor7oVU
        BBULfXWDkiBHUiZ41DAaEmHUVwRHfncRwYKciocTA30hjqDS4fpwZ8iMUwth6GVZKK+gEuHn
        21pS5Jlw/9QgHmSMWgQXakcmR1LDxNAFqdhsFbQM1kxqIuF0iSvUGKhfBJQ8KEaiIRWE0auT
        HAEfu72kyCoY+3SbELkQ2l2VpGguQzDhH5KKhcXgeX8YBa+HUdHQ1BYvHnIBdD2b7DsDin2/
        STGtgGKXUjRGweXxYYnI86BxqI08imjPlM08UzbzTNnA879XDcIb0GzOzltyOF5nXzz1sQUU
        +rAxaa2opWdtJ6JkiJ6uUG87mKWUsgX8HksnAhlGRypWnDyUpVSY2D17OYfN6Mg3c3wn0gcO
        X4mpZmXbAt/f6jRq9bqEBE2intEn6Bh6jkIIH9iipHJYJ7eD4+yc459PIpOritC54ajM/gJP
        +CjxYyO+SBW1PPJWdfjT5k3vy9cb/DX1j19duvh8mjoei7l7Pw0X2gpd60uthdJZ4y99meXr
        6uemGtO3X9U82tlzROjRlg5k0at3OeU+1/xLFa/vuG9Vy7k/Sq/uofdaWFx96YbEbm+K+vlI
        0cr0aonfsc9XXN9/nMb5XFYbgzl49i/18OSlxgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvK70ltY4g5trhSyaF69ns7ja9J7N
        YsqGD0wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFmcW97A6cHjtn3WX32LSqk81j/9w1
        7B6bl9R7rN9ylcXj8ya5ALYoLpuU1JzMstQifbsEroxJi6+wF7zkqZhwcjZrA+NJzi5GTg4J
        AROJD12bmLoYuTiEBHYzSpzdMJcVIiEjMeHFEmYIW1jifssRVoii54wSZ+bOYQJJsAnoSlxe
        /ATMFhFIkfj16QcLSBGzwC9GiWs3NjBCdFxnlFh9+DkLSBWngL7EtJuX2UBsYQFfiaudM8Hi
        LAIqEk/v9YDFeQUsJX49WsgOYQtKnJz5BKyGWUBb4unNp3D2soWvoc5TkPj5dBkrxBVuEtue
        LICqEZGY3dnGPIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXr
        JefnbmIEx5uW1g7GEyfiDzEKcDAq8fAqpLXECbEmlhVX5h5ilOBgVhLhdZzRGifEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBMUAh/xlz5KWPtbyNDLot
        F+Xu9r0o82bT4hOa/Ji3NVV+/xu/gI9rpe9Kf7j7W1Pb6blJe3X2tYC+xTGuC19ntZWlX/Kr
        /fvppRm/5NPUqIgFfMeDr+9msnz3RDPdtbJj6Z8XtofmHZn+eIZe8qz/PIFb5s5pFL+iZ+v6
        +Pw6g309X6uP9J2XU2Ipzkg01GIuKk4EAJUyQsezAgAA
X-CMS-MailID: 20200402094459epcas2p1af4cf104eb6d7ea0d602a562fd9c8c8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200401082749epcas2p2a774da515805bc3f761b6b5a8dc9e3d2
References: <CGME20200401082749epcas2p2a774da515805bc3f761b6b5a8dc9e3d2@epcas2p2.samsung.com>
        <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <20200401085548.GC2026666@kroah.com> <20200401091952.GA14425@kozik-lap>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 01, 2020 at 6:20:20PM +0900, Krzysztof Kozlowski
wrote:
> On Wed, Apr 01, 2020 at 10:55:48AM +0200, Greg Kroah-Hartman
> wrote:
> > On Wed, Apr 01, 2020 at 05:27:20PM +0900, Hyunki Koo wrote:
> > > -	if (np)
> > > +	if (np) =7B
> > >  		of_property_read_u32(np,
> > >  			=22samsung,uart-fifosize=22, &ourport->port.fifosize);
> > >
> > > +		if (of_property_read_u32(np, =22reg-io-width=22, &prop) =3D=3D
> 0) =7B
> > > +			switch (prop) =7B
> > > +			case 1:
> > > +				ourport->port.iotype =3D UPIO_MEM;
> > > +				break;
> > > +			case 4:
> > > +				ourport->port.iotype =3D UPIO_MEM32;
> > > +				break;
> > > +			default:
> > > +				dev_warn(&pdev->dev, =22unsupported
> reg-io-width (%d)=5Cn=22,
> > > +						prop);
> > > +				ret =3D -EINVAL;
> > > +				break;
> > > +			=7D
> > > +		=7D
> > > +	=7D
> > > +
> >
> > Does this mean that reg-io-width is now a required property for all
> > samsung uarts?  Does this break older dts files?  Or should you
> > fall-back to the previous operation if the attribute is not there?
>=20
> Yes, it looks like silently breaking all boards.  Since
> of_property_read_u32() will return errno, the warning message won't be
> printed and all register reads will fail (return 0).
>=20
> This looks like not tested on real HW.
>=20
> Best regards,
> Krzysztof

=5BHyunki Koo=5D=20
reg-io-width =3D4 is required for Samsung uart
To do not break older dts files, I will set default value in else of of_pro=
perty_read_u32 like below.
+		if (of_property_read_u32(np, =22reg-io-width=22, &prop) =3D=3D 0) =7B
+ ...
+		=7D else =7B
+			ourport->port.iotype =3D UPIO_MEM;
+		=7D




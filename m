Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D8C48BE5
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 05:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D71610A3
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 05:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhFUFit (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Jun 2021 01:38:49 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:51259 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhFUFit (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Jun 2021 01:38:49 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210621053633epoutp0325bd859322d0662007d8668297d8ed12~KgjhH5VP93153931539epoutp03m
        for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2021 05:36:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210621053633epoutp0325bd859322d0662007d8668297d8ed12~KgjhH5VP93153931539epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624253793;
        bh=0PLR6M50yiRdMI4Vr9g6B/Mq+cV1i9BidWEN60U5MmM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=kZ3b73Q2XoNjFX+Ayo+09HowV71kGYiYkrQekD6O/4MCp7uw+zXfJKvY7MvVo1HeN
         vYwMbgE0k3FrJmhHEh6FIvHg8H55byD/GCii5g6JEMRotxDhROOPri5jWzI8wglb4I
         t47x4jHigZcPGtXSYAxIfL/L6wO86V//0UDnTthI=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210621053633epcas5p29aebe7aa9f5ae95af2009098a6434163~KgjgkpQ0e2583525835epcas5p2b;
        Mon, 21 Jun 2021 05:36:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.1E.09452.16520D06; Mon, 21 Jun 2021 14:36:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210621052648epcas5p3cbacaee0cccd663805a27056c6137356~Kga-_e8oP2593125931epcas5p3x;
        Mon, 21 Jun 2021 05:26:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210621052648epsmtrp127ff6ada70782f09379c23a531f03b40~Kga-9ox020352403524epsmtrp1J;
        Mon, 21 Jun 2021 05:26:48 +0000 (GMT)
X-AuditID: b6c32a4b-429ff700000024ec-ed-60d02561441f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.08.08394.81320D06; Mon, 21 Jun 2021 14:26:48 +0900 (KST)
Received: from mshams01 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210621052646epsmtip168d181e4f721be5f7428ca887d4ae298~Kga_beFNs3221732217epsmtip1W;
        Mon, 21 Jun 2021 05:26:46 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     <kgene@kernel.org>, <krzk@kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <ajaykumar.rs@samsung.com>
In-Reply-To: <20210621044757.40046-1-m.shams@samsung.com>
Subject: RE: [PATCH v4] serial: samsung: change to platform_get_irq_optional
Date:   Mon, 21 Jun 2021 10:56:45 +0530
Message-ID: <000801d7665e$08424a00$18c6de00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLrt4vOvQgF3TDEnmyTfCXOmtgdwgF+I3k8qOlbpbA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7bCmhm6i6oUEg5ltPBYH3h9ksXgwbxub
        RfPi9WwWUzZ8YLLof/ya2eL8+Q3sFpseX2O1uLxrDpvFjPP7mCzOLO5ld+Dy2LSqk81j/9w1
        7B6bl9R79G1ZxeixfstVFo/Pm+QC2KK4bFJSczLLUov07RK4Mk6cnMBWsIK/YtWdV2wNjO94
        uhg5OSQETCT+P7rH0sXIxSEksJtR4uG0qawQzidGibYzV5ggnG+MEm++bmGEaXmy4S4LiC0k
        sJdRovG0B0TRM0aJjvYtzCAJNgFdiUkH28BsEYEYiZVrPoNNYhY4wyjxePFkJpAEp4ClxL4r
        R9lAbGEBH4kXz6aC2SwCqhI/JjeD2bxANVOa5jNB2IISJ2c+AdvMLKAtsWzha2aIixQkfj5d
        xgqxzEpi/8rzjBA14hIvjx5hB1ksIbCWQ2LOhidQL7hIHF94gAnCFpZ4dXwLO4QtJfGyvw3K
        zpeYP28V1IIKiZUX3kDZ9hIHrswBOoIDaIGmxPpd+hBhWYmpp9YxQezlk+j9/QRqPK/Ejnkw
        tqLE/939UOPFJd6tmMI6gVFpFpLXZiF5bRaSF2YhbFvAyLKKUTK1oDg3PbXYtMA4L7Vcrzgx
        t7g0L10vOT93EyM4YWl572B89OCD3iFGJg7GQ4wSHMxKIrycmWcShHhTEiurUovy44tKc1KL
        DzFKc7AoifMuZT+UICSQnliSmp2aWpBaBJNl4uCUamCqzdznYK7T9tlO9evrbt3LMrVpu3Iu
        Wv+N7TJLOnvrqqGCRzH/RBEOeeZHZ2cdEJkozfD5W3rg0U8BenWRVTNzEuQOrBY+4K91YpZE
        671/gRlxS3fHdz1vTj+Yd0juFP/b8uNXb0/Lj9da5OFgK7en0VXr/0Q7abvn2WIFF/QDtCZX
        t1xmep1ffMxK7Ry7SZSazYJZ8X76fQuTypnC229whUx/+ZY56Jq/72mOygjfQyW+YULL/Csm
        SwiIaPH2CO3K2x6dKZWw1zN12u2VciZuTw/HeNiK71u+aPVXnXchrg4Ru0sZJ5eKVKqXPZ2z
        mEPd7YNM/YK8mU+c+edMYtdqWnN/uZKb7pte1i+blViKMxINtZiLihMBdaz9j8cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnK6E8oUEgwOTJSwOvD/IYvFg3jY2
        i+bF69kspmz4wGTR//g1s8X58xvYLTY9vsZqcXnXHDaLGef3MVmcWdzL7sDlsWlVJ5vH/rlr
        2D02L6n36NuyitFj/ZarLB6fN8kFsEVx2aSk5mSWpRbp2yVwZUz68oep4A9fRc/uC2wNjPt4
        uhg5OSQETCSebLjL0sXIxSEksJtRomHzbXaIhLjEtF/7GSFsYYmV/56zQxQ9YZQ4teM8WBGb
        gK7EpINtzCC2iECCxJeTMxlBipgFLjBKdB+9AdXRxSjxfudlsFGcApYS+64cZQOxhQV8JF48
        mwpmswioSvyY3Axm8wLVTGmazwRhC0qcnPmEBcRmFtCW6H3YyghjL1v4mhniPAWJn0+XsUJc
        YSWxf+V5qBpxiZdHj7BPYBSehWTULCSjZiEZNQtJywJGllWMkqkFxbnpucWGBYZ5qeV6xYm5
        xaV56XrJ+bmbGMGRp6W5g3H7qg96hxiZOBgPMUpwMCuJ8HJmnkkQ4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgUmJ/bmv6bYas7gw1uOPD32LPPa7xDBj
        0Yts7533q1ZtirolbZc+//csoXCBjZWCS19/2XLpRIDOhVk1UUJ6Cod9Fz3VNum0fbBw5az3
        XRfrrE+uVo5g3jut7E3uZvmXd0/517yZyKbaPN3o1a3eEK37u+N1ttm/SthUbL/r3bRYnfqZ
        385/W38v/31jS8VK6W+TOMUON3w+PzvDVU5nfqepdbjIBlWzFNGdb8KXXZTher6+dt93TvXv
        su90OCIsprvM5asQTxUOc+XicWf7Um+f8I/t+PF5V3NOfpj9ZMK0K1Lr+2u5D15eqdF9UfyQ
        /TPruR5LZwocer7Sas6XK/NWv4l9yd+izSJ26LjilsSPSizFGYmGWsxFxYkAVgQfPisDAAA=
X-CMS-MailID: 20210621052648epcas5p3cbacaee0cccd663805a27056c6137356
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210621044400epcas5p40368077e77d2da219db8f890dfd69f7c
References: <CGME20210621044400epcas5p40368077e77d2da219db8f890dfd69f7c@epcas5p4.samsung.com>
        <20210621044757.40046-1-m.shams@samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Tamseel Shams <m.shams=40samsung.com>
> Sent: Monday, June 21, 2021 10:18 AM
> To: kgene=40kernel.org; krzk=40kernel.org; gregkh=40linuxfoundation.org;
> jslaby=40suse.com
> Cc: linux-arm-kernel=40lists.infradead.org; linux-samsung-soc=40vger.kern=
el.org;
> linux-serial=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> alim.akhtar=40samsung.com; ajaykumar.rs=40samsung.com; Tamseel Shams
> <m.shams=40samsung.com>
> Subject: =5BPATCH v4=5D serial: samsung: change to platform_get_irq_optio=
nal
>=20
> In few older Samsung SoCs like s3c2410, s3c2412 and s3c2440, UART IP is h=
aving
> 2 interrupt lines.
> However, in other SoCs like s3c6400, s5pv210, exynos5433, and exynos4210
> UART is having only 1 interrupt line. Due to this, =22platform_get_irq(pl=
atdev, 1)=22
> call in the driver gives the following false-positive error:
> =22IRQ index 1 not found=22 on recent platforms.
>=20
> This patch replaces the platform_get_irq() call with
> platform_get_irq_optional() and hence avoiding the false-positive error.
>=20
> Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> ---
> Commit message is changed.
> Addressed Krzysztof's previous comment.
>=20
>  drivers/tty/serial/samsung_tty.c =7C 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 6ef614d8648c..c44582011b9b 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> =40=40 -1911,7 +1911,7 =40=40 static int s3c24xx_serial_init_port(struct
> s3c24xx_uart_port *ourport,
>  		ourport->tx_irq =3D ret + 1;
>  	=7D
>=20
> -	ret =3D platform_get_irq(platdev, 1);
> +	ret =3D platform_get_irq_optional(platdev, 1);
>  	if (ret > 0)
>  		ourport->tx_irq =3D ret;
>  	/*
> --
>=20

Please ignore this patch.
Sorry for the spam.

Thanks & Regards,
Tamseel Shams



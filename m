Return-Path: <SRS0=XDGD=AD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60B4C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 02:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E032536F
	for <linux-serial@archiver.kernel.org>; Mon, 22 Jun 2020 02:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NnuIzdx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgFVC2n (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:28:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:46893 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgFVC2m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Jun 2020 22:28:42 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200622022840epoutp0458574a384fc387bdb6cdc8a775a6f9fb~avLjj-lIU0883808838epoutp04-
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2020 02:28:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200622022840epoutp0458574a384fc387bdb6cdc8a775a6f9fb~avLjj-lIU0883808838epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592792920;
        bh=j+KRWMeL94ow0fZi3QmpG8KRcj/J1YvaKWgzqFi+vCo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NnuIzdx0fIwbuHSXKIaEvDbrClT0LOud+TmJyA/QUlnMCM1qkJB0HkFg0+nRIx4ml
         qZRTYAv7CxjzcklgIK3Fn2fIQC7nP7dD1mMU39QNiEzkhwhIEktjgxr57CSFKgRht3
         lnSQB/Ah1xM3+X1wi8rft7Cmh9tYi/h5mXIb7W4U=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200622022840epcas5p10a3c21e7709fe8d6ea90fcb62f48d7ef~avLjLH_5K0180201802epcas5p1U;
        Mon, 22 Jun 2020 02:28:40 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.25.09475.75710FE5; Mon, 22 Jun 2020 11:28:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200622022838epcas5p3a8f55c596b3cd46eff780b6ee0eb5401~avLiI7e252477724777epcas5p31;
        Mon, 22 Jun 2020 02:28:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200622022838epsmtrp2da2cd61dc0dbdd2aa40d91a0218c6f3d~avLiINBU91717117171epsmtrp2q;
        Mon, 22 Jun 2020 02:28:38 +0000 (GMT)
X-AuditID: b6c32a4b-389ff70000002503-15-5ef01757445b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.43.08303.65710FE5; Mon, 22 Jun 2020 11:28:38 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200622022835epsmtip1654e0d7c668f83c7483fdd7fe7074415~avLfAmfOH2921629216epsmtip1h;
        Mon, 22 Jun 2020 02:28:35 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Tamseel Shams'" <m.shams@samsung.com>, <kgene@kernel.org>,
        <krzk@kernel.org>, <gregkh@linuxfoundation.org>, <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200617105907.7143-1-m.shams@samsung.com>
Subject: RE: [PATCH] serial: samsung: fix spelling mistake
Date:   Mon, 22 Jun 2020 07:58:32 +0530
Message-ID: <00c701d6483c$d6587f90$83097eb0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHKng1dpmBVsT1kIn4KbhhNPgyntAIoJRNTqOn8EuA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7bCmum6E+Ic4gw8bmC2aF69ns5iy4QOT
        Rf/j18wW589vYLfY9Pgaq8XlXXPYLGac38dkcWZxL7vF3dbF7A6cHptWdbJ57J+7ht1j85J6
        j74tqxg91m+5yuLxeZNcAFsUl01Kak5mWWqRvl0CV8aqVWuZC9ZwVez7dJqlgfE6RxcjJ4eE
        gInEjGML2bsYuTiEBHYzSqy/3coG4XxilOi+e4kVwvnMKHH96xxGmJZHZ/ZDVe1ilLj5pgGq
        /w2jxOEt19lAqtgEdCV2LG4DqxIRaGWUOPvgAZjDLDCZUeLjwwOsIFWcAhYSZ8/3sYDYwgJW
        EkeOXWUCsVkEVCV+7GxgBrF5BSwlJvxoYIOwBSVOznwCVs8soC2xbOFrZoibFCR+Pl0GNlME
        aM7EjjOsEDXiEkd/9jCDLJYQWMohsXXJGjaIBheJSW8XskDYwhKvjm9hh7ClJD6/2wtUwwFk
        Z0v07DKGCNdILJ13DKrcXuLAlTksICXMApoS63fpQ6zik+j9/YQJopNXoqNNCKJaVaL53VWo
        TmmJid3drBC2h8S/28uYJzAqzkLy2Cwkj81C8sAshGULGFlWMUqmFhTnpqcWmxYY56WW6xUn
        5haX5qXrJefnbmIEpykt7x2Mjx580DvEyMTBeIhRgoNZSYT3dcC7OCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8Sj/OxAkJpCeWpGanphakFsFkmTg4pRqYpB57XZY78kZaQHl9F3fW5uOS3+Mi
        1f6YbdVqVvBLcOS3zriwcGt5cHnxibIWRYEFK9KU7XepLG78fHFNIevjlGyHk1MclW1iKlyz
        684um///1VqT4ACP97sMjrz9yeOj1aTL+TZ3lsCG580id587ukhWbzwuEa6keu4eh8Jj29wD
        956m5MQumHZOo+vM/0y2Cx4lsV+fGJsdzb93ztdhJ8NpFgZePR6B3nrppF9NX8xSmdsWr70m
        nigavV1R9AfTk+dvD7+4fexE14UCtW9G824cWCV77qG4+5xN1YH1d9IDm+Y+LV89mcX756OY
        Ldpbd8jUd+bpLI/fmNJpYnR2oYjA2U4dKzYfo2Vf/29UYinOSDTUYi4qTgQAjpPKJ8IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnG6Y+Ic4gxkvLSyaF69ns5iy4QOT
        Rf/j18wW589vYLfY9Pgaq8XlXXPYLGac38dkcWZxL7vF3dbF7A6cHptWdbJ57J+7ht1j85J6
        j74tqxg91m+5yuLxeZNcAFsUl01Kak5mWWqRvl0CV8a+7dNYC1q4Kloe2jUwrufoYuTkkBAw
        kXh0Zj8biC0ksINRYvZsY4i4tMT1jRPYIWxhiZX/ngPZXEA1rxgl1mx4zAySYBPQldixuI0N
        JCEi0M0o0X/pB5jDLDCVUeLYhAZmiJZORonP786zgrRwClhInD3fxwJiCwtYSRw5dpUJxGYR
        UJX4sbMBbCyvgKXEhB8NbBC2oMTJmU/A6pkFtCWe3nwKZy9b+JoZ4j4FiZ9Pl4HNFwGaObHj
        DCtEjbjE0Z89zBMYhWchGTULyahZSEbNQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66
        XnJ+7iZGcLRpae1g3LPqg94hRiYOxkOMEhzMSiK8rwPexQnxpiRWVqUW5ccXleakFh9ilOZg
        URLn/TprYZyQQHpiSWp2ampBahFMlomDU6qBKeX0JnX2pxsLpi6YvHua6J2NkWpZjZufHjHa
        5C6/g5fDuWZ5RZr+uUmC+3+3ZNxfMPlOxIyDj76d+Z/Hv7d22h8Ds6a3DMb189/6tPy6ab/P
        UoVZ0GW+1SzFJ3ozL71i2qLyW95Edv3m6YlSBy9eYv3llFjfWeMU8qJb7v68JK2Ny1ZYu9U4
        N8w65RKSt3tTkaUs1+EbYRcE3j1jOuKuk8La+/+DXnN6dEJPeMP87eFnX85m3Lb71H+NxNtd
        Ux+l9QvfdtGL4+W6uc7u9UOxSWbuAZXartwJZz4w6jVxyB/R/sTy/XzVikofG5PdPGpblaTV
        og5bMkQIFKlxVF+rjtnbZlpvGPTzLfPNs3cblViKMxINtZiLihMBu4+y6yUDAAA=
X-CMS-MailID: 20200622022838epcas5p3a8f55c596b3cd46eff780b6ee0eb5401
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200617111707epcas5p3fcb86caeac4a852d44f37ae40759c8a1
References: <CGME20200617111707epcas5p3fcb86caeac4a852d44f37ae40759c8a1@epcas5p3.samsung.com>
        <20200617105907.7143-1-m.shams@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Tamseel,

> -----Original Message-----
> From: Tamseel Shams <m.shams=40samsung.com>
> Sent: 17 June 2020 16:29
> To: kgene=40kernel.org; krzk=40kernel.org; gregkh=40linuxfoundation.org;
> jslaby=40suse.com
> Cc: linux-arm-kernel=40lists.infradead.org; linux-samsung-soc=40vger.kern=
el.org;
> linux-serial=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> alim.akhtar=40samsung.com; Tamseel Shams <m.shams=40samsung.com>
> Subject: =5BPATCH=5D serial: samsung: fix spelling mistake
>=20
> There is a spelling mistake in a comment. Fix it.
>=20
> Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

>  drivers/tty/serial/samsung_tty.c =7C 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 6ef614d8648c..050a47fecdef 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> =40=40 -6,7 +6,7 =40=40
>   *	http://armlinux.simtec.co.uk/
>   */
>=20
> -/* Hote on 2410 error handling
> +/* Note on 2410 error handling
>   *
>   * The s3c2410 manual has a love/hate affair with the contents of the
>   * UERSTAT register in the UART blocks, and keeps marking some of the
> --
> 2.17.1



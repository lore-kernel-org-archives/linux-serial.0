Return-Path: <SRS0=8eBw=5X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF30C2BA80
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 06:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3F420747
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 06:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XpwM1Dzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgDGGDA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:03:00 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:57957 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgDGGDA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 02:03:00 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200407060258epoutp02d05ee37921728e660cc327f72f72ab3b~DdE9wxpXQ2922129221epoutp024
        for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2020 06:02:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200407060258epoutp02d05ee37921728e660cc327f72f72ab3b~DdE9wxpXQ2922129221epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586239378;
        bh=UHJ/xy/UlANgcny0UOh5Ut2QlDZdjfdnSsm1AznPSTE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=XpwM1Dzveq7gjd55a1CBsNtwtt8QF+bBqsabzFvDCJFZcuPCzQ43UVzV/HeQttWw4
         L7JOODIqauJ7OsLHrBFgnF9FcOXm7nSq2PuO10c2CXEYI4wxe5urnBPE4kLbRSseUy
         A2+f5d2usGEl5tUiMPKVDQAjVQxIlAFfQ+UbMAk4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200407060257epcas2p372c0452e9eb770b02eb360fd8b216b6e~DdE9a6nfD1451114511epcas2p37;
        Tue,  7 Apr 2020 06:02:57 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48xGzM40PjzMqYkg; Tue,  7 Apr
        2020 06:02:55 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.04.04704.E871C8E5; Tue,  7 Apr 2020 15:02:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200407060253epcas2p4a98467e9fdd8c77db2be8c7a8c2e0d1f~DdE5pBu1j0264802648epcas2p4P;
        Tue,  7 Apr 2020 06:02:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200407060253epsmtrp246645ee0fa5ad61d407cfbc0c42b653e~DdE5nzJMo0321703217epsmtrp2r;
        Tue,  7 Apr 2020 06:02:53 +0000 (GMT)
X-AuditID: b6c32a46-811ff70000001260-d4-5e8c178ec2ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.8D.04024.D871C8E5; Tue,  7 Apr 2020 15:02:53 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.165.196]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200407060253epsmtip2b8eb7f5017b9e1a33efbdeb4071fc24c~DdE5aMClM2535825358epsmtip2a;
        Tue,  7 Apr 2020 06:02:53 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Jiri Slaby'" <jslaby@suse.com>, <gregkh@linuxfoundation.org>,
        <krzk@kernel.org>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <62a918df-b3ba-21f4-b3ad-9f638ad104ad@suse.com>
Subject: RE: [PATCH v6 2/2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Tue, 7 Apr 2020 15:02:53 +0900
Message-ID: <000401d60ca2$2d2b3550$87819ff0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKEs4Y1dkf1SYeuuA/6Ie9wROds5QJr8Gf+Ae0ziqcBDq6a2abkmiBQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut3u3Xa3Fz2V1GFLjJpHVdFtNr6EWVLIoSOhlEdrN3aa0F7vT
        XkSGZWqariJtFSaa9kJrmYkyEzUsMqX3A4vCFpX0UloIWW27Vv73nd/5Ps73nd+hCHmjREFl
        WRyc3cKaaEko2dQZxaiOTC9OUztfRjCVXb1iJq+6QcIcv/JVxJQODBJMX98VKeMeeCJmHrac
        ljAVfW0ipqe6RMoc9HRJl4Tq3RcLJfqbZy5L9ddq9ukbGh+T+mH3jBTxJlNCJscaOLuSs2RY
        DVkWYyK9ck360nRdrFqj0sQzcbTSwpq5RHrZqhRVcpbJb4pW5rCmbP9TCsvzdExSgt2a7eCU
        mVbekUhzNoPJptHYonnWzGdbjNEZVvMijVqt1fmZW0yZA2VdyOYJ2/ljuIHMRcOyIhRCAV4I
        5a67ZBEKpeS4GUF7o1MqFEMI3rS+FguFD4H7UKX0n8TpHWt4EBy930cIxQcEn3p9KMCSYBU8
        rH4rKkIUFY43QGtHToBD4J8I8jxPyAAnBCdA5+D9IJ6C18P1plZRAJM4Ei74eoLTZDgezj3y
        iQUcBndOvg3yCTwPaqsGCcGREka8tUFOOE6GL0f6CYETDqcK84PmAP+WQOWzcpEgWAZlD0pJ
        AU+Bj92NY9EUMPzZIxHwPmjLF5YBuBjByFevWGgsANe7QyiQjMBR0NASE4CAZ0HXizFvk6Gg
        c1QqPMugIF8uCGdDve/9mIMIuOxtkZYh2jUumWtcMte4BK7/s84i8iKaxtl4s5HjtTbt+N92
        o+DFzk1uRjW9qzoQphA9SZYacjhNLmZz+F3mDgQUQYfLFCWFaXKZgd21m7Nb0+3ZJo7vQDr/
        4p2EYmqG1X//Fke6RqeNjVXH6xhdrJahp8vcE59vlmMj6+C2c5yNs//ViagQRS56euz7UsdL
        WnTL82HCVa5qfvmboaTIV/31/KtfG1fmPb69f/Gs2abRgqMnt1WW31DFHdjbHXm+pzQtdU99
        incts/rewbq6wq2iihVPl9s3DY0WNT3aXkfMPHPN2D1tx0hM/+5ow/J113XGSW3fik9M9HRG
        XNpR0n426sXi3KQ4ZiB1jlNBk3wmq5lL2Hn2D4ffaEXHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvG6veE+cwcpvuhbzj5xjtWhevJ7N
        YsqGD0wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFmcW97Bate4+wO3B5bFrVyeaxf+4a
        do/NS+o91m+5yuLxeZNcAGsUl01Kak5mWWqRvl0CV8a+XbUFCwUr9i3rY21gvMzbxcjJISFg
        IjF94lPWLkYuDiGB3YwSS3cfY4NIyEhMeLGEGcIWlrjfcgSq6DmjxKN9C1lBEmwCuhKXFz9h
        6mLk4BARiJTY1ScOUsMs0MQk0XttB1izkMBHRomp26pBbE4BG4nDry+ygNjCAiES65o/gM1h
        EVCRWPntDDuIzStgKbH0yjdWCFtQ4uTMJ2D1zALaEr0PWxlh7GULX0MdpyDx8+kysHoRATeJ
        9313mCFqRCRmd7YxT2AUnoVk1Cwko2YhGTULScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWl
        eel6yfm5mxjBkaaluYPx8pL4Q4wCHIxKPLwM7N1xQqyJZcWVuYcYJTiYlUR4pXo744R4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpglFCZ6HHomci8KYvu
        /uB+Uni3YLO+KQ/z7NbKU1E2k9qM9maW2ja92Mh3e1t8r+0uxY0JfNEfld1tXP7pHZ1kxxSx
        5Zr0s/yIe+XP1qa1Ln+Zc7Og9ivX7q0RLlF79EN3rG1zF45ZxJD946h/21IP1VO6v5bsvVH1
        +Fma84u8zAMXUsX5e73+K7EUZyQaajEXFScCAGO85/mwAgAA
X-CMS-MailID: 20200407060253epcas2p4a98467e9fdd8c77db2be8c7a8c2e0d1f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200406230902epcas2p19a8df6805dac59968d664efb9bc9419b
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <CGME20200406230902epcas2p19a8df6805dac59968d664efb9bc9419b@epcas2p1.samsung.com>
        <20200406230855.13772-1-hyunki00.koo@samsung.com>
        <62a918df-b3ba-21f4-b3ad-9f638ad104ad@suse.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 07. 04. 20, 1:49, Jiri Slaby wrote:
> On 07. 04. 20, 1:08, Hyunki Koo wrote:
> > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> >
> > This is required for some newer SoCs.
> >
> > Signed-off-by: Hyunki Koo <hyunki00.koo=40samsung.com>
> ...
> > ---
> >  drivers/tty/serial/samsung_tty.c =7C 76
> > +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 64 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 73f951d65b93..bdf1d4d12cb1 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > =40=40 -154,12 +154,47 =40=40 struct s3c24xx_uart_port =7B
> ...
> > -=23define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port,
> > reg))
> > +static void wr_reg(struct uart_port *port, u32 reg, u32 val) =7B
> > +	switch (port->iotype) =7B
> > +	case UPIO_MEM:
> > +		writeb_relaxed(val, portaddr(port, reg));
> > +		break;
> > +	case UPIO_MEM32:
> > +		writel_relaxed(val, portaddr(port, reg));
> > +		break;
> > +	=7D
> > +=7D
> > +
> >  =23define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port,
> > reg))
> >
> > +static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
>=20
> You need to explain, why you need this _barrier variant now. This change
> should be done in a separate patch too.
>=20
> > +=7B
> > +	switch (port->iotype) =7B
> > +	case UPIO_MEM:
> > +		writeb(val, portaddr(port, reg));
> > +		break;
> > +	case UPIO_MEM32:
> > +		writel(val, portaddr(port, reg));
> > +		break;
> > +	=7D
> > +=7D
> > +
> >  /* Byte-order aware bit setting/clearing functions. */
> >
> >  static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
>=20
> thanks,
> --
> js
> suse labs

The purpose of this patch is to support 32bit access for registers, and it =
is also working exsisting device.
There are 3 operations what I have to to change which are rd_regb, wr_regb,=
 and writeb.
rd_regb, wr_regb are changed to rd_reg, wr_reg.
and writeb is changed to wr_reg_barrier.
So I make as a one patch.

wr_reg_barrier is not a different patch, itis just replaced from writeb.


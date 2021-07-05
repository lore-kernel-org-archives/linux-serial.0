Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A425C07E9B
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jul 2021 12:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14776613B1
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jul 2021 12:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhGEMmD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:42:03 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:37630 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhGEMmD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Jul 2021 08:42:03 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210705123924epoutp0237859ff6a03f4b343c6523b854d782d7~O5WtcNZpS2456224562epoutp02i
        for <linux-serial@vger.kernel.org>; Mon,  5 Jul 2021 12:39:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210705123924epoutp0237859ff6a03f4b343c6523b854d782d7~O5WtcNZpS2456224562epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625488764;
        bh=+b1UlhnYxKP3gQD/M4hY8gPMlxFnQZGtkIv4YR07XAY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=upGzKuoh8COGJ+zSzaw0gxB/fr/O97BdEDf0o/sFoeO2qxJam7Pw+YWcCjjeFdkKY
         yS07rQLRGGY/V1rQWlMR/7VEE/UTa5T8oIcyVxA9p/Udt4fgJyujZt8+SM7NLKg83F
         +BnrcBFvWO3QlpUTflXFVAOErVQdRS2FlCa6LTow=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210705123923epcas5p13f903f7b681d62b9a24f8b5ef6eeb958~O5WsrTt8D2594625946epcas5p1z;
        Mon,  5 Jul 2021 12:39:23 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.197]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GJQHF4TZSz4x9Pp; Mon,  5 Jul
        2021 12:39:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.EA.09452.97DF2E06; Mon,  5 Jul 2021 21:39:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210705110409epcas5p442a806bed53d1f2942a06d0ad4e46c16~O4DilClo70999409994epcas5p4Q;
        Mon,  5 Jul 2021 11:04:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210705110409epsmtrp21fc3b83fea0be21edf7882fa90a874aa~O4DikQcYh0973909739epsmtrp2R;
        Mon,  5 Jul 2021 11:04:09 +0000 (GMT)
X-AuditID: b6c32a4b-43fff700000024ec-ef-60e2fd79030e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.B1.08394.927E2E06; Mon,  5 Jul 2021 20:04:09 +0900 (KST)
Received: from mshams01 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210705110407epsmtip1c86d7ccaec645455f0193cf5663370e7~O4DhHDw7P1242812428epsmtip1t;
        Mon,  5 Jul 2021 11:04:07 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>
In-Reply-To: <0c608d5e-f59b-3f05-a461-2205cece4b7e@canonical.com>
Subject: RE: [PATCH v2] serial: samsung: Checks the return value of function
Date:   Mon, 5 Jul 2021 16:34:05 +0530
Message-ID: <014501d7718d$7a8939e0$6f9bada0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH37JPbw1HOGlkSZQVzgfq3POuaFwHzBW1EAsE0F1iqzZ9PgA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmpm7l30cJBqs2y1o8mLeNzaJ58Xo2
        i3dzZSw2vv3BZLHp8TVWi8u75rBZzDi/j8nizOJedgcOj1kNvWwem1Z1snnsn7uG3WPzknqP
        vi2rGD0+b5ILYIvKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLx
        CdB1y8wBOkdJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoVKBXnJhbXJqXrpec
        n2tlaGBgZApUmZCT0bRhKnNBn1DFif7DzA2Mv/i6GDk5JARMJA4evsjYxcjFISSwm1HizKd3
        7BDOJ0aJPcuusIFUCQl8Y5TY1MAF0/H58COoor2MEo0dy6GcZ4wS299dZgWpYhPQlZh0sI0Z
        xBYRKJc4P2M2G0gRs8A6RokN3y6AJTgFHCXurL8KtJyDQ1jAR+JpazVImEVAReLHsWZ2EJtX
        wFKiaco9ZghbUOLkzCcsIDazgLbEsoWvmSEuUpD4+XQZK8QuJ4kjb/uYIGrEJV4ePQJ2nITA
        Qg6Ju2+WQTW4SDxe9I0dwhaWeHV8C5QtJfH53V42CDtfYv68VVD1FRIrL7yBsu0lDlyZwwJy
        M7OApsT6XfoQYVmJqafWQe3lk+j9/YQJIs4rsWMejK0o8X93P9QqcYl3K6awTmBUmoXktVlI
        XpuF5IVZCNsWMLKsYpRMLSjOTU8tNi0wzkstR47wTYzg5KrlvYPx0YMPeocYmTgYDzFKcDAr
        ifCKTHmUIMSbklhZlVqUH19UmpNafIjRFBjeE5mlRJPzgek9ryTe0NTIzMzA0sDU2MLMUEmc
        dyn7oQQhgfTEktTs1NSC1CKYPiYOTqkGJmc5Ll7LVplZnPfmlgRO8hExuJ/n/mdBW8aLO2mJ
        6k/VP2/uUQ96Fzp14bJunzOOD6337+Xd92N25PRZKa6mOvOj/ij8fjVz8UeRzUYpd+fYm9tM
        63tyV1jX8W3ABMb59Rc3xdo2nL/QuqKfaffkG27821hCQ5/V99Vax05+c3xr+TtvpaeKh/ou
        GtYxtzm6Fv/+x7CE55j7IQPui2+5A0/t23fnhpJaxdbCqMusK5yKuyafcTmTUsqV2sC9e+eT
        jWf8904N7pp6ednfE4ncERyfXhhFrmStag2+87NF5j7rjY85++snarksvicoxRDPpGe0K/rV
        5mbNpl8TXwp9qqoVfnL8RXPg1aeGS3da9CixFGckGmoxFxUnAgCsIZ43NwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTlfz+aMEgyXfBCwezNvGZtG8eD2b
        xbu5MhYb3/5gstj0+BqrxeVdc9gsZpzfx2RxZnEvuwOHx6yGXjaPTas62Tz2z13D7rF5Sb1H
        35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZZzeH1lwSrDi1rt3rA2M2/i6GDk5JARMJD4ffsTe
        xcjFISSwm1Hiw5yHbBAJcYlpv/YzQtjCEiv/PYcqesIocXTTJLAEm4CuxKSDbcxdjBwcIgKV
        Ekua9EBqmAU2MUo0n1/ICNGwn1HiZs9CsKmcAo4Sd9ZfZQRpEBbwkXjaWg0SZhFQkfhxrJkd
        xOYVsJRomnKPGcIWlDg58wkLiM0soC3x9OZTOHvZwtfMEMcpSPx8uowVxBYRcJI48raPCaJG
        XOLl0SPsExiFZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7u
        JkZwdGlp7mDcvuqD3iFGJg7GQ4wSHMxKIrwiUx4lCPGmJFZWpRblxxeV5qQWH2KU5mBREue9
        0HUyXkggPbEkNTs1tSC1CCbLxMEp1cB0skQ5srJVUNSq8f0GE9OrWn55a14+2fU1J8SsLXXm
        XN5Ji9rD2cPya5ZM+NX4Uf7XMpapPM1THlyMtOyf8N/zLoPMFZNJJWaKhR2RSwJCVnYs2B3T
        JXl81WOT6z3/3lofrg82OTJ/18X6B6opk0SqxSIvL7505vvSDk3v/38z5voLJ54LfiO/6NIi
        nY3Olv5rPacFe2281LJ64p/UR/p9oU3L7I3r+ngvSS+zEfuz5WvtE66azqcdvZG1D1Mk0x5N
        Up5/6e/54O9RB/WP+AuVmkdwFTwW3fVNKXaBks9bsYRLTb+8rZ3DS74Lx/z/sfBuntc0qcrw
        oJvN289UOrit+bxotfymSRX3rGd7Fd9XYinOSDTUYi4qTgQAGySe6x0DAAA=
X-CMS-MailID: 20210705110409epcas5p442a806bed53d1f2942a06d0ad4e46c16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210630133115epcas5p1706041f122819d47b18b83853b49694e
References: <CGME20210630133115epcas5p1706041f122819d47b18b83853b49694e@epcas5p1.samsung.com>
        <20210630133359.59275-1-m.shams@samsung.com>
        <0c608d5e-f59b-3f05-a461-2205cece4b7e@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40canonical.com>
> Sent: Thursday, July 1, 2021 12:06 PM
> To: Tamseel Shams <m.shams=40samsung.com>; gregkh=40linuxfoundation.org;
> jirislaby=40kernel.org
> Cc: linux-arm-kernel=40lists.infradead.org; linux-samsung-soc=40vger.kern=
el.org;
> linux-serial=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> alim.akhtar=40samsung.com
> Subject: Re: =5BPATCH v2=5D serial: samsung: Checks the return value of f=
unction
>=20
> On 30/06/2021 15:33, Tamseel Shams wrote:
> > =22uart_add_one_port=22 function call may fail and return some error co=
de,
> > so adding a check for return value.
> > If it is returning some error code, then displaying the result,
> > unregistering the driver and then returning from probe function with
> > error code.
> >
> > Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> > ---
> > Changes since v1:
> > 1. Added support to unregister driver on failure of =22uart_add_onr_por=
t=22
> > function call.
> > 2. Commit message updated.
> >
> >  drivers/tty/serial/samsung_tty.c =7C 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 9fbc61151c2e..188e2d2da201 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > =40=40 -2253,7 +2253,11 =40=40 static int s3c24xx_serial_probe(struct
> platform_device *pdev)
> >  	=7D
> >
> >  	dev_dbg(&pdev->dev, =22%s: adding port=5Cn=22, __func__);
> > -	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> > +	ret =3D uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> > +	if (ret < 0) =7B
> > +		dev_err(&pdev->dev, =22Failed to add uart port, err %d=5Cn=22, ret);
> > +		goto add_port_error;
> > +	=7D
> >  	platform_set_drvdata(pdev, &ourport->port);
> >
> >  	/*
> > =40=40 -2272,6 +2276,11 =40=40 static int s3c24xx_serial_probe(struct
> platform_device *pdev)
> >  	probe_index++;
> >
> >  	return 0;
> > +
> > +add_port_error:
>=20
> You did not unwind fully s3c24xx_serial_init_port() - clocks.
>=20
Hi Krzysztof,

Yeah, missed the unwinding of clocks.
Will fix this in next version.

Thanks & Regards,
Tamseel Shams


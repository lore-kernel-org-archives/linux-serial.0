Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C7EC2B9F4
	for <linux-serial@archiver.kernel.org>; Mon, 28 Jun 2021 13:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211BE61C79
	for <linux-serial@archiver.kernel.org>; Mon, 28 Jun 2021 13:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhF1NqY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Jun 2021 09:46:24 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:53417 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhF1NqY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Jun 2021 09:46:24 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210628134357epoutp03b59a3c888e18938e13e98e7902b4d82e~MwuED1_6G3068630686epoutp03L
        for <linux-serial@vger.kernel.org>; Mon, 28 Jun 2021 13:43:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210628134357epoutp03b59a3c888e18938e13e98e7902b4d82e~MwuED1_6G3068630686epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624887837;
        bh=ANfBLqIe/IpafTRn4Rdd9A8v/+LQS9MPXh6/5mSbrF8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=UnoSNge1RTJf3Vo5TtnhheuwbHij5LjZP2EOQhGX2ZheyN5Vy4y9ceeGGHn0ilS7/
         Sb2ZJqE3idZSjbruB6RxonTOvEBsyEODp+KZPfxyDJ/6qK5cNKcBUtky1G5vUXwKu9
         PE7N9J7M62tWaNzOfVBMMjYscNpPTF20cqB67g1s=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210628134356epcas5p12e307b6f1ab67287d13660ea277d96d3~MwuDHwBT00730107301epcas5p1U;
        Mon, 28 Jun 2021 13:43:56 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.48.09452.C12D9D06; Mon, 28 Jun 2021 22:43:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210628133713epcas5p3f4d801f37d32bef752e5fb19252a786c~MwoLyknx60058100581epcas5p3V;
        Mon, 28 Jun 2021 13:37:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210628133713epsmtrp2cf6f298c5e9d0526f59848eb071d30c3~MwoLxrOub1775117751epsmtrp29;
        Mon, 28 Jun 2021 13:37:13 +0000 (GMT)
X-AuditID: b6c32a4b-43fff700000024ec-66-60d9d21ceee5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.08.08289.980D9D06; Mon, 28 Jun 2021 22:37:13 +0900 (KST)
Received: from mshams01 (unknown [107.122.12.94]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210628133711epsmtip12e4d3b9ec28bdf5df78606ee1a6969d7~MwoKTU_Bu1243412434epsmtip1W;
        Mon, 28 Jun 2021 13:37:11 +0000 (GMT)
From:   "M Tamseel Shams" <m.shams@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <ajaykumar.rs@samsung.com>,
        <robin.murphy@arm.com>
In-Reply-To: <3aa88ee4-c662-8069-fb04-90df82038dbe@canonical.com>
Subject: RE: [PATCH v4] serial: samsung: use dma_ops of DMA if attached
Date:   Mon, 28 Jun 2021 19:07:10 +0530
Message-ID: <022901d76c22$b3af0a80$1b0d1f80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK2IkAgtIfCRGonZQvdeYnU2JkFyAHqIlofAj9D7r2pSnSzIA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7bCmlq7MpZsJBofusFsceH+QxeLBvG1s
        Fs2L17NZvJsrY7Hx7Q8mi02Pr7FaXN41h81ixvl9TBZnFveyWxz88ITVgctjzbw1jB6zGnrZ
        PDat6mTz2D93DbvH5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJXx+VZewTyxiiu3e5kb
        GHuEuhg5OSQETCR+nZ7A2MXIxSEksJtR4tHNIywQzidGiYvbfkBlPjNKHJ52G8jhAGtZ9jsK
        Ir6LUWLSrk9QRc8YJa4v72MBmcsmoCsx6WAbM4gtIlAucX7GbDYQm1ngCaPE2ffqIDangKPE
        7zO/2UFsYQF3iTeTJoLVsAioSnRPuAo2h1fAUmJ7zxdWCFtQ4uTMJywQc7Qlli18zQzxg4LE
        z6fLWCF2OUkcX/AJqkZc4uXRI+wgx0kI7OGQ+HavmRWiwUVi4ufbLBC2sMSr41vYIWwpic/v
        9rJB2PkS8+etglpQIbHywhso217iwJU5LKCQYBbQlFi/Sx8iLCsx9dQ6Joi9fBK9v58wQcR5
        JXbMg7EVJf7v7odaJS7xbsUU1gmMSrOQvDYLyWuzkLwwC2HbAkaWVYySqQXFuempxaYFxnmp
        5XrFibnFpXnpesn5uZsYwUlLy3sH46MHH/QOMTJxMB5ilOBgVhLhFau6liDEm5JYWZValB9f
        VJqTWnyIUZqDRUmcdyn7oQQhgfTEktTs1NSC1CKYLBMHp1QD0xl3fl79fdUqD3zCZBrfzf7+
        mGGL5CPRrZ/OJyVeXLa2mTvg/bmUtVIb/k1jU9c4+v7VA88nQnP+HM5ce63gjNu9FwVusa9t
        2MwljNeenKNw+an/wVCl6uMrYjIEwvN89uiYakhfN7yos9/wWsyzQ893Gs5+sKM9U/Zz9Obz
        XzyqF/r/qG/vvWaXGDY78UGQp3+cX6BpALc3M0/Y1xN2tqpOiks+H3r3sKtnfqpfBbPYL/fg
        omo9t4B5SZtCjW6wbdD7liQz4+P3oLzJT/86nyhM2jdhZYuF5VHGyw2/1goWXdlj7pCsGt8c
        xn1W5+zvnW2HZkxJn1Gk75558F6vjxdPwafzb8LXKMTct1JRVmIpzkg01GIuKk4EAMuT6trJ
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnG7nhZsJBuv/clgceH+QxeLBvG1s
        Fs2L17NZvJsrY7Hx7Q8mi02Pr7FaXN41h81ixvl9TBZnFveyWxz88ITVgctjzbw1jB6zGnrZ
        PDat6mTz2D93DbvH5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJUx/cAapoJGsYoly2ax
        NjC+FOxi5OCQEDCRWPY7qouRi0NIYAejxP6Gu6xdjJxAcXGJab/2M0LYwhIr/z1nhyh6wijx
        bOsssCI2AV2JSQfbmEEGiQhUSixp0gOpYRZ4xSjx6dxtNoiG/YwSp7YeYQJp4BRwlPh95jc7
        iC0s4C7xZtJENhCbRUBVonvCVRYQm1fAUmJ7zxdWCFtQ4uTMJ2BxZgFtid6HrYww9rKFr5kh
        rlOQ+Pl0GVi9iICTxPEFn6DqxSVeHj3CPoFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucW
        GxYY5aWW6xUn5haX5qXrJefnbmIER5+W1g7GPas+6B1iZOJgPMQowcGsJMIrVnUtQYg3JbGy
        KrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmVtdpe20u3fpjs09M
        MY2TZ9Lq5B1Su46LnneatmLyYbM1l3b9PjFfjVFkZw/vCWdGrrDbzk4HJ83Q/Ln6b3jnqsNT
        zaQ0uusvlytx2Req5cvJ7qkXdF15fde3t5J8T0Sesl5u+Je8fl2wqExSy5V71yNUpv6auYmV
        fZOJ05mYd7yC/EHWq7d4t3bf5QzlC9eNcnXJE1wdeILfS+LgKxZhrX1XN9kuKHE0/S/f87xm
        71Xj2TITf/m9fXxJ7U/5BHE21zmzONvfn2tS5tLksi7XdYpQ5ajmubSjhmvpA/NuT/Zm3S//
        d+1Y5nmiIakrP/oc/+6a/uasXyzb14qedDgpO2EJ2++42DcV/dcVOn4psRRnJBpqMRcVJwIA
        oO39eC0DAAA=
X-CMS-MailID: 20210628133713epcas5p3f4d801f37d32bef752e5fb19252a786c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210625074751epcas5p125067e47c4ff1ad24a1e595d85f82540
References: <CGME20210625074751epcas5p125067e47c4ff1ad24a1e595d85f82540@epcas5p1.samsung.com>
        <20210625075114.71155-1-m.shams@samsung.com>
        <3aa88ee4-c662-8069-fb04-90df82038dbe@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > When DMA is used for TX and RX by serial driver, it should pass the
> > DMA device pointer to DMA API instead of UART device pointer. DMA
> > device should be used for DMA API because only the DMA device is aware
> > of how the device connects to the memory.
> > There might be an extra level of address translation due to a SMMU
> > attached to the DMA device. When serial device is used for DMA API,
> > the DMA API will have no clue of the SMMU attached to the DMA device.
> >
> > This patch is necessary to fix the SMMU page faults which is observed
> > when a DMA(with SMMU enabled) is attached to UART for transfer.
> >
> > Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> > Signed-off-by: Ajay Kumar <ajaykumar.rs=40samsung.com>
> > ---
> > Changes since v1:
> > 1. Rebased the patch on =22tty-next=22 branch of TTY driver tree
> >
> > Changes since v2:
> > 1. Updated the commit message.
> > 2. Changed the comment description
> >
> > Changes since v3:
> > 1. Removed the null pointer check for =22dma=22, =22dma->tx_chan=22 and
> > =22dma->rx_chan=22 and instead sending DMA device pointer while calling
> > DMA API.
> >
> >  drivers/tty/serial/samsung_tty.c =7C 32
> > ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index 9fbc61151c2e..fa30aa20a13f 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > =40=40 -305,7 +305,7 =40=40 static void s3c24xx_serial_stop_tx(struct u=
art_port
> *port)
> >  		dmaengine_pause(dma->tx_chan);
> >  		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
> >  		dmaengine_terminate_all(dma->tx_chan);
> > -		dma_sync_single_for_cpu(ourport->port.dev,
> > +		dma_sync_single_for_cpu(dma->tx_chan->device->dev,
> >  			dma->tx_transfer_addr, dma->tx_size,
> DMA_TO_DEVICE);
> >  		async_tx_ack(dma->tx_desc);
> >  		count =3D dma->tx_bytes_requested - state.residue; =40=40 -338,8
> +338,8
> > =40=40 static void s3c24xx_serial_tx_dma_complete(void *args)
> >  	count =3D dma->tx_bytes_requested - state.residue;
> >  	async_tx_ack(dma->tx_desc);
> >
> > -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
> > -				dma->tx_size, DMA_TO_DEVICE);
> > +	dma_sync_single_for_cpu(dma->tx_chan->device->dev,
> > +			dma->tx_transfer_addr, dma->tx_size,
> DMA_TO_DEVICE);
>=20
> Looks like alignment is broken here. However even if the line was not ali=
gned
> before, please fix it up now - align the arguments like checkpatch sugges=
ts.
>=20
> This applies to other places as well. Thanks.
>=20
> Best regards,
> Krzysztof

Hi Krzysztof,
Will fix the alignments in the next version.

Thanks & Regards,
Tamseel Shams


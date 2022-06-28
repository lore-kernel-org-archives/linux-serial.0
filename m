Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F04CCA479
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 13:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbiF1NQ6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346102AbiF1NQf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 09:16:35 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC9C31904
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 06:16:32 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220628131630epoutp03ce1248e7613de492f5edcdd4463bec6c~8yzTcCzVx1691016910epoutp03n
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 13:16:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220628131630epoutp03ce1248e7613de492f5edcdd4463bec6c~8yzTcCzVx1691016910epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656422190;
        bh=WWniLOvfhtGT303Dhe689KHo6Xwb0/jW7PJlv+IVEqc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rv5lP3vUsD65Mfu/E2fsPMKyw4qmFbID0gbD9XcfzALuVNHsLXBH/gKqv3dzcj68B
         71W+UjKhoPZPKEEB9vBex1CD0305fxpTyDqQjbBd9MpNt94z0YuecC/WmMXrekvpvM
         4HVdueC7Jk/9G8O1H9DN1GgZlnifaAqL3StGY23g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220628131629epcas2p32ea998d5b68a1791bcddd8e740e2b5e8~8yzSbB1RD0963409634epcas2p3Z;
        Tue, 28 Jun 2022 13:16:29 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LXQ8s18Ggz4x9Ps; Tue, 28 Jun
        2022 13:16:29 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.9B.09642.C2FFAB26; Tue, 28 Jun 2022 22:16:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220628131628epcas2p35f053286613b6f15aa1666ee4a9c07f7~8yzQ3h5uH0963509635epcas2p3b;
        Tue, 28 Jun 2022 13:16:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220628131628epsmtrp2a9874560557a752d91f1e6762d146760~8yzQzgyf13158931589epsmtrp2K;
        Tue, 28 Jun 2022 13:16:28 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-f0-62baff2cf6ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.C5.08905.B2FFAB26; Tue, 28 Jun 2022 22:16:27 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220628131627epsmtip102453ab8d10fd210e092a279ab8504dd~8yzQnOMSm0672006720epsmtip1C;
        Tue, 28 Jun 2022 13:16:27 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>
Cc:     "'Jiri Slaby'" <jirislaby@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Hector Martin'" <marcan@marcan.st>,
        "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'Vincent Whitchurch'" <vincent.whitchurch@axis.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <YrmZ8ikVsnAGrBXF@kroah.com>
Subject: RE: [PATCH] tty: serial: samsung_tty: support more than 4 uart
 ports
Date:   Tue, 28 Jun 2022 22:16:27 +0900
Message-ID: <019e01d88af1$46547080$d2fd5180$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIhEjNC1vSa89v9pVIhrA6dMRC8BwFIWE6jArhqFLgBoFqUg6ymsm2A
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmua7u/11JBvsXMls8mLeNzaJ58Xo2
        ix0NR1gt3s2Vsdj7eiu7xabH11gtZpzfx2RxZnEvu8XpawvYLc5v83fg8ri+LsBj06pONo87
        1/aweeyfu4bdY/OSeo/Fy3ayefRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxz
        vKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCBSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJb
        pdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjMWb57MVTOer6HnzhKWBcQp3FyMHh4SA
        iUTjavYuRi4OIYEdjBJNa7pZIJxPjBJ7+5qYIJxvjBI/rj4DcjjBOj6d2ssIYgsJ7GWUmPcj
        BaLoBaPEkzMTwRJsAvoSLzu2sYLYIgLFEr9b37CBFDELXGCS+DTxBViCU0BTYt2p1WwgtrCA
        v0T38/NgNouAqsSeM6vYQWxeAUuJzxOes0LYghInZz5hAbGZBeQltr+dwwxxkYLEz6fLoJa5
        SWycO4kVokZEYnZnGzPIYgmBAxwSzz+tYIFocJG4cWkd1DvCEq+Ob2GHsKUkPr/bywZhF0ss
        nfWJCaK5gVHi8rZfUAljiVnP2hlBoccM9MH6XfqQgFSWOHIL6jY+iY7Df9khwrwSHW1CEI3q
        Ege2T4e6QFaie85n1gmMSrOQfDYLyWezkHwwC2HXAkaWVYxiqQXFuempxUYFxvDITs7P3cQI
        Trta7jsYZ7z9oHeIkYmD8RCjBAezkgjvwjM7k4R4UxIrq1KL8uOLSnNSiw8xmgLDeiKzlGhy
        PjDx55XEG5pYGpiYmRmaG5kamCuJ83qlbEgUEkhPLEnNTk0tSC2C6WPi4JRqYNK6aPTVZW+H
        kZju4k0He1+av9zH2CH/pfygurYxi9R3trO1HEJ/KheIy28+dU1wOe+qpDlmSimnNeM+vWnd
        XL3zNEda45kPy0z+fY71nX9K409td2H2/3afmJI3tnILD3xRKrL1yby8qrRianzq6g+dbw+k
        7mlffuLV27fy1WqSSjNvCZ4ytFVM59c89bD3wg49gz06/+Q4Iw36ExiFbLf9Kfy89HCMdnlb
        EkuwXdcHPpkIgUvbzJ5tnLD0WItnnnDV4s1/eRqrHH/L+RTLaCkezGLfxfJwZcrOZyc+cuRa
        t7xbuLBpx2p/gfrglLTMC2uOrd1ctsjuY90kmf2SubzFz6ceflhV9lRmot2MxUosxRmJhlrM
        RcWJAFEDw1JEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSnK72/11JBv37rCwezNvGZtG8eD2b
        xY6GI6wW7+bKWOx9vZXdYtPja6wWM87vY7I4s7iX3eL0tQXsFue3+TtweVxfF+CxaVUnm8ed
        a3vYPPbPXcPusXlJvcfiZTvZPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugStj8eb5bAXT+Sp6
        3jxhaWCcwt3FyMkhIWAi8enUXsYuRi4OIYHdjBKzL7eyQCRkJZ6928EOYQtL3G85wgpR9IxR
        Yu+x04wgCTYBfYmXHdtYQWwRgWKJSzd/gzUwC1xjkph9NQ2i4T6jxNc705lAEpwCmhLrTq1m
        A7GFBXwl1t18DLaNRUBVYs+ZVWDNvAKWEp8nPGeFsAUlTs58AlTDATRUT6JtIyPEfHmJ7W/n
        MEMcpyDx8+kyqBvcJDbOncQKUSMiMbuzjXkCo/AsJJNmIUyahWTSLCQdCxhZVjFKphYU56bn
        FhsWGOallusVJ+YWl+al6yXn525iBEegluYOxu2rPugdYmTiYDzEKMHBrCTCu/DMziQh3pTE
        yqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamHZ+EWvPtDgQfdfe
        4in33nDTC1LrYtUKDK52ZE7fdCh59qz1mkbxmzXNNaoO+70+Osc9JKw2rqo9cYvo1hUGwkZP
        3xuePeF4yuuNW/7ixZuLmPN2ZHdlPstatD4nLbvKaLpJGd+nV+n2HTUTXv6Z+bGNcbuZQqPV
        yidBT1p+yXG5Zb+8Hu5X4L5ez+LEVVPTEFlljzUn+/jmmGXtLHqsMjWa84f+3/xrHosXT1CM
        CdL7c8qU4/vu09Lt8b7L76/LDXzNsmbTkZUuX6dfSZEoWL9y2/ty3yNJlzyTNhT1W07b/S1F
        TrXiZdmhqQuOq8wOUHpicIPhWG53pdWU27+KrthwXP4fZ/j223HV97+mBSmxFGckGmoxFxUn
        AgDTkGWzLwMAAA==
X-CMS-MailID: 20220628131628epcas2p35f053286613b6f15aa1666ee4a9c07f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627071726epcas2p476cfa45f74a73bfd0fcfe03eacc2df60
References: <CGME20220627071726epcas2p476cfa45f74a73bfd0fcfe03eacc2df60@epcas2p4.samsung.com>
        <20220627071512.18180-1-chanho61.park@samsung.com>
        <2efd725f-3d99-c1df-23ce-9ee60bbe4600@linaro.org>
        <YrmZ8ikVsnAGrBXF@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> Subject: Re: [PATCH] tty: serial: samsung_tty: support more than 4 uart
> ports
> 
> On Mon, Jun 27, 2022 at 12:33:51PM +0200, Krzysztof Kozlowski wrote:
> > On 27/06/2022 09:15, Chanho Park wrote:
> > > Regarding Exynos Auto v9 SoC, it supports uarts up to 12. However,
> > > the maximum number of the ports has been derived from
> > > CONFIG_SERIAL_SAMSUNG_UARTS and tightly coupled with the config for
> > > previous Samsung SoCs such as s3c24xx and s3c64xx. To overcome this
> > > limitation, this changes the usage of the definition to UART_NR
> > > which is widely used from other serial drivers. This also defines
> > > the value to 12 only for ARM64 SoCs to not affect the change to
> previous arm32 SoCs.
> > > Instead of enumerating all the ports as predefined arrays, this
> > > introduces s3c24xx_serial_init_port_default that is initializing the
> > > structure as default value.
> > > Regarding the ports which are greater than 4 will be initialized as
> > > default value and the fifo size will be retrieved from the DT
> > > property.
> >
> > You need to explain why you are doing this.
> >
> > It's confusing to initialize some statically and some dynamically.
> 
> I agree, why not just make them all dynamic?

I thought it was the easiest way for me to expand the number of ports
without many changes :)
I'm looking around all other drivers how they initialize the ports.
I couldn't find any drivers who initializes the port dynamically. I think
they need to assign .nr of struct uart driver so they don't need to allocate
the ports dynamically.

static struct uart_driver s3c24xx_uart_drv = {
	.nr             = UART_NR,

I'll try to convert the initialization dynamically but I'm not convinced
whether it can be possible.

Best Regards,
Chanho Park


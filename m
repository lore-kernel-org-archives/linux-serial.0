Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC4C43334
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 04:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbiF1Et0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiF1EtW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 00:49:22 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B606DFB0
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 21:49:21 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220628044919epoutp01a1a27279c0148b8745a36ae828b235f6~8r4dzNIPU0386103861epoutp01w
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 04:49:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220628044919epoutp01a1a27279c0148b8745a36ae828b235f6~8r4dzNIPU0386103861epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656391759;
        bh=tZRp1hr3OFlZPK5x7ruDFuXqjTpo0F7nxmEQoiwRIHI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=lm8/7P0AbDJktrwmY2u/E/QoFcKTX4PtkzQ2dh++EzeI7CavCxazLJLGuzVTENK4C
         IfG7g1ZbhQGrs2fEPGw8GcaCmaVx7HhYYQWUEfRMl2LSaPK5HvkkF1ANFMX4K7c0c/
         qvKhgOs7Y+r1Vl0EVJWZYQjbMuQEhKdOQnEOyAyY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220628044918epcas2p23930818c9d81a11f9aa951d7a2efb33e~8r4dNASLi2237222372epcas2p2L;
        Tue, 28 Jun 2022 04:49:18 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LXBvf0lLtz4x9Q5; Tue, 28 Jun
        2022 04:49:18 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.BA.09666.D488AB26; Tue, 28 Jun 2022 13:49:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220628044917epcas2p2db5484962f321045e11c11324c332ecd~8r4cQtP4k2237222372epcas2p2I;
        Tue, 28 Jun 2022 04:49:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220628044917epsmtrp16a5ca19576c0708f4552c771faecdef3~8r4cP0o-w2400824008epsmtrp1G;
        Tue, 28 Jun 2022 04:49:17 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-bc-62ba884d734d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.F0.08905.D488AB26; Tue, 28 Jun 2022 13:49:17 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220628044917epsmtip2231c645d97c808fa1e2af69949b9bee5~8r4cFUYKK1361413614epsmtip2K;
        Tue, 28 Jun 2022 04:49:17 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Jiri Slaby'" <jirislaby@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Hector Martin'" <marcan@marcan.st>,
        "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'Vincent Whitchurch'" <vincent.whitchurch@axis.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <Yrmk+/2CqrBXcqAT@kroah.com>
Subject: RE: [PATCH] tty: serial: samsung_tty: loopback mode support
Date:   Tue, 28 Jun 2022 13:49:17 +0900
Message-ID: <004501d88aaa$6c6150a0$4523f1e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIYBiAk/1BqxfP9MIgOSKejVHmFRAK1rqSQAXkXugesw9FWEA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmqa5fx64kg9NtzBYP5m1js2hevJ7N
        YkfDEVaLd3NlLPa+3spusenxNVaLGef3MVmcWdzLbnH62gJ2i/Pb/B24PK6vC/DYtKqTzePO
        tT1sHvvnrmH32Lyk3mPxsp1sHn1bVjF6fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8c
        b2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SgkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
        KbUgJafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7484q4YKfXBUrdn9kbmB8wNHFyMkhIWAi
        sXLjQvYuRi4OIYEdjBK7P/xnhnA+MUo8PL+OBcL5BuTc/cEO07K4dR0jRGIvo8SinzPYIJwX
        QFUN/UwgVWwC+hIvO7axgtgiAuYScx8eB1vCLNDDLLFh2xNGkASngKbExoufwGxhAReJmZeu
        gzWzCKhKTD+4B2wdr4ClxNVJK1ghbEGJkzOfsIDYzALyEtvfzmGGOElB4ufTZVDLnCSmTprE
        DFEjIjG7sw3sIQmBIxwS3f9PsEI0uEg8+H6dEcIWlnh1fAvUb1ISL/vboOxiiaWzPjFBNDcw
        Slze9osNImEsMetZO1AzB9AGTYn1u/RBTAkBZYkjt6Bu45PoOPyXHSLMK9HRJgTRqC5xYPt0
        FghbVqJ7zmfWCYxKs5B8NgvJZ7OQfDALYdcCRpZVjGKpBcW56anFRgWG8NhOzs/dxAhOvFqu
        Oxgnv/2gd4iRiYPxEKMEB7OSCO/CMzuThHhTEiurUovy44tKc1KLDzGaAsN6IrOUaHI+MPXn
        lcQbmlgamJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgarln4la6bAqj9vy7
        XT0F9kc840PmH3gvcPr1uZ/NCf8XPDtxiDMt48+Xq0+WTM76sdVV5VBy8IVFt8KLTav7ojNO
        n7kVzBM1S/6J8uGsw2cP3Vm4hDl6vrD//8rOnwWzuvSmFmplzDF+8mVl08+zRn/TbbKcVY4y
        Xiw6bB+atrneIihs09v3ErqbvCT6cutyou93vX2qc+pE35ozPc/9HL7X/HjTvcD+zpKLn/YJ
        SaSssZC997m8+NjhcKVtjzcuEbTgDHs2UYhvUUx736mV60+cuL8r+RWHt/OvaOvkS+8SStyu
        MnZWbZH6eDk4WMPyT8W6Pqs3S91Cj4Y/edBbulpucq6LU3JB9hEvVRHTG0osxRmJhlrMRcWJ
        AMsd5upFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSvK5vx64kgxPLFCwezNvGZtG8eD2b
        xY6GI6wW7+bKWOx9vZXdYtPja6wWM87vY7I4s7iX3eL0tQXsFue3+TtweVxfF+CxaVUnm8ed
        a3vYPPbPXcPusXlJvcfiZTvZPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugSvjzirhgp9cFSt2
        f2RuYHzA0cXIySEhYCKxuHUdYxcjF4eQwG5GiYsPjrJAJGQlnr3bwQ5hC0vcbznCClH0jFFi
        2a73TCAJNgF9iZcd21hBbBEBc4m5D4+zgxQxC0xiljj66TITRMcaRolfk6axgVRxCmhKbLz4
        iRHEFhZwkZh56TrYJBYBVYnpB/eAreMVsJS4OmkFK4QtKHFy5hOgkziApupJtG0Ea2UWkJfY
        /nYOM8R1ChI/ny6DOsJJYuqkScwQNSISszvbmCcwCs9CMmkWwqRZSCbNQtKxgJFlFaNkakFx
        bnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcARqae5g3L7qg94hRiYOxkOMEhzMSiK8C8/sTBLi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBafPWitta52Y8
        uHzy2Qezs3eurgj6uPbVsiUpLL8kDzhdqRF1qrzF8OP5ughVD7kplxMfH418mL7F5Hi/bMiG
        z5V30m3nXIzzsOfs7nn0NahR0W3rE+v6+MVbvgaeCVr4MMy+UHN1+ssupmefWfdZaDJ3nr89
        fSuDOSffgu1x0VkH47iUOURSz/MLrf1aUl8ucrNrNs+WBVF7OliXmgcftVDrf9CrdSB7/fWN
        eUyzHMK9/n6133jwxZkLFX9lFL7q7961quA148qqeZP6j043+Lhmy92M8j9L/jZfv/5u5rwH
        wqEtj1WaXXzSrCT0dGPDlRZ7u+VGyP/YpL7jNI/EvA9i/Gl/Y7ctzt1/59SxDf+UWIozEg21
        mIuKEwFXJxzgLwMAAA==
X-CMS-MailID: 20220628044917epcas2p2db5484962f321045e11c11324c332ecd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627032556epcas2p26c2cd2786888a5018607bf651bc5dec0
References: <CGME20220627032556epcas2p26c2cd2786888a5018607bf651bc5dec0@epcas2p2.samsung.com>
        <20220627032353.8868-1-chanho61.park@samsung.com>
        <Yrmk+/2CqrBXcqAT@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> Subject: Re: [PATCH] tty: serial: samsung_tty: loopback mode support
> 
> On Mon, Jun 27, 2022 at 12:23:53PM +0900, Chanho Park wrote:
> > Internal loopback mode can be supported by setting
> > S3C2443_UCON_LOOPBACK bit. The mode & bit can be supported since
> > s3c2410 and later SoCs. We can test it by linux-serial-test program[1]
> > with -k option. It will set TIOCM_LOOP mode during test.
> >
> > -k, --loopback     Use internal hardware loop back
> 
> I do not understand this line in the changelog text, what is it for?

Ah. I'd like to show the option of linux-serial-test tool how we can test
it.

> 
> >
> > [1]:
> > https://protect2.fireeye.com/v1/url?k=a0d4e46c-c15ff149-a0d56f23-74fe4
> > 85cbff6-c2c20e5c0d4f5c92&q=1&e=7c91006c-af87-4dad-8069-360450d31b36&u=
> > https%3A%2F%2Fgithub.com%2Fcbrake%2Flinux-serial-test
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> 
> Our tools require a blank line before the signed-off-by line.  Did you not
> get a warning when checking this patch before sending it out?

I'm able to see below warning. I'll fix it. Thanks.

WARNING: Do not use whitespace before Signed-off-by:

#15:

> 
> Also, no need for a footnote in a changelog that is so short, just put the
> link in the body of the text itself.

Okay. I'll put the link in the body instead of the footnote.

Best Regards,
Chanho Park


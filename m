Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F1FC43334
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 11:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbiF1LzV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 07:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343940AbiF1LzT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 07:55:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8075F31228
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 04:55:17 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220628115515epoutp0261f9974a4390ec7665e60cade80f500c~8xsW5gCTx1259812598epoutp02R
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 11:55:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220628115515epoutp0261f9974a4390ec7665e60cade80f500c~8xsW5gCTx1259812598epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656417315;
        bh=i6YODiJmY3k0rS6SbrmdfnttwEjx62o5iv4NgsN9cXc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DrjO/Dfiq7HPPcN6qSKFtnsKZvmYB85HEH2+Q/wBj9QKwaAgI5ble/VKrVS28GwX0
         e4GwJj7cYXV7Lq+Gssr0M4wZGfDVYm7rD+9GrBTo42xbiGKwHR82LsvSMR3+gLtyIC
         CQgZaVtG4k/04F2YaL2UfIbhLYU+rBWEhs1qEDM0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220628115514epcas2p3c6090e8b9af804b638f23440c7d14664~8xsWYj4Po3114331143epcas2p3d;
        Tue, 28 Jun 2022 11:55:14 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LXNM64ZDkz4x9Q2; Tue, 28 Jun
        2022 11:55:14 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.E3.09650.22CEAB26; Tue, 28 Jun 2022 20:55:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220628115514epcas2p111c656393c313ee2245d195679486678~8xsVhoCsm2065020650epcas2p1B;
        Tue, 28 Jun 2022 11:55:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220628115513epsmtrp2e2013bcb374c8db4882c27e8e817b00c~8xsVgCPFk1577615776epsmtrp2p;
        Tue, 28 Jun 2022 11:55:13 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-72-62baec225712
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.4D.08802.12CEAB26; Tue, 28 Jun 2022 20:55:13 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220628115513epsmtip1f6e0dfd2598291da22a1130ff88b5672~8xsVRc7DA2553225532epsmtip1W;
        Tue, 28 Jun 2022 11:55:13 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     =?ISO-8859-1?Q?'Ilpo_J=E4rvinen'?= <ilpo.jarvinen@linux.intel.com>
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
In-Reply-To: <ab327a8f-f520-ad85-c0fc-1e505647164c@linux.intel.com>
Subject: RE: [PATCH] tty: serial: samsung_tty: loopback mode support
Date:   Tue, 28 Jun 2022 20:55:13 +0900
Message-ID: <018601d88ae5$ed2af930$c780eb90$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIYBiAk/1BqxfP9MIgOSKejVHmFRAK1rqSQAVoU74OsxTEdMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmma7Sm11JBt9uKlg8mLeNzaJ58Xo2
        i84dPSwWOxqOsFq8mytjsff1VnaLTY+vsVrMOL+PyeLM4l52i9PXFrBbnN/m78DtcX1dgMem
        VZ1sHneu7WHzmHcy0GP/3DXsHpuX1HssXraTzaNvyypGj8+b5AI4o7JtMlITU1KLFFLzkvNT
        MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVVIoS8wpBQoFJBYXK+nb2RTl
        l5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ3zveMZecJq9ormvka2B
        sYWti5GTQ0LAROLFioOMILaQwA5Gifs7ZboYuYDsT4wST6adZoRwPjNKfLp0G67j+K11TBCJ
        XYwSjz5MZINwXjBKLO7czwpSxSagL/GyYxuYLSLgJtH+rJEdpIhZ4AqzxLcDR9hBEpwCzhLz
        5/wHs4UFXCRmXroONJaDg0VAVWJruytImFfAUuL1i9WMELagxMmZT1hAbGYBPYkpV1sYIWx5
        ie1v5zBDXKcg8fPpMlaQMSICThKTN8dAlIhIzO5sYwY5QULgAodE8+O57BD1LhKtO/uhPhOW
        eHV8C1RcSuLzu71Q8WKJpbM+MUE0NzBKXN72CyphLDHrWTsjyDIJAWWJI7egbuOT6Dj8lx0i
        zCvR0SYEUa0ucWD7dBYIW1aie85n1gmMSrOQfDYLyWezkHw2C8kLCxhZVjGKpRYU56anFhsV
        GMFjOzk/dxMjOBVrue1gnPL2g94hRiYOxkOMEhzMSiK8C8/sTBLiTUmsrEotyo8vKs1JLT7E
        aAoM64nMUqLJ+cBskFcSb2hiaWBiZmZobmRqYK4kzuuVsiFRSCA9sSQ1OzW1ILUIpo+Jg1Oq
        gck+qzIqOPN5u9uShgvXZeYE80r/u2W/7Ozf1M2H7/meP5v4S+PGK/l986Y65DsLzrhXxdz7
        b4qWiF7JVLWpYdJzRIsYE+5tENkepTwtfG+L3vG5TExmkb7Za+8GZOZncZ7j/BwtpjIz1nnv
        UcGH+xpXL9+/ZRHnSfMir367OcedmnPS8huKFW4HpzzJuWC7/vLuBbHNAd5y1y8XnFE6HBiz
        3eT4iShlQ9X+5EMqLYfX8vAJWT59fsM7PmB5t49Ek/Wb0J6631Nrr8qnfE9cx33u7YwT/7dv
        Cs1dxmF0M2V6x0/V801fjFl8upVeu9hbhDfM7ReK+fm5tzgqYXL4hG89akxxf89dmn/+5wzX
        f0osxRmJhlrMRcWJANPrMohOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSnK7im11JBgc7zCwezNvGZtG8eD2b
        ReeOHhaLHQ1HWC3ezZWx2Pt6K7vFpsfXWC1mnN/HZHFmcS+7xelrC9gtzm/zd+D2uL4uwGPT
        qk42jzvX9rB5zDsZ6LF/7hp2j81L6j0WL9vJ5tG3ZRWjx+dNcgGcUVw2Kak5mWWpRfp2CVwZ
        3zuesRecZq9o7mtka2BsYeti5OSQEDCROH5rHVMXIxeHkMAORolDx2YxQiRkJZ6928EOYQtL
        3G85wgpR9IxRYuO8aSwgCTYBfYmXHdtYQWwRATeJ9meN7CBFzAK3mCV+3/zCDNFxjFHi8qSl
        YPs4BZwl5s/5DzZWWMBFYual60C7OThYBFQltra7goR5BSwlXr9YzQhhC0qcnPkEbBmzgIHE
        tlP/2CFseYntb+cwQ1ynIPHz6TJWkDEiAk4SkzfHQJSISMzubGOewCg8C8mkWUgmzUIyaRaS
        lgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKjUktrB+OeVR/0DjEycTAeYpTg
        YFYS4V14ZmeSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxS
        DUwt54N3Rr2L3uStGOZ/KabR5utLttgHN49c4a46erDkVk72sz8Lymfkz+DJEuW5vnu/Z+PB
        5KMbp5lr3T67LkeHrZfRpML7W0/4/gsac4wL/n2MmeB4Y90PtuOrQ/XXPGxWbUyxyXT5wu89
        d+PPwtOTOcU0mFdG3LbecmLn5Ltz9lsz3tI4qi/PwM7ndLzow9llrz0LUxoX/9D4WLes+plG
        ldZaq9NrvJ0ZMib5r5ga/uPD3MvnlI4sueAyb4Vnx1Yj78cP+1nUuw4VavvMijx0aa/1O7Xs
        d+pLq1WKDn5y/7Bp4ZEjSka+iYdqXWs3mE1POjHDeWbT+mOrFJ37f9QzRSpL1U3qcZ17M1ss
        dH+MEktxRqKhFnNRcSIAR4XWMzkDAAA=
X-CMS-MailID: 20220628115514epcas2p111c656393c313ee2245d195679486678
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627032556epcas2p26c2cd2786888a5018607bf651bc5dec0
References: <CGME20220627032556epcas2p26c2cd2786888a5018607bf651bc5dec0@epcas2p2.samsung.com>
        <20220627032353.8868-1-chanho61.park@samsung.com>
        <ab327a8f-f520-ad85-c0fc-1e505647164c@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> Subject: Re: [PATCH] tty: serial: samsung_tty: loopback mode support
> 
> On Mon, 27 Jun 2022, Chanho Park wrote:
> 
> > Internal loopback mode can be supported by setting
> > S3C2443_UCON_LOOPBACK bit. The mode & bit can be supported since
> > s3c2410 and later SoCs.
> 
> In that case, why is the  LOOPBACK define named 2443 and not 2410???

It might be copied from mach-s3c24xx.

> 
> The change looks fine otherwise.
> 
> I note though that many of the current drivers won't return TOICM_LOOP
> from ->get_mctrl() but I don't think it's exactly wrong to return it
> either. Perhaps lack of returning it is due to Documentation/driver-
> api/serial/driver.rst not including TOICM_LOOP in get_mctrl's list of
> information but only in set_mctrl's one.

According to the description, TIOCM_LOOP bit might be used only for setting.
I'll drop the bit manipulation from get_mctrl callback.
Thanks for the heads up.

Best Regards,
Chanho Park


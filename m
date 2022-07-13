Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BADC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 13 Jul 2022 00:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiGMABU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 20:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGMABT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 20:01:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB623C920B
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 17:01:15 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220713000113epoutp02aee481167f93edaa5d9e032acff7b368~BOoNqs0yN1950519505epoutp02L
        for <linux-serial@vger.kernel.org>; Wed, 13 Jul 2022 00:01:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220713000113epoutp02aee481167f93edaa5d9e032acff7b368~BOoNqs0yN1950519505epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657670473;
        bh=vvfbUrbE2gEhgu5/oYnl8z9mZHtlxJEMCza3szvcnkM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MSsnaTnjOUgoZigTfcSCfHlge07gPMtChwgasf9Iu9xubpFqEslA4lSSNRx/5V0j4
         hZd1eUMUqAmeojBVX4ElrFTz+Zw/fwjqtGs5CZL5R/KFiuZ1ICVughFA/Jq8yqhRJ4
         iUP76qSosS2psjm5pZtlBWwTOtvlwouJ+/cVpgIs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220713000113epcas2p42fea1d7e667da2ebcb43ff97dc03dd4d~BOoNW084t0254502545epcas2p4G;
        Wed, 13 Jul 2022 00:01:13 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LjHpK2D81z4x9Q1; Wed, 13 Jul
        2022 00:01:13 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.6A.09662.94B0EC26; Wed, 13 Jul 2022 09:01:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220713000112epcas2p2e2d361b9edd840c280e8e1613f794bde~BOoMweBYG1714617146epcas2p2Y;
        Wed, 13 Jul 2022 00:01:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220713000112epsmtrp1cd1f6440d0c448a4d001a2fa0a7a6292~BOoMvqfuk2244122441epsmtrp1p;
        Wed, 13 Jul 2022 00:01:12 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-0e-62ce0b499c39
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.F7.08802.84B0EC26; Wed, 13 Jul 2022 09:01:12 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220713000112epsmtip14add4b8f43a0aa6d1b673794fb2cd49b~BOoMk2Z4Z0602606026epsmtip1T;
        Wed, 13 Jul 2022 00:01:12 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <linux-serial@vger.kernel.org>
Cc:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
In-Reply-To: <20220712140745.30362-1-m.szyprowski@samsung.com>
Subject: RE: [PATCH] tty: serial: samsung_tty: fix
 s3c24xx_serial_set_mctrl()
Date:   Wed, 13 Jul 2022 09:01:12 +0900
Message-ID: <01e501d8964b$aa1cfe10$fe56fa30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHlth+Ozq6Xf3CjQkkpPE5AQ9tvlAFgG/v1rVYo3QA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdljTVNeT+1ySwb1b/BYP5m1js2hevJ7N
        Yu/rrewWM87vY7I4s7iX3WLtkbvsDmwed67tYfPYP3cNu0ffllWMHp83yQWwRGXbZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
        K+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ2xv+clUMJml
        ovPyBcYGxt3MXYycHBICJhI3Zr1g7GLk4hAS2MEo8eTGVVYI5xOjxNJDXYwgVUICnxkl3l2R
        gul4cv8vC0TRLkaJR1N3MkE4Lxgl1v/8DtbBJqAv8bJjGyuILSJQJfFmfhMzSBGzwAJGifYr
        i9hBEpwCdhKbf85jArGFBfwlbjyaABZnEVCVePlsN9ggXgFLie61B5ghbEGJkzOfsIDYzALy
        EtvfzoF6QkHi59NlrBBxEYnZnW3MEIutJK6cfMIOslhCoJVD4vmsPVANLhLLF86EsoUlXh3f
        wg5hS0m87G+Dsoslls76xATR3MAocXnbLzaIhLHErGftQNdxAG3TlFi/Sx/ElBBQljhyC+o2
        PomOw3/ZIcK8Eh1tQhCN6hIHtk9ngbBlJbrnfGadwKg0C8lns5B8NgvJN7MQdi1gZFnFKJZa
        UJybnlpsVGACj+3k/NxNjOCEqeWxg3H22w96hxiZOBgPMUpwMCuJ8P45eypJiDclsbIqtSg/
        vqg0J7X4EKMpMKwnMkuJJucDU3ZeSbyhiaWBiZmZobmRqYG5kjivV8qGRCGB9MSS1OzU1ILU
        Ipg+Jg5OqQam2hkHBA0eyGT/sE4JPn3xfpbEpvd70nckx7mwvbOqtxd+cn3WloVFk/493yr1
        Xs/gBOshJSVhRmlO0fZLWz0C4x5Z1L06fd2606dh+yM9AS2zisO2BtdPdNh8280wgUWp+XpU
        XvXn24cm7GwWMLq+7bRzjvG/Ok2bc7yyJ/JU7jhKzss93vngPWt8V9rjGwLZb3ZcSZMpzlj+
        a5Wy2L/I/2F2raHLv810yMz7WdA1y3HBIjvXuDm3vy6a+4g33C5sQ99sm4WC0y9kVUtt3eIv
        q28adUJ7lszkvMAlazNuGKut5mHe7l/tpGz9/JSfQev9E0GfLp/dcHjNjOWPJhsckFqrkXe8
        a07yum3PezqDlFiKMxINtZiLihMB9n1mmiEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSnK4H97kkg8Z9phYP5m1js2hevJ7N
        Yu/rrewWM87vY7I4s7iX3WLtkbvsDmwed67tYfPYP3cNu0ffllWMHp83yQWwRHHZpKTmZJal
        FunbJXBlbG/5yVQwmaWi8/IFxgbG3cxdjJwcEgImEk/u/2XpYuTiEBLYwSjR29vHApGQlXj2
        bgc7hC0scb/lCCtE0TNGiZ1rW9hAEmwC+hIvO7axgtgiAjUS33dPA5vELLCAUeLF441QHf2M
        Ehv6PoKN5RSwk9j8cx4TiC0s4CsxedZRRhCbRUBV4uWz3WA2r4ClRPfaA8wQtqDEyZlPwHqZ
        BbQleh+2MkLY8hLb386B+kFB4ufTZawQcRGJ2Z1tzBAXWUlcOfmEfQKj8Cwko2YhGTULyahZ
        SNoXMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjh8trR2Me1Z90DvEyMTBeIhR
        goNZSYT3z9lTSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFw
        SjUwtceHc1zI613ger6J812Pimxpjsr835emtb2fweqhvsj6pwvvp0vXOBvlZNfl22lw1R6X
        3Rt76tLLH71ue5fPs551amXP3a2+YntWz4rZ2ahvcDZrN8tnttD4188uTLdg/6tQfWy6735X
        LbHkj6kHnkzeYFIqsdFivVb8ht+Xj7EGZJkmG8ypMOxL1Dio/PZ7/7J24RcnL4hOXqIYx7v0
        TMD/KTrzay5J+k5db3lrVt6kyXFlUQ2SaSfm9Abyxr84brom6uIn3Tkyxh2/n2e+Lw+yvu11
        T7d52rHKsxOfSscUzPiT6+judGhav9fBrjkFIsZHPkb4Tpn7a2fHoz+PQ4uOcNgosM1LMEh7
        5XHyoxJLcUaioRZzUXEiAAUTWrMOAwAA
X-CMS-MailID: 20220713000112epcas2p2e2d361b9edd840c280e8e1613f794bde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220712140800eucas1p29b2518142084bcff075b0f47c1ddc7aa
References: <CGME20220712140800eucas1p29b2518142084bcff075b0f47c1ddc7aa@eucas1p2.samsung.com>
        <20220712140745.30362-1-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> Subject: [PATCH] tty: serial: samsung_tty: fix s3c24xx_serial_set_mctrl()
> 
> S3C2410_UCON is a 32bit register, so it must be read with rd_regl()
> instead of rd_reg(), otherwise the upper bits will be zeroed. Fix this.
> 
> Fixes: 72a43046b61a ("tty: serial: samsung_tty: loopback mode support")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for the fix.

Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park


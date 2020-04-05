Return-Path: <SRS0=ea9B=5V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE133C2BA2B
	for <linux-serial@archiver.kernel.org>; Sun,  5 Apr 2020 21:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F9020678
	for <linux-serial@archiver.kernel.org>; Sun,  5 Apr 2020 21:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ar9lKVzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgDEVfw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Apr 2020 17:35:52 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:59837 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgDEVfw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Apr 2020 17:35:52 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200405213549epoutp01ae4c22f9ef22a70110324337497d3408~DCg44Fghm0101901019epoutp013
        for <linux-serial@vger.kernel.org>; Sun,  5 Apr 2020 21:35:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200405213549epoutp01ae4c22f9ef22a70110324337497d3408~DCg44Fghm0101901019epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586122549;
        bh=i4vDl0Hq3BadisnXS91ugHfkfG645fsLl4N8xWDFYfA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Ar9lKVzNmZCujUDtf3yx5K4/e9BjGxWYv0k1roFUHOH6KKULyl0weqWNJshAvF8KX
         Qu9oklbk17VeQZ1EQYMB/JnhDMSCs+EwkgMT54aIXPB5Gn8NSvt9AyK4x7i4Z3axTf
         9leNGOBechMk0sz3mtET+Nuz4OuejqSeb7JwKyKs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20200405213549epcas2p4c8154f647d5cca48f32150472daa630e~DCg4SRbg00810308103epcas2p4x;
        Sun,  5 Apr 2020 21:35:49 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.186]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48wRmg3FBpzMqYkV; Sun,  5 Apr
        2020 21:35:47 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.3D.04647.33F4A8E5; Mon,  6 Apr 2020 06:35:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20200405213546epcas2p33180adeb5ca7a933755e5d290e13cd25~DCg2Dex6i2827528275epcas2p3Y;
        Sun,  5 Apr 2020 21:35:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200405213546epsmtrp2dbe549086a478e8ad6b9214d48dc506c~DCg2CzzvC2052320523epsmtrp2F;
        Sun,  5 Apr 2020 21:35:46 +0000 (GMT)
X-AuditID: b6c32a48-8a5ff70000001227-de-5e8a4f337b37
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.C3.04024.23F4A8E5; Mon,  6 Apr 2020 06:35:46 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.165.196]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200405213546epsmtip29db29707265742024ff01036a0c82734~DCg105_NF0764407644epsmtip2H;
        Sun,  5 Apr 2020 21:35:46 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     <gregkh@linuxfoundation.org>, "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jiri Slaby'" <jslaby@suse.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403115941.GB29484@kozik-lap>
Subject: RE: [PATCH v4] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Mon, 6 Apr 2020 06:35:46 +0900
Message-ID: <000001d60b92$2adaee50$8090caf0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKEs4Y1dkf1SYeuuA/6Ie9wROds5QHXsprVAbJLbnoB5/iuVKbiKywg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHObvbvVdrcZtWP0aPcQvpgbpZW9fQHlSySEiyoCxcN3dTaS92
        p2T/aFSmQ0lLwraKaj1UJHWWDU2rWUkYrZKiB0Rk62EU5lAyet3rXeR/n/M73+/5/b7nHBJT
        NeBqstDm4pw21kLjsfKO3kX6xKWb3LnaG9eBOehrwZm61mEZc3TwM8aEQq0E4x98pmAGOk/h
        TH2oR8Y88FUTq0mjv6kSN9483UwY2y+UGluuPpUbI/65WYocS1oBx5o5p4az5dnNhbb8dHpj
        tmmtSW/Q6hJ1qcxyWmNjrVw6vS4zKzGj0CKMQmuKWUuRUMpieZ5OXpnmtBe5OE2BnXel05zD
        bHHodI4knrXyRbb8pDy7dYVOq03RC8pdloK2PxcIxxCxr6rrEV6GTuBuFEMCtQx8t6tlbhRL
        qqgAgvbyY9HFCIJfr0aRtBhD0HUlovhn6X/zFpc2uhF8qO+eOEtFfULQWJsgMk4lwoDvnUzk
        eIHbn18mRANGfUfQM/ZQOIkkY6hkGAxuETVx1Gbw1v2c0MupBfB4JCATJUoqFVr6TGJZSU2H
        +yffyUXGqHlw/cspTJpHA+PhSwqpVQZErpVjkiYevJUixwqaCA5u71g08zqo6QkhieNgqO8q
        IbEaIl+7o5pS6CmvJSRzFYLx4XA0/VLwvD+CxOEwahG0dCaLCNR8uPMyOts0qOj9RUhlJVSU
        qyRjAlwZ+yiTeDY0hzuJGkR7JiXzTErmmZTA87/XWSRvQjM5B2/N5/gUx7LJb+1HE790sTGA
        bj3MDCKKRPRUZcPzylyVgi3mS6xBBCRGxyvV1UJJaWZL9nNOu8lZZOH4INIL916LqWfk2YU/
        b3OZdPoUg0Gbqmf0hhSGnqX0T3mxU0Xlsy5uL8c5OOc/n4yMUZehXUk/PHJvxo++8dCSVQPN
        Fzv21MebP4a3Bzbk5hz6drzNOH9b/86Ou9tUel96Wb07OBqzf73XmXd4zpLu/t57A+feXgzs
        Vj06HITzGWfkNYYky4HkWTk7dvviqn5f4+5ScV1DddMaK8LrWeMzf41jz8uchausT15nE9qt
        r2RrRu5oaTlfwOoWY06e/Qs32cncuwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvK6Rf1ecwe8P+hbNi9ezWUzZ8IHJ
        ov/xa2aL8+c3sFtsenyN1eLyrjlsFjPO72OyOLO4l92Bw2PTqk42j/1z17B7bF5S77F+y1UW
        j8+b5AJYo7hsUlJzMstSi/TtErgyNv5fwl7wir2iZ/cFtgbGaWxdjJwcEgImEqcfPAKzhQR2
        M0rsemELEZeRmPBiCTOELSxxv+UIaxcjF1DNc0aJZ+8eMoIk2AR0JS4vfsIEYosA2ZtvLGcH
        KWIW+Mco0fz2DjNExxNGif37lrB0MXJwcAroSzw+FALSICwQILFoxVGwDSwCKhIXP+1gAinh
        FbCUWH88HiTMKyAocXLmExYQm1lAW+LpzadQtrzE9rdzoI5TkPj5dBkrxA1uEp+3tjFD1IhI
        zO5sY57AKDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcx
        gqNKS3MH4+Ul8YcYBTgYlXh4GW53xgmxJpYVV+YeYpTgYFYS4ZXqBQrxpiRWVqUW5ccXleak
        Fh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXA6Pv2lsiGFbYqjx9fELUxum+7Z/nS
        BPe7MU67lnm6xF6SPewtHft0Yr3PgSadlx+OLkg+syhG9Uex4bFvZ4JOX1vfepallc3lS++i
        jJ7Aec6BS9SWT5E6dKy1Jjz+k//Ny3sVpJ7WFy7by6C9eUElw0n7qsI6C/n0+ttfrte2nfBl
        /Cli902kQ4mlOCPRUIu5qDgRAM7DlaumAgAA
X-CMS-MailID: 20200405213546epcas2p33180adeb5ca7a933755e5d290e13cd25
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
        <CGME20200403111520epcas2p42ef81138693ffaaa281499c7a24e0e48@epcas2p4.samsung.com>
        <20200403111511.10598-1-hyunki00.koo@samsung.com>
        <20200403115941.GB29484@kozik-lap>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 03, 2020 at 9:00: 10PM +0900, Krzysztof Kozlowski wrote:
> On Fri, Apr 03, 2020 at 08:15:10PM +0900, Hyunki Koo wrote:
> > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> >
> > This is required for some newer SoCs.
> >
> > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > ---
> > v2:
> > line 954 : change rd_regl to rd_reg in for backward compatibility.
> 
> I did not see any change around line 954 in v1... so what was it?
954  line  is changed like below.
V1 : rd_regb --> rd_regl : we thought, this register need to change to 
V2: rd_regl --> rd_reg : we discuss internally, and 
I decided not to change  to existing devices for backward compatibility.
So we changed to rd_reg.
> 
> Rest looks good for me, although you should address Greg's comments.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org> Tested on Odroid
> HC1 (Exynos5422):
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof



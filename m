Return-Path: <SRS0=8eBw=5X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D39C2BB1D
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 06:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D3F2072A
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 06:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fr9aFOcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDGGyK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:54:10 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:38944 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgDGGyK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 02:54:10 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200407065407epoutp03743b5767a281a4f38a43fcbc37b2ab17~Ddxoc6dXH1555515555epoutp03N
        for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2020 06:54:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200407065407epoutp03743b5767a281a4f38a43fcbc37b2ab17~Ddxoc6dXH1555515555epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586242447;
        bh=FD6u6gfSfkVoafsxdQNzxjDTpNg+DSItmEjTgsOLtxk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Fr9aFOcBoX+ijwXyThPrEYedZA1LFeIUQs3ZbJiiAttqRG3amcBE2ZenidORB6kjb
         Kn0bR0uR8T5bz0kOXu+D1Ai5HcTLYyVKblFzqYQb88Ks5gIKh4IRwk8cC9oVScF87J
         4o4cI9yZPE4/MSvVdpN6P89i1CuWkLJOP2Tvx2rg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200407065407epcas2p1c6e02e1a1e1cb8d5a91877e733e5f94d~Ddxn9mXvO1808218082epcas2p1x;
        Tue,  7 Apr 2020 06:54:07 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48xJ6P4nNWzMqYkk; Tue,  7 Apr
        2020 06:54:05 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.1D.04647.B832C8E5; Tue,  7 Apr 2020 15:54:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20200407065403epcas2p37d0990979790e3e14a25149830f5c913~DdxkNzj_k2389123891epcas2p3-;
        Tue,  7 Apr 2020 06:54:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200407065403epsmtrp27601e96f08f9701f497a9742ed6ce228~DdxkK9nvC3043630436epsmtrp2c;
        Tue,  7 Apr 2020 06:54:03 +0000 (GMT)
X-AuditID: b6c32a48-8a5ff70000001227-59-5e8c238bbe98
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.42.04024.B832C8E5; Tue,  7 Apr 2020 15:54:03 +0900 (KST)
Received: from KORCO004660 (unknown [12.36.165.196]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200407065402epsmtip21f3515027a661b7686ec8d83ad8aae00~Ddxj6Sdlv2245622456epsmtip2X;
        Tue,  7 Apr 2020 06:54:02 +0000 (GMT)
From:   "Hyunki Koo" <hyunki00.koo@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc:     <gregkh@linuxfoundation.org>, "'Rob Herring'" <robh+dt@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jiri Slaby'" <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20200407062655.GC21995@kozik-lap>
Subject: RE: [PATCH v6 2/2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Date:   Tue, 7 Apr 2020 15:54:02 +0900
Message-ID: <000501d60ca9$529b3cc0$f7d1b640$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKEs4Y1dkf1SYeuuA/6Ie9wROds5QJr8Gf+Ae0ziqcAfW/RYKbpNljg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29k5Z1qL07J6GVHjdCENdZttHSujSGVgkGRlWGgHd/LSbu1s
        doMyTPOSZShdppFlpVhMmaU2cTOzQgoVrOhGRWqUUVmC3ZDa8Rj573m/73m+93ne75VhCg+h
        lGVZHJzdwppoIljafCdUF16y8Hiq+rtPy1zo6sGZvJoGgqloHJEwJwc+YkxvbyPJeAae4Ey/
        t4pgzvb6JMzDmlKSyW/vItcGGzz1RYTBf/46aWi6fNjQcOOx1DDqmZ+Ip5hWZ3KskbOrOEu6
        1ZhlyYihE5LS1qfp9GpNuCaaWUGrLKyZi6FjNySGx2eZAqZoVQ5rcgaOElmepyPXrLZbnQ5O
        lWnlHTE0ZzOabBqNLYJnzbzTkhGRbjWv1KjVWl2AudOUeeRlB2nzS/edaCwjctE9rBgFyYBa
        Dn+8r/BiFCxTUK0I+i8VSsXiGwJ37phUYCmoMQTdT/hiJJtQjNZyIqcdQcnRXkIsPiDwuR+R
        goCgwqG/ZlAi4JAAbnpaSwokjPJJoPNsPi68FERFwthggsCZRW2Fm81tE3wptQg++e/jApZT
        0dDXVIKJeCZ0nxucMIRRC6DlU9VkBBX8HLqKi73iobJuHImcEKgsKsCEvkDlkdBV7ZWIglho
        OX+bFPEsGL5/YxIrYfRzOyHiw+ArOEWK4uMIfo4M4eJFFLjeHUNCAIwKhQZvpDiVhdD1fNLb
        DCi8M06Kx3IoLFCIwiXgHns/6WAeXB/ykmWIdk1J5pqSzDUlget/r2okrUdzOBtvzuB4rW35
        1L/2oIl9DTO0oo6eDZ2IkiF6unxbUEmqAmdz+P3mTgQyjA6RK0uLUhVyI7v/AGe3ptmdJo7v
        RLrA4E9hytnp1sD2WxxpGp1Wr1dH6xidXsvQc+Weac92KKgM1sHt5jgbZ/+nk8iClLloY3ze
        657fy65cS/ma3fYcUb+iF+trL5cbIk+7V+mT7751upvWpvQd/FExMn/mSv+Xir4O3P0nzmvd
        8iNJq8tXJj/QNvjiirTMvtTEHev21B2afSam1f9m+OJm1falB1vmvtu0t/sYGs52GNvULyru
        5ZeHbT7UrzEvvXV1+645UQPXRmkpn8lqwjA7z/4FM7y3qcUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSvG63ck+cwZq/zBbzj5xjtWhevJ7N
        YsqGD0wW/Y9fM1ucP7+B3WLT42usFpd3zWGzmHF+H5PFmcW97Bate4+wO3B5bFrVyeaxf+4a
        do/NS+o91m+5yuLxeZNcAGsUl01Kak5mWWqRvl0CV0bjnQPsBftZKvo2TGBrYDzG3MXIwSEh
        YCLxeXlqFyMXh5DAbkaJx5962bsYOYHiMhITXixhhrCFJe63HGGFKHrOKLHt6wuwBJuArsTl
        xU+YQGwRIHvzjeXsIEXMAseYJG4+/8kC0fGEUeJs10I2kHWcAvoS3554gzQIC4RIrGv+wApi
        swioSLzdfxzM5hWwlLiwuZsZwhaUODnzCQuIzSygLdH7sJURwpaX2P52DtR1ChI/ny5jhTjC
        TWL2ir9QNSISszvbmCcwCs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi
        0rx0veT83E2M4FjT0tzBeHlJ/CFGAQ5GJR5eBvbuOCHWxLLiytxDjBIczEoivFK9nXFCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MHLvL7U5v0L8rsQ7
        U570MwsnrtB5+ptXMttyd9/Vo1y/srufxvezsRdyKWzV+3G4+WBZ6qSEzE256cbzp2/fL1yy
        63g958dXsuwHNj1e3Bmu3ffn3IaMj4XvgifHr9py9rddI1OItdykJ0eLFSYc8b37/uVX5v4E
        /qZrc+dWf/fK0lVLeFNnfV+JpTgj0VCLuag4EQDbGOyGsQIAAA==
X-CMS-MailID: 20200407065403epcas2p37d0990979790e3e14a25149830f5c913
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
        <20200407062655.GC21995@kozik-lap>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 07, 2020 at 3:27 :00PM +0900, Krzysztof Kozlowski wrote:
> On Tue, Apr 07, 2020 at 08:08:49AM +0900, Hyunki Koo wrote:
> > Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> >
> > This is required for some newer SoCs.
> >
> > Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> > ---
> 
> Why I am adding these for the third time?
Sorry, I didn't knew that,
I will keep this next time
> 
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof


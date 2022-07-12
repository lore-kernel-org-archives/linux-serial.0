Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B3EC43334
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 23:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiGLXzl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 19:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGLXzk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 19:55:40 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D4EC74BE
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 16:55:38 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220712235534epoutp0452748a33a1cb6e6916e4ba592c0db2a5~BOjRu_MF42698026980epoutp04i
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 23:55:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220712235534epoutp0452748a33a1cb6e6916e4ba592c0db2a5~BOjRu_MF42698026980epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657670134;
        bh=h+MmzoTV3WWSbqxRelDKq5MfWyGPnDmV1Hq/PNYZJZg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=kRdX++o+d29hEsPvZMryCEm75B2jGHcCck082csQYvEYPceZknXNMQ7bxlbPiMXhH
         dI+EzcilTgShKCQrx5RXa0j9SzvGk0BErmAVyZ+iHyUd5VN3hAQW6Y505C6UzIRFe3
         XZsonPuG/5ty1Ru05IE7dRxsrd6P+t9CrOUvtNY8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220712235534epcas2p1147e25f37d706febdaa20c68fa5f1b62~BOjRM-VHZ1195511955epcas2p1C;
        Tue, 12 Jul 2022 23:55:34 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LjHgn0sWfz4x9Q9; Tue, 12 Jul
        2022 23:55:33 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.74.09662.5F90EC26; Wed, 13 Jul 2022 08:55:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220712235532epcas2p1ddfe459f8401fda7d08203f07ad2c537~BOjP2l8Zf2406824068epcas2p1W;
        Tue, 12 Jul 2022 23:55:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220712235532epsmtrp1ba88e5ac74a8289bf7561c70ddeb0782~BOjP1w6vz1725817258epsmtrp1T;
        Tue, 12 Jul 2022 23:55:32 +0000 (GMT)
X-AuditID: b6c32a48-9e1ff700000025be-79-62ce09f533e1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.77.08905.4F90EC26; Wed, 13 Jul 2022 08:55:32 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220712235532epsmtip132604ebaeeb1985069993c1ae12e7df9~BOjPqpyNp0444704447epsmtip1w;
        Tue, 12 Jul 2022 23:55:32 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Jiri Slaby'" <jirislaby@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Hector Martin'" <marcan@marcan.st>,
        "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'Vincent Whitchurch'" <vincent.whitchurch@axis.com>,
        =?UTF-8?Q?'Ilpo_J=C3=A4rvinen'?= <ilpo.jarvinen@linux.intel.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <caa266c1-aecc-31c4-75f5-b5061444b446@samsung.com>
Subject: RE: [PATCH v3] tty: serial: samsung_tty: loopback mode support
Date:   Wed, 13 Jul 2022 08:55:32 +0900
Message-ID: <01e401d8964a$df20e190$9d62a4b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQLzDSGin7fZbeDDkoOCu4DD8KtQ/QLMCkYfAQCTfcoCHt2Y0ANtTziFqvu03uA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmhe5XznNJBk8WsVg8mLeNzaJ58Xo2
        i84dPSwWOxqOsFq8mytjsff1VnaLTY+vsVrMOL+PyeLM4l52i7VH7rJbnL62gN3i/DZ/Bx6P
        6+sCPDat6mTzuHNtD5vHvJOBHvvnrmH32Lyk3mPxsp1sHn1bVjF6fN4kF8AZlW2TkZqYklqk
        kJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SukkJZYk4pUCggsbhY
        Sd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE74+afB+wFc5gq
        +pc/YWlgfMTYxcjJISFgIjF7yyHmLkYuDiGBHYwSE3puMkE4nxgl/je2QmW+MUrs6mpkhWnZ
        t3UdG0RiL6PEtQVbWSCcF4wSc+/sYwGpYhPQl3jZsY0VJCEisIxR4mL/IrAqZoEpzBKXLjYz
        g1RxCthLvF/5jAnEFhZwl1jd/A4sziKgKnHg9x2wSbwClhINK98zQ9iCEidnPgGLMwvIS2x/
        O4cZ4iYFiZ9Pl7FCxEUkZne2gcVFBPwkvt+byw6yWELgCofEpb4Z7BANLhJvVvYyQdjCEq+O
        b4GKS0m87G+Dsoslls76xATR3MAocXnbLzaIhLHErGftwADkANqmKbF+lz6IKSGgLHHkFtRt
        fBIdh/+yQ4R5JTrahCAa1SUObJ/OAmHLSnTP+cw6gVFpFpLPZiH5bBaSb2Yh7FrAyLKKUSy1
        oDg3PbXYqMAEHt/J+bmbGMGJWctjB+Pstx/0DjEycTAeYpTgYFYS4f1z9lSSEG9KYmVValF+
        fFFpTmrxIUZTYFhPZJYSTc4H5oa8knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWp
        RTB9TBycUg1M+1Z3eZ1NfSNmvm6h6mbHldLXzixpZAu6teLORfddf05/en6tf4uE+lYmIXmR
        735GXpaf/j/fu/Vq6+KsmBs3syak7oqwPRLYGznxTtm+C6yzxZJqJI69TjnZ/fz1jWkeGfee
        Nm7NvG/+231Rim33qs6Yf2rWT1hW7kvROWD7RPoe5/8LzRc17N0jPtsULJ5ya8Wx419mGCh8
        r3kldCLzWXfenPkOBX89pyRfnlnmHLQ94aRHU98jvx2ntkc9fdi3uu5j36FnWf9Wma5avLQt
        3GPv57savEKi6otWHH2jqe/Y/uK13lTz9pn3nHRtv1SnsV19ZKD07IvyiYwQLRclzwRxk6cT
        XwavlVjUs+CARZwSS3FGoqEWc1FxIgDIq2LAVQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSnO4XznNJBh/fqlk8mLeNzaJ58Xo2
        i84dPSwWOxqOsFq8mytjsff1VnaLTY+vsVrMOL+PyeLM4l52i7VH7rJbnL62gN3i/DZ/Bx6P
        6+sCPDat6mTzuHNtD5vHvJOBHvvnrmH32Lyk3mPxsp1sHn1bVjF6fN4kF8AZxWWTkpqTWZZa
        pG+XwJVx888D9oI5TBX9y5+wNDA+Yuxi5OSQEDCR2Ld1HRuILSSwm1FiwXlhiLisxLN3O9gh
        bGGJ+y1HWLsYuYBqnjFK3Lz7mgUkwSagL/GyYxsriC0isIxR4mFDDEgRs8AsZolHi15DdSxh
        kvh44CtYB6eAvcT7lc+YQGxhAXeJ1c3vmEFsFgFViQO/74DV8ApYSjSsfM8MYQtKnJz5BCzO
        LKAt0fuwlRHClpfY/nYOM8R5ChI/ny5jhYiLSMzubGOGuMhP4vu9uewTGIVnIRk1C8moWUhG
        zULSvoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnCEamnuYNy+6oPeIUYmDsZD
        jBIczEoivH/OnkoS4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJ
        g1OqgYlz50+rFRf53m56btRoeV1txe1bx2JuREgfZFStc2qR1ItY3/zVk0FP7HDS0awJmvEO
        2i8dv4Ue+1XS6Z6xTzhZOZN7SmT85DtnejJfXj0fPbdok43wh2Z1xYeGv6KvXI9quLvu9TvP
        wsPqE99oe52M90lo05rxUv3R2T/7teaan2q8qdIz9a1p46UwtaZc6f2TPjwtz6jW+Rc+bWpB
        7o4HB7wO9GkFHFuz+fQkTsX5nhzXfL5KHthepKyQ7WZgq/zLK7cpf+NEwX83bE2Nw/e9MDkh
        XcjTwV/S8oCtp0LKfd/vo8+0v7HvDlPZ0MG9eqOBgKHOUcuySenuJxMrTv/6XVhsIO75bN7N
        q+++cSixFGckGmoxFxUnAgCI7zNvPwMAAA==
X-CMS-MailID: 20220712235532epcas2p1ddfe459f8401fda7d08203f07ad2c537
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc
References: <CGME20220629004356epcas2p408afcd3d19d926a86d98e887e25e93bc@epcas2p4.samsung.com>
        <20220629004141.51484-1-chanho61.park@samsung.com>
        <4fb8c922-08aa-2ee3-8073-95b8a26bf5db@samsung.com>
        <000001d89588$936d14c0$ba473e40$@samsung.com>
        <caa266c1-aecc-31c4-75f5-b5061444b446@samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> Right. The problem is elsewhere. You used rd_reg(port, S3C2410_UCON)
> instead of rd_regl(port, S3C2410_UCON) what always zeroed upper bits. I
> will send a fix in a few minutes.

Oops. You're right. Thanks for pointing it out and send the fix.

Best Regards,
Chanho Park


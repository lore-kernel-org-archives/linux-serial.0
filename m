Return-Path: <SRS0=CAi2=6R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F7C28CBC
	for <linux-serial@archiver.kernel.org>; Sun,  3 May 2020 07:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8520E2078E
	for <linux-serial@archiver.kernel.org>; Sun,  3 May 2020 07:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SBKzxKKV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eE0KlyWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgECHo3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 3 May 2020 03:44:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47827 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgECHo2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 3 May 2020 03:44:28 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FB805C02D5;
        Sun,  3 May 2020 03:44:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 03 May 2020 03:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=N
        8Cx2/KCwTZPc2wHmE1jAvckSENViw1r2VmOZsfUcHU=; b=SBKzxKKV4sCWKYcCN
        LVT7VdEFGxsw/3J0Nuoj/ydxG/+xzG6V0a6qcccGnBoR1liRZ/QbxN/HP+1jFso1
        P2Wz6ej36q9FhfsmZRTdSvkxtgWvYZkAte+IYoLR3dq+u9uAzStZYUbvQ14Tpcmv
        vQXTPEfJ3Ky4+TxilTQCAD/sQAhZSsiUy7CS5EnjaMsJOyRadV9iYlriV0O8hQcx
        KwJtixXFyKvMWuPSfVO/xbONXNxxR1dRWr+tYo2IMRIdTk0Tad5OmTW1R7Q/WbY9
        uZpToOQ9Btw7VHj2vi8khH3sONdftl1HDivBuElxb8P1qt0FqfrMTLRvwd/ny2ND
        /4Iag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=N8Cx2/KCwTZPc2wHmE1jAvckSENViw1r2VmOZsfUc
        HU=; b=eE0KlyWu+1lRvJ9mOk78jOBCGLM3BUIpXo3gVQgSwB9tWg8jR4MoG6O9N
        1UqkYXpxTHieG5GP/rDIETTIEIUods8sqX1S5yyMmY65gl1XAvmoElcmzrPuq3/m
        KMIi99N8R7vS2vARtN2zj3Z5DDMaGfd8pnXAsg8jlkAKlgV1V14sh6hwNkQKlSQk
        VGKvhX5ouDl8DAsBw7M7RObdIUApncFYccAdAX8dU5EQZTr06NsyQj7U+UVRyF2x
        Wo7dOQAQI89uhyMLM+e/IBKMGBLX++FkkXQB6fyy8pW6ZpxfgRBLCeNJJtPmFcL2
        733ZLH9SXIkYhxIPhh5r2uoQNKrlw==
X-ME-Sender: <xms:WXauXiIY1KCFcz3LSPlzAGboemRQfQBpTXv_-Ac8je2k70HYIDQowA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjedugddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepueehkeehlefffeeiudetfeekjeffvdeuheejjeffheelud
    fgteekvdelkeduuddvnecukfhppeekfedrkeeirdekledruddtjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homh
X-ME-Proxy: <xmx:WXauXhC5gd6Qtm-g3xjthRuD7SW_j2hxK7HhzY67K99ekYUl4jopHw>
    <xmx:WXauXrC-Umel1dtl8ijENio_W5aR046CxttipYChX1je4tZpKoJ_gQ>
    <xmx:WXauXjB7bkVYMw-6Y-Ufe8qSLEaMlo-ePibrJhREkXGZnR4HI8BeeA>
    <xmx:WXauXiIsIXP0MktHiQxZkkflmewdyhCDbADRb5hN-j1CZ4w-3IBVBw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2B313065FC6;
        Sun,  3 May 2020 03:44:24 -0400 (EDT)
Date:   Sun, 3 May 2020 09:44:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Dongyang Zhan <zdyzztq@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Fwd: Possible null pointer dereference in con_init()
Message-ID: <20200503074420.GA536697@kroah.com>
References: <CAFSR4cs_pVwH1Tcf4-pyKr3-TPtvS34Av-2jGA7L4MmTX-_4rw@mail.gmail.com>
 <CAFSR4ctg3xM_Z+oqVWjA9+hy+Cc33FfVqa5LgFAEkgUO1RxX1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFSR4ctg3xM_Z+oqVWjA9+hy+Cc33FfVqa5LgFAEkgUO1RxX1A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, May 03, 2020 at 03:20:50PM +0800, Dongyang Zhan wrote:
> Hi,
> 
> I am a security researcher, my name is Dongyang Zhan. I found a potential bug.
> 
> I hope you can help me to confirm it.
> 
> Thank you.
> 
> In Linux 4.10.17, function con_init() in /drivers/tty/vt/vt.c forgets
> to handle the failure of the memory allocation operation (e.g.,
> vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data),
> GFP_NOWAIT)).
> 
> Source code and comments；
> vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> tty_port_init(&vc->port);
> visual_init(vc, currcons, 1);
> vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> vc_init(vc, vc->vc_rows, vc->vc_cols,
> currcons || !vc->vc_sw->con_save_screen);
> 
> If the allocation fails, dereferencing vc will cause a null pointer dereference.

But that allocation can not fail, so all is fine.

thanks,

greg k-h

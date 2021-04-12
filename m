Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA762C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 23:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CD761278
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 23:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhDLXib (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 19:38:31 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:55061 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237567AbhDLXia (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 19:38:30 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 11E6E1A1E;
        Mon, 12 Apr 2021 19:38:11 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Mon, 12 Apr 2021 19:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=rs+CMVSq1IMzDicnOc3HJ7GexWkfQde
        TZ0h6vZF00Ao=; b=fTQA1ulm96fXRCSUmZQn345kH1+ACTCX1Hqu6PWZ9Et8srw
        Nyen9qCbo0adg/nc/0dXsYY7tCe6KSGdowg1XVr6Ycxs0JDHg1JsZ5oVOHAUbLIy
        99mc3I6QyCGRsBPFoMxJwxMQEIGinOYeKKMzdJI5LsjDoqgdmYGqa1dRn+dYQCIP
        2nUm2rTcqyFAJ+KWcdcxeIVJ6fISwAIp7EgiQ/mfAhs/aWFFlgpGvYnLyjxKkB4+
        B5nGpvmUBPGY9RWctdEnYrrPvHZSQbnxrFPOCkaptWkahh0qWpaV4eyqAus7WZe7
        +6ZtM9U80KfaQOfiyJ6H8kak+01ZTTXpv8mVCJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rs+CMV
        Sq1IMzDicnOc3HJ7GexWkfQdeTZ0h6vZF00Ao=; b=U/QkrDg5yoPsJwNtMq2gjj
        GCSJA2zr2DdcrY1lcB4y/EaBaPVThhB85nXrwFXgiLSAhbbhFCOhVZv/iaeM3e+G
        WbQ474kaWLCJO6xGXS1e5PY6EGUDFvoq+IhWjzvFE+QgOEjkLMMeBLwDEC1cHxhT
        HiFSyNF2r9Uvn9j2X+i5movGiD/WqESnJOu2iDdZPRIcAW6QSGySiAPVG36WT7F+
        XVXhFM26GqQ01L+OtmFRCOXsQPWaSJ/8fUrYqXlZcRYj13C1HwlzWkfxt3SutQLX
        b4zckSzJt2i8rrgsoJRso9m2RGzHiwZBo+x34y+TvKMtjj/Td6F2uMBp7zTiOW6Q
        ==
X-ME-Sender: <xms:4Nl0YNedyTglQvPF84v975xVpzrmWdp5isVR3lQm907dL2KEIjxocA>
    <xme:4Nl0YLN60Y38isv8zfNPcqCZI9RA5n5DXrWfmfId5DnO17RlkHOjyDqBpU_tsgwck
    nOAvFmpQUt63OJ_PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:4Nl0YGho0uT6g_SSlWZCEIWvB6dvwf0jnC0riQM0JDz6G3SGXw8fiA>
    <xmx:4Nl0YG9QJyyTIKLve8NNZTb6BC16beRe8Qm4rCi7xm58JIRifxWe-w>
    <xmx:4Nl0YJu9mMMPV46-dIaQkKAC0egCLyGDLQ-foJ8F1OOat1hptaqufw>
    <xmx:4tl0YNgmRs8fTvXp7cI9sHzomD62GXywWFVnV1m-5_UVWuR0aWa5jA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BD9A2A00492; Mon, 12 Apr 2021 19:38:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <85b5abef-7c7a-4157-a13e-6ba85f463703@www.fastmail.com>
In-Reply-To: <20210412034712.16778-4-zev@bewilderbeest.net>
References: <20210412034712.16778-1-zev@bewilderbeest.net>
 <20210412034712.16778-4-zev@bewilderbeest.net>
Date:   Tue, 13 Apr 2021 09:07:48 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Zev Weiss" <zev@bewilderbeest.net>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v6_3/4]_serial:_8250=5Faspeed=5Fvuart:_add_aspeed,l?=
 =?UTF-8?Q?pc-io-reg_and_aspeed,lpc-interrupts_DT_properties?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Mon, 12 Apr 2021, at 13:17, Zev Weiss wrote:
> These allow describing all the Aspeed VUART attributes currently
> available via sysfs.  aspeed,lpc-interrupts provides a replacement for
> the deprecated aspeed,sirq-polarity-sense property.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

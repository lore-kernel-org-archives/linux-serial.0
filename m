Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3866EC433B4
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 05:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA99260FED
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 05:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhDIFPj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Apr 2021 01:15:39 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54233 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhDIFPi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Apr 2021 01:15:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 05D075C00A0;
        Fri,  9 Apr 2021 01:15:26 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Fri, 09 Apr 2021 01:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=FOmFmqL40ZegqMlq/XzagzjasgzMbz3
        EyAsKTAH4Em0=; b=fgY9QsQ8fhRt+1tMgfceEzzfRPZeQQgkj6SXcyts2cJr8cb
        G+WoiBHcFt9gOcMOatIn/oG+o/6BRMEMRACSSNoZcUIakSHCDMr26T/mzor5gGWC
        o4calS2LiZdaiZLHbhLkaJKU7rsb73SpBWRV1fTSXpTzBZV7XZX+jxEwGpjPUv+Y
        7K8LzwW8OdQIjoEhlRao8w31Qni3VE/D0Mf1RiEvXj8pqmu7UVULqQVcYohi3axP
        C5xdJkPAVltWPJiTFIGCUUxemBJJyGuhx2lWxx/jDO6xVcwrNBL8Y2sCRDVMJ8Bf
        mE4OF8JEGYyaiImqJoe0pOgj7dwYPUPubXgTOAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FOmFmq
        L40ZegqMlq/XzagzjasgzMbz3EyAsKTAH4Em0=; b=FMpYMLnActwMm4HhCpT1Hm
        MGJThPRYskkKMmdYcwuwwgRhIu8mSkeebMZdGOcjprV2+PLTs3WhSVV39bKuMmuE
        8iUAf9kqXdg5UA8R/DMfYvm3IxEVRx5arhxrDC0NCvpYMCesEFDk7ibqZdHUezD8
        v8Fg2JOFgJ278Vlj+tvf2wdftMEWP1swB43lznHyKgBtA+aSNTUAbJKPRtXKb8Tz
        FU1VftlKm7MRJllQmcCWgNCONzWkNuKxYbln94HCAjMyPFnaO5MOKToKezBO2eI2
        97cF3mTZt3mNCUT42ejHoiRVwkh3Uuvfg37EE6EbSoImL9sMkb61zaDwEL7cveDA
        ==
X-ME-Sender: <xms:7OJvYNeeYO5-SNB9nXxxrsdTVXStCSH4FXHHGTPGRM9GJ-7U2_oBeg>
    <xme:7OJvYLPnAnbqQ_kZU0JmwwHRaGTOFgT9lWVaumes0HyegXqH0KCORf0WSG9X7OYSI
    mKbEHONn3Kv4iDUww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudektddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:7OJvYGjRy6WCWgh3CIizVUY66gl9Qd_t9Xfc1pJPhF2bddHASw2DFQ>
    <xmx:7OJvYG8FrzYPy1Yyn71GVD6r4izLJe66Mxj4mRbvmjjR_oFrYSAbsw>
    <xmx:7OJvYJvO_geyQh5hJuOnaQ-_a1MJhe1leZRhwBKnwopNG9FqmwtFzw>
    <xmx:7uJvYNhnn4xfvSwi-0jHJDzCleAvmgrw_0lkvfZfbCnKa-QEH9RLog>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A55E2A0007C; Fri,  9 Apr 2021 01:15:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <3eef2478-c5b8-4f14-a937-16bbe0a3e05a@www.fastmail.com>
In-Reply-To: <20210408011637.5361-4-zev@bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-4-zev@bewilderbeest.net>
Date:   Fri, 09 Apr 2021 14:44:54 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Zev Weiss" <zev@bewilderbeest.net>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, "Jiri Slaby" <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: =?UTF-8?Q?Re:_[PATCH_v5_3/4]_drivers/tty/serial/8250:_add_aspeed,_lpc-io?=
 =?UTF-8?Q?-reg_and_aspeed,_lpc-interrupts_DT_properties?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Zev,

A couple of minor comments:

On Thu, 8 Apr 2021, at 10:46, Zev Weiss wrote:
> These allow describing all the Aspeed VUART attributes currently
> available via sysfs.  aspeed,sirq

aspeed,lpc-interrupts now

> provides a replacement for the
> deprecated aspeed,sirq-polarity-sense property.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 44 ++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c 
> b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index 8433f8dbb186..75ef006fa24b 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -28,6 +28,10 @@
>  #define ASPEED_VUART_ADDRL		0x28
>  #define ASPEED_VUART_ADDRH		0x2c
>  
> +#define ASPEED_VUART_DEFAULT_LPC_ADDR	0x3f8
> +#define ASPEED_VUART_DEFAULT_SIRQ	4
> +#define ASPEED_VUART_DEFAULT_SIRQ_POLARITY	IRQ_TYPE_LEVEL_LOW
> +
>  struct aspeed_vuart {
>  	struct device		*dev;
>  	void __iomem		*regs;
> @@ -393,7 +397,8 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>  	struct aspeed_vuart *vuart;
>  	struct device_node *np;
>  	struct resource *res;
> -	u32 clk, prop;
> +	u32 clk, prop, sirq[2];
> +	bool sirq_polarity;
>  	int rc;
>  
>  	np = pdev->dev.of_node;
> @@ -501,6 +506,43 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>  		of_node_put(sirq_polarity_sense_args.np);
>  	}
>  
> +	rc = of_property_read_u32(np, "aspeed,lpc-io-reg", &prop);
> +	if (rc < 0)
> +		prop = ASPEED_VUART_DEFAULT_LPC_ADDR;
> +
> +	rc = aspeed_vuart_set_lpc_address(vuart, prop);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "invalid value in aspeed,lpc-io-reg property\n");
> +		goto err_clk_disable;
> +	}
> +
> +	rc = of_property_read_u32_array(np, "aspeed,lpc-interrupts", sirq, 2);
> +	if (rc < 0) {
> +		sirq[0] = ASPEED_VUART_DEFAULT_SIRQ;
> +		sirq[1] = ASPEED_VUART_DEFAULT_SIRQ_POLARITY;
> +	}
> +
> +	rc = aspeed_vuart_set_sirq(vuart, sirq[0]);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "invalid sirq number in aspeed,lpc-interrupts > property\n");
> +		goto err_clk_disable;
> +	}
> +
> +	switch (sirq[1]) {
> +	case IRQ_TYPE_LEVEL_LOW:
> +		sirq_polarity = false;
> +		break;
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		sirq_polarity = true;
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "invalid sirq polarity in aspeed,lpc-interrupts 
> property\n");
> +		rc = -EINVAL;
> +		goto err_clk_disable;
> +	}

A bit ugly open-coding the mapping and error handling, maybe worth a helper?

Looks okay otherwise.

Cheers,

Andrew

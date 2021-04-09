Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C4C433B4
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 05:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D021461177
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 05:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhDIFHD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Apr 2021 01:07:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59947 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231402AbhDIFGy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Apr 2021 01:06:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3BCDF5C00DC;
        Fri,  9 Apr 2021 01:06:38 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Fri, 09 Apr 2021 01:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=mxLFzNV3p0aWRPTd2D1rW2nB8WwCHV/
        KmSpV66nSk/E=; b=Oc2By+aONtbTP4QV8cs/AySEkzS/sdmDYs0E7MWiuMr+AP6
        +Jv6p84NFYA0tbiwdHkk15NfkgK8fK7u6ab1JUJmk9mc01kZ+l7rf2t9MLC/AwGz
        HTYPE2DhRy9zNUSd/KZpUmKKpz3KA8VHpO4nALqB1emBXPB1AobR0fRG0SkHfwfW
        FlkW4AZNfHM5rMdzpCmDNOx4B36xFQW1AXetPM3P/yNaB70eoGYHLOAwr5rnRqYf
        Q91v1iGcdjOhIGQUEBNO5xLLR3DkPgwDDIoyP4/gT+c6noayOBEpGpxhhnrYrFIL
        xThCR/FtC/iR3uy4ose0bVyz1KcT3zJwnvW3+tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mxLFzN
        V3p0aWRPTd2D1rW2nB8WwCHV/KmSpV66nSk/E=; b=uvdRnJkpC/09mqEE+cJ/b1
        XO7mUxofkzdKoYDEP46d46reRrmxu/1jAgaA1R626t31qftbZeAipP9z0D4tGSda
        zc4TzpJ47aGImaAvb2fCK39XZVmEVLHjt2ttaXj8b6g+6GB2gh+Ef9zdNq99Fij2
        hnpLxvjgK+YkP2GfVCk6dtzd3A+SdxS7PuZnFdxLiqnkUrnQY6B/1bGRC7Pc4bFv
        Trm+AAkBrOJ+tk3knrMmCc5ByA7DpJkiR47mseJ99GsV818ZFjgVsUDdNFA2+069
        zQT7tfcvGYrGXfz3peBdE4vmJvhwm21rtnUAPK9Amkuhux8lauIVL6I2AGc+4jew
        ==
X-ME-Sender: <xms:3OBvYEAr_Wt3-BrZGmq_Jiiy-e9EFJg_Cs3sgHibIUifb437Fpadeg>
    <xme:3OBvYGgGnRakapBSn55eiaLsKPZkvOTjOB0ykBGpJKtp6uI4k2hLr12eRNz5I4wxN
    9NP6r974RM0eC9WRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudektddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepkeelgedtkeduudetveektdfhtedtveffvedutdfgfeejhfeuleelffeh
    vefgffdtnecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgu
    rdgruh
X-ME-Proxy: <xmx:3OBvYHmC3cMpY7sUfNG8oQMONtJM1YjQPKcyPhovaqPyXpDa90FJgQ>
    <xmx:3OBvYKyv-OI1T1_cdIwC5BIGKE0raNoFKg1PpRXALexjxVe56PFaLw>
    <xmx:3OBvYJQYi2gWGskNIfuWp__f2jriC4eMeJso4N9ewrQgTKXhWE4Fsw>
    <xmx:3uBvYIHgC6pybE4Us5RIn7OZctovkJSRDlJ7vsyaOZq4rQhdY_GJrg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 51608A0007C; Fri,  9 Apr 2021 01:06:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <db7271d8-8d13-4a8c-a7ba-564e4e769ea5@www.fastmail.com>
In-Reply-To: <20210408011637.5361-3-zev@bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-3-zev@bewilderbeest.net>
Date:   Fri, 09 Apr 2021 14:36:16 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Zev Weiss" <zev@bewilderbeest.net>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v5_2/4]_drivers/tty/serial/8250:_refactor_sirq_and_?=
 =?UTF-8?Q?lpc_address_setting_code?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On Thu, 8 Apr 2021, at 10:46, Zev Weiss wrote:
> This splits dedicated aspeed_vuart_set_{sirq,lpc_address}() functions
> out of the sysfs store functions in preparation for adding DT
> properties that will be poking the same registers.  While we're at it,
> these functions now provide some basic bounds-checking on their
> arguments.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 51 ++++++++++++++-------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c 
> b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> index c33e02cbde93..8433f8dbb186 100644
> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
> @@ -72,22 +72,31 @@ static ssize_t lpc_address_show(struct device *dev,
>  	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
>  }
>  
> +static int aspeed_vuart_set_lpc_address(struct aspeed_vuart *vuart, u32 addr)
> +{
> +	if (addr > U16_MAX)
> +		return -EINVAL;
> +
> +	writeb(addr >> 8, vuart->regs + ASPEED_VUART_ADDRH);
> +	writeb(addr >> 0, vuart->regs + ASPEED_VUART_ADDRL);
> +
> +	return 0;
> +}
> +
>  static ssize_t lpc_address_store(struct device *dev,
>  				 struct device_attribute *attr,
>  				 const char *buf, size_t count)
>  {
>  	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
> -	unsigned long val;
> +	u32 val;
>  	int err;
>  
> -	err = kstrtoul(buf, 0, &val);
> +	err = kstrtou32(buf, 0, &val);
>  	if (err)
>  		return err;
>  
> -	writeb(val >> 8, vuart->regs + ASPEED_VUART_ADDRH);
> -	writeb(val >> 0, vuart->regs + ASPEED_VUART_ADDRL);
> -
> -	return count;
> +	err = aspeed_vuart_set_lpc_address(vuart, val);
> +	return err ? : count;
>  }
>  
>  static DEVICE_ATTR_RW(lpc_address);
> @@ -105,27 +114,37 @@ static ssize_t sirq_show(struct device *dev,
>  	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg);
>  }
>  
> +static int aspeed_vuart_set_sirq(struct aspeed_vuart *vuart, u32 sirq)
> +{
> +	u8 reg;
> +
> +	if (sirq > (ASPEED_VUART_GCRB_HOST_SIRQ_MASK >> ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT))
> +		return -EINVAL;
> +
> +	sirq <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
> +	sirq &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;

This might be less verbose if we reordered things a little:

```
sirq <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
if (sirq & ASPEED_VUART_GCRB_HOST_SIRQ_MASK)
	return -EINVAL;
sirq &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
```

But otherwise it looks okay, so

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> +
> +	reg = readb(vuart->regs + ASPEED_VUART_GCRB);
> +	reg &= ~ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
> +	reg |= sirq;
> +	writeb(reg, vuart->regs + ASPEED_VUART_GCRB);
> +
> +	return 0;
> +}
> +
>  static ssize_t sirq_store(struct device *dev, struct device_attribute 
> *attr,
>  			  const char *buf, size_t count)
>  {
>  	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
>  	unsigned long val;
>  	int err;
> -	u8 reg;
>  
>  	err = kstrtoul(buf, 0, &val);
>  	if (err)
>  		return err;
>  
> -	val <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
> -	val &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
> -
> -	reg = readb(vuart->regs + ASPEED_VUART_GCRB);
> -	reg &= ~ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
> -	reg |= val;
> -	writeb(reg, vuart->regs + ASPEED_VUART_GCRB);
> -
> -	return count;
> +	err = aspeed_vuart_set_sirq(vuart, val);
> +	return err ? : count;
>  }
>  
>  static DEVICE_ATTR_RW(sirq);
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FF7C433ED
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 07:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D48610FC
	for <linux-serial@archiver.kernel.org>; Fri,  9 Apr 2021 07:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhDIHBT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Apr 2021 03:01:19 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:45231 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhDIHBT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Apr 2021 03:01:19 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 240CB86;
        Fri,  9 Apr 2021 00:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617951666;
        bh=+JLpB4B4pZBi2h8DfTURJ08nGqgdO/pYNV0sF8isNXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CidT4DYvw7ZKpQkK8gdGXnDdEJXCD9goWMGofn7kROmWmdqG5EWltzowMmaLMHNGU
         6M7G/SO7aMkIYPy7bEV3EaXiUUNr3sIQU3g/L8T8wnqwdiGHfBq5p8sFg0zAprzD90
         FGNpAD/S63WbHASqkhrS6RDPjVQU9ap1qxx8FeqA=
Date:   Fri, 9 Apr 2021 02:01:04 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 2/4] drivers/tty/serial/8250: refactor sirq and lpc
 address setting code
Message-ID: <YG/7sFv+2AlLKbZ5@hatter.bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-3-zev@bewilderbeest.net>
 <db7271d8-8d13-4a8c-a7ba-564e4e769ea5@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <db7271d8-8d13-4a8c-a7ba-564e4e769ea5@www.fastmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 09, 2021 at 12:06:16AM CDT, Andrew Jeffery wrote:
>
>
>On Thu, 8 Apr 2021, at 10:46, Zev Weiss wrote:
>> This splits dedicated aspeed_vuart_set_{sirq,lpc_address}() functions
>> out of the sysfs store functions in preparation for adding DT
>> properties that will be poking the same registers.  While we're at it,
>> these functions now provide some basic bounds-checking on their
>> arguments.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>  drivers/tty/serial/8250/8250_aspeed_vuart.c | 51 ++++++++++++++-------
>>  1 file changed, 35 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> index c33e02cbde93..8433f8dbb186 100644
>> --- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> +++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
>> @@ -72,22 +72,31 @@ static ssize_t lpc_address_show(struct device *dev,
>>  	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
>>  }
>>
>> +static int aspeed_vuart_set_lpc_address(struct aspeed_vuart *vuart, u32 addr)
>> +{
>> +	if (addr > U16_MAX)
>> +		return -EINVAL;
>> +
>> +	writeb(addr >> 8, vuart->regs + ASPEED_VUART_ADDRH);
>> +	writeb(addr >> 0, vuart->regs + ASPEED_VUART_ADDRL);
>> +
>> +	return 0;
>> +}
>> +
>>  static ssize_t lpc_address_store(struct device *dev,
>>  				 struct device_attribute *attr,
>>  				 const char *buf, size_t count)
>>  {
>>  	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
>> -	unsigned long val;
>> +	u32 val;
>>  	int err;
>>
>> -	err = kstrtoul(buf, 0, &val);
>> +	err = kstrtou32(buf, 0, &val);
>>  	if (err)
>>  		return err;
>>
>> -	writeb(val >> 8, vuart->regs + ASPEED_VUART_ADDRH);
>> -	writeb(val >> 0, vuart->regs + ASPEED_VUART_ADDRL);
>> -
>> -	return count;
>> +	err = aspeed_vuart_set_lpc_address(vuart, val);
>> +	return err ? : count;
>>  }
>>
>>  static DEVICE_ATTR_RW(lpc_address);
>> @@ -105,27 +114,37 @@ static ssize_t sirq_show(struct device *dev,
>>  	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg);
>>  }
>>
>> +static int aspeed_vuart_set_sirq(struct aspeed_vuart *vuart, u32 sirq)
>> +{
>> +	u8 reg;
>> +
>> +	if (sirq > (ASPEED_VUART_GCRB_HOST_SIRQ_MASK >> ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT))
>> +		return -EINVAL;
>> +
>> +	sirq <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
>> +	sirq &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
>
>This might be less verbose if we reordered things a little:
>
>```
>sirq <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
>if (sirq & ASPEED_VUART_GCRB_HOST_SIRQ_MASK)
>	return -EINVAL;
>sirq &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
>```

Hmm, that (or something similar, perhaps with a '~' on the mask in the 
if condition?) does seem like it'd be a nice improvement, though I 
suppose it'd also mean we'd fail to reject some way-out-of-range sirq 
values (e.g. if it had its MSB set) -- so I think I'll leave it as is, 
just in the name of thoroughness/paranoia?

>
>But otherwise it looks okay, so
>
>Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>

Thanks.


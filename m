Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F57EC63777
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 08:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340B5206F9
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 08:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhK18TRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgKYIiz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKYIiz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Nov 2020 03:38:55 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC66C0613D4
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2020 00:38:54 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d17so1943578lfq.10
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2020 00:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uY/KqFUR3RVi6oRM4q3e3zG0lPvuGsBTEKi5EXfCs84=;
        b=hhK18TRvXL6GBGRiFCfcJKiPJV6LIrGSjAoSmjDHYy3MDZayuz1bF8i43t1CpYx9W0
         Le6rtshYiqAREYVNrvF7ITM1L7pdY4+PQkPF49IgMy9zQhoQBgHrLChMS90T3K9lwDr+
         uZ3OeL3OTlmEDuUoFtKtVJ4hsnuZPWM8w0opTQcpGdx+z6Jw8O+JqZVLlIN9FPAB0VYh
         gLGCUe2a1fQW2asGZrNYsDesoyluuvavCeImtvNgO6OnqNwvtdC/K7KSNbDnl2OccAkT
         ja1CCWTbYA940OyWj9IXXj+S1uDjaGJ2lyoypfoRaz4M7TsxBLT2PO8k7WwRzWrc3GHs
         APXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uY/KqFUR3RVi6oRM4q3e3zG0lPvuGsBTEKi5EXfCs84=;
        b=ZemGluACVUogf8e3uBxQzYlMSlyYiAMQTVtmH/urKr01gR2QZ0kLzS4gK4vCR0N2ap
         GuDXPTl7zNdhbtSgvXx/bc35Iq1+enS9pvG37ZbwEZfk+IwTM0gVopGHUuX91/nLz9Dm
         AFBI5IQ50fv0z/tj3ERd1+CTUGFzv80j3zUZmUe5TxeiaY/xad6Ax5V+4z7J0xd4A8Au
         IUIP8b2RJzEoL5nBpqdUDXYzZaaTb/x3iVYIqlTXQud9mBiFKvV+fDnk6Ht6o26FmEq0
         wl3UzEbmBKqaa5BVhgqkZpvakRmkxBz4kke4iS2nkfJabxfGg63VvHxCq/x058+bCZTG
         uubA==
X-Gm-Message-State: AOAM530eksicFlOs/FjyG6/Y6omZSEFzNS2vTVo343UwWB3lKeDTN+/S
        r0O3fuHGHS7QQkaLiB9in8E=
X-Google-Smtp-Source: ABdhPJwQPF2PcLe3bECGoMK+osKeZwKnyfLWDDh2q20riXRJeIMyNV1O+mU1kOjPIDb5F4QJzh6z5Q==
X-Received: by 2002:ac2:4182:: with SMTP id z2mr869437lfh.451.1606293533224;
        Wed, 25 Nov 2020 00:38:53 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id e23sm173345lfd.91.2020.11.25.00.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 00:38:52 -0800 (PST)
Subject: Re: [PATCH] tty: serial: bcm63xx: allow building on ARM64
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201125081352.25409-1-zajec5@gmail.com>
 <X74Uanu26sx4Hait@kroah.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <6b107933-9ab1-7c46-c383-ed39b71b4ecb@gmail.com>
Date:   Wed, 25 Nov 2020 09:38:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <X74Uanu26sx4Hait@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25.11.2020 09:23, Greg Kroah-Hartman wrote:
> On Wed, Nov 25, 2020 at 09:13:52AM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
>> is ARM64.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   drivers/tty/serial/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 28f22e58639c..6907c5b17a0e 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1133,7 +1133,8 @@ config SERIAL_TIMBERDALE
>>   config SERIAL_BCM63XX
>>   	tristate "Broadcom BCM63xx/BCM33xx UART support"
>>   	select SERIAL_CORE
>> -	depends on MIPS || ARM || COMPILE_TEST
>> +	depends on MIPS || ARM || ARM64 || COMPILE_TEST
> 
> Why do we have an arch dependancy at all now?

 From my experience "depends" is often used to limit symbol visibility to
applicable platforms only. I don't think Broadcom has any x86, risc, etc.
platforms so it's useless there.

As for testing driver compilation on unused arch-s I thought that's what
COMPILE_TEST is for.

Am I wrong there? I'm afraid we don't have clear Documentation on that.
Please kindly point me to some info if I'm wrong.


>> +	default ARCH_BCM4908
> 
> Really?  I thought we were getting rid of these "ARCH_platform_type" of
> things.  That's what a defconfig file is for, right?

I had to miss something, last time I checked Linus called defconfigs a
garbage and wanted to get rid of them:
https://lwn.net/Articles/391372/

There are also no platform defconfigs in arch/arm64/ at all. Should I
handle it with arch/arm64/Kconfig.platforms and "select SERIAL_BCM63XX"?

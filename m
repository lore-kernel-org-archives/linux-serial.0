Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B233DEE9
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124674; cv=none; b=s1FRTG1nHWfl1UE6Iv/mVr7pLs8+7JtXYE3i6kErnFF+lc4Ce0i2yv7lsLEOnkHlMkK5q4XqSHcqAh3lkJWj8MwwCojduwcbWlpOubpMkFJ5LQDn0Uh54KtAF9KCgWpD4gOY7+pNbpgTzi8qhrJSxnfVDL6zTNMwTW8+nnWLP0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124674; c=relaxed/simple;
	bh=KDz40ob1DP1awgyQpoQz8zlL0Dgc5sAY4J66gSV3FQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D68Kvat9v4PdLk+YPmI0T+Sioc8blX8P+EfoVjlAwVgpDQ11Ppau6eWzzi/4bfWCs2nxDBRWkTMc42Un185RmVAWtdSj8hZI0RfDVWDLpeo/P3QIrsJt5k9MXJWltZe76MQorjWeu2Aotmus/KpHdTOPC5wU2J842FkG7ymJcEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2022323c37so95979466b.0
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 00:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787124671; x=1787729471;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HiDaEknU4hvGEw8cYMmApLQGE2jE6rj6ed8HdH6DIqQ=;
        b=fzjHtK9HE8I4gWJXct4jHcm1MWpviF9srgmHPBBVdgz9t2VavHorGFBbz6d7Y+xAY1
         xi7r11zOJskQZrb1xIYzJu9yldj+4yoltRac9cFdQJUPkxeqo8+F1yuVAWpX43d0SvyF
         heyWqopfVRN6bgagwd+wnk6NA0gjxopGSThL0Rf46UTMfOU2VNp117roYwlK8J8yfzwC
         XRKLyEpUf5a6x5xW8Ui7O4aGiUmaPlqHAPmmjipex3z6EYzCQTsMIiCr7Cxmk/CZUoOo
         YAdxh5kjG1lLMeBevvrrwp0+AAsc2l/CFyjZHjkRzdyWEPQ7rf5HTvYJssxEkt8iNfOb
         lY0w==
X-Forwarded-Encrypted: i=1; AHgh+RrfBKQFH0F+CQBo/Yhro3juIfwMqj19X5ieuFVqXC+RMHkXWrgWzycTAfPh7QJVxGErKhqc7h+ohNgk4Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqM5r/eIrM5netQO3IsXDwn+JKQXYcqQyG7FvnvfIfShhUO8z
	0Yc5y7QXGVE50hBPR2TTRe11O/Ymw11MV2gfHyRYDVQT+Q8m5OwqaEFa
X-Gm-Gg: AR+sD10exqe2NnWlUu3IinTUyl+FxkwE8mwQ6Qeg/IjRhQRqpNNVGUYqcEPR2Z1CdRs
	mSdp6HB5Qb+HQluSQC6l8Kz1ba/OFN9im5oFYaZBe/DfsC0nZaMN8jsjclBcjVtDJ8rNm2OSPfr
	KLuEbJRzWoH6BuCRjMKH57RZIqqB8xioFaZwrpiRZ9WhYuwIvWwzDJHrre+S8+m6pn6ySKdeBcJ
	btEk0gVM+2V8q9uPjJs8NxyIK61HMfm8Lti/G+LNx22RHEfj5F7+8i8dSW6EGs8Q+nLQfJPcg/a
	+r1Sl0t3Ie+ybDepkFmMf1BAfDIqnkERtu0SCg/k88kTF65KGVsGJ498yFjD9cPdYWK4Eqj8Gld
	mLWEPWe1MDWRgo4m5vDjzgfjaYOPKhz4hrsIyLfVX116gZk8AaLRrwzVvoQo59rR/Q/mrdk7kQs
	ZjABp+fEl8b3WSG8MKviUQZTkuEzhnW9pwyEyRz1tEo6Cc1YW+00Yp8WLX3SalNke8I9sgZg1g0
	knmiLTX7PHtFjxlY+33vw==
X-Received: by 2002:a17:906:9c95:b0:c12:74af:51f3 with SMTP id a640c23a62f3a-c242a5af4fcmr134040566b.6.1787124671066;
        Wed, 19 Aug 2026 00:31:11 -0700 (PDT)
Received: from [192.168.1.135] ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c7c2b45sm37142066b.13.2026.08.19.00.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 00:31:10 -0700 (PDT)
Message-ID: <47719008-a26d-481c-8b0c-8acf669e987f@linux.com>
Date: Wed, 19 Aug 2026 08:31:10 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250: don't register ports that have no hardware
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20260818185200.10243-1-tanure@linux.com>
 <2026081923-magical-enlisted-64ff@gregkh>
 <ecc5ada8-c878-4123-acd7-64af3219b181@linux.com>
 <2026081908-clamp-safely-de2f@gregkh>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <2026081908-clamp-safely-de2f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 07:49, Greg Kroah-Hartman wrote:
> On Wed, Aug 19, 2026 at 07:40:17AM +0100, Lucas Tanure wrote:
>> On 19/08/2026 06:57, Greg Kroah-Hartman wrote:
>>> On Tue, Aug 18, 2026 at 07:52:00PM +0100, Lucas Tanure wrote:
>>>> The 8250 driver creates a fixed set of port slots at boot and
>>>> registers a ttyS device for each one, even when the slot describes no
>>>> hardware. On device tree platforms those slots are empty, but they
>>>> still take the ttyS0..ttyS3 names.
>>>>
>>>> New Amlogic SoCs (S4, T7) name their real UARTs ttyS as well. With
>>>> both drivers built in, as in arm64 defconfig, the real port fails to bind:
>>>
>>> Then fix that bug, don't break everyone else's systems because of it.
>>>
>> Hi,
>>
>> Understood. I thought preventing 8250 from probing on devices that don't use
>> it would be a good idea, and fix my bug. Thanks for the feedback.
>>
>> I will tak to Amlogic list the ttyS name collision introduced for the new
>> Amlogic SoCs in e71aab9d6132.
> 
> That was an explicit decision by Amlogic to do that, so there should not
> be any collisions as their systems should NOT be having the older 8250
> device tree entries.
> 
> So perhaps just fix your device tree to not be broken?
> 
> thanks,
> 
> greg k-h
Hi,

There are no 8250 nodes in the Vim4 device tree.
At __serial8250_isa_init_ports() in 8250_platform.c it creates nr_uarts 
ports unconditionally:

       for (i = 0; i < nr_uarts; i++)
               serial8250_setup_port(i);

And serial8250_init calls serial8250_isa_init_ports unconditionally. So 
by just probing the module the serial ports are created.

Am I missing something? I can also boot with 8250.nr_uarts=0 to make the 
issue go away, but I would prefer a code fix for the colision.

I will take the naming question to the Amlogic list, but I wanted to 
double check my understand of the code.

Thanks,
Lucas

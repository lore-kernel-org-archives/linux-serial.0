Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B73B636A
	for <linux-serial@vger.kernel.org>; Fri, 17 Apr 2026 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421916; cv=none; b=mFP/IkoacaqQH0Qx7PZeVwJcVQqlCrn1ay2SAVSwNyF1dI5SpAT0xkZMFHFreQrYAD3PNU35wTRJ25dm2jNXPGApqP4gio55cMbGwQB45iYUSZ57qELRdVPRnmDrt+zgGZxVy9+vHyBd5nogqmU6yDvZ8ivx/Wx1/G2YMjrEdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421916; c=relaxed/simple;
	bh=dMSa1ZYVHAXRfZPoqn3DEJ0kYY0h2KvNjupT0MmylvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnjqavGf6ZUJXEmzIAcDJYgeg9u2MvgXd9a9zlz3dtKS606c1fOw7xZsAwYdlTgS09kHWKMYv8SEUtkJfSUOjSZUueWLuuoXpMe7jgqtetOihZF7qRTuykAia3rKJJMOnfPVnXYlxsM8QqxSQn35BjPu92NOwbqqo6JrtX+lFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvvxRw5v; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvvxRw5v"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d77f60944so380888f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 17 Apr 2026 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776421914; x=1777026714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0D9fB9YPS5bWDOTVeNiq3WO6cAOHLgc4jMTJXbNx0ZY=;
        b=YvvxRw5v1rtC5mI8Q94ah73K5qcyCR/1XdcNq/9SYmeLO6tLoISzG51eY5hMtY5GH8
         wb/d/S+yWF3AWzjI4b1V8mLibyr3pD7GdcVqvojAN0C6gNcSzi3pt6c18GtxKnqZvLE/
         3BR7aOte4/ox06kkRxQcX6un+rxLyEHbG3u7tw0zRBr7BZHWezUkUMYGuCJf5OS2WOEI
         Hm2I8NdK5NPOLufPjLpZXtON4uJWA9YVWR0J2gllLQqAyF/QijydMW/0KJTSy89BD3sk
         s4zob6wf9XPNTfrVn/ScMnwSW4vWZgt5t342tkyYKkxjQZ+83XFdRPDaTN2b2IWfPsMy
         xPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776421914; x=1777026714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0D9fB9YPS5bWDOTVeNiq3WO6cAOHLgc4jMTJXbNx0ZY=;
        b=ic4QaIDre8F7MHdSJTc1Zkj6uBOdZmEX5giYUxP8egSoAZGzttELKFXjDF7P+o8Ydn
         57hH3b10NwpBfTeumiPK/EzLIzRCLYrnmkD3V5GwrO5bMTC8yB+1DaK9TalSszREJ2f4
         mKsIKBO7NYcWtlmTp7vQlfeeJVrZfN5T8qosuWtPi5VXAOnOPku2dr/1MOCN9DI4vRSj
         5R3stlU+2MBP7oDVdGxI7LDe9CrJStGsEo25q99BU6Aeu7y+byF+5w4vr6uwswc0rFJ5
         LvhrVh6KEblzhfarMDUCaGm1aLH1YWWX5JL/YojdlKR733TERtowvMfsD3w4shE+z+ru
         gUHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+k338B+xAa7oA5REDtJA8knYqnFNxx5yo2Bs8a1i+OdR91UqpUybTwkbAAoinFYiy5+EMX0jXGujnoAq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyttspEPBnST8z8LfSRPp+h6FkU8TvicXB63OY1pLZi1K6eG6eN
	2lwpGk/sJx1ifvrfwB6Hd9Hwef+1igHR9K1hLm9DLGjgcRGjkpR6oD4B
X-Gm-Gg: AeBDievJH8oemHpzNlTDGXwnqoU4HFmdo1zBB2WRu9bahwQ9+xn/BgJjEuO/xSfxvck
	/Mbd5QSNE5fcmsoNeD5PCVpZTlmQKdaG75oxLK8VLMth0KrvETFS3rbw2SxF3hafVf1twnRtcdO
	tRBVsi+6u08sEmgUZLwGg2vY2vWlN5ySoQ2Bw33xt9+SDXcTnD5ttRR5phvQsCWPu3DVL6foDzn
	utT6RDhyr4XVa+xvmU0Cnh3sGGuzspzozGCjHKERmcsJaC1/Vy4SxDcbuMdvR5hxzHXh9omRHw0
	eZ3GNXTwqCxB/6RYIdml0+m3xid1P9NW38q5mXN/tCsUKxDUoQ01MgmOfxFu6ZMfgTIZNWjMZfr
	I4M0ij+cPK4MhmKnF8PVSlqFKBp+tJC75zd/KW31I4itvQ1HyymeFKkDp9vCH0VXwmeRx7LCI2T
	achcIjSnqY3KF/DIc2bDrR8ez7XmNY76CWMYMfDdxakqeSFuc=
X-Received: by 2002:a05:6000:22c5:b0:43d:6fb7:fedb with SMTP id ffacd0b85a97d-43fe3e1645emr3218314f8f.36.1776421913626;
        Fri, 17 Apr 2026 03:31:53 -0700 (PDT)
Received: from [192.168.1.169] ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm3395465f8f.27.2026.04.17.03.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 03:31:53 -0700 (PDT)
Message-ID: <26cd0656-ca76-4cb7-9f1e-b8c042a7e2cb@gmail.com>
Date: Fri, 17 Apr 2026 13:31:52 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: mxs-auart: Compare the return value of
 gpiod_get_direction against GPIO_LINE_DIRECTION_IN
To: Frank Li <Frank.li@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20260416083254.1798-1-zlatistiv@gmail.com>
 <aeHt3c9Fqp6-WdLV@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
In-Reply-To: <aeHt3c9Fqp6-WdLV@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/26 11:22 AM, Frank Li wrote:
> On Thu, Apr 16, 2026 at 11:32:54AM +0300, Nikola Z. Ivanov wrote:
>
> subjust suggest change to
>
> Replace hardcode 1 with predefined macro GPIO_LINE_DIRECTION_IN
>
> Frank
Hello,

I suppose you are suggesting a subject change, in that case I will send v2.
Also I can see that automated code review notes that this will not build
on greg's tty tree as 7.0 is not yet merged into it. I will wait for 
that to happen
before mailing v2.

BR,
Nikola
>
>> The GPIO_LINE_DIRECTION_* definitions have just recently been exposed to
>> gpio consumers.h by breaking them out in a separate defs.h file.
>>
>> Use this to validate the gpio direction instead of the hard-coded literal.
>>
>> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
>> ---
>>   drivers/tty/serial/mxs-auart.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
>> index cc65c9fb6446..6c6df4d5c21f 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -1519,7 +1519,7 @@ static int mxs_auart_init_gpios(struct mxs_auart_port *s, struct device *dev)
>>
>>   	for (i = 0; i < UART_GPIO_MAX; i++) {
>>   		gpiod = mctrl_gpio_to_gpiod(s->gpios, i);
>> -		if (gpiod && (gpiod_get_direction(gpiod) == 1))
>> +		if (gpiod && (gpiod_get_direction(gpiod) == GPIO_LINE_DIRECTION_IN))
>>   			s->gpio_irq[i] = gpiod_to_irq(gpiod);
>>   		else
>>   			s->gpio_irq[i] = -EINVAL;
>> --
>> 2.53.0
>>


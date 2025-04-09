Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF8925E476
	for <linux-serial@vger.kernel.org>; Wed,  9 Apr 2025 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200620; cv=none; b=Laio6owWJFo1K4H2KhexL96sLfWzqT1hJxIeEUmq5HQsa+OKV811fyVeH2CfYpwzEbLcHIhGh6HOvx5J2iivWv/dtL4FTOkacL44H7/TkWIPsc8C4n9xAbTX3/ymy3irLxMXw1xfcJe3yZQUJJ2TPvieEEGfsta9cZNwrlkY+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200620; c=relaxed/simple;
	bh=7EbvCyUEXn2qtD5n42Iv8tV6gC107je0x9KkT+DB1Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sD/K5udTJ75vchHkrW8m66HZI4zezN33u29dbWUkcckz+QFQluBQbo5kHYBtp5m99wc7C/bXRwIjaHzDsml3vDm8WzvrxpfiBYhoESAWJsTp3SbnfVNotogNh9PV3DlJ8Tj7vYgABnFlttfI01VLYUdiwt12OB6PcyuZdjHd8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=1/C1GspJ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="1/C1GspJ"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85db3475637so18933339f.1
        for <linux-serial@vger.kernel.org>; Wed, 09 Apr 2025 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744200617; x=1744805417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZ20LkStNkObd3KEihi6TUJmcbZftlQkn47bOpKz8AE=;
        b=1/C1GspJG8yzgxSoVPr3ZUVnvaU3BB7PKSkRKpxiBZmr2QtZSkzOymmvjT9K6s2nsx
         KjSFvQpviDA/8GMbZrEVxJpNmEJrKjw1vOUuCCgJhtkozK1aKQhibkOGwWzt3rNkIG4I
         lF7Tp7kgWfxyuAQXNMLGGQK0X5kK5iZcoODGRpHY12RJub+QXnxpDk002etGHx3whnUw
         HIUlkZUS6I50eOx//gZOA2n62RucEk4ObalGTOVKPrlXqezDr/ZZxBaJbqtkMmdPBXpv
         t96hIeVpCsQHaQisyYgHIf+K+G6AuFm4McaWZ/F0A++v9Yaaj52150YuQg8HHZ23ppoM
         eSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744200617; x=1744805417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZ20LkStNkObd3KEihi6TUJmcbZftlQkn47bOpKz8AE=;
        b=VZ/X2h8jSKleHellbltBBtRa49NJJRJtP3QJyJXXZE8n4VojpBQAaMeazRAASE9U/O
         F7X5yIsruR8GIUOajFSMJ74nbKR7J3zDJdGCUAIUgEqG2Rmro8nZqxLcoKc484l75ogW
         +4Kp5dyS/Yp41LFPtKUZYJi9pxsCxttROs/2XyeqP0qzzrCZmM7o+e8yzkS16M9VFrda
         UbBNQ9m7Iky1zbHyRAdaZV/F3U55ghGBwc5WqDUCXH213UFegEVWk9LJM68OS/XZH6z4
         H18wb2Cw1PUSgSLGGY5BCp2NDAkqeJTAOzonX7sVGWgPSbVZEdpVBLgLe65YfdQEAQ5k
         54Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWOtI0SO+tcbM6VvmqKy9KspVEDdqu7hHR0n4yISw9FsLZ3C0Veg+x8HdkhBd3ITSeDHpjy8P/Pybc6qic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gwlu/lbjO4WCfg3LjeynJNRZR4HaLkAVfYiwQqwXukhbiEX5
	H73RY/CAvk0YipgCRjt7q7Y2pUz1mU5HfHm/Kx63YcSIHzyFkpGnMdsielaTGfk=
X-Gm-Gg: ASbGnctkB8a0Czqprv0Uef2D/RKJapOaIWXZ5F2qau7SnQE74AkGq/MPrUt0XMbRNdp
	gErCJ8uABDfeOg7ImbeDc6B6p0+zTNMoCxIrIkFp/slyNmHllhzchBpMzmJhyQQgNqTxRNl5bwb
	YFtTQY8JD58iv7mFXGMjADuw6Zl+jNoNpDzTAtH158kteYt6cxt8eXvBZG72VN8BP8Hej4HYcLn
	U1oTyGJV5c95AGy64F1RfejtuT5LvpldUuYUPesJHyglVj4G3iZkk3dxRKaxOl2lNO5usXrD3cF
	n4t/HkikibI5AaWKS03/CEuwpo5TCZagPwTyAqTQEZzr7Dh9DUWufX4wiGV4q1zo1VZmYWJKMsZ
	pSRQW
X-Google-Smtp-Source: AGHT+IHOJ53eVbLiI0OAfSwCZqdwNMQH9qWfpQM+iXRoOuzCIFtY9CzuuScoSIUUfueyiH3NuZt54g==
X-Received: by 2002:a05:6e02:4413:10b0:3d3:de5f:af25 with SMTP id e9e14a558f8ab-3d7035afda7mr62331215ab.0.1744200617264;
        Wed, 09 Apr 2025 05:10:17 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505dfd795sm204358173.97.2025.04.09.05.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 05:10:16 -0700 (PDT)
Message-ID: <0ca876ea-2607-407f-a0e8-98bb4bd94135@riscstar.com>
Date: Wed, 9 Apr 2025 07:10:15 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: 8250_of: add support for an optional bus
 clock
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, benjamin.larsson@genexis.eu,
 bastien.curutchet@bootlin.com, u.kleine-koenig@baylibre.com, lkundrak@v3.sk,
 devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250408175146.979557-1-elder@riscstar.com>
 <20250408175146.979557-3-elder@riscstar.com>
 <Z_V-aKBOFHt-0RKz@smile.fi.intel.com>
 <2b322564-10c0-4bbd-89d9-bc9da405f831@riscstar.com>
 <Z_YhwJ1ZGSodMcMH@smile.fi.intel.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <Z_YhwJ1ZGSodMcMH@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 2:29 AM, Andy Shevchenko wrote:
> On Tue, Apr 08, 2025 at 03:11:10PM -0500, Alex Elder wrote:
>> On 4/8/25 2:52 PM, Andy Shevchenko wrote:
>>> On Tue, Apr 08, 2025 at 12:51:43PM -0500, Alex Elder wrote:
> 
>>>> The SpacemiT UART requires a bus clock to be enabled, in addition to
>>>> it's "normal" core clock.  Look up the core clock by name, and if
>>>> that's found, look up the bus clock.  If named clocks are used, both
>>>> are required.
>>>>
>>>> Supplying a bus clock is optional.  If no bus clock is needed, the clocks
>>>> aren't named and we only look up the first clock.
>>>
>>> Code and description are not aligned. And What you are described above make
>>> more sense to me than what's done below.
>>
>> I want to do this the right way.
>>
>> My explanation says:
>> - look up the core clock by name
>>      - if that is found, look up the bus clock
>>      - both clocks are required in this case (error otherwise)
>> - If the "core" clock is not found:
>>      - look up the first clock.
>>
>> And my code does:
>> - look up the core clock by name (not found is OK)
>>      - if it is found, look up the bus clock by name
>>      - If that is not found or error, it's an error
>> - if the "core" clock is not found
>>      - look up the first clock
>>
>> What is not aligned?
> 
> That you are telling that bus is optional and core is not, the code does the
> opposite (and yes, I understand the logic behind, but why not doing the same in
> the code, i.e. check for the *optional* bus clock first?

Ahh, now I see what you mean.  The result will be the same,
but if it "reads better" that way to you then I'm all for it.

One of the reasons I did it this way was that I wasn't sure
how to express a "don't care" clock name as a DTS binding,
so I just tried to avoid that.

In other words, I thought about adding the "bus" clock as an
optional first lookup, and then leaving the existing code to
look up the core clock by position--without caring about the
name.  But I assume named clocks aren't guaranteed to be in
any particular order ("core" clock *could* be listed second).

So I look up the "core" clock by (optional) name, and if not
found look it up by position.  If it is found, I look up the
bus clock--required in this case.

Now that I write that I understand why you felt the logic was
a bit inverted.

I'll send v2 today and will rearrange the logic to match what
you're talking about.

>>> Also can we simply not not touch this conditional at all, but just add
>>> a new one before? Like
>>>
>>> 	/* Get clk rate through clk driver if present */
>>>
>>> 	/* Try named clock first */
>>> 	if (!port->uartclk) {
>>> 		...
>>> 	}
>>>
>>> 	/* Try unnamed core clock */
>>> // the below is just an existing code.
>>
>> That's easy enough.  I think it might be a little more code
>> but I have no problem with that.
> 
> I;m fine with a little more code, but it will be much cleaner in my point of
> view and as a bonus the diff will be easier to review.

I understand that completely.  Thanks a lot for clarifying.

					-Alex

>>> 	if (!port->uartclk) {
>>> 		...
>>> 	}
> 


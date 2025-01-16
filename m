Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F621DDA14;
	Thu, 16 Jan 2025 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021693; cv=none; b=RlojSK6KMOZfUaAwRnmv0jUQQTFP1NUCocZ4SoZgqNqP1OBPyRRSQJI30War0qn/JyMIqkwWhjEa7/EYk7djq9zWlKpTrgjjDe327764O9IVsfntGIdC1kLJwnfRIBaqh6LZIjBjp3NxAqVMHjf/S9nAhGgK87JB74MKyaAwMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021693; c=relaxed/simple;
	bh=vKrd1S5kPjokp3ALFbH6dwkiWO9sqacDoKnr3ujGd30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0pNJH/SK/0SG5pRJc4JnGbJLv83ippl250OmuY9v/+v8vh4m2OCJt6yLjHqwjz+1HjWondi5Dg0v3h3LYqAMUt5tjiZBOiP+HSDOPMv1JlED2vlSY/rvA+TI/ItBt+w2lqyNVZvn5dmMjiP5SmChn9AeSxw+6YqX6CMZTI7S3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsOJr54/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsOJr54/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C25C4CEE3;
	Thu, 16 Jan 2025 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737021693;
	bh=vKrd1S5kPjokp3ALFbH6dwkiWO9sqacDoKnr3ujGd30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NsOJr54/fKLOTQfFy/l9FfFoFmd+rgSIZm7N+l/ypzGvrf7JXjCWWssBTYSS4UMol
	 3o2rjnyvx1tyhKA8ACnhi5FY+87N8soVwk7ACg3ArzXenhW6p8fjQoyPgX+tVDs2Lg
	 uXzpwl6Wn3q7lEeyolFcyPY98xAzh5pkUcy5pYTzJvaIJjQ8pGhoOrUaeFdcOELf4e
	 PPcLuOh7nPQSTA5kvOZREU1r77l/HI+hIvajDnUkEVVKxOYZ5xXnU1G2yEESiDguut
	 ukZyd1whNRi27NZZaqom6Bi5/Uk4Ya7o4F5Q5xosVlDTHJcT/oJxfS527TOxV+arnl
	 1nQ9UV63/XVSA==
Message-ID: <516509cc-23d9-41b3-a3a2-f0c66d8c2af2@kernel.org>
Date: Thu, 16 Jan 2025 11:01:30 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External Email] Re: [PATCH v1] serial: sc16is7xx: Extend IRQ
 check for negative valus
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: gregkh@linuxfoundation.org, hvilleneuve@dimonoff.com, andy@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 lech.perczak@camlingroup.com
References: <Z4jLU75SU53VGsRU@smile.fi.intel.com>
 <20250116093203.460215-1-andre.werner@systec-electronic.com>
 <be1bc254-da95-47c2-b81c-e630c0f924b2@kernel.org>
 <5556e4f7-79b1-af02-7456-fac9800a173f@systec-electronic.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <5556e4f7-79b1-af02-7456-fac9800a173f@systec-electronic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16. 01. 25, 10:52, Andre Werner wrote:
> On Thu, 16 Jan 2025, Jiri Slaby wrote:
> 
>> This is threaded weirdly.
> 
> Sorry for that.
> 
>>
>> On 16. 01. 25, 10:32, Andre Werner wrote:
>>> Fix the IRQ check to treat the negative values as No IRQ.
>>
>> Care to describe on what HW that can happen?
> 
> I have no example on that. In the previous thread it was mentioned that
> it is not absolutely sure that the API is not called with negative values. Thus,
> negative values shall also be treated as no IRQ.

SPI:
         if (spi->irq < 0)
                 spi->irq = 0;

I2C:
                 if (irq < 0)
                         irq = 0;

So unlikely :).

>>> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
>>> ---
>>>    drivers/tty/serial/sc16is7xx.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
>>> index 7b51cdc274fd..560f45ed19ae 100644
>>> --- a/drivers/tty/serial/sc16is7xx.c
>>> +++ b/drivers/tty/serial/sc16is7xx.c
>>> @@ -1561,7 +1561,7 @@ int sc16is7xx_probe(struct device *dev, const struct
>>> sc16is7xx_devtype *devtype,
>>>     /* Always ask for fixed clock rate from a property. */
>>>     device_property_read_u32(dev, "clock-frequency", &uartclk);
>>>    -	s->polling = !!irq;
>>> +	s->polling = (irq <= 0);
>>>     if (s->polling)
>>>      dev_dbg(dev,
>>>       "No interrupt pin definition, falling back to polling mode\n");
>>
>>
>> --
>> js
>> suse labs
>>
>>
> 
> Regards,
> 
> André


-- 
js
suse labs

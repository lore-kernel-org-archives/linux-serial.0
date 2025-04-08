Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F98253F0F
	for <linux-serial@vger.kernel.org>; Tue,  8 Apr 2025 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143075; cv=none; b=gTt+nGS2GVpeUiUBMtDNmx6XGLV/5D//uv4AYDmSDTUTO28HU2JqCYMLznlZobcCrwM57MmJcJHvW5FGjTcRiAH2W1Y/0fFJ8BZKMc1ttqbnC+Yd9ctIitCR5kQW2eOEYz4RHjdGa8Wh6Sf7gsyoPEH519VczEJ8LtKoQL7BcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143075; c=relaxed/simple;
	bh=NKGR9aNCdAuFjHfEVhQYZVeV11egoapzwZVQAXZ0KhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulnuU0CmJCAllP9jv45XcQU5xKUGD9hKYiuKRK/Wnu6M0phxDRGFxd4hyEIs/SU14iY3qQPZQtudkc6SE2D8zBIbbFfjb2MEGTN7pj00+1BfuxBVsYLRnCn9Bc+4W25XiVuBEoZN1eqCRXhvd2f6nPCqgXMWvTunWGVa+C9BiB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=d6+5PxZN; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="d6+5PxZN"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3fe9fe62295so1689611b6e.0
        for <linux-serial@vger.kernel.org>; Tue, 08 Apr 2025 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744143072; x=1744747872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hy3Mbc+QJnexJzWSQDFuvCjCd9Gg8NAoaKf1OoRHY8k=;
        b=d6+5PxZNs8E2eLcW/C1FMT99NnUfGPkWkt9C2pDWQ7DRE67FF8EBKulcZaAsqtZa82
         oINDDQqw1sTCrPtiDc7CEKbg1NDn+lntk2beMXMJSi7Q/Kw0hPfsZCYMpYp0mClxIaPT
         YT/oyajMxCaZrZ77R9GqFdqw6JgKnEZv3Dm9Fcg1zi2yt3VZlSlDdnhSdH/aE50MDNh1
         e7xMntG2w2CDElxdqSNbKVJ2hZDuu8zObB4MdN6wGb3ajuwI5PTTCCvunf73/URERIfv
         UjiT84rgycRTYVOXRr/Docp5pTvPPzNeodbnljfx0TfH4iEPhRBClV2/Dt6j7V3DzDdr
         FW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744143072; x=1744747872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy3Mbc+QJnexJzWSQDFuvCjCd9Gg8NAoaKf1OoRHY8k=;
        b=IKQWbPkxSNRad4G44VyYCvCR8nhaWdtJKz7ARGnWhGakqFJmwPlyxNcYmDF2N/nTnO
         /+RSWW63SlaYBxeGCgyTNK+8536cgOqE4dpdN4J+Cf99ImMD+/2jmN/IQY0qhRCzBU+H
         ijUQm2gQ5IPFYt0mDGdsl6yxjswWs91x/SRTf4qDdn//vDchN5dhib62zu/bH97vzs3W
         CkyQXk5twwme8XViDvCTuNIrlxIcqwt4CyX0b5M9fiJo3MdNziT6nHhPPLJoywSBjqUF
         U3quyfJpBUozOiUtSU+kN/HT/o3Z1aCvUM2jVpFxTNJ9x6a6gIMB1vGsFX3+I1OsK9MT
         ftkg==
X-Forwarded-Encrypted: i=1; AJvYcCXvoRl7xU5nYZdkU/VcbKSHSuVH4WB3UaV6D6I3fnXsLQLIMPL0EXoHSkfu469jFhq3AJ3W1sONgPQ37lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygNhPO0TR2yYFMAuN4bYjMQtrb6WkGFCUAjTTIFHSfnolA6RT9
	JCyt3tH2pt77UIzxSXMQbzlZoKz5/qV2n7xq7KUjDaxb+X5NuiG7idMrZHxSGyY=
X-Gm-Gg: ASbGnctsQ0rMjx/jpG6COQ4fMox5eC8HsqhNsFLRWYwF7UL3R0TUH/oxjCQZXHPDvCt
	rXwcylVie1r6idNSh5L6cDsM+c2+t8RF3afbhqigERoMGpzm916pZwPJ+aYSHN4X5lrWixKt87F
	OtjYYUHp/Kuv+0blIrllLxBnZZxmcVCbYnEie5rCNOuNTgkOp0v4VHzIFtDKX+QYIgliNoNloEq
	3HUHhOfmvDph738bmsP151ounTI/upMFyKKpT1BThD35GdHF4TIXKxoXo3EQqHrUQgdNSEhBP3A
	+mpJ6ruT/ZcMdhtSdEFBJ5gOfg41s0YdoUons2Sq5BpLdufBRJ2MjWUIpdmBdmQVLWr/gnooMN8
	EkDYRZpS4
X-Google-Smtp-Source: AGHT+IE8nNTgB6dy/XdcKIBtTqym2gMO2UZjpx330tqiOTBJS+T/NPOP1RDevUQcPBjWRVuzwCtREw==
X-Received: by 2002:a05:6808:f16:b0:3f6:ab0d:8dc0 with SMTP id 5614622812f47-4007372de8cmr135170b6e.24.1744143072623;
        Tue, 08 Apr 2025 13:11:12 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-400699fd5ccsm574106b6e.33.2025.04.08.13.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 13:11:12 -0700 (PDT)
Message-ID: <2b322564-10c0-4bbd-89d9-bc9da405f831@riscstar.com>
Date: Tue, 8 Apr 2025 15:11:10 -0500
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
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <Z_V-aKBOFHt-0RKz@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 2:52 PM, Andy Shevchenko wrote:
> On Tue, Apr 08, 2025 at 12:51:43PM -0500, Alex Elder wrote:
>> The SpacemiT UART requires a bus clock to be enabled, in addition to
>> it's "normal" core clock.  Look up the core clock by name, and if
>> that's found, look up the bus clock.  If named clocks are used, both
>> are required.
>>
>> Supplying a bus clock is optional.  If no bus clock is needed, the clocks
>> aren't named and we only look up the first clock.
> 
> Code and description are not aligned. And What you are described above make
> more sense to me than what's done below.

I want to do this the right way.

My explanation says:
- look up the core clock by name
     - if that is found, look up the bus clock
     - both clocks are required in this case (error otherwise)
- If the "core" clock is not found:
     - look up the first clock.

And my code does:
- look up the core clock by name (not found is OK)
     - if it is found, look up the bus clock by name
     - If that is not found or error, it's an error
- if the "core" clock is not found
     - look up the first clock

What is not aligned?


> Also can we simply not not touch this conditional at all, but just add
> a new one before? Like
> 
> 	/* Get clk rate through clk driver if present */
> 
> 	/* Try named clock first */
> 	if (!port->uartclk) {
> 		...
> 	}
> 
> 	/* Try unnamed core clock */
> // the below is just an existing code.

That's easy enough.  I think it might be a little more code
but I have no problem with that.

> 	if (!port->uartclk) {
> 		...
> 	}
> 
> ...
> 
>>   	/* Get clk rate through clk driver if present */
>>   	if (!port->uartclk) {
>> -		info->clk = devm_clk_get_enabled(dev, NULL);
>> +		info->clk = devm_clk_get_optional_enabled(dev, "core");
>>   		if (IS_ERR(info->clk)) {
>> -			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
>> +			ret = dev_err_probe(dev, PTR_ERR(info->clk),
>> +					    "failed to get core clock\n");
> 
> Can be still one line.
> 
>>   			goto err_pmruntime;
>>   		}
>>   
>> +		/* If we got the core clock, look for a bus clock */
>> +		if (info->clk) {
>> +			info->bus_clk = devm_clk_get_enabled(dev, "bus");
>> +			if (IS_ERR(info->bus_clk)) {
>> +				ret = dev_err_probe(dev, PTR_ERR(info->bus_clk),
>> +					    "failed to get bus clock\n");
> 
> Something with indentation happened here and below.
> 
>> +				goto err_pmruntime;
>> +			}
>> +		} else {
>> +			/* Fall back to getting the one unnamed clock */
>> +			info->clk = devm_clk_get_enabled(dev, NULL);
>> +			if (IS_ERR(info->clk)) {
>> +				ret = dev_err_probe(dev, PTR_ERR(info->clk),
>> +						"failed to get clock\n");
>> +				goto err_pmruntime;
>> +			}
>> +		}
>> +
>>   		port->uartclk = clk_get_rate(info->clk);
>>   	}
> 
>> +
> 
> Stray change.

Sorry, I didn't notice that.  Next time it won't be there.

Thanks for your (quick) review.

					-Alex


>>   	/* If current-speed was set, then try not to change it. */
>>   	if (of_property_read_u32(np, "current-speed", &spd) == 0)
>>   		port->custom_divisor = port->uartclk / (16 * spd);
> 


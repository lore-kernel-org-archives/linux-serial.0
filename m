Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5DD1B0107;
	Mon,  9 Sep 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875506; cv=none; b=qzxTvHnXusNGYIe+s9xIhgYNdEatez1Fe8KninkiMD+OkZeZ1RoZ7eIiq9T9amjtp2X+rCxCrLTTHmKSrRPTkTxEfBaPkW2Ha4gUcU3RkcdN/DqcI+0R0IL4RgV9TyFRqsUAptDhtjAyIX8H4QRiohY/TPHIZ/d+g4frUn++vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875506; c=relaxed/simple;
	bh=v//5t/0bjkhgBJiDQenroWTa5RUPXSaUSGG4FMHwedA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQBtIQl1fCqIrQc+m8kuPHwmagoEnNg6nbeEdTvj2tSzpfTR6ffvgc9boCiVZJne9p7fdFfatRtfexh8GLwcVnKvAwuaNiEb7QevdGy1qhvfrEqKHK9BKD8ccrkN9A2nTslnUasWSJB9sItpJfuGmh4nMOrJJ0vuLDn6PO95LyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPvrlfOi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPvrlfOi"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206e614953aso31220845ad.1;
        Mon, 09 Sep 2024 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725875504; x=1726480304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxThiR5nzFK+xrLdN3ioSN/1qBMtAgwpQa7ur9iw0b4=;
        b=hPvrlfOiOBp9XLShqVDiqeJc041yOjbs5mES3NGSwtG2IH0GG0wH/gZWsdELFBO6/G
         c4Pc3zMednQsv0p7g/J+g14nV+dm5lQtA89qCC0bompoVhEjSKWsQh7lfzg6mNYbcok0
         coWtDYxZGxGdmI0lkM3wOhtP4L7lNvamsKZ6kbqSHpXhhACAMeNwWKbaKnIzbQaRgQxg
         rgAfSIndxVkezWY/3tFNozHJ+fT8p49kO2CYsx3ky5TcxBeL3BV5/OIke8GtBsc/x63d
         OPDfOJLwUqHLd4fOAzfsJS7BQLbPJPuvmyqvdaQCR4DsVtLW0yP3bkUMs3l5TyiR7AzT
         DyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875504; x=1726480304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxThiR5nzFK+xrLdN3ioSN/1qBMtAgwpQa7ur9iw0b4=;
        b=Z6wequ5n5BVfIeY3YwgPD4kE/4wLXTGCgPjdxGizCq//FfRp1dhsh25bZ9r0VqetIN
         ksyZV9zXCVCU5l/ZZ23sNZcVVnudJokBbi+0y96bWAqXt2atZ1guM6Rc254MLKn+aWB9
         phcqzwo1XhCKZhJx1F0XTCfZoFnH2ZbTqo8WR42TfhDgkbyWEY0r6ZbkSa6bSydehtWo
         VP0lE6dsIQ6ZWl952B71HNU4mtMG+CO/U/8h/nFdzvNjigneMxFkdXSeDy8ecPjCYfWv
         eNUJrgmVagcgIfTDsdJ0dR0Q6BbKeMpHosgVrPdDPUF4bu/mz0NB6lTr456cRMlv4+js
         a5sA==
X-Forwarded-Encrypted: i=1; AJvYcCUnqyZMsc3iBEEUioJ7vS9p52QBADwp+ww3UapNoNp2Hy+e56rJUbdtDefr5dDnmu4pTDInz0hNK+kR1LxJ@vger.kernel.org, AJvYcCVhYvC8jEoFrbJJfovv1d3jnvjbi2jy+gbAeclypXh62AxhIANcUhqDdBP9Ryud3sVNJWrQjWVXPs69psE=@vger.kernel.org, AJvYcCXL9jlG8I9mMbYZVqO9EnoftlP8JLEdMJu5SyJSQNj+/Uzj0JGal4Ec5RT+RtRIB743XJOUjLet3BmIRtwREduIack=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMmCY3gnjDOSnr0eGaifoYdBZ4g6WIZ5GvXif6iZ+EG31TI5eU
	d6npiz0laD7BFz4FfLHfeEdySUbfn/d+klmqvorr/gH4fgOwq5VR
X-Google-Smtp-Source: AGHT+IFLzyaF+XKIAZGKqTPsXXToAQg6EiMRfk82/uweXHNRCdQrhJ4wH8AMQsWVKzmrGz2I3FhO3A==
X-Received: by 2002:a17:903:2350:b0:205:6552:1099 with SMTP id d9443c01a7336-2070c077273mr100891695ad.8.1725875503992;
        Mon, 09 Sep 2024 02:51:43 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e15cfdsm30915395ad.6.2024.09.09.02.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:51:43 -0700 (PDT)
Message-ID: <1a318d4f-8883-490f-a537-d641cf845a7c@gmail.com>
Date: Mon, 9 Sep 2024 17:51:40 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] tty: serial: samsung: Fix serial rx on Apple A7-A9
To: Kwanghoon Son <k.son@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev
References: <20240909084222.3209-1-towinchenmi@gmail.com>
 <20240909084222.3209-4-towinchenmi@gmail.com>
 <CGME20240909094327epcas1p4bd962fc01182a76c07888e9222572917@epcas1p4.samsung.com>
 <c73a59634ed8eeb099f4d5cb746f3b3e770391f5.camel@samsung.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <c73a59634ed8eeb099f4d5cb746f3b3e770391f5.camel@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/2024 17:43, Kwanghoon Son wrote:
> On Mon, 2024-09-09 at 16:37 +0800, Nick Chan wrote:
>> Apple's older A7-A9 SoCs seems to use bit 3 in UTRSTAT as RXTO, which is
>> enabled by bit 11 in UCON.
>>
>> Access these bits in addition to the original RXTO and RXTO enable bits,
>> to allow serial rx to function on A7-A9 SoCs. This change does not
>> appear to affect the A10 SoC and up.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>>
> 
> [snip]
> 
>> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
>> index 1e8686695487..964a4fbf2626 100644
>> --- a/include/linux/serial_s3c.h
>> +++ b/include/linux/serial_s3c.h
>> @@ -246,24 +246,28 @@
>>  				 S5PV210_UFCON_TXTRIG4 |	\
>>  				 S5PV210_UFCON_RXTRIG4)
>>  
>> -#define APPLE_S5L_UCON_RXTO_ENA		9
>> -#define APPLE_S5L_UCON_RXTHRESH_ENA	12
>> -#define APPLE_S5L_UCON_TXTHRESH_ENA	13
>> -#define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
>> -#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
>> -#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
>> +#define APPLE_S5L_UCON_RXTO_ENA			9
>> +#define APPLE_S5L_UCON_RXTO_LEGACY_ENA		11
>> +#define APPLE_S5L_UCON_RXTHRESH_ENA		12
>> +#define APPLE_S5L_UCON_TXTHRESH_ENA		13
>> +#define APPLE_S5L_UCON_RXTO_ENA_MSK		BIT(APPLE_S5L_UCON_RXTO_ENA)
>> +#define APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_LEGACY_ENA)
>> +#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
>> +#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
> 
> Small thing, but other diff is not needed except
> APPLE_S5L_UCON_RXTO_LEGACY_ENA.
> 
> Kwang.
The other diffs are there to keep everything aligned, it looks like a
jumbled mess here in the email, but in an editor like nano it is all
aligned, before or after this series.

> 
>>  
>>  #define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
>>  					 S3C2410_UCON_RXIRQMODE | \
>>  					 S3C2410_UCON_RXFIFO_TOI)
>>  #define APPLE_S5L_UCON_MASK		(APPLE_S5L_UCON_RXTO_ENA_MSK | \
>> +					 APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK | \
>>  					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK | \
>>  					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
>>  
>> +#define APPLE_S5L_UTRSTAT_RXTO_LEGACY	BIT(3)
>>  #define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
>>  #define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
>>  #define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
>> -#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
>> +#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f8)
>>  
>>  #ifndef __ASSEMBLY__
>>  
> 

Nick Chan

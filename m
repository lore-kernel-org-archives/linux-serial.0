Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8811CD2A;
	Tue, 10 Sep 2024 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937201; cv=none; b=o81KRKfBImcTewbYqWq97x9lRCJCKZmQOFgFilBeGC6HyEjJ8v9dgRm2toxKT/vBT8wwqYZW7asoYZRnx8G4D9kjca9T4jE60tQIm1iiVogf/SyW7LQ5xbSuW3qdFQE0BqI/woOPJYhr0z5/TrL6CAEeHkgwKft/AbrX2OKtv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937201; c=relaxed/simple;
	bh=q0r4Fi61Jn6siHSDM7ItPe/0sg50Syg1vbEZJFerK5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/HoDKqnyAi59sF1kaOpmMyTlTT6ZkkMUKNlUwohM9atwtsPo8kU9WDcJPJTMb9xV4izvmMs5qyPejYkdYKOJObkDS+Cf9gKomoIadLVTwgkGRzHQaEvALYiR+whucnhiBMvtrserAM6W1TD80l1gZxuGRRMcG/3rq17IgmpJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCcpEB57; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCcpEB57"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718e5edf270so1940390b3a.1;
        Mon, 09 Sep 2024 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725937198; x=1726541998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQciPQDkugtAP0hWhW7kTHQAdvMMenMBzmDVXCAvYeg=;
        b=fCcpEB57FJq8OEswqa61KsHoOp31Vwz3FjqOQGh9OA62GHInTAOdGez78HQMTeH2u6
         a1/F5D+0peCbyvwBMfQxmRsSqzrOfQRvcBBUWlJ6FxjiDSpqZ0KbZdugtpXJbR5ry2JV
         1hq26eDub5bIzw7Fv/7J2HYeZXLtDJbVAoMxdiiz7hwef3AcxAH50OOQMHtVI/km/tCw
         LH3jZREoADsNoRhl31iWW0PlYwvF/rjZ9fReeMmjNWdAQdOPDorQ+PsjS28bpKgjqpAx
         4IXPMsGiI5cK6b4EAdJ/cs5DiNcEo4jPU/6LwKslvXKMyOB3UlttnoXd4+20PaHAzKL0
         HzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725937198; x=1726541998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQciPQDkugtAP0hWhW7kTHQAdvMMenMBzmDVXCAvYeg=;
        b=OsfchsdPcOzVQR8AnwbNlNrRiADLcSkFwyg0grk3nDes32GoMJyayeZVb7BwM+E5rR
         dWaQpbT1VRPw/WVbEDxixtRuOwQWAfPQStEAFJ3VmyZ+0TLLiSbPCeBzsXz6Dl809jIz
         htyEy5StWVvWqvrtVj+nWUR4cKbGZRpfb51+ypEHCbuZJskQFNAtB30x1ZMQgw5RIgsB
         eeIjs4IkTLNR+/G+6ctAjKHW/4F6Ry7/RXfpPV1I8h4MbIi7xFpgLCDzU14sqoXsixSu
         5tQDb8KwJCUIgWHQ1kQLP5Namqx7xRDBp8umRfb+zpDfUnz6jpmcesgCZN23DyxZ74W1
         UOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPZyV82TnA6nj3KqzRjMrstt5Q0S2bf2h9iQ8Xgd7Py0N1Dx4hA+QU6AuvK4qGYMfdWgF7wYdiKXNniKBL3BSmB/c=@vger.kernel.org, AJvYcCWZD6WLwuzzEWmO5j0sok904ZiEQ7ja9WhFsmBjqPJuXysq6lANzhHbUw/xWBlCLoIjcxv5Z01urA2OCyaC@vger.kernel.org, AJvYcCXq3hErXmyl3ugUJlmHkz5ZYa53ZgPknV0OudbWV67dddzlGeEO9vIx8hKyuysSGzAEBcQsAJHQqP4Tye8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8o+oTSNFAZ9oiKtB1qQ4oSfrSq9BA2jF3pAjUISWWTPu54o7Z
	rnn3W3u23bDcODQvwJrsuMwTKL4TK/19C7aUWT9Ed0jMuW8g/D3j
X-Google-Smtp-Source: AGHT+IHwRa52fzHU/LUgU2N3g4+TIQrBjfx35+Ouynkyd60bD+P5qo2Sn7JQUtCMN7xdW3NxKn7aMQ==
X-Received: by 2002:a05:6a00:2193:b0:717:81b3:4c6d with SMTP id d2e1a72fcca58-718d5c34f91mr19197697b3a.0.1725937198218;
        Mon, 09 Sep 2024 19:59:58 -0700 (PDT)
Received: from [172.20.10.2] ([49.130.44.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090ad8d7sm403059b3a.160.2024.09.09.19.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 19:59:57 -0700 (PDT)
Message-ID: <866d51a6-1eae-4dc6-8298-df2d608d2507@gmail.com>
Date: Tue, 10 Sep 2024 10:59:54 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] tty: serial: samsung: Fix serial rx on Apple A7-A9
Content-Language: en-MW
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
 <1a318d4f-8883-490f-a537-d641cf845a7c@gmail.com>
 <36a7a634b001bf23ef41daa1b8d7644c6aab133f.camel@samsung.com>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <36a7a634b001bf23ef41daa1b8d7644c6aab133f.camel@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/2024 09:59, Kwanghoon Son wrote:
> On Mon, 2024-09-09 at 17:51 +0800, Nick Chan wrote:
>>
>> On 9/9/2024 17:43, Kwanghoon Son wrote:
>>> On Mon, 2024-09-09 at 16:37 +0800, Nick Chan wrote:
>>>> Apple's older A7-A9 SoCs seems to use bit 3 in UTRSTAT as RXTO, which is
>>>> enabled by bit 11 in UCON.
>>>>
>>>> Access these bits in addition to the original RXTO and RXTO enable bits,
>>>> to allow serial rx to function on A7-A9 SoCs. This change does not
>>>> appear to affect the A10 SoC and up.
>>>>
>>>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>>>>
>>>
>>> [snip]
>>>
>>>> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
>>>> index 1e8686695487..964a4fbf2626 100644
>>>> --- a/include/linux/serial_s3c.h
>>>> +++ b/include/linux/serial_s3c.h
>>>> @@ -246,24 +246,28 @@
>>>>  				 S5PV210_UFCON_TXTRIG4 |	\
>>>>  				 S5PV210_UFCON_RXTRIG4)
>>>>  
>>>> -#define APPLE_S5L_UCON_RXTO_ENA		9
>>>> -#define APPLE_S5L_UCON_RXTHRESH_ENA	12
>>>> -#define APPLE_S5L_UCON_TXTHRESH_ENA	13
>>>> -#define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
>>>> -#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
>>>> -#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
>>>> +#define APPLE_S5L_UCON_RXTO_ENA			9
>>>> +#define APPLE_S5L_UCON_RXTO_LEGACY_ENA		11
>>>> +#define APPLE_S5L_UCON_RXTHRESH_ENA		12
>>>> +#define APPLE_S5L_UCON_TXTHRESH_ENA		13
>>>> +#define APPLE_S5L_UCON_RXTO_ENA_MSK		BIT(APPLE_S5L_UCON_RXTO_ENA)
>>>> +#define APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_LEGACY_ENA)
>>>> +#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
>>>> +#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
>>>
>>> Small thing, but other diff is not needed except
>>> APPLE_S5L_UCON_RXTO_LEGACY_ENA.
>>>
>>> Kwang.
>> The other diffs are there to keep everything aligned, it looks like a
>> jumbled mess here in the email, but in an editor like nano it is all
>> aligned, before or after this series.
> 
> I know why you did. But still there is way keep aligned and only one
> line added. 
> 
> you just added one more tab to other lines.
> If one tab with APPLE_S5L_UCON_RXTO_LEGACY_ENA, then everything will
> fine.
> 
> I think less changes better when see git show or blame.
While as you said, APPLE_S5L_UCON_RXTO_LEGACY_ENA would be fine,
APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK is too long for that to be aligned, see
below without +, - or > distorting everything.

Before:
#define APPLE_S5L_UCON_RXTO_ENA		9
#define APPLE_S5L_UCON_RXTHRESH_ENA	12
#define APPLE_S5L_UCON_TXTHRESH_ENA	13
#define APPLE_S5L_UCON_RXTO_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_ENA)
#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_TXTHRESH_ENA)

Patch 1:
#define APPLE_S5L_UCON_RXTO_ENA		9
#define APPLE_S5L_UCON_RXTHRESH_ENA	12
#define APPLE_S5L_UCON_TXTHRESH_ENA	13
#define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_ENA)

After:
#define APPLE_S5L_UCON_RXTO_ENA			9
#define APPLE_S5L_UCON_RXTO_LEGACY_ENA		11
#define APPLE_S5L_UCON_RXTHRESH_ENA		12
#define APPLE_S5L_UCON_TXTHRESH_ENA		13
#define APPLE_S5L_UCON_RXTO_ENA_MSK		BIT(APPLE_S5L_UCON_RXTO_ENA)
#define APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK
BIT(APPLE_S5L_UCON_RXTO_LEGACY_ENA)
#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK		BIT(APPLE_S5L_UCON_TXTHRESH_ENA)

> 
> Best regards,
> Kwang.
> 
>>
>>>
>>>>  
>>>>  #define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
>>>>  					 S3C2410_UCON_RXIRQMODE | \
>>>>  					 S3C2410_UCON_RXFIFO_TOI)
>>>>  #define APPLE_S5L_UCON_MASK		(APPLE_S5L_UCON_RXTO_ENA_MSK | \
>>>> +					 APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK | \
>>>>  					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK | \
>>>>  					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
>>>>  
>>>> +#define APPLE_S5L_UTRSTAT_RXTO_LEGACY	BIT(3)
>>>>  #define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
>>>>  #define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
>>>>  #define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
>>>> -#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
>>>> +#define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f8)
>>>>  
>>>>  #ifndef __ASSEMBLY__
>>>>  
>>>
>>
>> Nick Chan
> 

Nick Chan


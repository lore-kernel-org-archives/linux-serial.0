Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0953194151;
	Tue, 10 Sep 2024 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978410; cv=none; b=TwPVcjd3t16wi5E1FDCcGDIKRMJ/WJ/lruJWXfJyNDj3MgfEbS/Saw0sGwPbnvFRlvKfFaZ/SpgoDkTsVDR9J75ZZs90MRyqfShtWKz3TV3JHCxPBXJekuS0bjIP4XeDvp4RQ05ctIfGXPMuM/2c+q3RdXRuUekSdQaKE3hK7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978410; c=relaxed/simple;
	bh=hc7NyxgpJ6DbiRHsgdcnzwepguGDZlHND0w3d7+mHNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4ZX7TSi5ACi17gNvb9lH52AjUasVKx3dmnPCYPk2HlJyNS+I/5O/Qf8YSj7pVBwIcTcZrKIddxkQrP9leC6ODD2b+y9DZdTYeoW1KROsDQF4I5Kx9E281tLp8F75r5FhPtDaIQosq92kNfzvUM4bbG7rRw28t7/Nu2mU9XuXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv973UAU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv973UAU"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71788bfe60eso655952b3a.1;
        Tue, 10 Sep 2024 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725978408; x=1726583208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+t6DdrK5yndZ10uTnmpmlxoTF20sSnH2lNklBwPw3IE=;
        b=gv973UAUJ0EWjv5/TmuVQr7iiuH+SxXY/hw1amL8NOelZLS1e3W150YAvLRFJQMofl
         mDU2w/myyo2vRwAGQg3kwodNrMgowU6o1yv6y9LBWzZjg6a/BgSJU0LVbyGO5q6QDNPA
         K1VWPiiJBrbtV8fPZ/+2T6curZbLcUq/zq/E0aOvfif2DnB8A3vl7iybK1Y+H4vuPaRb
         ZTEfgmoFmzqbQbcCHTLk3V14E+8Yjwd7v/Y8otcsHfeh8dIDruWXyWovBywxVlNKOF1H
         rxTRQLiLRLXFPGZ3tBPUSe8utyAa3FqcRXwUxb17TVD6acAURBiQNN38VO5Rj3TsMGrl
         Hhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725978408; x=1726583208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+t6DdrK5yndZ10uTnmpmlxoTF20sSnH2lNklBwPw3IE=;
        b=mszN4tCayGWv3C+6t7ICDwaSWPfAC4sGI7JX82FUY42op4fr8eE3bO0MV5gsHCkEoK
         e0u6QT5Jm8//NoOJ5rPdBIGEh2LyOfU/HcOYEbA/MJXUSpXTPxO6PKpWMzoQWkx9BzUc
         mMVhAxmQi6DUkdunif0ptu9xuGrZVpCDFuWRVk/VeRd68YN0JGeiqOI0HN7ng2GDlyHf
         Ta+ZblYIAaFeJfNrY2Mkq0AKAyuqzfKr8NgJ+99KVCXKj7Ul5vPW8NDqEQbKPQ2TEI42
         8r9+FBX2Bm+nxk0e2RyyJVlw6bZWhA87WN+8QQfWgTb7NVb8DXVmq8gHlEFRLRo1sssf
         pmvw==
X-Forwarded-Encrypted: i=1; AJvYcCU0LcXH1SRsK0jDaZKIR1njVJZ6zyKfyt8nLIpF7O14nsKVH4PlpUoOVY+098eCfO5Ry2yE1Mc0UDew3kQ=@vger.kernel.org, AJvYcCVMxDevHCCrNQMvPay+APQmk6GK1reaNQsHq1rS3R/iqLD3OY2wMtS1uM2Q74xRID+MS4hGB/mN2oDegeC8i9vbDig=@vger.kernel.org, AJvYcCVj6r5ILSBXoaKWQNGHIyHdMpW4mdsuAIXiv4WpM79StRr7pGr3A2+xHMvveazg7ujEbfU0OIBHEwoMRf0A@vger.kernel.org
X-Gm-Message-State: AOJu0YziycpFtGtS7gP3MfMfhI7PjTO6TXfYQrdbmgySPjDqqPI95Ss8
	MJnylJfmwCR8weU3p1A0AC0e9Ls1E6nBJKB+ATO/y4v6nfqfBDDkePmFj/Eoyqc=
X-Google-Smtp-Source: AGHT+IEf3wHNP6yf1vdBPZkHwAbshOdAEbtculahpnCqwG6Zq2HSxCVLlv0APhg8CaZYX2Sbty2Kew==
X-Received: by 2002:a05:6a20:e609:b0:1cc:bb1f:1d4 with SMTP id adf61e73a8af0-1cf5dc246c8mr1477157637.0.1725978407681;
        Tue, 10 Sep 2024 07:26:47 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e3271csm49416375ad.78.2024.09.10.07.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 07:26:47 -0700 (PDT)
Message-ID: <a7f7ccb0-1dd2-4df5-a2ad-1fe4c98d67e0@gmail.com>
Date: Tue, 10 Sep 2024 22:26:44 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] tty: serial: samsung: Use BIT() macro for
 APPLE_S5L_*
Content-Language: en-MW
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, asahi@lists.linux.dev
References: <20240909084222.3209-1-towinchenmi@gmail.com>
 <20240909084222.3209-2-towinchenmi@gmail.com>
 <lbyvuozxjywyt46w2imk2jvwfas3p43wooj2ioyhufwkyg72da@d6stk7xk4rx4>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <lbyvuozxjywyt46w2imk2jvwfas3p43wooj2ioyhufwkyg72da@d6stk7xk4rx4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/2024 20:48, Andi Shyti wrote:
> Hi Nick,
> 
> On Mon, Sep 09, 2024 at 04:37:25PM GMT, Nick Chan wrote:
>> New entries using BIT() will be added soon, so change the existing ones
>> for consistency.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> 
> I think this is:
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
We will see... Got a bit paranoid after bad things happened with v2 and v3.

> 
>> ---
>>  include/linux/serial_s3c.h | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
>> index 1672cf0810ef..1e8686695487 100644
>> --- a/include/linux/serial_s3c.h
>> +++ b/include/linux/serial_s3c.h
>> @@ -249,9 +249,9 @@
>>  #define APPLE_S5L_UCON_RXTO_ENA		9
>>  #define APPLE_S5L_UCON_RXTHRESH_ENA	12
>>  #define APPLE_S5L_UCON_TXTHRESH_ENA	13
>> -#define APPLE_S5L_UCON_RXTO_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_ENA)
>> -#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
>> -#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_TXTHRESH_ENA)
>> +#define APPLE_S5L_UCON_RXTO_ENA_MSK	BIT(APPLE_S5L_UCON_RXTO_ENA)
>> +#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_RXTHRESH_ENA)
>> +#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	BIT(APPLE_S5L_UCON_TXTHRESH_ENA)
>>  
>>  #define APPLE_S5L_UCON_DEFAULT		(S3C2410_UCON_TXIRQMODE | \
>>  					 S3C2410_UCON_RXIRQMODE | \
>> @@ -260,9 +260,9 @@
>>  					 APPLE_S5L_UCON_RXTHRESH_ENA_MSK | \
>>  					 APPLE_S5L_UCON_TXTHRESH_ENA_MSK)
>>  
>> -#define APPLE_S5L_UTRSTAT_RXTHRESH	(1<<4)
>> -#define APPLE_S5L_UTRSTAT_TXTHRESH	(1<<5)
>> -#define APPLE_S5L_UTRSTAT_RXTO		(1<<9)
>> +#define APPLE_S5L_UTRSTAT_RXTHRESH	BIT(4)
>> +#define APPLE_S5L_UTRSTAT_TXTHRESH	BIT(5)
>> +#define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
>>  #define APPLE_S5L_UTRSTAT_ALL_FLAGS	(0x3f0)
> 
> You could make this GENMASK(0x3f, 4)
Good idea, given the above context I think I may add

Suggested-by: Andi Shyti <andi.shyti@kernel.org>

too. And actually it should be GENMASK(9, 3)

> 
> Andi

Nick Chan


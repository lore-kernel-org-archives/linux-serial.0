Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E0205502
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744401371; cv=none; b=apSas1u9SOHzSPfSgfVSmie8xA/FKhxakKSX0H3qsoHgQkHG1pLInHsGswJGJvu4SGtf/DfB7pNON8KGjBSucEhkgip+yzligP7MMrl0M2s69B+ofkZj8MWED/ziPbGDqwNh9aiYJTADFz3P+pXtdmCH4Ootiw4TFyN4BmIdhXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744401371; c=relaxed/simple;
	bh=j9Tizz+SRhxb0fTkfoOzWc/NBGesQAebEneLXbxTKRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyuztt+qXYhrw7l/vjiwA3zzEbHbt7rmx7nSXA5BQ6TBGOIyAtwdRmFLjZdEtUH3ZkGzPr5s9pwqU7GzeOmCB4coYo0aN44M9YoVWY8Qe2BZPvi9asGpHQn7crIKo9zpFuphd8Wq+L3lvJlf+ArHDSx4R2y2cYD1F0kbSMArhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ICbhKt4s; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ICbhKt4s"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85d9a87660fso202579139f.1
        for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744401368; x=1745006168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pERBQu6v36RmU72wS1eWJUx4EztB8M6FCvDbPo24Sik=;
        b=ICbhKt4seggfsPI2MVCvd1mL6sfUFbxsygcOFFyRWwH0m7MegWYVvtsyxsqgQ86j+C
         Esg4kypN4miVEfUYcGyiA4FjuS1gH+XZbycN4od1B3ueJOoPbUizUPRJwoXIjryneXHc
         J6oLoDME1yr3s5eHXm9Ufoq9Hqb3yFjAeFxCpw0YB4UP6XEY7LCmSf5uMtg2CiPpau29
         x2jZtGqG1rdced4iAXLyaq7v9YIWXs1/3HQr8bzR88Z3jfHlVKuA4Y69OmPbk5oB73Kp
         ieMgLVW8vZRa56Ar9T6Q64JctlGz2QYF0m+i2YHv3KR0eCCUW9Mdym4H4ovTE6A1rfEh
         p5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744401368; x=1745006168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pERBQu6v36RmU72wS1eWJUx4EztB8M6FCvDbPo24Sik=;
        b=vUD/21mWa4xuuwPBfuuC1ro9MZTWUouX9X/58B0av9UgAwtnazGAAVR4r6fCt6xuG1
         v6he7Y/VKrFdpxQnLocEJcnpwZVNe05kdgUqFoIMNO1y3bOctdvkYpcNdj/iVCn/aGcL
         rNHdeoANamXaCbV60NPd4ysf0c0grwilNCYMVfLWBnSmEao/F0V3Ens/uhqF+NFjltuy
         f/YgTRoPyDzl4pI1kyFKW765LCJ6Lyr+UBUIAAQa+F1izDcwluMtzK14N85Kutk7jkwz
         7qcAObZJdyFDbxQDcis12o2tyMFONNyln6CFArXVYuWi5Vde42kjhAQDpvd/lBSl+e45
         E7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx2OEjEqRRfU0GgRd8Rx3v/uN0b0ngNEqZnnsLvNdYoHI1bjbkn9YugV3gQQbx2Ef4iNSvSUUUD1rLZzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21IhtWhtL08SxCbfFzmgX9air3UHhkWsaJ+Y4ev357Q14WiNn
	kSo5wzIqlO+bNF3TKHZMzsVLBYGue8T7lUEeEqvM51g/TgXrGq8ovtPko1GPsgY=
X-Gm-Gg: ASbGncv3otnU+bDAtuQszb3fM5/rwj3+U07t2wCCBh4tNjU4jfTno4tr7t92mCizf3S
	5sjskQfysEUMzeYV7gtJBpssyqnvJCKE2By5aFd1swFrILaW2/c/cM1Qg4TnMbzR2y06R4OpyZ7
	voWnrU3Ljrqcv4pqEkXjr7DGc3YdLg9boalP7pTAkqbTki+AweBLAEtS94rJqPZZ8WayUCg8Ssr
	K6vl0CSculrtjMm2ZuJHJo3anegpNTYO4TF4wNGNUNBvHsd3pMuSTwzbVvkQ+shA/6Z+Dyp6005
	sB+Q6AhTXwjCIsTNcmvmFXK/Uev9IFCatsbkW8AlN40/uq14/cUP/XBLD7VlR0650U4Mio9xEIV
	DHsk0
X-Google-Smtp-Source: AGHT+IGGVgYOqXyinnwT6qaZuwXYKc6jVRRPKYnkZ8fNRAGpPWFR1hWfOKnlDOwqftP7FLSw5NTERg==
X-Received: by 2002:a05:6e02:184d:b0:3d3:e3fc:d5e1 with SMTP id e9e14a558f8ab-3d7ec1cb49bmr44622035ab.1.1744401368624;
        Fri, 11 Apr 2025 12:56:08 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dba6704esm14337435ab.12.2025.04.11.12.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 12:56:08 -0700 (PDT)
Message-ID: <925ea396-fd60-460e-a3c2-968d0d837a61@riscstar.com>
Date: Fri, 11 Apr 2025 14:56:06 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] serial: 8250_of: manage bus clock in
 suspend/resume
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org,
 benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com,
 andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com,
 lkundrak@v3.sk, devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250411154419.1379529-1-elder@riscstar.com>
 <20250411154419.1379529-4-elder@riscstar.com>
 <Z_ltyAO-OBzl0adV@surfacebook.localdomain>
 <a3b2d0cc-c055-4cf0-9e03-3ea73041642a@riscstar.com>
 <CAHp75VchEcpP67oPC8xD+tYrY_A0BGSJqK=1au939-W60_qQoQ@mail.gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <CAHp75VchEcpP67oPC8xD+tYrY_A0BGSJqK=1au939-W60_qQoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/25 2:44 PM, Andy Shevchenko wrote:
> On Fri, Apr 11, 2025 at 10:36 PM Alex Elder <elder@riscstar.com> wrote:
>> On 4/11/25 2:30 PM, Andy Shevchenko wrote:
>>> Fri, Apr 11, 2025 at 10:44:18AM -0500, Alex Elder kirjoitti:
>>>> Save the bus clock pointer in the of_serial_info structure, and use
>>>> that to disable the bus clock on suspend and re-enable it on resume.
> 
> ...
> 
>>>>       if (!port->uartclk) {
>>>> -            struct clk *bus_clk;
>>>> -
>>>> -            bus_clk = devm_clk_get_optional_enabled(dev, "bus");
>>>> -            if (IS_ERR(bus_clk)) {
>>>> -                    ret = dev_err_probe(dev, PTR_ERR(bus_clk), "failed to get bus clock\n");
>>>> +            info->bus_clk = devm_clk_get_optional_enabled(dev, "bus");
>>>> +            if (IS_ERR(info->bus_clk)) {
>>>> +                    ret = dev_err_probe(dev, PTR_ERR(info->bus_clk),
>>>> +                                        "failed to get bus clock\n");
>>>>                       goto err_pmruntime;
>>>>               }
>>>>
>>>>               /* If the bus clock is required, core clock must be named */
>>>> -            info->clk = devm_clk_get_enabled(dev, bus_clk ? "core" : NULL);
>>>> +            info->clk = devm_clk_get_enabled(dev, info->bus_clk ? "core" : NULL);
>>>>               if (IS_ERR(info->clk)) {
>>>>                       ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
>>>
>>> While the first patch against this file looks okay now, this one inherits the
>>> same problem (seems like not enought thinking about the code representation).
>>>
>>> Instead of rewritting half of the lines you just introduced (which is also a
>>> bad practice), add a one-liner that assigns a field to the local variable.
>>
>> So you want me to re-spin this again so that I use the local variable?
> 
> Yes.
> 
>> I understand what you're saying based on ease of review,
> 
> No, not only review. Here the main issue is ping-pong between patches.
> If you know ahead that these lines should be changed, do it from the
> start. But I understand the need to have separate changes for
> logically different pieces. That's why

I did do it from the start (v1 of the series).  Then I reworked
it based on your feedback and concluded there was no need for
keeping a copy of the bus clock in the of_serial_info structure.
In the interest of keeping the code simple I dropped it.

Yixun asked me to disable/enable the bus clock in suspend/resume,
so I was preparing the patches for that, when Greg informed me
he had already accepted the first two patches.  So I added this
new feature on the end.  This is the reason for this "ping pong."
I would have done it from the start in this series otherwise in v3.

Anyway, I'm sending v4 shortly.  I just have to run it through
another test.  It is indeed a much simpler change.

					-Alex

>> but this
>> is a simple patch
> 
> It doesn't matter how simple it is.
> 
>> and the change is very understandable, and the
>> code is no more or less clear when using the local variable.
> 
> See above.
> 
>>>>                       goto err_pmruntime;
> 
> 


Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8BE1DA27
	for <linux-serial@vger.kernel.org>; Thu,  7 Mar 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833437; cv=none; b=UIASkptSVlRnkr5/T0F3IaHgcnFckVighbyZLVwJBJ3SauK9A8ZQtSS5P31dgOl3q9QBijmmPjADDMTxRoEuA5Be94L6FY6tYLFWoM/7sdREx7PTcrq32jrKBiHtoFHQ+0N3GFcdweNPjsgR3pj/+ufVI4xWRP/M87Ef1eRn/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833437; c=relaxed/simple;
	bh=dZeYXOSdY/4jvJAj6fxXOeE1w+W/IjR8pzn1Uxxjfl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEGZomf1Gcg/UsAvLy68x02il3Iw616pTEwt7LdDkFGnaSwx7WvHEq6URvo9Va26HwhHBXog82EayZeo8yynRcLfIkZwbwNneCwI4E0d9RdBRG/UzJjMbNeJtJeZgCcc6eripger3yTgyFCeaZL2r6f/7Z1f1vqt9gM6teo7DT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=X/7ja346; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X/7ja346"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d5c2502ea2so19508241.1
        for <linux-serial@vger.kernel.org>; Thu, 07 Mar 2024 09:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709833435; x=1710438235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGhxsCrSlIL1H5bPGz05hojfL4uxXqMBgjkZvvXNIfs=;
        b=X/7ja346IodkbWhOZwmIDyfKHD1xTJmwUOiu1xdeJvx+Jv0B7Zy5RtaA0km0mjK3q6
         h4FUozrDJOyJPZXgMXYnAbTq5EMukLIYlnnz2lgjA5hrqov8vFmIVOQHZH51ZSl3iu8o
         iNQM3ubJNOvE2tTkMYcJOxuSsDl/9zeEkK/k4ryWrVSP4/Wy530fQu9aPR9LvXnunBrQ
         ll8l+KbeVosNh0cJx2PNDQN60IllHtBLDLWQLypdFErUuhrKC0BV0p+vcIMSB9sDJyiA
         ZaSDi5OKQGZCHhPAAwAJNuMl4M6KZKVNiGDXslk92WSed7I9QnandBWU28YvbE6BPdo8
         x0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833435; x=1710438235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGhxsCrSlIL1H5bPGz05hojfL4uxXqMBgjkZvvXNIfs=;
        b=St5sqZg7P478Rfr9MF+Nh5z93+d+jP+j/lAJAxTWfItxYBHGOGTzWweXFWJhA1V3Pd
         hxsZ7RQLlVgEzlx0vqST+tSwmJ7H+FsDv9dm3XHyDVBfMb9g7NceHSoAaa8zA8eVV8YP
         5Sz8+ZXnxsrRCcGLUaLCD1fUTEQlOJhovyN0W1XjS1SU2bUoivarLGyaAYSEzhJou6ZU
         o20tyI6H60/l12sMBl7zXXnv9nQydAz19dGghue1XviftE5Yu0azZtTCr8ysBgHj51Kf
         Hrj1l99nuaKbwjD3os9P+JeWihU5UVmAv6hGg8IIj3pyNJhr2HazOnAgUl1uwVaijtVo
         afsA==
X-Forwarded-Encrypted: i=1; AJvYcCXD2vgFo74KDtHw42SIEB8nnec47w6QpGCHfVwc+xgTUGwGxrHGQVVTlLgtkaojSFV5gMjmTnbUNiUlIv2rs//eGHkKKHVKSXjs4azs
X-Gm-Message-State: AOJu0YysIWlw+HX8BA0He4cNuFEud06VsG4V6p6KpkiNodTtoHlw/NDi
	gdZ4WDrKhEGgJ5uhTrYhQqgu2oq6Ks2nHtv4/E7gohO1tmUPKoGRZ25lWf92oSE=
X-Google-Smtp-Source: AGHT+IHmKnQCHSzfI8s8d2OPjXV6i3chOIHlVgGQnD/3C11o0velNtkBVN4Qz0YnOiMcDdD/zL06Fg==
X-Received: by 2002:a05:6122:2912:b0:4d3:48b9:3c91 with SMTP id fm18-20020a056122291200b004d348b93c91mr9559208vkb.5.1709833434964;
        Thu, 07 Mar 2024 09:43:54 -0800 (PST)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id vq5-20020a05620a558500b00788242166dbsm4994715qkn.133.2024.03.07.09.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 09:43:54 -0800 (PST)
Message-ID: <4d85215e-64ca-491c-8f69-f2c83c7e72d7@sifive.com>
Date: Thu, 7 Mar 2024 11:43:53 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sifive: Remove 0 from fu540-c000-uart0 binding.
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20240304105947.SJcVAdr1@linutronix.de>
 <20240304-whomever-gladly-d43da7ad2fe6@spud>
 <229b34c1-5419-93ae-0a6f-a21cf4e4a276@sifive.com>
 <20240307090950.eLELkuyK@linutronix.de>
 <20240307-sacrifice-dares-09c91fc8fefe@spud>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240307-sacrifice-dares-09c91fc8fefe@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor, Sebastian,

On 2024-03-07 11:39 AM, Conor Dooley wrote:
> On Thu, Mar 07, 2024 at 10:09:50AM +0100, Sebastian Andrzej Siewior wrote:
>> The driver is using "sifive,fu540-c000-uart0" as a binding. The device
>> tree and documentation states "sifive,fu540-c000-uart" instead. This
>> means the binding is not matched and not used.
>>
>> This did not cause any problems because the alternative binding, used in
>> the device tree, "sifive,uart0" is not handling the hardware any
>> different.
>>
>> Align the binding in the driver with the documentation.
>>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> On 2024-03-06 18:48:13 [-0800], Paul Walmsley wrote:
>>> On Mon, 4 Mar 2024, Conor Dooley wrote:
>>>> I suspect that the driver is what's incorrect, given there's little
>>>> value in putting the IP version in the SoC-specific compatible as it's
>>>> a fixed implementation. I'd change the driver to match the bindings.
>>>
>>> Agreed
>>
> 
>> I didn't add any stable/ fixes tags as I guess there is no point in
>> backporting this.
> 
> Every documented device falls back to "sifive,uart0", as you mention
> above, so I think that's reasonable.

Right. In fact this means the sifive,fu540-c000-uart compatible can be removed
from the driver entirely, since the driver would match sifive,uart0 anyway.

Regards,
Samuel

> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.
> 
>>
>>> - Paul
>>
>>  drivers/tty/serial/sifive.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
>> index 0670fd9f84967..cbfce65c9d221 100644
>> --- a/drivers/tty/serial/sifive.c
>> +++ b/drivers/tty/serial/sifive.c
>> @@ -761,7 +761,7 @@ static int __init early_sifive_serial_setup(struct earlycon_device *dev,
>>  }
>>  
>>  OF_EARLYCON_DECLARE(sifive, "sifive,uart0", early_sifive_serial_setup);
>> -OF_EARLYCON_DECLARE(sifive, "sifive,fu540-c000-uart0",
>> +OF_EARLYCON_DECLARE(sifive, "sifive,fu540-c000-uart",
>>  		    early_sifive_serial_setup);
>>  #endif /* CONFIG_SERIAL_EARLYCON */
>>  
>> @@ -1032,7 +1032,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
>>  				sifive_serial_resume);
>>  
>>  static const struct of_device_id sifive_serial_of_match[] = {
>> -	{ .compatible = "sifive,fu540-c000-uart0" },
>> +	{ .compatible = "sifive,fu540-c000-uart" },
>>  	{ .compatible = "sifive,uart0" },
>>  	{},
>>  };
>> -- 
>> 2.43.0
>>
>> Sebastian


Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A521B85EF;
	Sat,  7 Sep 2024 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725715358; cv=none; b=EcVBCBaMvIdmNb49CfbQh2CggSI4bnYyffbh7fyoL87Alc2u5NKgXAy9qbKpCqto+nicYY/yy3wf4rxZQPJ/DkJ+QeuXzjWhtD5haechf3h9NAzsyoB/DVkPJk8Txb+Ycz+Ry0bsOT8I5cCCpF8TSjBPAGDnIYwTchyB1eJL21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725715358; c=relaxed/simple;
	bh=hbSkz6bDI6cLFbwXFJV6dDhT57AZB9GSy+xISrmGrQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvMH7NZwFaSSIiYwjo8wSdIPnj/jg787tsDRKQC8dyO08JYMJrUVKLpAnuUPfrE4rE0JtDwq692hJCQzKCrRcUpuhZPIumgs5XcFGIChLi0JvgMw+R989Pvlu8QMDdspp4lwHphu6fAig5khd7laocukiw8zxieTBfwTwSHedFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=karCzz34; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="karCzz34"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d885019558so2202357a91.2;
        Sat, 07 Sep 2024 06:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725715356; x=1726320156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0r0BvC0JYwjLynqTsK9rmwWO+bU4XTC1+gIg1Xr9eo=;
        b=karCzz34L9eJXBQMsImaSY3DfQQQoWdfWVvXSFS0g2av0ysbaUcMbdHpWMxNSEqTZp
         9wxtnoNWZXK3k16NOJ3nQh7T61QUZgSHRCKwmt2j94if32ef9VlqrRqQDmqKPzK3S3Vd
         x7XQqQtVxftKrM3uLFpsBi54JTmrK35xJzeS6hhU46LsIRrWzn5yWoaLC9HGgUN1lkx5
         cTy8bTZhwjaL7Wx4HGO/T7MRry3d/SApbwjQh/BfPtvZTbfr6NopKTa1aQQCrQ82yGUb
         gMtBBzv9VEHok4tucqJu0dzSjNO1oLZ7OzALqFhSJ58m8Z2lYrtypjCDxsU+EYbaZguO
         txiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725715356; x=1726320156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0r0BvC0JYwjLynqTsK9rmwWO+bU4XTC1+gIg1Xr9eo=;
        b=rJC06pKAE1xRlJDmZYEMNqgDPrR7zy0kitVkHjE8NXl7dxPhpv00VGEz7lNN0OYkF8
         yfEuXQsQyz7KIbluR/ojHb5yTY/FOBnE29mcxKe3XTO8x3oYgvfmg8MwsghCJg81gNqP
         2crkDYCaFSobxnbarp9W83CizitX89VgV808hbuj5EVnipoVdYWPp46MkFyhOeP0RuFe
         sEHr+r3PRBD7O/QE0KbIVMQ2dtzVQvJKTiOtizKepSQzoxKwTiOS2JVRm7RtABDoSefw
         gZvBSuoMIsG3/GnwTjViSTlsCS+NprkhzPlfdG/oPxP7JbnZ2gyfN2oinG9ZWnm+fA8W
         /F/g==
X-Forwarded-Encrypted: i=1; AJvYcCWGq8t7mDpGQ3MMYtllQhEfqa29+mCwUqsO0PdbavpsFrM1g4HZkas2Fb0L13FKN+xb63mKKcDfNDfprj4=@vger.kernel.org, AJvYcCXB92+NRQv5VFMmyNw8XKtWhMsc3Zrr35rkINkQx/fmT8TGzT9qsU9qW1GrI4r5RFDIqLiYCH2nGH/6O//8VCR/67Q=@vger.kernel.org, AJvYcCXi0I3L2g3H58B1XE+tAmusMB2JKZPGoMFZ8JDxZ8nRYeqXsOq+mzvztpaTh8JaH9Hdnz3gFUEP11nPrOsv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+mao+SwRO+R+wYKSCfwHiLMJjnTRpsnmDm0hqYxsR7Hx+jq4
	KXeqYx7EwbH31dHqQ/fgDUN646ZY+0HLi28E2Y9s+m3hOn8DS91xqf8y48U+O9k=
X-Google-Smtp-Source: AGHT+IHdVHLUbDTTXz6BefBZHbxE7BD7z1FDmqLP55VkGFikFJgclg5egAWIQWqUu90Qh+mLNT47dQ==
X-Received: by 2002:a17:90a:c08b:b0:2c9:359c:b0c with SMTP id 98e67ed59e1d1-2dad5181bc6mr5654503a91.28.1725715355933;
        Sat, 07 Sep 2024 06:22:35 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe46d4sm3370238a91.1.2024.09.07.06.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 06:22:35 -0700 (PDT)
Message-ID: <378c9865-270f-4a36-8614-ecff6f0236ce@gmail.com>
Date: Sat, 7 Sep 2024 21:22:31 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tty: serial: samsung: Fix A7-A11 serial earlycon
 SError
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev
References: <20240907111431.2970-1-towinchenmi@gmail.com>
 <20240907111431.2970-2-towinchenmi@gmail.com>
 <440be61d-b60e-4179-8481-b9a7a0dabae5@kernel.org>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <440be61d-b60e-4179-8481-b9a7a0dabae5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/2024 20:54, Krzysztof Kozlowski wrote:
> On 07/09/2024 13:06, Nick Chan wrote:
>> Apple's earlier SoCs, like A7-A11, requires 32-bit writes for the serial
>> port. Otherwise, a SError happens when writing to UTXH (+0x20). This only
>> manifested in earlycon as reg-io-width in the device tree is consulted
>> for normal serial writes.
>>
>> Change the iotype of the port to UPIO_MEM32, to allow the serial port to
>> function on A7-A11 SoCs. This change does not appear to affect Apple M1 and
>> above.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  drivers/tty/serial/samsung_tty.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index c4f2ac9518aa..27b8a50bd3e7 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -2536,7 +2536,7 @@ static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
>>  		.name		= "Apple S5L UART",
>>  		.type		= TYPE_APPLE_S5L,
>>  		.port_type	= PORT_8250,
>> -		.iotype		= UPIO_MEM,
>> +		.iotype		= UPIO_MEM32,
>>  		.fifosize	= 16,
>>  		.rx_fifomask	= S3C2410_UFSTAT_RXMASK,
>>  		.rx_fifoshift	= S3C2410_UFSTAT_RXSHIFT,
>> @@ -2825,8 +2825,10 @@ static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
>>  	/* Close enough to S3C2410 for earlycon... */
>>  	device->port.private_data = &s3c2410_early_console_data;
>>  
>> +	/* ... however, we need to change the port iotype */
>> +	device->port.iotype = UPIO_MEM32;
> 
> If there is going to be resend, then this comment is redundant and can
> be dropped - repeats the code and does not provide any explanation why.
> 
> Which would also make the patch smaller and easier to read. See GS101
> earlycon.
I agree that the comment is quite useless as-is. However, I think it is
worthwhile to mention that A7-A11 expect MMIO32 register accesses here,
as someone looking at this code is likely using one of the newer SoCs,
which does not have this restriction.

> 
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof
> 

Nick Chan

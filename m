Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B0125DD
	for <linux-serial@vger.kernel.org>; Fri, 23 Feb 2024 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670532; cv=none; b=EwJnKYNa4GMBscf8HGrBLhRJvi6/FqS6r6WetdQmIuReKoY1Qsr/mkkWSVA+k+0KuCm0eBoy/HBriiFSIwaLWxu2Grl0EmHtLtXXVuRnPIAb1QY4IwsRmzwjpARiII0JhkRfO7AiIlMxLfL3KQOBmiwTuD37N51jrZmA01FCHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670532; c=relaxed/simple;
	bh=WfcVna4D9/Fitjx5Zx2KhnKgcEj+rDkoCRY2w+9h/EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOzpkU0A/txAfMTexXoeJqfQMWxffmnEyphrhZ8/LOu9/MmP/Ft2MYAaJPuqj0dfblLtYvnE650V+EKe4lBUCfnlF1OV1Xgxj4KZ6xvfZKjQh3HJQZ+ZskP+1VvcXmSOt4zPvOU9Nq7HHyo0qhXjx/vrqNhOngZncsEjZiPkDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d22fa5c822so7304031fa.2
        for <linux-serial@vger.kernel.org>; Thu, 22 Feb 2024 22:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708670529; x=1709275329;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87rNbzQXWBuxzBiyrHT0FGAnir2v/SVomTZ+ou/qdfQ=;
        b=N0WpNcGK+QEVufOTe0zlTm2vHMRn69eTsdVGEYagUlt35eh8W/aEVa2JGIvCDAIGax
         2JwVMlWqMuGFgj9P0dWybcQpjJLquSYFWgiC9b+FpRoGXVaxEOrXkoRjpWdwUY2to3DQ
         NKhQ6oeJyeVfu5bULwSN5Xq/U5KX3XGwm4iStdsSA8oNb7cdRC2D/Carf/ksxvtXxZBP
         MRGaqredgATuhUgL/2Qa+GfVwNGum0A9N97/rMn+6KaxZswJFjXIaey/eCBWcuTKE2+M
         4mZO++yzZLVKKzFJaXQXv9O/sNe/uGqEPLxDksKRFQGii5plphcJs+RfJd6gQEsJZllG
         SDww==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1LyOisSkRRYSKVz2j1EJ91/GZWiHTBZA3EpMj1f2WCDG15IE7ZQDCvt/S/Jw7rOAjuOmwip10TPIOuGLr7ku8I2R1WcCDQ20GNN7
X-Gm-Message-State: AOJu0YxeBd3rcpA2DsDlAz/XF51T3xM9o3qmbu/bgq7mdLo6V07uKnxM
	1ExHDOyB+Bmnp6vZrR7bGlUeZYwVGt/C3AlpAKo7+gJIPVVVPpUW
X-Google-Smtp-Source: AGHT+IE86VQtqZilxBOVVy8dU63e31TQmrYQxzkEV6tLxM3EDk/Cr6WQSTslkC68yUSoBc2FWX1x2Q==
X-Received: by 2002:a2e:9051:0:b0:2d2:7392:5057 with SMTP id n17-20020a2e9051000000b002d273925057mr196673ljg.30.1708670528726;
        Thu, 22 Feb 2024 22:42:08 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id bi13-20020a05600c3d8d00b004128808db91sm1155744wmb.23.2024.02.22.22.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 22:42:07 -0800 (PST)
Message-ID: <751d67fe-59e5-4159-b674-924de4dfb959@kernel.org>
Date: Fri, 23 Feb 2024 07:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: serial:support: Using 8250 driver With MOXA CP-132EL Device
Content-Language: en-US
To: andy.shevchenko@gmail.com
Cc: Federico Vaga <federico.vaga@cern.ch>, linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org, Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
References: <zmry3u7l7dzh2iqqonxyombv4v2nzpr3fccoe677laxc2jn6nm@mo4afecdt45o>
 <v7jpnrrgmjqgmtwrahwmd6vouv2opuhwxaeo6ouimojql7lv3j@zqhwaky2lqki>
 <ZdfKxqwuJZodRDbz@surfacebook.localdomain>
 <ZdfL68clwFIYI4tG@surfacebook.localdomain>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ZdfL68clwFIYI4tG@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ccing Crescent.

On 22. 02. 24, 23:34, andy.shevchenko@gmail.com wrote:
> Fri, Feb 23, 2024 at 12:29:26AM +0200, andy.shevchenko@gmail.com kirjoitti:
>> Thu, Feb 22, 2024 at 10:21:38AM +0100, Federico Vaga kirjoitti:
>>> On Mon, Jan 22, 2024 at 11:52:15AM +0100, Federico Vaga wrote:
> 
> ...
> 
>>>> I'm having problems in trying to use the MOXA CP-132EL card with the 8250 driver
>>>> on the stable kernel 5.10.192 (but I also tried the 6.1.70). It seems not to
>>>> work. As a note, to do my tests, I have a loop cable connecting the two on-board
>>>> serial ports.
>>>>
>>>> I see this device should be supported by the 8250 code, in particular this
>>>> appears in 8250_pci.c
>>>>
>>>> ```
>>>> $ git grep 132EL drivers/tty/
>>>> drivers/tty/serial/8250/8250_pci.c:#define PCI_DEVICE_ID_MOXA_CP132EL   0x1322
>>>> drivers/tty/serial/8250/8250_pci.c:     { PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
>>>> ```
>>>>
>>>> At boot time the device is correctly discovered, and it matches the driver.
>>>> Indeed two new tty interfaces appear under `/dev`
>>>>
>>>> ```
>>>> $ dmesg | grep 0d:00.0
>>>> [    0.196175] pci 0000:0d:00.0: [1393:1322] type 00 class 0x070002
>>>> [    0.196350] pci 0000:0d:00.0: reg 0x10: [io  0x4000-0x403f]
>>>> [    0.196448] pci 0000:0d:00.0: reg 0x14: [mem 0xb0100000-0xb0100fff]
>>>> [    0.196534] pci 0000:0d:00.0: reg 0x18: [io  0x4040-0x404f]
>>>> [    0.197474] pci 0000:0d:00.0: supports D1 D2
>>>> [    0.197475] pci 0000:0d:00.0: PME# supported from D3hot
>>>> [    0.371301] 0000:0d:00.0: ttyS2 at MMIO 0xb0100000 (irq = 16, base_baud = 921600) is a ST16650
>>>> [    0.371832] 0000:0d:00.0: ttyS3 at MMIO 0xb0100200 (irq = 16, base_baud = 921600) is a ST16650
>>>>
>>>> ```
>>>>
>>>> The communication seems not to work. However, the communication works when using
>>>> the driver provided by MOXA (``mxupcie.ko``).
>>
>> Shouldn't we use mxser in the kernel for MOXA?
>>
>>          { PCI_DEVICE_DATA(MOXA, CP132,          2) },
> 
> Ah, letters matter, we have only these there
> 
> #define PCI_DEVICE_ID_MOXA_CP132        0x1320
> #define PCI_DEVICE_ID_MOXA_CP132U       0x1321
> 
> But maybe it should also support 0x1322? Dunno, I believe Jiri knows better.

No, it's a different kind of devices. There are moxa and mxser drivers 
for specific devices and then 8250-akin moxa devices handled by 8250 
(like this one).

The support seems to be incomplete though. 132EL seems to be a 
422/485-only device, but 8250 doesn't care.

Does it magically start working if you set 422/485 manually via 
TIOCSRS485? But I doubt SER_RS485_ENABLED is set anywhere...

Crescent how are these 422/485 devices supposed to work?

Oh wait, you may need:
commit 43f012df3c1e979966524f79b5371fde6545488a
Author: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Date:   Thu Dec 14 14:02:34 2023 +0800

     tty: serial: 8250: Set RS422 interface by default to fix Moxa 
RS422/RS485 PCIe boards



which landed only to 6.7.4. Care to try that out?

thanks,
-- 
js
suse labs


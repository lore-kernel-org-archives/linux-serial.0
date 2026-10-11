Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C5324B20
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791735521; cv=none; b=ULgVVHZNYxztdGhfnu6DDXBKMzxIGW17c/BKkHUogazK58YkiGOWnAsdzvZFhin3Qn2wEmFZya9qKJAjrrSOFt82lDmN3ttZV5LWaADOY2i0xeIYtmHdMbJIhBap/jzIizBUf2UTg3pB4ufvpeV+Vi8Pa5e/Fc3qXlwhTb/6G6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791735521; c=relaxed/simple;
	bh=hva/tp2Acvt6W18JV2TcLHNPDVP7d9Gml2g9nvQ33+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9rFR3VR/AdaBCF5JtE/V7d7dSA26amsyUeOFNqqRoegKMyP6P/upaNpclCSXwFoP0iazBLbqsyeMW58MrZ+ev3OnGEYx/H9Lb/nOwbMY6Pp0zWHfmzwKHRQQ6rO0zZIsD32gLSQ1odS6JDXtVQyLAI42X3aA5w0lRaNGu5EkPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=WhByQg/2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="WhByQg/2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a16c399641so11837505e9.2
        for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1791735517; x=1792340317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLevDBr/a6xSK2+ESklMCOJC1LXr8ChWRGeELvbz+GI=;
        b=WhByQg/2SRcNZpapndxLKrK0V9VERwrjQ4zJF7n60mzMsMNlKnpdfXTHxaGF5cYZut
         YTheVuNqt5f7vZvmwuts5NA3O4QGv+KxuqplIkKH/kzPsZtnZ8fVv3FgLcEGHZXkTa5Q
         8CkuJvvKKk4L1CZN/uC1NEJlUZjY8kswxXSjApXirJL+H5ErNUyLMVIMGiy1qTHd1rA0
         zKwnyepclOZngDHO+Lt6ukiLHpfS5SkzckOlGxgdDs9G/t3H9OvlijG8fSsnQ4//FvTk
         xzGWWN3SAMh7G/DJo/lGrY/6HnPh8FYDhVUAk2fI423ZChRgRkY/mjNBKYqWJo7ilT0E
         Fg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791735517; x=1792340317;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLevDBr/a6xSK2+ESklMCOJC1LXr8ChWRGeELvbz+GI=;
        b=DHozbBOCGLf6x+V5VBmSKqlv4hcAVhZbgnpbDngD5qsQ+FpYD/LZ3N3HzmOU1SSenx
         W9YW2T2WAalLpoeLesaN4+7DdITd/Wx4LMd7MaCYSjl3P/r2Zm8KYdE/ODlekUwsAQzf
         wGF+ZNT6BXjnAlljj4bAXT54QnaZunLpOkqApp6J5j4onkPpfkNVwb7kD0n1tO/TH6Up
         aiZ9UPHki4b0V/JbVD2KgOx4hHo1qE5UgNOhsrmpuw/aiWhkQcdVN5CjeWJ6JAJmJ0Hz
         aM5FpaR1j33Uj9rqfgsKnbEZSmu0u3YhqzVumyLG6I9Zx6hd7b1JDdxKopUSUA5TPR+Z
         6YDw==
X-Forwarded-Encrypted: i=1; AKwUvBxaRzIrNqJ7o7TXeBVw9GXvCbyJUSJUPsn8RI3o458dbbgf/wGkXIhNYbwmjMiive65uwmNna9dk5Me8Pk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAefHuWE/ovm8oJlVXGvDT/ot4bhqBHfyuEgzgpy0edcDaVKeR
	Ol8vepObeuGMHr+3QyUR+rAiKA0Z428axqXlTqAgKJVFIszGKIyqjzZHG7Q/hjowx8A=
X-Gm-Gg: AYBFou0oG1cok/1GG96ZL5nzBdUKXRbYpU+Oy5gT7/rKX6TXLwSd5k1IyK/cVkZZWid
	INtwZK02XsTMusCWJGwf3QHh0q+lLH4cBvOjGXuk84z2y2UZV7FTqJymI249cOju1EjyqPyvUzK
	uhfX4Mu1mWXJiPvHCxxyMFc1ugPMogemTNp2RMIfbJho5G569z6Vm4swb4LF189flFdyDIeIAtc
	1maVwCqp5zMrniiS9Jj8avVTT8LmWSM3AotYSc3ljpQpERyCw7Tv4gzKA8yiQfvhUspEr38MwH3
	vApLXqvviZw72HJqjXUcz90JimfjOJbm26rRwVT1Pd3ulm1kAW/wD+ydYhDg7HMStn7hhF5Pa9I
	fsTjM3wR9ANmQ8h0koi+pVRyrk6aRewredkFA2Ufa2BG2vgGA2GEtTQI5R0ljc13LzocALThN5m
	jcZYbE2+Mo2A3iMJpidFvp5QR90GgEhlaFyjY3ZPSobm9l9D9yond3LwlHIbeyIO/tPyZ17zIhR
	R5dpLlQUURsCE7gT2HFE6sDPrXzZoCtbz53T006Mgc3dVwU
X-Received: by 2002:a05:600c:3c89:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-4a18e49242fmr134428835e9.19.1791735517494;
        Sun, 11 Oct 2026 09:18:37 -0700 (PDT)
Received: from ?IPV6:2001:9e8:2cc:2101:aa59:e08:7cab:1f61? ([2001:9e8:2cc:2101:aa59:e08:7cab:1f61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm302192575e9.0.2026.10.11.09.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 09:18:37 -0700 (PDT)
Message-ID: <e2e3d98b-9a89-4845-aa7d-0e23a1d95f70@9elements.com>
Date: Sun, 11 Oct 2026 18:18:35 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs over
 PCIe
To: Phil Rosenthal <phil@phil.gs>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Corey Minyard <corey@minyard.net>,
 "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>, Andy Shevchenko
 <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 Ninad Palsule <ninad@linux.ibm.com>, Andrew Lunn <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 =?UTF-8?Q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>
References: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
 <CAHp75VdiO9tPX2vLqsX2-omNvs-YjkWWD-HOiqyDSzpJrrZ_5w@mail.gmail.com>
 <60996F21-A12C-4FCC-9D5E-9D188A4ADBEA@phil.gs>
 <CAHp75VdmMwXRQFKLG8c4yAsVA5=eFZA3jagtMGb-qVswcQ88Wg@mail.gmail.com>
 <2F1931BE-F0F0-4F21-BED4-67080A40AEA9@phil.gs>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <2F1931BE-F0F0-4F21-BED4-67080A40AEA9@phil.gs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/26 12:47 PM, Phil Rosenthal wrote:
> On Sat, Oct 10, 2026, Andy Shevchenko wrote:
>> I will look into this deeper when I return from the LPC 2026 trip, but
>> what you are doing sounds really wrong.

*snip*

> One correction to v1: it said interrupts don't work on this device.
> They do. The board just uses a different MSI vector than the one I
> tried, and which vector it is depends on the BMC firmware.

Disclaimer: It's been a while since I worked on this driver, so please 
take my words with a grain of salt.

Correct, the BMC firmware sets its SIRQ statically. As far as we have 
seen on devices that use VUART over PCIe, they used the vendor 
recommended interrupts which are 0 and 1 (vectors 16 and 17 on the host 
side).

> In a separate driver I can find the vector at probe time and fall back
> to polling if there isn't one. That makes the console about 7 times faster
> than polling (about 15 KB/s instead of 2 KB/s), and the CPU no longer has to
> poll the port. I couldn't do that cleanly as a quirk in 8250_pci.c, but
> it would work the same in a driver for the whole device.
> 
> Grégoire Layet (Cc'd) has a series for the same device [1]
> It adds an MFD driver, drivers/mfd/aspeed-pci-core.c, that registers the
> serial ports as a child device. But it only binds when the BMC runs a modified
> OpenBMC, which changes the device's class code and puts the serial port
> interrupts on fixed MSI vectors.

@Grégoire do you remember why `8250_aspeed_vuart` sets the PCIe class 
code to `0xff000000`?

The reason for having an MFD driver instead of a separate 8250 serial 
driver is simple: We want to have the ability to support multiple 
devices like KCS over PCIe or Mailbox too, which uses the same BARs.
There was a discussion about this already in previous versions of the 
series that Grégoire has proposed (I think it was v2) [0].

> With stock firmware, like on this board, it doesn't bind at all.
> So there are two ways forward:
> 
> 1. A separate 8250 driver for stock firmware, as I proposed.
> 
> 2. Extend Grégoire's driver so it also handles stock firmware: match the
>     KCS class code as well, and find the MSI vector at probe time instead
>     of assuming it. I'd work that out with Grégoire and send it on top of
>     his series, together with the ipmi_si change. KCS would stay with
>     ipmi_si's ACPI path either way.

If you found a way to find the correct MSI vectors at probe time (with 
other features like KCS or Mailbox enabled), please propose it so. 
AFAICR we've looked into this and haven't found a suitable solution for it.

[0] 
https://lore.kernel.org/all/cover.1780929570.git.gregoire.layet@9elements.com/

Cheers,
Tan

> 
> I'm happy with either. Please let me know which you'd prefer, and I'll
> wait for that before sending anything new.
> 
> [1] https://lore.kernel.org/r/20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com
> 
> Thanks,
> Phil
> 
> 
>> On Oct 10, 2026, at 4:10 AM, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>> On Fri, Oct 9, 2026 at 4:45 PM Phil Rosenthal <phil@phil.gs> wrote:
>>>> On Oct 9, 2026, at 4:57 AM, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>>
>>>> There is already a driver for this 8250_aspeed_vuart.c. Please, do not
>>>> add new quirks to 8250_pci.c.
>>>
>>> Thanks for the review.
>>>
>>> As far as I can tell, 8250_aspeed_vuart.c drives the other end of the
>>> VUART. It is an OF platform driver (aspeed,ast2400-vuart and
>>> aspeed,ast2500-vuart) for Linux running on the BMC itself: it depends on
>>> ARCH_ASPEED, has no PCI ID table, and programs the BMC-side GCRA/GCRB
>>> registers (VUART enable, host SIRQ routing), which the host cannot
>>> reach.
>>>
>>> This patch is for the host side. There the VUART appears as 16550
>>> registers in BAR1 of the BMC's PCIe function (1a03:2402), and nothing
>>> binds that function today,
>>
>> In the comments to the patch you told that ipmi_si matches it.
>>
>>> so SOL goes quiet once Linux starts. I don't
>>> see a way to reuse 8250_aspeed_vuart.c for it, but please correct me if
>>> I'm missing something.
>>>
>>> Understood about 8250_pci.c. Would a separate driver be acceptable,
>>> e.g. drivers/tty/serial/8250/8250_aspeed_pci.c using 8250_pcilib, along
>>> the lines of 8250_pericom.c? It would do the same as this patch: find
>>> the VUARTs the BMC has enabled in BAR1 and register them as polled
>>> ports. If that works for you, I'll send it as v2.
>>
>> What has Pericom to do with all this?
>>
>> ...
>>
>> I will look into this deeper when I return from the LPC 2026 trip, but
>> what you are doing sounds really wrong.
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
> 


-- 
Tan Siewert
(they/she)

9elements GmbH, Kortumstraße 19-21, 44787 Bochum, Germany
Email:  tan.siewert@9elements.com
Phone:  +49 234 68 94 188

Sitz der Gesellschaft: Bochum
Handelsregister: Amtsgericht Bochum, HRB 17519
Geschäftsführung: Sebastian Deutsch, Eray Basar

Datenschutzhinweise nach Art. 13 DSGVO

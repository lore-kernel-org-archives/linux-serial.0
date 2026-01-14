Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BA0341065
	for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768435030; cv=none; b=gvoSNphMAmxDPqPFvHJyClW/nNmgzpNqoHDh9nnNKX0H2RmRkkHn6vFXj53oM5xc4Tt0E9LNcgmIM+dHsq5YhBAaMctos/fG+VR334dH3ES+sz6lbtlodtG9/JbvlvzGXfpuAkXwEV1pK+FDsa01g+cnOvCkGiB7vAMrm8hoPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768435030; c=relaxed/simple;
	bh=HDziqQp0ZHq73qfDA8T8c1LSXjVu6KKuZcSbqhyXZsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggOV7keNLixh8jeXBlZjzU6OISsXO8YlzIJ1RFqOyTzqElfVZum0SYetrGNZA5FQc81SxMMiW5DS1vDy3mk8RQk+vH9wgdNEwI76/QmMFmIH7+MHXKEBa14eJkhjASWLh0/Z4/pMdBie3NIfVsimNPSgHaaEGs5TPHFg0VGR8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mw+XGQ96; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mw+XGQ96"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40418578e28so131879fac.1
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 15:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1768435026; x=1769039826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrZ0xz6rtJrpX2gJTATZXWCSjCkVy/ptUp7g0PyWV/k=;
        b=mw+XGQ96V1W6i5Fis6GP34a5P2UqxfwqhEWpw16B9pk3SHGCTfbZwAM8msON/4NyRy
         27wIuSu+IbN1RMsQrEI0Znanp2UXOjYLlTXWv6KEhvpqQ1eKrbazy8Jpb9uE7gMBc8a4
         c5Ylk48ZSPOA/l08LUhuxdviCAKe/nTYXUcvV3feBt2ubTeaFKVG6Dub7vIUWp0f7rx7
         1KCIT0wNJWKHXOg+khCTe0XXSUk1/A/NguVFTuk2PZYU7at3v7EaSMSgZRGREyb3GIu8
         562RVx3o2WDTqaf+YImfijvtZPFZuKW+gK646lD1f/6+4X2bw4hKznMIeWTHH56BgdL1
         XJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768435026; x=1769039826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrZ0xz6rtJrpX2gJTATZXWCSjCkVy/ptUp7g0PyWV/k=;
        b=aesW2GdmVJPHZRk4ZOv+BN5rMFRcYyoCCxIyxO8fUbQFfiGVUyR08FWUqcqUb2L7bu
         VZA5TSt9+YiB/ZmErKskt95uztryJPO07j5kQiJgxH7GJJ0Ut59pyhecoSYOAFTlTYIj
         x+/xKGWvbcMLaslUg5hKIfttZnqjZ6hNR6rjMf7AypcnQ4OiC35vWenqLLWfTi5pjmSW
         yuE3o5DKDInWn2gZNLhRx37AZT4BD1F5Bgz+jEasgQrXq3wDKeqpcEd3yiWA+aRVXErt
         cVu2WLv0nQWFRSMbRFXMNQ4RwAcI3HLc2JYHTsWZLsrf5dZ5/ahuqKipJdTUvOyHej9d
         QMKg==
X-Forwarded-Encrypted: i=1; AJvYcCVFAs4bcjR4NTPSlooGKOUxal3qLJPLg8h4JviLQ1PgLsC6JzRpXAf5f2n4IsOhV2de8mP33mMcxl5naTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy55a0eAMkfitt0xVaqsq9eLFgG47/iqozee0CQqYhWWi3wXxvn
	jyz4dX5KBvix5/mtifCODfK61zGX4TgcwtaD1QXg88A8HCzls6G30gauwc9iwKtwq7s=
X-Gm-Gg: AY/fxX4v4prB75Bb2jmC/UQYmba75A6LDBrrxyqTjOngcckyvqatJIL550iGa/U+7hY
	l6+UaWh9nX4ANGTheS9HQp8rob93VWUZzopkUVBqiBAGL8fe5qD9QzQM+OoS58gS3BrINlRCxcG
	gb8wS+evpSPKqhlWxvxhiLcEY1EuItOKSMpmpTGbZiAczsm30RGAiKYQY7TV6wfAHK4mr5DI/aS
	sUEhiDf3TQG/CNWyrZyZ3T2SpbTDHHokAln51wN71yWaP54KM3Z6U3vRuyKkErF1JDr4qJV4A3U
	riEn4cOXPME1UY+aZxU2iZ7wggnAcuQadNhSCzqlJEqWx+FNmVtDHIY45rQVrbPhd80KVbeVMUA
	3zvRODul+ZZ/971x0bVgsd6PSVIqLvJHYa8V56xxXcbPMaDAVTIk3GaXcSCitjWVOi+6ezbP4fB
	VeyCcSHMrJMCOaBj+t7lc4c7hyQZJh
X-Received: by 2002:a05:6871:3393:b0:404:2fe7:e184 with SMTP id 586e51a60fabf-4042fe7e4b3mr317528fac.43.1768435026295;
        Wed, 14 Jan 2026 15:57:06 -0800 (PST)
Received: from [100.64.0.1] ([170.85.11.118])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa515f4dasm17826541fac.21.2026.01.14.15.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 15:57:05 -0800 (PST)
Message-ID: <fd95c2f2-9292-483c-9613-4adf3c65c500@sifive.com>
Date: Wed, 14 Jan 2026 17:57:04 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Guodong Xu <guodong@riscstar.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley
 <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, linux-serial@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>
References: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com>
 <20260108-k3-basic-dt-v3-10-ed99eb4c3ad3@riscstar.com>
 <77f9a001-7f0a-4c29-abcb-501e875da117@sifive.com>
 <CAH1PCMZ5rKbG8xEbB9jt6TqyB28T5aLgRtf3iJ8Gt6Fk+3XFhQ@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAH1PCMZ5rKbG8xEbB9jt6TqyB28T5aLgRtf3iJ8Gt6Fk+3XFhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Guodong,

On 2026-01-09 3:58 AM, Guodong Xu wrote:
> Hi, Samuel
> 
> On Fri, Jan 9, 2026 at 2:19 AM Samuel Holland <samuel.holland@sifive.com> wrote:
>>
>> On 2026-01-08 6:26 AM, Guodong Xu wrote:
>>> SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
>>> Add nodes of uarts, timer and interrupt-controllers.
>>>
>>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>>> ---
>>> v3: Remove "supm" from the riscv,isa-extensions list.
>>> v2: Remove aliases from k3.dtsi, they should be in board DTS.
>>>     Updated riscv,isa-extensions with new extensions from the extensions.yaml
>>> ---
>>>  arch/riscv/boot/dts/spacemit/k3.dtsi | 548 +++++++++++++++++++++++++++++++++++
>>>  1 file changed, 548 insertions(+)
>>>
>>> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..be9335fba32cb9e81915b2b91cf08c55a5e96809
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
>>> [...]
>>> +                     reg = <0x0 0xe0400000 0x0 0x00200000>;
>>> +                     interrupt-controller;
>>> +                     #interrupt-cells = <0>;
>>> +                     msi-controller;
>>> +                     #msi-cells = <0>;
>>> +                     interrupts-extended = <&cpu0_intc 9>, <&cpu1_intc 9>,
>>> +                                           <&cpu2_intc 9>, <&cpu3_intc 9>,
>>> +                                           <&cpu4_intc 9>, <&cpu5_intc 9>,
>>> +                                           <&cpu6_intc 9>, <&cpu7_intc 9>;
>>> +                     riscv,num-ids = <511>;
>>> +                     riscv,num-guest-ids = <511>;
>>> +                     riscv,hart-index-bits = <4>;
>>> +                     riscv,guest-index-bits = <6>;
>>> +             };
>>> +
>>> +             saplic: interrupt-controller@e0804000 {
>>> +                     compatible = "spacemit,k3-aplic", "riscv,aplic";
>>> +                     reg = <0x0 0xe0804000 0x0 0x4000>;
>>> +                     msi-parent = <&simsic>;
>>> +                     #interrupt-cells = <2>;
>>> +                     interrupt-controller;
>>> +                     riscv,num-sources = <512>;
>>> +             };
>>
>> Does the chip also have M-mode IMSIC and APLIC instances? Those need to be
>> represented in the devicetree as well, for M-mode firmware to access them, just
>> like the CLINT below.
> 
> Yes, the K3 chip does have M-mode IMSIC and APLIC instances. Currently, the
> boot firmware (U-Boot) transfers information about these nodes to OpenSBI.
> However, you are correct that they should be properly described in the DT.
> 
> In the next version, I will add the M-mode APLIC (maplic) and IMSIC (mimsic)
> nodes to k3.dtsi, for topology representation and potential firmware usage.
> I will set their status to "disabled" because exposing them as "okay" to Linux
> causes access faults during driver probing.
> 
> Please let me know if this approach (adding them but keeping them disabled)
> looks okay to you.

I think this is a reasonable compromise.

Personally, I think of the DTS files in the Linux repository as the "static"
devicetree, which should describe a "complete" view of the hardware--that is, as
seen from the highest privilege level. Then it is the responsibility of that
highly-privileged software to modify the FDT as needed to provide a limited view
of the hardware to lower-privileged software. And this modification is exactly
what OpenSBI does before it passes the FDT to U-Boot. So the "static" devicetree
would not disable these M-mode-only devices.

However, I recognize that people want to use the DTB files generated by the
Linux build process with Linux directly, ignoring the firmware-provided FDT. In
that cases the M-mode-only devices need to be disabled. And then you need a
-u-boot.dtsi file to set `status = "okay"` for the firmware build. I think
that's a reasonable compromise to make the "static" devicetree as complete as
possible while still being usable directly in S-mode in some cases. (It still
breaks if some peripheral is assigned to a different supervisor domain, or some
DRAM is reserved by M-mode, etc., which is why I really recommend using the
firmware FDT and not a file.)

Regards,
Samuel


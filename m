Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0051D50096A
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900220; cv=none; b=LDWCzpl68gHvA6OUU0yb6gTDimt/A7TEoAuLMASW7197qAvvK8So/uXFg4xqT7m8Y6OWgs4tVyjFN2Dh6agmfH0QDiKY7luL1Amp2Od+ofX4kopGWBkEhUWCwWkcD1YgKU+hwG2V4nc/84GBxmrRlPXQcwz3Mld98wEpbu0P1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900220; c=relaxed/simple;
	bh=rQuCPnYPLg4Ui2a0ObeA7TCLE/RLxICLMmiEBGi0cLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGaYwIeJogt6HzdJzRlh1KC9odSRMtFTtwADv4bWcKUP2Urqiloi1Nu2j09YtWDqOCC9hx6zdD5K6+e/+c10Q3MTHjCifAujJpyYNUCN4h0BO8uXykyQDBpTdKYuF1DHQ9vCJjbJ7g7kZWa/3Kd7LPXKnjQtestrfTT8r0X3Q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mbTe6U7i; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mbTe6U7i"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-3fa139e5d90so1308098fac.3
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 11:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1767900215; x=1768505015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hjqd0wbUL/0gATLT7Jr3bq/fYYzs5CcoqUGsadwzmFw=;
        b=mbTe6U7i2ohQaLiGP4AJMR2slaLEUYJYOOFgiI2EgQIi2pbFpQrGe4XUGLYmFqgHsk
         brk4vS927Z1lDWdEYlahWkHycmYrbsq9K5n+2wr4zt88WYQK4yNSSQxoWeYR6Ig9hRZJ
         k4zwlI2cJ96wWmoZ2I9qBw9zDXMVZM6gRFBOLfOIFgE4a2Uh7CUOQSOTvo2+wOVQl43c
         MLrfvFGhRBJRj6rRO7B11zsEkxW1eU05hICE6RTVH+UyXMOqqqncGVhdQLdEGl/LWYr/
         MGIJuVWkraLtLahbvfdTiGzOA1TcTdidS1XFU3rxUAinEPAw08R4OXObSQ8o2R1i10EP
         qBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767900215; x=1768505015;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hjqd0wbUL/0gATLT7Jr3bq/fYYzs5CcoqUGsadwzmFw=;
        b=Jx5SxUNy/PH6VrAbarSKQQglt5qJ/nAArliyUkn0IilfWBNjz337n5MKaMzqAPgx5E
         1UrLItWHZkfrBec7KaMOWKW1QufPLjvD/dXd02GHoSZNqig9CgiocINKPk+StHAuR37p
         M86xaK/4m3WVrsang/PZVaLA0oRytBnHk1GFSFJM/5obhPFAMJP7/68VZpB067lUTiY/
         joxDowNDP9HCwcaUZbw9637Z6STSALyS4xEGMxea9G69/ExWOrH/7qGYw67Lyv3W+x/8
         6ow5aGoYWVjesNdbILb8sNbo3BNmNl8ghNhCGA/KZ4zgFZZ+7mp+4YFDVk70TVnk9aTO
         DtQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJivxwECEvQ4w9360d41ifwkdnz2ifAFEBNRt+VL48iou50S4STRsr+Qfgw0L/GDWW061dqMHo+oz9bxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1efHwDmrntRo4VNn7j7uLl83bKkPa9rxTBwKkClaO4n2Qkt/a
	6xSjd9OCA/ELHF3NaSfP/PP4jXn2XJSy4zgqxvlGt1cXw9R8Z4H3FWtapWbm1/5biyo=
X-Gm-Gg: AY/fxX44etel9tKz4TEfK6G+781UqGepLfhjeUgQFf/wTD2UnuMTn1ymIBqIub1FgsI
	0z5waL/9k45RPbJP1wyKuo+sUAiM1GjRWJGPXyTpeL4enU/+8c1Ivj4Bu+znf80oc5wjUlwL72g
	g51MN1L4SRHWWjRcWBZu0fe71xAaSyu3WUZ6zmVnynO8IgebzSKdHYSufcynxxvxKCJEK9y6Ehx
	mDR2AoW0wyvhUWs5hjhfHJtiXIrhGf+S928t/4ee78wa5YLPr6JU8Omf8xFPLC8WsKSwZ7k3Qgu
	/nvQ2NpllFgycS+lHSHAYIq5Eay6bn5G+S4UHLkSwwyUveCcX0XeQWBfM37cm6pB/F5PkQvRbx6
	CRFrmuuG5OVeWUeReInqaVjqdSfoxYyCnL7zHa8jYinxwYCSa2zJ42siFVLqyjh0Dortgn3G0ea
	fi1yvG+lGyNc9pBorlPDsutUULuVY=
X-Google-Smtp-Source: AGHT+IHKLUgghrPd29RErvBws0kQ87awrcNfi7vgU0Zf7ngrlTJY/amh5n0uvlMoYU4vmYrjhXLVGQ==
X-Received: by 2002:a05:6870:c243:b0:3e8:95d2:389d with SMTP id 586e51a60fabf-3ffc0c02c95mr3135629fac.43.1767900214837;
        Thu, 08 Jan 2026 11:23:34 -0800 (PST)
Received: from [100.64.0.1] ([170.85.11.86])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm5357385fac.5.2026.01.08.11.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 11:23:34 -0800 (PST)
Message-ID: <9504b2f6-12f5-46c2-ac74-826dba3fb530@sifive.com>
Date: Thu, 8 Jan 2026 13:23:32 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Conor Dooley <conor@kernel.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Guodong Xu <guodong@riscstar.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@sifive.com>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
 linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com>
 <60948ca2-ed3d-485b-9b11-15df7ef8791d@canonical.com>
 <CAH1PCMb=+TvB1w+G6a2ANDp05HUwC4r6CFBDHXFwSmoP3Mm8xw@mail.gmail.com>
 <f9b6b5e2-ec9e-4208-8267-77020e0a9411@canonical.com>
 <20251218-basil-quantum-225ce16e4699@spud>
 <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com>
 <20251220-repacking-football-c79e660e788a@spud>
 <4e4c9e7b-d95c-4157-94c3-b06002f94a48@canonical.com>
 <20251222-dimmer-wooing-db29fe925498@spud>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20251222-dimmer-wooing-db29fe925498@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Sorry, I wasn't following this thread.

On 2025-12-22 2:36 PM, Conor Dooley wrote:
> On Sun, Dec 21, 2025 at 01:10:15AM +0100, Heinrich Schuchardt wrote:
>> On 12/21/25 00:23, Conor Dooley wrote:
>>> On Fri, Dec 19, 2025 at 10:03:24AM +0800, Guodong Xu wrote:
>>>> Hi, Conor and Heinrich
>>>>
>>>> On Thu, Dec 18, 2025 at 8:56 AM Conor Dooley <conor@kernel.org> wrote:
>>>>>
>>>>> On Wed, Dec 17, 2025 at 09:07:14AM +0100, Heinrich Schuchardt wrote:
>>>>>> On 12/17/25 08:11, Guodong Xu wrote:
>>>>>
>>>>>>> Specifically, I must adhere to
>>>>>>> Documentation/devicetree/bindings/riscv/extensions.yaml (and cpus.yaml for
>>>>>>> properties like 'riscv,sv39' which stands for the extension Sv39). If I
>>>>>>> add extension strings that are not yet defined in these schemas, such as
>>>>>>> supm, running 'make dtbs_check W=3' fails with: 'supm' is not one of
>>>>>>> ['i', 'm', 'a', ...], followed by "Unevaluated properties are not allowed."
>>>>>>
>>>>>> If Documentation/devicetree/bindings/riscv/extensions.yaml is incomplete
>>>>>> with respect to ratified extensions, I guess the right approach is to amend
>>>>>> it and not to curtail the CPU description.
>>>>>
>>>>> Absolutely. If the cpu supports something that is not documented, then
>>>>> please document it rather than omit from the devicetree.
>>>>
>>>> Thanks for the review. May I clarify one thing? Both of you mentioned
>>>> document them, given the amount of missing extensions, is it acceptable if
>>>> I submit a prerequisite patch that only documents these strings in
>>>> riscv/extensions.yaml plus the necessary hwprobe export? Leaving the actual
>>>> usage of these extensions (named features) to the future patches.
>>>>
>>>> To provide some context on why I ask: I've investigated the commits & lkml
>>>> history of RISC-V extensions since v6.5, and I summarized the current status
>>>> regarding the RVA23 profile here:
>>>> [1] status in v6.18 (inc. v6.19-rc1):
>>>> https://docularxu.github.io/rva23/linux-kernel-coverage.html
>>>> [2] support evolution since v6.5:
>>>> https://docularxu.github.io/rva23/rva23-kernel-support-evolution.html
>>>>
>>>> Strictly describing the SpacemiT X100/K3 (or any core) as RVA23-compliant
>>>> requires adding these extensions that are currently missing from
>>>> the kernel bindings:
>>>> RVA23U64: Ziccif, Ziccamoa, Zicclsm, Za64rs
>>>> RVA23S64: Ss1p13, Ssccptr, Sstvecd, Sstvala, Sscounterenw, Ssu64xl,
>>>>            Sha, Shcounterenw, Shvstvala, Shtvala, Shvstvecd, Shvsatpa, Shgatpa
>>>
>>>
>>>> Plus 'Supm', 'Zic64b', 'Ssstateen', 'B' where the kernel supports them but
>>>> they are not literally documented in yaml.
>>>
>>> I don't think Supm is suitable for devicetree, doesn't it describe
>>> what the kernel/userspace are capable of rather than hardware?
>>> Zic64b doesn't sound like hardware description (so not really suitable
>>> for devicetree either) but block size information is already represented
>>> by some existing properties (see riscv,cbo*-block-size in riscv/cpus.yaml)
>>> and duplicating that information is not really a great idea.
>>>
>>> I'll admit that I do not really understand Sxstateen and how they work,
>>> but my understanding was that knowing about Smstateen is sufficient and
>>> implied Sstateen, but having Ssstateen defined seems harmless and
>>> possible. I think kvm is the only user of this at the moment, so
>>> probably worth CCing Anup and maybe Drew Jones on the patch adding
>>> Ssstateen to make sure it makes sense.
>>
>> Supm is described in
>>
>> RISC-V Pointer Masking
>> Version 1.0, 10/2024: Ratified
>> https://raw.githubusercontent.com/riscv/riscv-j-extension/master/zjpm-spec.pdf
>>
>> The interpretation taken by QEMU has been:
>>
>> * Supm implies Ssnpm and Smnpm

This is not correct for system emulation. Supm (pointer masking visible in the
U-mode execution environment) requires exactly (S ? Ssnpm : Smnpm), not both of
them.

>> * RVA23 capable machine models display it in the device-tree

This is also not correct for system emulation. It is impossible for QEMU to know
if pointer masking is visible to the U-mode execution environment, because QEMU
does not provide the U-mode execution environment. Software inside the VM does.

>> If Supm is not shown in the device-tree, software might assume that the
>> system does not support pointer masking in user mode and is not RVA23
>> compliant.

Software shouldn't be looking for Supm in the devicetree, because the devicetree
does not describe the properties of the U-mode execution environment.

>> Hence I would suggest:
>>
>> If the X100 cores have Ssnpm and Smnpm, add Supm to the device-tree.
>>
>> If the kernel does not support user space pointer masking, the kernel should
>> filter out Supm and not announce it, neither in /proc/cpuinfo nor via
>> hwprobe.
> 
> Samuel seems to have some specific thoughts on how this works, given he
> didn't blindly implement ssnpm and smnpm, but has made supm be mode
> dependent and not permitted in dt, hopefully he sees this.
> 
> Personally I'm not convinced that putting supm in dt makes sense, but
> instead the kernel should imply it if the sxnpm extension matching the
> mode the kernel is operating in is present and RISCV_ISA_SUPM is set in
> Kconfig. That's effectively how it works at present, except it'd involve
> promoting RISCV_ISA_SUPM to a "real" extension instead of being a macro.
> A validate callback should easily be able to handle checking the
> mode and whether the Kconfig option is set.
> That way it would get exposed to userspace using the actual mechanisms,
> reading the devicetree itself from userspace is not a valid way of
> checking what extensions are usable after all.

We already do this for hwprobe(), so the only difference is that Supm would be
added to /proc/cpuinfo. I don't think I have a problem with this.

Regards,
Samuel


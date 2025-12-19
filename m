Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441381CAB3
	for <linux-serial@vger.kernel.org>; Fri, 19 Dec 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131699; cv=none; b=kxed24EurV+9ZJmSYWIxiN31ageINeuFfkD6/cA5aoSKNKW6L3DgG4+zUl1tjJvEyB+ABByuHQbUqBwv71c8UBx1hmC+9WRzBq+W24L9rSwxdDu1WqPb4AM9u1HJu+5tS6ezP2on4hY+hqXGv99LThJj6FghNYqFk5nJIEXbXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131699; c=relaxed/simple;
	bh=8udCBDJHixWYZ9BHIHwvKAqzaP5NF/DkqRjG+1eXjBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNSvu2vD5ACqNjWL4bBfw62Kgjvgqf2lcr4lqRSHe0IpLdfaBtOAbgakj8JQKj3lVHoYswJKsGmlwrhNW/RHkI3jEW/ivlczIKNLLifvcTtdkdQ/aOAeWuRc+wR8rFfO7luCWrTKq/hNMlcpDK+1AC4RjX1kqjBGHzgHcSIra84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=lMO9chE9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="lMO9chE9"
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 742903F85F
	for <linux-serial@vger.kernel.org>; Fri, 19 Dec 2025 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1766131690;
	bh=EaxKPv8EzMQw4Q+d/tnNq9TX6lEJW/rr1OxXypt8e2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=lMO9chE9CcnVozxEYLHoj4xFpT1kl3IskAJ3/7366fiBllXxh85PbwM5l0L21nAxi
	 kveo6QHHrBaaNckQ9Bi8YvvjL8P9o+j793sFO3xmBJbT59h86Z+VDZq+ElTmgcJfuz
	 68tR5M1xM5GiUqaXs277UbQkeWZfb1/qJCrkQJXSvGBFJLP7dSqQ/pHx6FJM0j8RP+
	 /+WmTHSF844Wh7jvZxoUDTHq5E43NVLDyHYl/0epFZmfS9bcH+HvQxWPTIa/Bv1kEB
	 ZmPudXl3Of8tNNpQ4DfmeygGGuidzoUl/Gk57i0o62qRxymPATEqaQ7Irgoe3oXziE
	 8MCss7G3kAQ7B5FiinJt62iv+RWAOVmeedSFHfhifI/Vn9eLBgWuRRuaKx7P4v/xf7
	 lveNktI8e0G8AyZJMbU+djvve4d6KXQmeIMEHEuYfDD6fAhqQB1O57JhAgb8h6jsWJ
	 44ZVR2GxTTl0jWh1YakMkXlxgAQDw+iFL3vd0EvBmzNNSfNYD5SfD9o0jll/LgCIR+
	 Ne4ZbQ++AsjXQ05i+ooBqv4i6ENQ9D7o9Ra8nmkCKeffO/IsXmSzKDCpoTXu9mKZhf
	 Aeie9E8yHXg6uBmx69uN2jtnDu1PjhPicgX4OJfE5O5WSeMnkx1lNKtIAKVGMKLy/+
	 sDa+8XYzY1uiRoa5xUabefr4=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f4609e80so682455f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 19 Dec 2025 00:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131690; x=1766736490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EaxKPv8EzMQw4Q+d/tnNq9TX6lEJW/rr1OxXypt8e2A=;
        b=c6dNEoXsMVqt8H5xXi/8ZTcYSIZz5pEMwytPY6Ob+Xs89u1UclHlakWglRnX/4u+HQ
         Cf7PvxZaKOzoTIJ1ng1TYv5McMkrTA2I7XK6idRn70ge9kAf9by177OyiGw7GI35EjKj
         Uh3Qu4VZh5k7tUJ0QEH/RWX8RHAqXmiR6fnSgGiC/3rsxM96LMjlNBEMT59lTwEJ1eAF
         ml8VIMY0oKPt1BxxdhRn2QGIIdGokgmZpXjhk7ZwdnzQwBWntFeDBBIWVq+j2AW6+q7C
         JIhZQg2G2jsjhTsPwxEiBciPPKVdHzgRgVrKoAESviyjAJ92aIuHPc+01qJBNgxH5+Kz
         /mrA==
X-Forwarded-Encrypted: i=1; AJvYcCWoQ/rL8Ya7nUvg+ow85yKkESvcLKGUgPRTYAqVF+jn4qiS9cc5cuS2kdltI9UI1yQ/gK/H5aqlb552nl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbtd6u4+TLEwL3FBm5I01ff0sfWxWgbWlajwT6qVfLLWFBLQK0
	hAf0+MLqamRiOSpMQP4kJ6G6wpIXmzxRKowfTBgYrCsGdl7HEh6oudLT9xYQgkPKUwA99SH3hxI
	HzhsM6IjOOJqWdc0G0XRxonT216kQtev14PU6gyEAnnTXAVUchZNtNFQvfwJGXWzSTqCo3j5lN9
	B0FUieiw==
X-Gm-Gg: AY/fxX784g+4nRkEwcIahyQyxf/hMUsZpv3cnYLLO/SCnpkGGcVci85CE1pP8T422za
	dk/fv4g6NqNr7G+27GQSWVzzAE0iTwwSO2nI6r06c125h384UcUCtimTz6y2Alt+PQRHK7e2qRz
	TytpMvprfUifhB6fwleTI88FAOS6bRdJtpALwPUdBKipl8FG3eymGeg71whs9TfNWD4mirke1DL
	3WmfAGSdhp3PHexHsTzYxrezGKataCiBTy6m775zZzHd11xjYgBKNDpU/W/Dc8KfNAr2G4gPVzI
	rNlaSEPeVWYaE7u4gZU/O4AmtBmHBYcclX7iE+T5wkUYvrFgRQ+Ia7B2ul0R9OGJ9yvvS2eBe5L
	sktw+PKA4aFQLl+AEmomdo4iwjnfPKiue5UPu8m2L/lDA3vqK7d6rW29EWk9ttCI+RV6vfF37Ei
	wWQUKgYJk=
X-Received: by 2002:a05:6000:1a8d:b0:430:f6ad:1814 with SMTP id ffacd0b85a97d-4324e7045eemr2091914f8f.58.1766131689915;
        Fri, 19 Dec 2025 00:08:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+g+eItW+D6N0t8wn4CUhhQAlan/FWbDAzi/nwqnnLL5ClhWb3g9EwyncInKQ4MUzOoaMdTA==
X-Received: by 2002:a05:6000:1a8d:b0:430:f6ad:1814 with SMTP id ffacd0b85a97d-4324e7045eemr2091855f8f.58.1766131689463;
        Fri, 19 Dec 2025 00:08:09 -0800 (PST)
Received: from [192.168.123.154] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2267fsm3416457f8f.12.2025.12.19.00.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 00:08:08 -0800 (PST)
Message-ID: <212e6371-245e-4f44-98a0-5e1db47222a1@canonical.com>
Date: Fri, 19 Dec 2025 09:08:07 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Guodong Xu <guodong@riscstar.com>, Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
 linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com>
 <60948ca2-ed3d-485b-9b11-15df7ef8791d@canonical.com>
 <CAH1PCMb=+TvB1w+G6a2ANDp05HUwC4r6CFBDHXFwSmoP3Mm8xw@mail.gmail.com>
 <f9b6b5e2-ec9e-4208-8267-77020e0a9411@canonical.com>
 <20251218-basil-quantum-225ce16e4699@spud>
 <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/19/25 03:03, Guodong Xu wrote:
> Hi, Conor and Heinrich
> 
> On Thu, Dec 18, 2025 at 8:56 AM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Wed, Dec 17, 2025 at 09:07:14AM +0100, Heinrich Schuchardt wrote:
>>> On 12/17/25 08:11, Guodong Xu wrote:
>>
>>>> Specifically, I must adhere to
>>>> Documentation/devicetree/bindings/riscv/extensions.yaml (and cpus.yaml for
>>>> properties like 'riscv,sv39' which stands for the extension Sv39). If I
>>>> add extension strings that are not yet defined in these schemas, such as
>>>> supm, running 'make dtbs_check W=3' fails with: 'supm' is not one of
>>>> ['i', 'm', 'a', ...], followed by "Unevaluated properties are not allowed."
>>>
>>> If Documentation/devicetree/bindings/riscv/extensions.yaml is incomplete
>>> with respect to ratified extensions, I guess the right approach is to amend
>>> it and not to curtail the CPU description.
>>
>> Absolutely. If the cpu supports something that is not documented, then
>> please document it rather than omit from the devicetree.
> 
> Thanks for the review. May I clarify one thing? Both of you mentioned
> document them, given the amount of missing extensions, is it acceptable if
> I submit a prerequisite patch that only documents these strings in
> riscv/extensions.yaml plus the necessary hwprobe export? Leaving the actual
> usage of these extensions (named features) to the future patches.

Adding the missing extensions to
Documentation/devicetree/bindings/riscv/extensions.yaml
is what it takes to describe the K100 cores in the device-tree.

Discovering the new extensions as CPU features and exposing them via 
hwprobe is probably best handled in a separate patch series.

Best regards

Heinrich

> 
> To provide some context on why I ask: I've investigated the commits & lkml
> history of RISC-V extensions since v6.5, and I summarized the current status
> regarding the RVA23 profile here:
> [1] status in v6.18 (inc. v6.19-rc1):
> https://docularxu.github.io/rva23/linux-kernel-coverage.html
> [2] support evolution since v6.5:
> https://docularxu.github.io/rva23/rva23-kernel-support-evolution.html
> 
> Strictly describing the SpacemiT X100/K3 (or any core) as RVA23-compliant
> requires adding these extensions that are currently missing from
> the kernel bindings:
> RVA23U64: Ziccif, Ziccamoa, Zicclsm, Za64rs
> RVA23S64: Ss1p13, Ssccptr, Sstvecd, Sstvala, Sscounterenw, Ssu64xl,
>            Sha, Shcounterenw, Shvstvala, Shtvala, Shvstvecd, Shvsatpa, Shgatpa
> Plus 'Supm', 'Zic64b', 'Ssstateen', 'B' where the kernel supports them but
> they are not literally documented in yaml.
> 
> Is this approach acceptable to you? If so, I will proceed with submitting them.
> 
> Thank you very much.
> 
> Best regards,
> Guodong Xu


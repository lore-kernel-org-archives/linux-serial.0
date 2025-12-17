Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8BB33D516
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958841; cv=none; b=qEjgJqnVGGOSsvmIOHCjRz/Rx8GC9YmLMSM+TVuDo8wis2EkDE37XS5HY2BzcKAPrgkymlIkFBiFZld0Dtgyzu47Ao3FETERVqQwkPHgy/nBurREBDA/sEYYd8dvPXJDyt3XdmZw72sf1BTHu2LYpSQ5tJMosXLgGlZfOGzOzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958841; c=relaxed/simple;
	bh=xvMjaVuP31bHxThVqScT60XlmU9Cz2Clf/weItOYM9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zrx+g6yE3Cl7L4KMGujiFN9JgSjlI77MFnPhFZMePXx1DGmCQ6OUk+82A2zqC46gLNp0gS/tAof/vdqshhnlxi64eCjOg3I6xTeOB5WoGseJ+hzp2q/c7ZRN/0ko/kRbmBVeHTI/V+okj5LySW7FDNnsWMdBSlNui6gN1Ts4Gq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=canonical.com; spf=fail smtp.mailfrom=canonical.com; dkim=fail (0-bit key) header.d=canonical.com header.i=@canonical.com header.b=KYE9ADm1 reason="key not found in DNS"; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=canonical.com header.i=@canonical.com header.b="KYE9ADm1"
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A2F763F864
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 08:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765958837;
	bh=xg/D3+GtNZwzqAPEwq0TMwZyqoVeXCC40cLNYkdUJrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=KYE9ADm1/ht4OG503aMtEdWs4UdqV694Zbq0pLcwMKY802ASoNxuQMKNHanmBWLIR
	 QjLwK9yHjVfwcQ0vx1WEbpHSTmfa4hl2adVOITqglrmj2zd/rJXpL9IcLr9kCQqxwD
	 BKsske22MmDZzlrVtyKqlcPRGfpiv2G4RvpGXMCmy/uG94kw69t6/AM05D2ovO0cBJ
	 Kp5fl/djW7K6kQp+ZU0PhzBL67ph4Hr4VysKIQ2oC8EGKTGb2IMpFVfFPxuRAkDpVj
	 /nOq8lBDtoegTQ7b6Qv33UPbROD0r9T/g/Iu8EgiULiNi9rbAdaoAtW7uhLlZv+1Au
	 l7eOYa5KQaJSVCz3wKalVI7v768ZoNt9e6awbXw1RL4cbwYXEaWP9hCk43JodP0N8c
	 AN2bSP88rMG8XfFwb0loGqHV4pW3ni/LPM6vx3YhrEPtXEUH1eoYqYwOd7EIyoBBp+
	 TwP+YaxjHobOdJ+fRZvDplO3A/wJyBAdHXJPjbhLbc5CBDg4bGR7bFkkDpTZHfoS4B
	 6Wf24/1GkW7W4Ht3tDNCPiTNsG5ol+nH5+5ZksU1t76ImZJXILpo8gUdkKKql8O3Du
	 nxZzDTeqL7Z5e0qB4/vTfYcM/WNaHsaY1D9kp+HVv3xLa70hiNYsqEvnPL7x1AJqlq
	 EzFkQrwWNcTwxOttd8C1HL9g=
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso2011145e9.1
        for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 00:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765958837; x=1766563637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xg/D3+GtNZwzqAPEwq0TMwZyqoVeXCC40cLNYkdUJrk=;
        b=FeVDmt4N7RW/NORWYvJy4H9zbtoQ6hPbrQxnOGA4cFj8/H8rCz7tRtVlMo9ivJ6p2r
         G5vIzmPEP2NFAnjC1xB/U2LEibYqeCbxv2BYuEMX5RsI5t5j8/gIIFnrBA8/idT4vq+r
         n+AWC90iKia+XwsZoQoJTSpb5mv82h9Rrch9NO8k+U5NXVzQ5TwR9LY7casPmdPKz/ay
         bUYEzEsa7a77D/n5vbBZArdy962TJRW4MH1C2gz1X7t9bFNe50uBRPoc2ZoXSWG6kFBW
         kRFsFVAbqnDiG0DZC1gqL5ejSXMp/V24AfK5ZqibOVCBPaWoiEH9NEyTqrUxK1p6o8K5
         QlWw==
X-Forwarded-Encrypted: i=1; AJvYcCVjk0JL+sYR3tqhXaVJkt4XY0n+N8FYKI31xQQpGfya1NhLRc+azLtsuoPJY/4F9ZGwfHoXWOcFs78h/sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziXBE5ODFWw2+EeF7hJurKa0Lj8FZtxGvIHU40/CkLoQvVmW6W
	qaNZrqUynES+3OufUAi0G/SeYKYMOzpjwVM3+6sHj7S5SqTu/tlBqPjpmogVq6M+DnPLMlE3sBu
	gY71lp73e0UT/BeXGYFCQNGDZI8hoYlKPGXW1vLFDDvQqB+UDcpSlmQ5/Q8/OXorou6eQw5eMDz
	c7rQF8lg==
X-Gm-Gg: AY/fxX6QOmTUCH/7pY8ag2bIigRk+V/U38EQLWGESHMQGRTjcdElzIDu3snZWWHIl2P
	Rwynu0FKi7vcPh/PLMQiDiPwI+MY6Zbfvvt1UTT9J15XQ9gbMnOXXcz0kijOxtOWl2IAQG2NRXj
	fqOgeRAO6gmIwpGUAId1nlePzyU2HC0YFslnsZ6KvzGr+YuuwnJ4DKqkiCQE1a7jM4Q5BxhjT7K
	RSAVzq5S1oNAGtYRK1/5qJOoytcI5DIkdSP1fAaKA2mnTFD1kAXL3a9NQXOdUGqMOstnfx4dDcl
	MlcpBRNfjc6jlpQtVeCh2iIrOd4Dajf1kFC8pGpF5YS9GY/26Q9Z+JQfWOBrRZK1J3yRqDc1Gyw
	B2DwHprFAlk5HHPrBTT/ELQBNo1xaxRyGNSy/LIUcaku3R+Fw6kir5MapXAYGtdnci8786oCoyG
	C2A91p2sk=
X-Received: by 2002:a05:600c:1c89:b0:479:3a8e:e490 with SMTP id 5b1f17b1804b1-47a8f2cb09dmr191147455e9.18.1765958837025;
        Wed, 17 Dec 2025 00:07:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7lkgkkTPibPOHbDFxaP2ZN+RqjAz8H8zIVMsrRtI5v9GDMT5pL8zNOJZxvsyHlbuiIA43Hg==
X-Received: by 2002:a05:600c:1c89:b0:479:3a8e:e490 with SMTP id 5b1f17b1804b1-47a8f2cb09dmr191147195e9.18.1765958836564;
        Wed, 17 Dec 2025 00:07:16 -0800 (PST)
Received: from [192.168.123.154] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc2221c4sm25403885e9.11.2025.12.17.00.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 00:07:16 -0800 (PST)
Message-ID: <f9b6b5e2-ec9e-4208-8267-77020e0a9411@canonical.com>
Date: Wed, 17 Dec 2025 09:07:14 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Guodong Xu <guodong@riscstar.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAH1PCMb=+TvB1w+G6a2ANDp05HUwC4r6CFBDHXFwSmoP3Mm8xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/17/25 08:11, Guodong Xu wrote:
> On Tue, Dec 16, 2025 at 10:24 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 12/16/25 14:32, Guodong Xu wrote:
>>> SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
>>> Add nodes of uarts, timer and interrupt-controllers.
>>>
>>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>>> ---
>>>    arch/riscv/boot/dts/spacemit/k3.dtsi | 529 +++++++++++++++++++++++++++++++++++
>>>    1 file changed, 529 insertions(+)
>>>
>>> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..cb27b790716fdd6dc2bc89c28dd2588a596a5af9
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
>>> @@ -0,0 +1,529 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (c) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
>>> + * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +/dts-v1/;
>>> +
>>> +/ {
>>> +     #address-cells = <2>;
>>> +     #size-cells = <2>;
>>> +     model = "SpacemiT K3";
>>> +     compatible = "spacemit,k3";
>>> +
>>> +     aliases {
>>> +             serial0 = &uart0;
>>> +             serial2 = &uart2;
>>> +             serial3 = &uart3;
>>> +             serial4 = &uart4;
>>> +             serial5 = &uart5;
>>> +             serial6 = &uart6;
>>> +             serial7 = &uart7;
>>> +             serial8 = &uart8;
>>> +             serial9 = &uart9;
>>> +             serial10 = &uart10;
>>> +     };
>>> +
>>> +     cpus: cpus {
>>> +             #address-cells = <1>;
>>> +             #size-cells = <0>;
>>> +             timebase-frequency = <24000000>;
>>> +
>>> +             cpu_0: cpu@0 {
>>> +                     compatible = "spacemit,x100", "riscv";
>>> +                     device_type = "cpu";
>>> +                     reg = <0>;
>>> +                     riscv,isa-base = "rv64i";
>>> +                     riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "h",
>>> +                                            "smaia", "smstateen", "ssaia", "sscofpmf",
>>> +                                            "ssnpm", "sstc", "svade", "svinval", "svnapot",
>>> +                                            "svpbmt", "zawrs", "zba", "zbb", "zbc", "zbs",
>>> +                                            "zca", "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
>>> +                                            "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
>>> +                                            "zicntr", "zicond", "zicsr", "zifencei",
>>> +                                            "zihintntl", "zihintpause", "zihpm", "zimop",
>>> +                                            "zkt", "zvbb", "zvbc", "zvfbfmin", "zvfbfwma",
>>> +                                            "zvfh", "zvfhmin", "zvkb", "zvkg", "zvkn",
>>> +                                            "zvknc", "zvkned", "zvkng", "zvknha",
>>> +                                            "zvknhb", "zvks", "zvksc", "zvksed",
>>> +                                            "zvksg", "zvksh", "zvkt";
>>
>> This not the description of an RVA23S64 cpu. It is not even RVA23U64,
>> e.g. `supm` is missing.
>>
>> Is the description incomplete or is the CPU not compliant?
> 
> Hi Heinrich,
> 
> The SpacemiT K3 supports the mandatory extensions defined in the RVA23
> Profile (ratified Oct 2024). The list appears incomplete here only because
> I am restricting the entries to those currently supported by the Linux
> kernel Device Tree bindings.
> 
> Specifically, I must adhere to
> Documentation/devicetree/bindings/riscv/extensions.yaml (and cpus.yaml for
> properties like 'riscv,sv39' which stands for the extension Sv39). If I
> add extension strings that are not yet defined in these schemas, such as
> supm, running 'make dtbs_check W=3' fails with: 'supm' is not one of
> ['i', 'm', 'a', ...], followed by "Unevaluated properties are not allowed."

If Documentation/devicetree/bindings/riscv/extensions.yaml is incomplete 
with respect to ratified extensions, I guess the right approach is to 
amend it and not to curtail the CPU description.

Best regards

Heinrich

> 
> Another angle, I found there are other reasons why Linux kernel chose to
> 'omit' some specific extension strings. For example, here are what I noticed
> so far, including the 'supm' you mentioned:
> 
> supm: There is no binding string for this yet. However, in the kernel config
> (refer to arch/riscv/Kconfig), RISCV_ISA_SUPM depends on the detection of the
> underlying 'smnpm' or 'ssnpm' hardware extensions. Since 'ssnpm' is
> present in my list, it can be considered as supported and the kernel
> will enable pointer masking support automatically.
> 
> Other examples:
> ssstateen: The kernel schema currently uses the smstateen string to
> cover CSR access control in all modes (H/S/VS/U/VU). I have included
> 'smstateen' to satisfy this, as there is no separate 'ssstateen' binding
> in the extensions.yaml.
> 
> ziccif: This extension is also absent from the bindings, despite being
> implied by ftrace dynamic code work. Reference:
> https://lore.kernel.org/all/20250407180838.42877-12-andybnac@gmail.com/
> I intend to submit a separate patch series to formally add ziccif to
> extensions.yaml.
> 
> Anyway, I have limited the x100 riscv,isa-extensions list to strictly
> validate against the current kernel schema while exposing all features
> the kernel is currently capable of parsing.
> 
> I hope this explanation clarifies the situation. Please let me know if you
> agree with this approach.
> 
> Best Regards,
> Guodong Xu
> 
>>
>> Best regards
>>
>> Heinrich
>>


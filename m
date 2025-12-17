Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0E5340A67
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962385; cv=none; b=LuoCN9boDo/8SjVxAp5jwUQaYOlsy99foStqiPBLGAn/pM4+O5jDAhlYLE99kGNFDIPO6U+peTY77+hCXDsGqIbVxSwN/34uU+akNk41OdcKGYbZwptHtoV80RdUnFVtr7Hey8Z7BxBX9II4GrDrwwVxorYNCZHLPq3I9Pu/Ev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962385; c=relaxed/simple;
	bh=Z0lMYo5+NJ79AHAUbnTNntH5jebkTrZggk5FVdEzBq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yk5vdqJ+UBedVcYevg9eyMJvsFjh+h/iK4fyHjOo9Lzw/A9hRHS3GYh1LIV5m8quMy8VYY5pPW1mVlhF3AXEVat3yszj3qE2wU3fg33tieUiRGaVHQE3k77ALpIsp/wJf6Kk64ulpctjOe+m/tqBSop8QTDCShVp5oX259bQM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7BlFVrh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7BlFVrh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so5134956a91.3
        for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 01:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765962383; x=1766567183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1VRWjeuH/kViMmS59iXj3V5sEFdHUh9qPFuC/Iijp4=;
        b=B7BlFVrhMI4D0POPuexZtxAwJHNEmgOYYu7BRI4K5mWSCmUlzdfTMUX7E45DwF+klC
         ptSOONI96qFQesWjKvCU4ripnqrvEPpJ63/bFAe50vn18y+wfnWuGPL3ImtmQJw7jcti
         K+RneF5ogEBuBYOQqxFEOrB7YXsQEAHU3QHTAN109phcn5qDr8nu66IJZomjBQz71Fal
         3MeAyTO+Myvrj2aeePVgSrbiWeqL2MP7Zv/B0ltJALz7a0TEmmq3NpAScmVqtR+xUSMe
         aCZ/FtWKttkzOkUC4nFrF0sLoV0281BJ9lGVtYhpR0ZIAShMu8SO0flS1Gy/wUAcK/L1
         klEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765962383; x=1766567183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1VRWjeuH/kViMmS59iXj3V5sEFdHUh9qPFuC/Iijp4=;
        b=oXVoyBJ6/CIyrJtup+WnY3qi1q+6N9TlaeVGkWih8W6omb4mLsMLqAXc9hsUvQ1Chm
         YpZMu56zqm3od4K3CTNwAOLhIUxzjAcznTes3aoqc2Ii733/hdWu24NDp1AFTvMez/qD
         tdN5JQS3WvvEx2yKt1D+8rB7AgNHJyFw/FR8tHQsY/xEc16p1FT1kUbhRbc//Xxrt+NO
         p2Va6DPKuFRZsT25le9BSD5qQXq1vrwUqNELJTgQXW/loIPXWaPGr2I02+Rw/qsmUGRw
         3LHJnKEWFIsvYZicThmkkH4mVR5YKL35Qc2pxvicNlv2Crn0DXhQ5Rl6U5joxR/+U/QL
         tcZg==
X-Forwarded-Encrypted: i=1; AJvYcCVNbu0S8NdoYCICHANHYmUJMbIw0kJgsovrZpBLi1256W0/Ud9P8oWsUxNC8mvczK3inyBe3m8oWj05rT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEAMJUcRTgiQyBOgMDK+9qwLBg6hdRR9JcAxrI2KTX4TBmRMl
	Fx68Kky4eWazr6kulB4sy2pTRydqQCpnT+mCfu/ZV9f3wA5G3jYg1OaV
X-Gm-Gg: AY/fxX7AHhXknw1DY5hwYtdywnApZST9QY8eQBtcbd1piUpPfjFxfJzMrQTC/QmQ8WP
	obN+ShUfDHbBft7lnz4ezHoGeILIpoCELy6eoRpfaFBu3BTn08WSrMxWyIVVpA6zQNO/RUy81u3
	pxj1tqT+wrXhFDSu5wywenw/SjxGT19MYB8tlCScmv6beXxrwpUnYi8TnPYXAwZllLj1fF9dqCQ
	I9yC3sOo1WE01nPhAJB5ozoMMFtmx0PIgh2zQXTPOE7fI+D1vyd+F2YB4r2Lk3N7r+iz5gRSowz
	V837ugGFt/0ogJ6rwTVLXqGHG1qpuP8LlC7QklyJHmCgoYLiSebxCuXWnSBhFmIs1hxH6FOZtfu
	5pHqFEzdFzPnNP8sAxQa2/d6rH1+YhmkxjXWo4/DkmnxgVEpyb7baMzoN19Gt9IOTXf1TC4FpEu
	T5viEMG1dmyaX9
X-Google-Smtp-Source: AGHT+IE6PfmxAkj5HlkxzkJmnrwLpLmQDasxQXTlueI2ut1ZFaSRcM/T3o7RF88n/l5r5DOiJzvQyA==
X-Received: by 2002:a17:90b:3f85:b0:330:6d5e:f174 with SMTP id 98e67ed59e1d1-34abd751aa3mr16360133a91.20.1765962382751;
        Wed, 17 Dec 2025 01:06:22 -0800 (PST)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcbc0be691sm2048570b3a.58.2025.12.17.01.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 01:06:22 -0800 (PST)
Message-ID: <e5d92ecd-6bc1-438d-87ec-96f60d1b8a24@gmail.com>
Date: Wed, 17 Dec 2025 01:04:27 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] riscv: dts: spacemit: add SpacemiT K3 Pico-ITX board
 device tree
To: Guodong Xu <guodong@riscstar.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley
 <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
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
 <20251216-k3-basic-dt-v1-8-a0d256c9dc92@riscstar.com>
 <3c38ce9c-4259-4149-bf2c-a54e74c00a34@canonical.com>
 <CAH1PCMbzv_uggyZ3JLPyWXSwbe2dJAh7jVT64xpM6SLG77VZqQ@mail.gmail.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <CAH1PCMbzv_uggyZ3JLPyWXSwbe2dJAh7jVT64xpM6SLG77VZqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Guodong,

On 12/16/25 23:13, Guodong Xu wrote:
> On Tue, Dec 16, 2025 at 10:33 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 12/16/25 14:32, Guodong Xu wrote:
>>> K3 Pico-ITX is a 2.5-inch single-board computer equipted with a SpacemiT
>>> K3 SoC.
>>>
>>> This minimal device tree enables booting into a serial console with UART
>>> output.
>>>
>>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>>> ---
>>>    arch/riscv/boot/dts/spacemit/Makefile        |  1 +
>>>    arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 25 +++++++++++++++++++++++++
>>>    2 files changed, 26 insertions(+)
>>>
>>> diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
>>> index 95889e7269d1bae679b28cd053e1b0a23ae6de68..7e2b877025718113a0e31917eadf7562f488d825 100644
>>> --- a/arch/riscv/boot/dts/spacemit/Makefile
>>> +++ b/arch/riscv/boot/dts/spacemit/Makefile
>>> @@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
>>>    dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
>>>    dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-r2s.dtb
>>>    dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
>>> +dtb-$(CONFIG_ARCH_SPACEMIT) += k3-pico-itx.dtb
>>> diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..0f9d04dd352f5331e82599285113b86af5b09ebe
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
>>> @@ -0,0 +1,25 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (c) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
>>> + * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
>>> + */
>>> +
>>> +#include "k3.dtsi"
>>> +
>>> +/ {
>>> +     model = "SpacemiT K3 Pico-ITX";
>>> +     compatible = "spacemit,k3-pico-itx", "spacemit,k3";
>>> +
>>> +     chosen {
>>> +             stdout-path = "serial0";
>>> +     };
>>> +
>>> +     memory@100200000 {
>>> +             device_type = "memory";
>>> +             reg = <0x1 0x00200000 0x3 0xffe00000>;
>>
>> Shouldn't the reserved memory be described as no-map /reserved-memory
>> nodes instead?
> 
> Hi Heinrich,
> 
> Yes, you are right. Using a reserved-memory node with the no-map property is
> the correct approach. I will update this in the next version to explicitly
> reserve the first 2MB.
> 
>>
>> I would assume that 0x1,0000,0000 is the location of OpenSBI.
>> What is at 0x3,ffe0,0000?
> 
> Yes, confirmed, 0x100000000 is the start of OpenSBI. The size 0x3ffe00000 in
> my original patch was the result of manually subtracting the 2MB OpenSBI
> offset from the total 16GB memory.
> 
> I will correct this in v2 to show the actual memory and put the first 2MB in
> reserved-memory {} for opensbi.

I don't think this is the right approach. The Linux kernel shouldn't care
about the size of the underlying SBI implementation. The size of OpenSBI
also depends on the version and features enabled. Thus, you should just
let the OpenSBI or whatever SBI fix up the device-tree for you. OpenSBI
already does that today. It inserts one or more reserved-memory node and
carves out the memory region of its own. If there's some bootloader in
between SBI <-> Linux, such as U-boot, then it's responsible for copying
over those reserved regions from OpenSBI into the device-tree Linux uses
(U-boot already does). Thus, there's no need to manually specify it.

Bo

> 
> Thanks for the review.
> 
> BR,
> Guodong Xu
> 
> 
>>
>> Best regards
>>
>> Heinrich
>>
>>> +     };
>>> +};
>>> +
>>> +&uart0 {
>>> +     status = "okay";
>>> +};
>>>
>>
>

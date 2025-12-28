Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599E1E32D3
	for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766965820; cv=none; b=cLo/J+Z5sVgvMvWF7jI+MwaiabPHwu79GULkNsPFqYY2E98kDYgnDxKf8lW3ry+llno4gwGx0ucK1vEHVUz/54Rb9X+zaBcif0Cf1R6G0EH0Tnb/doTk4nesXlaGYYA2lkzHr4eE02I30A/LY2E8yGdP7Ua/BEz1HraMCQTxBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766965820; c=relaxed/simple;
	bh=2w0A7ymf9jXbqKrPGnI5Cug27+M1AwvX/RchOIlL1II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mk5pYl++0WKmDItZf5K7uaqoMlvQrpoyzCVAfymhXYCh96aE5CMHFK40h4eakAqApt4M413IuKXJ5bPuieXnn6gpq5cdp/EVIEE+oHGyu9nIEivQ2Fuhdcl7srL7hVBBj1ZhAAFQhVk/OrQenJXCoJyKzsSlg8vDnjGanB4Ywxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=XXvcvG+B; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="XXvcvG+B"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b220ddc189so1207079185a.0
        for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 15:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766965818; x=1767570618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpN54oVgQguU3p5JgPy3uhgmnh+wgxqdR+Icp20pf+8=;
        b=XXvcvG+BFtgKYWIg264AJ3Qu1/kcAI2XJhI1qt6IUc4qCgg4tBS+NOgM4YxllC/2cm
         CFuuOLvFcK7z+rn3mc8j0Mhgk4TKIOADD7xlY/tRLFGBkhlzRW8U+e/abRGJIenOjJKB
         K/+GKDz+F/0hesQW0qAqlOdAtjjZ2N9nvg5+Em6NszGdicaGJ+u3YmCDpHRSQ3MTpdXn
         vTaAGrvOXWRZJSvXnZF4lvbI9rVF9ScL+mk7577ntWeIBX/jB6z5TBHf3xKTl29lzuW8
         7/CsGvX+Q+1eb++kKXna7K1+WbnnYr8bmY0aDbmJlSjRsVn5vNN6j9O665bZs5m2tf6h
         hf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766965818; x=1767570618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpN54oVgQguU3p5JgPy3uhgmnh+wgxqdR+Icp20pf+8=;
        b=cQdKXhf4CqXbdE0+n4XqAWF4QRFKkDnPvikIwIffvWV97HI5ncSeko1r7+QKsV6h0+
         xiIkyhmBPGFKYgqGqn96h8gd6Gt5hjhCdAo4o9zOjFS5WeU+5by91n5lvLmDwqzuBIGC
         c8+Tao49AS6k+a/J5ozU4b7bBbeD5mrHIrf2gLN215CEH3s1TwUa6es2RETgNOQs/+7P
         Iem0+ANpFuUP+j+95YThb0au5qjowLUpk1TAQ+4a8pIG+jTKwjzZfD8Z8UtU85TsSd/1
         +5q1lxA35K4CoRrFJjM15bFpb6NrTs2oX3SN006yplc4wTomW665Rb6cPzz5OrUlVE45
         Qtng==
X-Forwarded-Encrypted: i=1; AJvYcCWJAMMBMsNmmwLgQVCmKAOiemmhhC5REEZxIsK+AHtyspdh94MGp8GyWhuM3deRiV8DQpYQRCdDcNi2mpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2IyjtVITCVFNvFb53CsW5PytCzbHLaJp4NsbEewcmJxp3p2+5
	nGV6gVUuECTK2am1v9mnQw+lP3RIYF71xdV9CSqgDNYBGpQQdveUx+XhYi1M863uwy8=
X-Gm-Gg: AY/fxX7AJTuWv6VMnUtScuPaMkqu1o6V1xfeG4lMWvyyVa8lSdbTyObKSBLt6ba5yi/
	EiuPdeltzYO93z1TdGJFKoaB5WncZ7cIZdWXGjTiPF57ciOFfQowrLyTjTbdd/XLRuaV5fXEqOp
	73PsNBDh39ryZjjeq0fz9Qh4fC736naqQaAIGM3o1QfSFcA8/VyzNbM018ySm5JUx2Gpl8YSH51
	ytSR5XcyMUwEDJzocgdgNicp2d+RM8aTiTdNDuKx/Bgejp3t90cmaD65f++/T196Yr3zZ6tIeNH
	pNV/7j/wsH7jUkGKoGShS0p6crSkWOtWoc+E8X7MvQ+TBNyTa6WTbTTM2ZQg2VRVvvHcAufoKa2
	sBBpJpDZgNugEhD/cxJIeXTGZDU0zU17jMhrfIet6lATrxbHRdzBWhhSy2I+Mt3kh3NV3NWW/BM
	nWayVmT+aqQB5kVpsJgQEKiWm7Ud+zkR/PTetcOZ0NWOrv1kqBGmM=
X-Google-Smtp-Source: AGHT+IEGbKgRTG08k8rXERBJismFkK/tDgJdZx5wXocvbU/vsRR/qDK2KUySLLUQVB2beTsVWlcMDw==
X-Received: by 2002:a05:620a:29c7:b0:809:eb12:1ea0 with SMTP id af79cd13be357-8c08fd18b81mr4252356785a.81.1766965817857;
        Sun, 28 Dec 2025 15:50:17 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f28e3sm2406423185a.45.2025.12.28.15.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 15:50:17 -0800 (PST)
Message-ID: <5979c8ef-b0fa-40c8-944d-96e226fbcbe8@riscstar.com>
Date: Sun, 28 Dec 2025 17:50:14 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] dt-bindings: riscv: Add B ISA extension
 description
To: Guodong Xu <guodong@riscstar.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>, Paul Walmsley <paul.walmsley@sifive.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, linux-serial@vger.kernel.org
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com>
 <20251222-stitch-preachy-3fab87fd6f0f@spud>
 <CAH1PCMZ7ywZ3unLy0yHYK+fFHk0y=q2cEtPnRi=qSpf=fc75rw@mail.gmail.com>
 <66c0676a-7920-4825-b916-3c00b1648a08@riscstar.com>
 <CAH1PCMbBURb=DpChf+Y-DjYjzpXG-pKgoaHAu=TUuG4oVC56cg@mail.gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <CAH1PCMbBURb=DpChf+Y-DjYjzpXG-pKgoaHAu=TUuG4oVC56cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/27/25 8:51 PM, Guodong Xu wrote:
>> That's what I understand it to mean, anyway.
>>     https://github.com/riscv/riscv-b
>>
>> There's no point in supporting "b" in devicetree to represent
>> the others if it also requires the others to be present.
>>
>> I think that, instead, "b", "zba", "zbb", and "zbs" should all
>> be allowed.
>>
>> I might even go further and harden the requirement, saying that
>> if you specify "b" you should*not* specify "zba", "zbb", or "zbs".
> Historical reasons here. "b" came too late. The chip vendors have published
> cores with "zba", "zbb", and "zbs"already.
> 
> That's a migration bridge to require "b" must be listed
> together with the other three.

Are you saying "b" has already been included with "zba", "zbb", and
"zbs" in an existing DTS file?

What I'm suggesting is that (unless someone has already done this in
a DTS file), there is no reason to require "b" *and* the other three.
You should allow either "b" *or* all of the other three, not both.
That would support older platforms as well as newer ones that use
the more concise "b" only.

					-Alex

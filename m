Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31DA27E045
	for <linux-serial@vger.kernel.org>; Fri, 26 Dec 2025 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766784519; cv=none; b=IucSFH89iayfGq8721pUciQ5Kq9UdIWjJyFp2YRTI6B1bhwH9sj6AF1eit3lh4f3XljrCLc0GDwApe9xkDv9rxsQlIkPvt5la4bwK/l6+pzh3SmQjIOZhMUESUimyga60zo3QfCDtEU/0+O9pYR1V76vjmuklXrI5IoFq+7Pwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766784519; c=relaxed/simple;
	bh=ZhGFWm8Y7M3qzky9yCK/bA9/qroETuciVky1Ja9nmpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKGeCma1ppizYAX7JfaSdzqX6H8mlZL28Vjip/OBURkTs7ZMDBNiuwys/vUdlv6IvNjrT3slC7i+SEwNRFhKUB0ENETIGcFzMFzlkEzclN+XGPMZ+zKHqrIP2TslVX7eSwKyFXAcFNk9qB3lsvKq7PlrsgSWDIQJC+/JcN/qwug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=eM0cnaRz; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="eM0cnaRz"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88a3d2f3299so90565106d6.2
        for <linux-serial@vger.kernel.org>; Fri, 26 Dec 2025 13:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766784515; x=1767389315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fm5dxyjoGTgLB5EfhliAJ+8GZyHW/7sdxpOXkZhyc4Q=;
        b=eM0cnaRzB/SvQPYR7gBvZY7rfY1koUSb4dPNYT66DTGqmpm6Cu+WIf8w6We7UmMvIC
         LSMu8rbh1FZlsC5wBi82tm1mU7+essMJu2jgJ9nR5PYAsxauKvR+Pxi0u8EKmUtqIyZS
         UoplvFmVS+Dz+PosAoBiIQRbq7TdqPPd7ZarO1zQASSZ95BQe1BVGE4SN8tKxERL/uUR
         dXvsFXF2n39qecpCRXagMzvezGc9noAOFo1gRwjKgHqS9gbd9PtGKoCOvyjzRngFrJzy
         DLJC+zr6bzYwVQCPy1xrNU5H8OjsmNGaFW4Ii4c1hIU8rbmzXXqz5se0CXn+66YsySMJ
         04+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766784515; x=1767389315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fm5dxyjoGTgLB5EfhliAJ+8GZyHW/7sdxpOXkZhyc4Q=;
        b=etVxE5HP0D0XWxjfrx9EAWBWHQJaiq+9OBtAJKHca4Ni4GXJ7wUU8r51lzDLeZndBH
         CyzlCystN/c3yrUNdy+QBa6PMxBHGF5hrv8cDtCfghTQ1Ry+vczgUcmAhkmTB7Ea/aKC
         gB8KqXdcTO+JhBoagNnzN8x3KXkxMfn7vJMaV2Ibtfbo+Qo6gpWfECMGwzlREqjl+tiX
         6twBYrLfd9uOBaKVotYw520rLKfPVyf9TYIzJsd1Dw5ap+E4I9wvFGOU3kGqJEZS12iW
         G+uDifcaF4NXHTh73nugnp+7cfvtqNezCQys4wn/JgLE123fOoq8j82u3djwMKKdFjfl
         3dRw==
X-Forwarded-Encrypted: i=1; AJvYcCV/8VMb+JQQDvrwVjKNCYZ7WTwyQai1/0hzCqyYq3lIZ6IVnyOz6MkGrVUwIMUNpnxjDxdDpM+aj9PeeJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYAQH9QP86T6F7xYLtKqgmU2VnCSX9oIYnyNNubrhSR5aouM8P
	2lVmcBnjF6gJenqZD3k4SSncDFElRUx7+LHsb4uUQ9ouA0ZYb62p5cEnKoSTcJnYR0A=
X-Gm-Gg: AY/fxX5SyJeaZnzr1sZrpeAE/FMpc0Exsrk5kw0wnuH8HUdPJWtaNy2RZCnivKFOw5J
	W57dmj5EylYDXvI12lPzvZ97wfvAOATQQ4/i/rXgP6Gy1WG626qb8JbGHYfh9mUCyg4DzGpU5Xy
	Ajh0o6ldozNXKi+az4h/VKz9dlr+KbHlyxAvgeJNfps8sKvJI9d9G5Xlk/ufk6iAIq1rHEgYHmy
	YIiF0FMivMxIApd/0TbRWCs5KX5m7EfCsPr/KvQAKPaVmzC+ZdSA3GZyEuldsdtoCrAYnOndY/l
	+wR3+PGv6WpSrS5ZtI0c9GfBnj42+U/74duuwXnTh1FO9lypPV44eMAUzJ3JAsYDoLCX9R+G2hR
	V/d6ue+C1u4yH8c7QPUFQDMila0+y90zX/7UX394PdSHkJ7PYr/sq3AN8eSRs0R+jguCP/+PVQ+
	TfQF6Tlnu8kAhQ+DZI8Xd3TyMOuCa6umAAbrsOyEHnuaBYF/YKXmI=
X-Google-Smtp-Source: AGHT+IHacwFIf7+7Gu6DCHAGNcJqj4mIg/TsHnBOgw2K659NvhFpRoQ/eMLaH970LQj3miK0Jz/+jQ==
X-Received: by 2002:a05:6214:1403:b0:88a:2578:9fa9 with SMTP id 6a1803df08f44-88d84528e20mr297151096d6.2.1766784514736;
        Fri, 26 Dec 2025 13:28:34 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7d5f4sm176833206d6.40.2025.12.26.13.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 13:28:34 -0800 (PST)
Message-ID: <8851c155-300a-4241-a5be-5163ba54e47c@riscstar.com>
Date: Fri, 26 Dec 2025 15:28:32 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] dt-bindings: riscv: Add descriptions for Za64rs,
 Ziccamoa, Ziccif, and Zicclsm
To: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
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
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley
 <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, linux-serial@vger.kernel.org
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-8-3af3f3cd0f8a@riscstar.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251222-k3-basic-dt-v2-8-3af3f3cd0f8a@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 7:04 AM, Guodong Xu wrote:
> Add descriptions for four extensions: Za64rs, Ziccamoa, Ziccif, and
> Zicclsm. These extensions are ratified in RISC-V Profiles Version 1.0
> (commit b1d806605f87 "Updated to ratified state.").

I think stating the RISC-V profiles commit ID here (in the commit 
header) is good.

I do *not* think it's necessary to include it in the descriptions
for the extensions, below, but I seem to be late to the party in
expressing this opinion...

That commit ID is related to this repository:
   https://github.com/riscv/riscv-profiles.git

I have a few other comments below but generally I think what you
did looks good.  I have one overall question though.

> They are introduced as new extension names for existing features and
> regulate implementation details for RISC-V Profile compliance. According
> to RISC-V Profiles Version 1.0 and RVA23 Profiles Version 1.0, they are
> mandatory for the following profiles:
> 
>   - za64rs: Mandatory in RVA22U64, RVA23U64
>   - ziccamoa: Mandatory in RVA20U64, RVA22U64, RVA23U64
>   - ziccif: Mandatory in RVA20U64, RVA22U64, RVA23U64
>   - zicclsm: Mandatory in RVA20U64, RVA22U64, RVA23U64

I did not verify your statements about where these are
optional and mandatory, but I assume they're correct.

> Since Ziccamoa depends on the 'A' extension, add a schema check to
> enforce this dependency.

All of these extensions are related to atomic operations, right?
Don't *all* of them (not just Ziccamoa) depend on the A extension?
Furthermore, the A extension is already mandated by RVA23U64, so
is it really necessary to add this logic?


> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v2: New patch.
> ---
>   .../devicetree/bindings/riscv/extensions.yaml      | 34 ++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index 385e1deb23996d294e7662693f1257f910a6e129..a6b9d7e3edf86ecfb117ba72e295ef097bdc9831 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -237,6 +237,12 @@ properties:
>               as ratified at commit 4a69197e5617 ("Update to ratified state") of
>               riscv-svvptc.
>   
> +        - const: za64rs
> +          description:
> +            The standard Za64rs extension for reservation set size of at most
> +            64 bytes, as ratified in RISC-V Profiles Version 1.0, with commit
> +            b1d806605f87 ("Updated to ratified state.")

The more complete description says:

     Reservation sets are contiguous, naturally aligned, and a maximum
     of 64 bytes.

But as I read on (below) I suppose using the more succinct description
from the glossary might be best, forcing people who care to go look
at the reference documents.

> +
>           - const: zaamo
>             description: |
>               The standard Zaamo extension for atomic memory operations as
> @@ -378,6 +384,27 @@ properties:
>               in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
>               riscv-isa-manual.
>   
> +        - const: ziccamoa
> +          description:
> +            The standard Ziccamoa extension for main memory (cacheability and
> +            coherence) must support all atomics in A, as ratified in RISC-V
> +            Profiles Version 1.0, with commit b1d806605f87 ("Updated to
> +            ratified state.")

Similar comment here (but also with a similar caveat):

   Main memory regions with both the cacheability and coherence PMAs
   must support all atomics in A.

And I might say "the A extension", but maybe that's a bad idea.

> +
> +        - const: ziccif
> +          description:
> +            The standard Ziccif extension for main memory (cacheability and
> +            coherence) instruction fetch atomicity, as ratified in RISC-V
> +            Profiles Version 1.0, with commit b1d806605f87 ("Updated to
> +            ratified state.")
> +
> +        - const: zicclsm
> +          description:
> +            The standard Zicclsm extension for main memory (cacheability and
> +            coherence) must support misaligned loads and stores, as ratified
> +            in RISC-V Profiles Version 1.0, with commit b1d806605f87 ("Updated
> +            to ratified state.")
> +
>           - const: ziccrse
>             description:
>               The standard Ziccrse extension which provides forward progress
> @@ -795,6 +822,13 @@ properties:
>           then:
>             contains:
>               const: f
> +      # Ziccamoa depends on A

Maybe more than just depends on the A extension.

					-Alex

> +      - if:
> +          contains:
> +            const: ziccamoa
> +        then:
> +          contains:
> +            const: a
>         # Zvfbfmin depends on V or Zve32f
>         - if:
>             contains:
> 


Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835CA2D73B6
	for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766965827; cv=none; b=mNynWwqbrG4ymWpXX1hBFk1h1RzNXQbdRG1JRG0700N8UuFhIeCWb055QfJTSjPmisu80ZTmOTXpvssV3i/H5SdjLN2A9aGJkb2t1L2lAggpX1ackMQc0cEk3pBMaXbMRi4LlVwpZ2ActS6fM0XvzqNmdB7qzGGflo35Sb5U2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766965827; c=relaxed/simple;
	bh=sVpTDADuXtQMnOJQSbV+zhhpNFiOBbGnuogllAgBr+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op/8TcV8w+u3RwytZ28ARdinxKeKl+E1mES/9l7Sblg1mDCq0cQ22LfPwAgxw5+xZACHPozZv3KGbebnQjGkHN7OxuRVow+yef8sMmE7YhonB21GX+PQ6lfu5XXbKlEWxc7JsZVLGnBlDA4mYUL7pXvpR9//uUU4IZ4U+ef4y/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=jxwixLmN; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="jxwixLmN"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b144ec3aa8so913034485a.2
        for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 15:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766965824; x=1767570624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGg9TVkzSyLOYk8NKjbUBxoiYn1jq6nqqC2B9vxuQ20=;
        b=jxwixLmNkJh3xb9oNqir5cVRPYxsk7IPuSN2MmQoGCLXkXVeDvrK1xGbtONeGyftjC
         gYODemSICGQN1J6xEMvN9njWOUxz9yH7Hfl37sCf4MLWuN3T0tVvJlFPb+/zAONyGY70
         TgidHfAlbUjRLbBba8jqVEz3iOpiBZ1a1fMJ2jk2Pyf7bYL810XMJY/iflpFz5CqiBQo
         EjH5aGWYkJNmFJnU9PDIr0PYIJ2RC5cUeM8f7T81e+7AncILOidJnJXCrqMECHys/mHA
         9mWjMCi1jaR21goDEjMMBNI5peObERrAjmQVKh3EkEFnviMQprzw1ACcKI3CIHRKuYPs
         +RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766965824; x=1767570624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGg9TVkzSyLOYk8NKjbUBxoiYn1jq6nqqC2B9vxuQ20=;
        b=EzQRXSWYuzOGxR25eecgtuUKfQOiSq+Xps+nVPVoV+He2/ILoVTQisUGh7nbUYOXaj
         O7neyqQvznY8qVTxOTDBfMlN0PhF2tqTmiMfM0S3IyCP2dedArUwYh65jG27KBgUsxXT
         nk0QhPekSaBlQgDYFsxV6zRv5AInffDh6rnISQaujZKgYnLb1HPETXrbCzMpN/HOJRzg
         8GNdIx9WX2tVlOvbaSz0kPMRcHquCDAQ62DqANAcSvv8m6kpLs6umznZt1S0PUUP7R+V
         6Bcl3gSpuXd1oehLcsnYYXBG7519aJED3TivgZy2jQW31JgVOlMw1jRPMHi0f4VyAsae
         VmDA==
X-Forwarded-Encrypted: i=1; AJvYcCX7KGcpzkWBiIyfqqAdk3RRahc6t8WODm2LypVp2kX6IpK4YF89WI+6mSD0QfzfoQMIELpYyfQo3mQpBDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWoOoo/4auFLz5FOgtNs9deGY0f1fmPKBcm05i/xFa62J7QVt
	pOY1MRyIZ3jHR/IzRaqEx+TKFI3bfhKv5dxCcAtsso/zp+Yimxm80gA4qQO3WM34ZwQ=
X-Gm-Gg: AY/fxX469nUhLsc79wi3q/BJvsKksFgGC9FmQcaCPUUNpTpbuLE9dX49kMRzyVF3lE7
	t23J6MLrg7WI5c9MCHgpMcEMH6IgRDMg9h4mk7NAs1d9TvDOArFn/enzyWMc7sSeE5RU03LRKa0
	my2QCsehSH1QukI98ofTZqnyfzdKDvlrh8LVhpdnDKOn9XDmgH+TPzza0qztbV5/nyyGeT4PcSl
	372hJkMLVhQHkxzhBXXCxDzWKYCCLLEAvP5Zlboz3FCNzaiIa3d/egc6Mm8TSdf22qcJTesE7hC
	6tjgmJ9dEZ21WqPbIptjK/QWOSjbmV8r21iC3Xn5jhRompHnzKn/QCd1sLyJ+/EDipwa4sNonZY
	Zjn4JY8J3jzjKt1MeMppUine7ljfI3GbwTiEDI9e5Wv3mZTJy6PGRkX5HIVkQYP5HLeaN+cUlpE
	kf/cO/bp2gNcG7pRWkUuJajEXLaSvM433HOwFInKldgOKphSXOSdA=
X-Google-Smtp-Source: AGHT+IENo+4b0smC8TFEGHw2t77Y1hDrYcgaOhQgijSCe33rGID/qLKQXVh9HVX2zWXUPOmu52A9pQ==
X-Received: by 2002:a05:620a:2906:b0:8b2:e1bc:f27c with SMTP id af79cd13be357-8c08fabf900mr4212673585a.68.1766965824320;
        Sun, 28 Dec 2025 15:50:24 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f28e3sm2406423185a.45.2025.12.28.15.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 15:50:23 -0800 (PST)
Message-ID: <50559ab9-c537-4796-9538-495bf3d14069@riscstar.com>
Date: Sun, 28 Dec 2025 17:50:22 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] dt-bindings: riscv: Add descriptions for Za64rs,
 Ziccamoa, Ziccif, and Zicclsm
To: Guodong Xu <guodong@riscstar.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>, Paul Walmsley <paul.walmsley@sifive.com>,
 Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, linux-serial@vger.kernel.org
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-8-3af3f3cd0f8a@riscstar.com>
 <8851c155-300a-4241-a5be-5163ba54e47c@riscstar.com>
 <CAH1PCMatKR4rHuBdw0fih5P8naE=KU4Vp5-KNjeDeO-LsEe81g@mail.gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <CAH1PCMatKR4rHuBdw0fih5P8naE=KU4Vp5-KNjeDeO-LsEe81g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/27/25 10:10 PM, Guodong Xu wrote:
> Hi, Alex, Conor
> 
> On Sat, Dec 27, 2025 at 5:28 AM Alex Elder <elder@riscstar.com> wrote:
>>
>> On 12/22/25 7:04 AM, Guodong Xu wrote:
>>> Add descriptions for four extensions: Za64rs, Ziccamoa, Ziccif, and
>>> Zicclsm. These extensions are ratified in RISC-V Profiles Version 1.0
>>> (commit b1d806605f87 "Updated to ratified state.").
>>
>> I think stating the RISC-V profiles commit ID here (in the commit
>> header) is good.
>>
>> I do *not* think it's necessary to include it in the descriptions
>> for the extensions, below, but I seem to be late to the party in
>> expressing this opinion...
>>
>> That commit ID is related to this repository:
>>     https://github.com/riscv/riscv-profiles.git
>>
>> I have a few other comments below but generally I think what you
>> did looks good.  I have one overall question though.
>>
>>> They are introduced as new extension names for existing features and
>>> regulate implementation details for RISC-V Profile compliance. According
>>> to RISC-V Profiles Version 1.0 and RVA23 Profiles Version 1.0, they are
> 
> Thank you for the review.
> 
> Together with the filenames, I also listed the Version numbers.
> 
> These are officially released versions of profile documents. I mean they
> won't be changed without modifying the version number.
> 
>>> mandatory for the following profiles:
>>>
>>>    - za64rs: Mandatory in RVA22U64, RVA23U64
>>>    - ziccamoa: Mandatory in RVA20U64, RVA22U64, RVA23U64
>>>    - ziccif: Mandatory in RVA20U64, RVA22U64, RVA23U64
>>>    - zicclsm: Mandatory in RVA20U64, RVA22U64, RVA23U64
>>
>> I did not verify your statements about where these are
>> optional and mandatory, but I assume they're correct.
> 
> Yes they are correct. As far as what stated in the two profile documents.
> 
>>
>>> Since Ziccamoa depends on the 'A' extension, add a schema check to
>>> enforce this dependency.
>>
>> All of these extensions are related to atomic operations, right?
>> Don't *all* of them (not just Ziccamoa) depend on the A extension?
> 
> 
> Za64rs and Zicclsm: no, they are not 'A'. They are cache related.

Isn't a Za64rs reservation set related to atomic operations,
though?  They are related to load-reserved/store conditional
instructions, which are introduced in the atomic instructions
section.

I was mistaken about Zicclsm, that's related to unaligned
accesses, but does not apply to atomic operations.

> Ziccrse and Ziccamoa: yes, they are 'A' related.
> 
> Ziccrse specifies the main memory must support "RsrvEventual", which is one
> (totally there are four) of the support level for Load-Reserved/
> Store-Conditional (LR/SC) atomic instructions.
> 
> And in RVA profiles, two named features (exts) are added:
> Ziccrse: which further define the level of LR/SC operations being supported.
> Ziccamoa: which further define the level of AMOs instructions being supported.
> 
> 
> We already know that "A" = Zaamo + Zalrsc;
> 
> In summary, the dependencies among these extensions are:
> Ziccrse -> Zalrsc -> A;
> Ziccamoa -> Zaamo -> A;
> 
>> Furthermore, the A extension is already mandated by RVA23U64, so
>> is it really necessary to add this logic?
> 
> Hi, Conor
> 
> What do you think? I am kind of agree with Alex to remove the schema
> checking logic.
> 
> Leaving the dependency check to riscv/cpufeature.c, let the .validate call
> do the job. If you agree, I can remove the schema checking logic on Ziccamoa
> and A in my next version.

Yes I think this is a better way to handle it.  Conor?

> Btw, cpufeature.c validate() deserves another patch/patchset.
> I'll be happy to add that if we reach a consensus here.

Yes I think you should do this once there is concensus.



> 
>>
>>
>>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>>> ---
>>> v2: New patch.
>>> ---
>>>    .../devicetree/bindings/riscv/extensions.yaml      | 34 ++++++++++++++++++++++
>>>    1 file changed, 34 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> index 385e1deb23996d294e7662693f1257f910a6e129..a6b9d7e3edf86ecfb117ba72e295ef097bdc9831 100644
>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> @@ -237,6 +237,12 @@ properties:
>>>                as ratified at commit 4a69197e5617 ("Update to ratified state") of
>>>                riscv-svvptc.
>>>
>>> +        - const: za64rs
>>> +          description:
>>> +            The standard Za64rs extension for reservation set size of at most
>>> +            64 bytes, as ratified in RISC-V Profiles Version 1.0, with commit
>>> +            b1d806605f87 ("Updated to ratified state.")
>>
>> The more complete description says:
>>
>>       Reservation sets are contiguous, naturally aligned, and a maximum
>>       of 64 bytes.
>>
>> But as I read on (below) I suppose using the more succinct description
>> from the glossary might be best, forcing people who care to go look
> 
> That is exactly what I am doing.
> 
>> at the reference documents.
>>
>>> +
>>>            - const: zaamo
>>>              description: |
>>>                The standard Zaamo extension for atomic memory operations as
>>> @@ -378,6 +384,27 @@ properties:
>>>                in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
>>>                riscv-isa-manual.
>>>
>>> +        - const: ziccamoa
>>> +          description:
>>> +            The standard Ziccamoa extension for main memory (cacheability and
>>> +            coherence) must support all atomics in A, as ratified in RISC-V
>>> +            Profiles Version 1.0, with commit b1d806605f87 ("Updated to
>>> +            ratified state.")
>>
>> Similar comment here (but also with a similar caveat):
>>
> 
> I am using what the RVA23 Profile defines:
> "Ziccamoa: Main memory supports all atomics in A"
> 
> I prefer to keep it as is.

That's fine.  I don't think I felt strongly about any of the things
I said about the exact wording used here.

Thanks.

					-Alex

> BR,
> Guodong
> 
>>     Main memory regions with both the cacheability and coherence PMAs
>>     must support all atomics in A.
>>
>> And I might say "the A extension", but maybe that's a bad idea.
>>
>>> +
>>> +        - const: ziccif
>>> +          description:
>>> +            The standard Ziccif extension for main memory (cacheability and
>>> +            coherence) instruction fetch atomicity, as ratified in RISC-V
>>> +            Profiles Version 1.0, with commit b1d806605f87 ("Updated to
>>> +            ratified state.")
>>> +
>>> +        - const: zicclsm
>>> +          description:
>>> +            The standard Zicclsm extension for main memory (cacheability and
>>> +            coherence) must support misaligned loads and stores, as ratified
>>> +            in RISC-V Profiles Version 1.0, with commit b1d806605f87 ("Updated
>>> +            to ratified state.")
>>> +
>>>            - const: ziccrse
>>>              description:
>>>                The standard Ziccrse extension which provides forward progress
>>> @@ -795,6 +822,13 @@ properties:
>>>            then:
>>>              contains:
>>>                const: f
>>> +      # Ziccamoa depends on A
>>
>> Maybe more than just depends on the A extension.
>>
>>                                          -Alex
>>
>>> +      - if:
>>> +          contains:
>>> +            const: ziccamoa
>>> +        then:
>>> +          contains:
>>> +            const: a
>>>          # Zvfbfmin depends on V or Zve32f
>>>          - if:
>>>              contains:
>>>
>>


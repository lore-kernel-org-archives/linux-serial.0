Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BE2E1C7C
	for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766965831; cv=none; b=BiIwWb1Zcc+C8oWkK7XnX3gEYpBkzXB0N8OCBVgDTxkJ3wKg+lpX/Q6PFvyJWDJ/b0bCeLtBFK64NWac8DsLQZFvcFta0VVuzA79slTvGJwik4pkkvDyITm8LCyIOAeFOLofm/SE9sKkd1UP0Gc8DKvSLb0KZdplEt0q2WsXY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766965831; c=relaxed/simple;
	bh=FMGcKOOH2QAAM035N5VPwjsf6iLF3bsS2NHda98XWxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QT0uY1/m8vFufR0ggv/D5s7LG9UHLKbQ4r3v55aM+/mjR2Q6Odo871dtoGr6Hx+gomTUGjXSYihKMIhmMh5t4ZgkxBYxa4TNFWhT4k4OWJYVZecJGRmHupGUUzs8JmDDbqScUNlqhxnw3aVcWlMiVVgD4hTz4VOQizDxxl5rNxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=dU2x0BLr; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="dU2x0BLr"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4ee05b2b1beso91548311cf.2
        for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766965828; x=1767570628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iJY5kULQZeqgTosQ9scmyKuRaTaMg4i5yh/l64mgrA=;
        b=dU2x0BLrAW7aIWrVxChAmVhfNNqzEuTc2uSvxqkXU8zZTd+mzKWPcRqNXMtJS2oldL
         sILAiOlbaQUoMjgFqCI9YJwRYAsnel5zH+u1R/5c65oSapoJUy7eVxZvStk/9xxr4Lrm
         CYPBcsvZanVVbxXTqurivV1TEQd693CUojZG+YCB/2U1m5YO2qkSmEgBx7MlinMLHgbZ
         OFhGQBvPVlHnDdyXoGN8DCjdU0gCTN3SJHTWi36DL9fQ3wIJLOeKrKkuvKPzRNDHQlIr
         zXor/8M1Q0rL33yPWrXIS2OIlKIjW8119JDq/faMg8XObNodGXe7YCSJNHUvyTnlGLSq
         6A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766965828; x=1767570628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iJY5kULQZeqgTosQ9scmyKuRaTaMg4i5yh/l64mgrA=;
        b=V9jrFLSmoyl3/OelNmdvpepDLS9cOuaDsZuXbfyyVmIjmEoZTLOFjnbkUNh5N5f6HC
         XOQ7h6qSjJMLoH77vsmh93pwb/l15aFI5zf/tbHBzXx8el/RwY60pmXQzA61wuBUnkdO
         5nm7AymjkgCfkXNC2md+OtK556Rv3fafnG0Ox44EaJu7jJFnBcjIT99/F2pRi2UNP6Jm
         OEsYl+S1272VCHgCkCOc5WRnwRMq5gp1rMROrTCYGLXHzlzyMpKgfcuxunU9vWHC0b31
         kL6NIHejpKpIhsxyMPQmIe7hgdx5c2la6VkaDyA5Mw89JgW9+iqWST3cBxyPyWhDnYb1
         HAQw==
X-Forwarded-Encrypted: i=1; AJvYcCV7SG2pUjFrFYkYdiPeq4oKR5sBgOQj0c1ElDOXTAdbPtLRTpkHlDVNpJbJ5x+/cmmkzz5c9RZEO84bVQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0OZk+JRaCcv4YFbPLtpmsF2nYS66+Lk6PEJKE7KeNnRfs8OK
	MtkTdjB3z/0VFk2rIuHWAejJj5OJ+ewc0p8cTM1JUpEZqH7FfSOEqG1/qoweqKLKZKs=
X-Gm-Gg: AY/fxX42yMJiHbh9giH18OUmAgF0F4jMu2DGyxfMiNeevIEx9jlf3bOGRv0FwO2ENO5
	9uhvU1yJ0f0CTze6XIxvkETdRRZoouYWg8Xg6L+BQgh9v9cimB541/N48CwNi3FS7lDatt+1yS8
	FKLVJPNEvTLHcDM1K/4GzlziT1d89lhsb+WtZ3mQlICBUqLnd+svaED2w8MOkWMpUe1UylnHwJ/
	NYi1c95aBgElwRUYLLGUEzWfdHTC6Hjqh+P/6mAMJpQQUGftq6WbS6Z1P2F/4Mu+GFLEThbJuWr
	01D7/k4Yev3fl0miiE9gvZGOzIV71YbJ0irq62vXoLDw+dtkBqudo+NNZhwXH8PQghGXMXeum2j
	SxsWPfbCYqHfJYZSrgxtneALuXq0zqgIJikNgnfnc1t2ZzyUJhzCrB/wSJ1mn1mKfiNfps1VSRU
	kZAZ1N5po5Xu0AHfx/s8q1eTOxsIAOiSq7boMJ+MQOu2Scp90qEPM=
X-Google-Smtp-Source: AGHT+IHMoTvSCcsoBat644ksem8ZqP4Cs7kB7zIlLcWG+j/tQjQblk+rAjCWaI4lEYjd6IAfo873cw==
X-Received: by 2002:ac8:6f07:0:b0:4f3:4fe8:b5ca with SMTP id d75a77b69052e-4f4abcf6a40mr349244621cf.10.1766965828133;
        Sun, 28 Dec 2025 15:50:28 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f28e3sm2406423185a.45.2025.12.28.15.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 15:50:27 -0800 (PST)
Message-ID: <b3d015aa-01bd-4974-881a-0af297655c55@riscstar.com>
Date: Sun, 28 Dec 2025 17:50:25 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] dt-bindings: riscv: Add Ssccptr, Sscounterenw,
 Sstvala, Sstvecd, Ssu64xl
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
 <20251222-k3-basic-dt-v2-9-3af3f3cd0f8a@riscstar.com>
 <6925aa57-874c-479f-9f5b-f0fd6ede685b@riscstar.com>
 <CAH1PCMauCHQ==Fyb1pHzWtkNOCnpRoJ_8KE0zJBC4B6X8TzweA@mail.gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <CAH1PCMauCHQ==Fyb1pHzWtkNOCnpRoJ_8KE0zJBC4B6X8TzweA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/28/25 6:31 AM, Guodong Xu wrote:
> Hi, Alex
> 
> On Sat, Dec 27, 2025 at 5:28 AM Alex Elder <elder@riscstar.com> wrote:
>>
>> On 12/22/25 7:04 AM, Guodong Xu wrote:
>>> Add descriptions for five new extensions: Ssccptr, Sscounterenw, Sstvala,
>>> Sstvecd, and Ssu64xl. These extensions are ratified in RISC-V Profiles
>>> Version 1.0 (commit b1d806605f87 "Updated to ratified state.").
>>>
>>> They are introduced as new extension names for existing features and
>>> regulate implementation details for RISC-V Profile compliance. According
>>> to RISC-V Profiles Version 1.0 and RVA23 Profiles Version 1.0, their
>>> requirement status are:
>>>
>>>    - Ssccptr: Mandatory in RVA20S64, RVA22S64, RVA23S64
>>>    - Sscounterenw: Mandatory in RVA22S64, RVA23S64
>>>    - Sstvala: Mandatory in RVA20S64, RVA22S64, RVA23S64
>>>    - Sstvecd: Mandatory in RVA20S64, RVA22S64, RVA23S64
>>>    - Ssu64xl: Optional in RVA20S64, RVA22S64; Mandatory in RVA23S64
>>
>> Again, I did not verify your statements about where these are
>> optional and mandatory, but I assume they're correct.
> 
> Thanks for the review.
> 
> As mentioned in my response to patch 8, the requirement status for these
> extensions is clearly defined in the RISC-V Profiles specification(s) which
> I mentioned above.
> 
> I have verified these details against the official document to ensure
> accuracy.

Right, my comment here was just to be transparent that *I* did
not check this, and am trusting that what you said is right.
Thanks for confirming.

					-Alex

> The extension descriptions are included in the commit message to provide
> necessary background information.
> 
>>
>>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>>> ---
>>> v2: New patch.
>>> ---
>>>    .../devicetree/bindings/riscv/extensions.yaml      | 32 ++++++++++++++++++++++
>>>    1 file changed, 32 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> index a6b9d7e3edf86ecfb117ba72e295ef097bdc9831..ed7a88c0ab3b7dc7ad4a4d2fd300d6fb33ef050c 100644
>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> @@ -160,12 +160,26 @@ properties:
>>>                behavioural changes to interrupts as frozen at commit ccbddab
>>>                ("Merge pull request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
>>>
>>> +        - const: ssccptr
>>> +          description: |
>>> +            The standard Ssccptr extension for main memory (cacheability and
>>> +            coherence) hardware page-table reads, as ratified in RISC-V
>>> +            Profiles Version 1.0, with commit b1d806605f87 ("Updated to
>>> +            ratified state.")
>>> +
>>>            - const: sscofpmf
>>>              description: |
>>>                The standard Sscofpmf supervisor-level extension for count overflow
>>>                and mode-based filtering as ratified at commit 01d1df0 ("Add ability
>>>                to manually trigger workflow. (#2)") of riscv-count-overflow.
>>>
>>> +        - const: sscounterenw
>>> +          description: |
>>> +            The standard Sscounterenw extension for support writable enables
>>> +            in scounteren for any supported counter, as ratified in RISC-V
> 
> Here, I used the abbreviated version. See below.
> 
>>> +            Profiles Version 1.0, with commit b1d806605f87 ("Updated to
>>> +            ratified state.")
>>
>> Maybe you should just copy the text from the RVA23 specification
>> for all of these.  So something like:
>>
>>     For any hpmcounter that is not read-only zero, the corresponding
>>     bit in scounteren must be writable.  This was ratified in the
>>     RISC-V Profiles specification version 1.0, with commit ...
>>
> 
> As you noticed, the RVA23 Profile v1.0 provides two versions of explanation
> for Sscounterenw:
> "Sscounterenw: For any hpmcounter that is not read-only zero, the corresponding
> bit in scounteren must be writable"
> "Sscounterenw: Support writeable enables for any supported counter"
> 
> BR,
> Guodong Xu
> 
>>> +
>>>            - const: ssnpm
>>>              description: |
>>>                The standard Ssnpm extension for next-mode pointer masking as
>>> @@ -178,6 +192,24 @@ properties:
>>>                ratified at commit 3f9ed34 ("Add ability to manually trigger
>>>                workflow. (#2)") of riscv-time-compare.
>>>
>>> +        - const: sstvala
>>> +          description: |
>>> +            The standard Sstvala extension for stval provides all needed values
>>> +            as ratified in RISC-V Profiles Version 1.0, with commit b1d806605f87
>>> +            ("Updated to ratified state.")
>>
>> Or alternative to the full text in the spec, you could copy over
>> the abbreviated description listed in the glossary at the end
>> instead.  Something like:
>>
>>     stval provides all needed values.  This was ratified in...
>>
>>                                          -Alex
>>
>>> +
>>> +        - const: sstvecd
>>> +          description: |
>>> +            The standard Sstvecd extension for stvec supports Direct mode as
>>> +            ratified in RISC-V Profiles Version 1.0, with commit b1d806605f87
>>> +            ("Updated to ratified state.")
>>> +
>>> +        - const: ssu64xl
>>> +          description: |
>>> +            The standard Ssu64xl extension for UXLEN=64 must be supported, as
>>> +            ratified in RISC-V Profiles Version 1.0, with commit b1d806605f87
>>> +            ("Updated to ratified state.")
>>> +
>>>            - const: svade
>>>              description: |
>>>                The standard Svade supervisor-level extension for SW-managed PTE A/D
>>>
>>


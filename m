Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98C2E1747
	for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766965836; cv=none; b=rrpZ6atHXHzAQWLHEMt7uf5QI4r68T9LtDZX68xk080wwJMtSeW7M/aKhoscEK0FqKjjF5GGLa4iauza1FPRY4tpirV7D2bqoUGYHA00tcJN7/AeuJvbrmUJDBLv3rSVRCDsIU/VLZLWko5/0pcUBl9FqXl03wODTAbTTHTV158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766965836; c=relaxed/simple;
	bh=X77/aSGTpbbdGl/rmY+MOBIrDf1qSnwab7H3cEy+9ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxE8ETDRd37rudffcWxksITvPnIf1ldafdCveSpZOuh4fL53vE4gj2KA/nrKbVZ4a0bskZXFLb0Jh9ilDLVVWe8I0FTnwmGfockJT9ilPDpwMpTGRE2cPScTlfkw6djz+3nTcqNlEaZ+e6IlVTnXNM2pTTr5wPAJREFHds8D6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=b4zA4f/O; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="b4zA4f/O"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88888d80590so129508636d6.3
        for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 15:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766965833; x=1767570633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32IgmIv8zrlvmLhf4zlKlhWMKh5C1l6H+JNSEz9V4Ck=;
        b=b4zA4f/OueeO1wsKqtAfbesDwB7zEyec4wluzNJPmQqFc6qd+QXvN+POrTXCaTf/cy
         F8lwS4Sf/5mZJAE+7KX/JL0zKL6/5u2FJWvWlA72ch98RhKfQxcurItuAakLy4NLXoyO
         PmvmwPyq/nZr5mFhKwUVdAj8WLM7y6ALiFBxBw8QTt+B4jcUB2I2kYNUFNrKk8Zux79Z
         adAUzq1QQfb7quvIgIyUakx7VdncetQYlPbrNaWIkJRJUZfkZ9AvDxa4gSMBE9kmfvSR
         aEEuhqkxE8Xl3ptHaq0EQ+pHaHZuZx1LQ8B5BsJsZ+YvdlxFgOOkyHw2lO9YgofnJSt0
         BUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766965833; x=1767570633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32IgmIv8zrlvmLhf4zlKlhWMKh5C1l6H+JNSEz9V4Ck=;
        b=ff8inriMIp+EFE8pdPCNYdMgUribFWKYrfalqb4ZcNTtTXVq4M98+dcQxKHIDcwE+2
         xe1xXLDXRZ81uiiTSpum/gDDWN3eP1XywPHW3VaTb7CVjJTZ+pkMp0+iQMi1i1IvfjQT
         +YSRx4cOpjtG9wA2hwHjNFSL9znttL1qVZ6xy4uPKp7GXVFEoIYSmTp+lQ9nEeti0S03
         H7Q2PesGofw97ZGwfk8EkWSEoFqKX8TNFyccD/XIXaFOYl9V1Gq4xiZck4oWOp3yFiHN
         PMRrBBh0uNJJ0XvYekFuIsCyjG1vJuh9LTCG0LcGFyJ3DfkP6l3bm7LeEOUaziECjTJF
         soFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpePnf/21l9glZSDQPl4MtNhb3SYK+rdmKFSlokqoww1cGFR/UpPJHqW+6S4pq89/R31bNEE0pj3ko/6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcTox/l3e028IzlVOZuI+dTcPmErE8wW1DDXD6o08BmZESUBW
	aaCsZ4wHkyH+I2oz/0og9CU1BAu7CLdhwDDhEhweH1DC8KHBcbpT17LCpvXQ3+Nlqgk=
X-Gm-Gg: AY/fxX7uPitzqQ9torhh93PajsfeICsGy++RehbLuZQIsBxHk/zojX91EROW+dJOLsf
	5RIfldNCz7Ow1a8GP6f+pVBZPbBdx+WjY9OlxU9Tjarbph2+bZPPaX/XJaTIw4pZTtv1PVfmJGe
	dvaAROmhoRUHjaoShqGPOnO+LZuWCzZ3M1AJUBli0D8Xr55dwzexGMvF6yVPOCMaV/VCxO3PRES
	sZHfA67Txmvqc1nDa0lW7Srznur/BH0I5EkjppKTQxBPJbZzjrVb3OihqwkF6KiAGWE7iHM/NdU
	JbOvNPVKGU2B8N4jDyWLW813WdvH9oHXFNjDFuhrlFXmtGvtcY6vkirJfsyy1glBu5QABy3rI3B
	Ew1zv0rVHWRj+pwaxYAedjLkPrQTeoMurejj5gz6/DMYUB83QytFlrll3WP9AHr3c5sFqiRzzHp
	lHnMqL9Rtnj1dcxUzg7186lpGWPbErgbke68gXVFDa86HZCEBmqC8=
X-Google-Smtp-Source: AGHT+IGO0rRMB42YAPbAxySM0mJWBXB87uK13FjFxZZQF9ufEaQWAz5zIA8GyT5HoxBqf1wj2KD+tA==
X-Received: by 2002:a05:620a:172b:b0:8b6:134e:22f3 with SMTP id af79cd13be357-8c08fab7e14mr3980633785a.61.1766965833165;
        Sun, 28 Dec 2025 15:50:33 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f28e3sm2406423185a.45.2025.12.28.15.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 15:50:32 -0800 (PST)
Message-ID: <03f108a3-23ca-492f-8508-3a204861d063@riscstar.com>
Date: Sun, 28 Dec 2025 17:50:30 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] dt-bindings: riscv: Add Sha and its comprised
 extensions
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
 <20251222-k3-basic-dt-v2-10-3af3f3cd0f8a@riscstar.com>
 <0253c25d-f5fd-46f1-b4d3-ec56909d5eac@riscstar.com>
 <CAH1PCMa0NqZGQAknRZppVWUEBzKDE7tcega7bsT187+=wc-_YQ@mail.gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <CAH1PCMa0NqZGQAknRZppVWUEBzKDE7tcega7bsT187+=wc-_YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/28/25 6:43 AM, Guodong Xu wrote:
> Hi, Alex
> 
> On Sat, Dec 27, 2025 at 5:28 AM Alex Elder <elder@riscstar.com> wrote:
>>
>> On 12/22/25 7:04 AM, Guodong Xu wrote:
>>> Add descriptions for the Sha extension and the seven extensions it
>>> comprises: Shcounterenw, Shgatpa, Shtvala, Shvsatpa, Shvstvala, Shvstvecd,
>>> and Ssstateen.
>>>
>>> Sha is ratified in the RVA23 Profiles Version 1.0 (commit 0273f3c921b6
>>> "rva23/rvb23 ratified") as a new profile-defined extension that captures
>>> the full set of features that are mandated to be supported along with
>>> the H extension.
>>>
>>> Extensions Shcounterenw, Shgatpa, Shtvala, Shvsatpa, Shvstvala, Shvstvecd,
>>> and Ssstateen are ratified in the RISC-V Profiles Version 1.0 (commit
>>> b1d806605f87 "Updated to ratified state").
>>>
>>> The requirement status for Sha and its comprised extension in RISC-V
>>> Profiles are:
>>>    - Sha: Mandatory in RVA23S64
>>>    - H: Optional in RVA22S64; Mandatory in RVA23S64
>>>    - Shcounterenw: Optional in RVA22S64; Mandatory in RVA23S64
>>>    - Shgatpa: Optional in RVA22S64; Mandatory in RVA23S64
>>>    - Shtvala: Optional in RVA22S64; Mandatory in RVA23S64
>>>    - Shvsatpa: Optional in RVA22S64; Mandatory in RVA23S64
>>>    - Shvstvala: Optional in RVA22S64; Mandatory in RVA23S64
>>>    - Shvstvecd: Optional in RVA22S64; Mandatory in RVA23S64
>>>    - Ssstateen: Optional in RVA22S64; Mandatory in RVA23S64
>>>
>>> Add schema checks to enforce that Sha implies the presence of all its
>>> comprised extensions.
>>
>> Like patch 7 in your series, I *think* what you're doing
>> in trying to imply the presence of these other extensions
>> is actually requiring all those extensions to be present
>> *in addition* to just "Sha".  I don't think that's what
>> we want.
> 
> I tend to think this schema check block should be removed. Conor expressed
> similar design logic in his comments to my Patch 7/13 of v2 series.
> 
> If there is no objection, I will remove it.

Sounds good.	-Alex

> BR,
> Guodong
> 
> 
>>
>>                                          -Alex
>>
>>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>>> ---
>>> v2: New patch.
>>> ---
>>>    .../devicetree/bindings/riscv/extensions.yaml      | 79 ++++++++++++++++++++++
>>>    1 file changed, 79 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> index ed7a88c0ab3b7dc7ad4a4d2fd300d6fb33ef050c..1066b7e65dab89704dbac449db4aa5605c95b9d3 100644
>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> @@ -128,6 +128,57 @@ properties:
>>>                version of the privileged ISA specification.
>>>
>>>            # multi-letter extensions, sorted alphanumerically
>>> +        - const: sha
>>> +          description: |
>>> +            The standard Sha extension for augmented hypervisor extension as
>>> +            ratified in RVA23 Profiles Version 1.0, with commit 0273f3c921b6
>>> +            ("rva23/rvb23 ratified").
>>> +
>>> +            Sha captures the full set of features that are mandated to be
>>> +            supported along with the H extension. Sha comprises the following
>>> +            extensions: H, Shcounterenw, Shgatpa, Shtvala, Shvsatpa, Shvstvala,
>>> +            Shvstvecd, and Ssstateen.
>>> +
>>> +        - const: shcounterenw
>>> +          description: |
>>> +            The standard Shcounterenw extension for support writable enables
>>> +            in hcounteren for any supported counter, as ratified in RISC-V
>>> +            Profiles Version 1.0, with commit b1d806605f87 ("Updated to
>>> +            ratified state.")
>>> +
>>> +        - const: shgatpa
>>> +          description: |
>>> +            The standard Shgatpa extension indicates that for each supported
>>> +            virtual memory scheme SvNN supported in satp, the corresponding
>>> +            hgatp SvNNx4 mode must be supported. The hgatp mode Bare must
>>> +            also be supported. It is ratified in RISC-V Profiles Version 1.0,
>>> +            with commit b1d806605f87 ("Updated to ratified state.")
>>> +
>>> +        - const: shtvala
>>> +          description: |
>>> +            The standard Shtvala extension for htval be written with the
>>> +            faulting guest physical address in all circumstances permitted by
>>> +            the ISA. It is ratified in RISC-V Profiles Version 1.0, with
>>> +            commit b1d806605f87 ("Updated to ratified state.")
>>> +
>>> +        - const: shvsatpa
>>> +          description: |
>>> +            The standard Shvsatpa extension for vsatp supporting all translation
>>> +            modes supported in satp, as ratified in RISC-V Profiles Version 1.0,
>>> +            with commit b1d806605f87 ("Updated to ratified state.")
>>> +
>>> +        - const: shvstvala
>>> +          description: |
>>> +            The standard Shvstvala extension for vstval provides all needed
>>> +            values as ratified in RISC-V Profiles Version 1.0, with commit
>>> +            b1d806605f87 ("Updated to ratified state.")
>>> +
>>> +        - const: shvstvecd
>>> +          description: |
>>> +            The standard Shvstvecd extension for vstvec supporting Direct mode,
>>> +            as ratified in RISC-V Profiles Version 1.0, with commit b1d806605f87
>>> +            ("Updated to ratified state.")
>>> +
>>>            - const: smaia
>>>              description: |
>>>                The standard Smaia supervisor-level extension for the advanced
>>> @@ -186,6 +237,12 @@ properties:
>>>                ratified at commit d70011dde6c2 ("Update to ratified state")
>>>                of riscv-j-extension.
>>>
>>> +        - const: ssstateen
>>> +          description: |
>>> +            The standard Ssstateen extension for supervisor-mode view of the
>>> +            state-enable extension, as ratified in RISC-V Profiles Version 1.0,
>>> +            with commit b1d806605f87 ("Updated to ratified state.")
>>> +
>>>            - const: sstc
>>>              description: |
>>>                The standard Sstc supervisor-level extension for time compare as
>>> @@ -813,6 +870,28 @@ properties:
>>>                    const: zbb
>>>                - contains:
>>>                    const: zbs
>>> +      # sha comprises the following extensions
>>> +      - if:
>>> +          contains:
>>> +            const: sha
>>> +        then:
>>> +          allOf:
>>> +            - contains:
>>> +                const: h
>>> +            - contains:
>>> +                const: shcounterenw
>>> +            - contains:
>>> +                const: shgatpa
>>> +            - contains:
>>> +                const: shtvala
>>> +            - contains:
>>> +                const: shvsatpa
>>> +            - contains:
>>> +                const: shvstvala
>>> +            - contains:
>>> +                const: shvstvecd
>>> +            - contains:
>>> +                const: ssstateen
>>>          # Zcb depends on Zca
>>>          - if:
>>>              contains:
>>>
>>


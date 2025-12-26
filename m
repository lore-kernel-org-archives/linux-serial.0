Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C0270EC3
	for <linux-serial@vger.kernel.org>; Fri, 26 Dec 2025 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766784514; cv=none; b=pbTpsNZJtaCYqjwS7kz5HHCVJ8U2gJ7mg+/i8AXBtbOrl/DwCPZwS3YtdAc/5Xy5YQUKFGh2dnGfYpooV7qgq6C0i2D4Fr/1jieq6G7kNTcsxCDxbLbwq5eSE5C+eU31FJVwjsBp3oYm9Slkc+uJT1yFcvfnV/iGTTD3Yv/eSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766784514; c=relaxed/simple;
	bh=vVlakpeqjiBcmcsJZlFjb2lX+iMhz7jh7dMb3xGoowg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7YsEm+8U8EH3rhXvxuyMNdBUUuKlVOfXdgXyvv9I1UMgvllSUhJmN4CKrKN3xea1ZMcIUbT9Mn4MAWu5pvXPKuoInBD52NgPa3MGIEWU2oiUHoha5+3iRqth4RgJPhF2oVO1TagswcREyUjSOY5cqVj+pWKxCKaHaAr3YBaBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=vJ4DdzQh; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="vJ4DdzQh"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88a2b99d8c5so57528246d6.1
        for <linux-serial@vger.kernel.org>; Fri, 26 Dec 2025 13:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766784509; x=1767389309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvoJVAmM8Wok9hbNQDBnTQeicKDI82DiXYn2ZKWTwHY=;
        b=vJ4DdzQhwbVN6FEeadVm2wGPRzRGXwt07o5CNt1doLA7j1i3Ibj1CQk3uiIZqNA4Ii
         c8hM6K6uOLRgIXuTDLJASk12ree8xqPD6FQd5U+Mw3imey8R/1m2T1e9k7kbDVD1wiy7
         XGrjR3FWaUe85Xe9xrdiej/XBaoloIoGIkgJzKMpLVK1079hGBBxHaDvCtXSOOKdyjgx
         T8DlqgdzIxQqZdkE+2dqns3l6aEmF8ppvjfURPRyBTrbNmnYPitdmFN/RRuPGvBf4eEK
         sylzyO4mQE+CgPbiMLvtjTMyMjMLyMV7TjtnW1EK5BnmKsDbiuJ8QYY8/yQI9cDTY8IF
         hAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766784509; x=1767389309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvoJVAmM8Wok9hbNQDBnTQeicKDI82DiXYn2ZKWTwHY=;
        b=s/ILGBrgb2v+WNt41upbAthspEKILVb9PZS0hkMWzS+bmXkwqjOZcSuGACPDXZ6FzW
         uUeS7+cDlqVP6flCPcIhW/jSlbaB7+54hDVNoguXvCionF5QO46R5+KfXCLa/G15YTKm
         YqZznJeMAAcqsYuwt5UEANNsuFrGnVmWeNRKinPZRN4iYkuioRvA9NG4hmBNrx6zqg83
         BcT6EpNIpC91RnRM5jMIxaj0s16Gp0s4+TDHVcDLb2WtPJmi79StBO/WDs5T6/jLYiAi
         EVbV6HXXFQm8pwAS8DRpe5dciO4wcXKx6DlTsRiv+n8OMmj/twfkA3Rbp1kV77oOAKDw
         8n+g==
X-Forwarded-Encrypted: i=1; AJvYcCVWalBuLwZKl+s2SXZLauIv76XzCXJDXoFd3PfQVxDvyFuxl9DKxYGvmZo6V77eRR6HlT1sNaeaiU4HQKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCgs8wQXKjFyKsofzrQ6R7V1jtJKGm8Zdd1EQ9zTHdkPeNy9Tg
	T/kMqMvELNkJ+dqOLxjABvI9q+8uN+ZUzlECJ200n+1bW3SK7hqdUGVF0bY6qTyWH9s=
X-Gm-Gg: AY/fxX4uBI5q5earzSTfEGL3MG197VZvDtNunbMFN4Sfpj28VXyleprciHSXek2oMg5
	d5QcLHNsPoUDiKlLY+r1yOWFTQdZX5HbFVSqQpppYx6PB82UW66/5T25IcX3nNKfhz5IwDqtsoF
	L0WRTxVmhqR7guzIPGzkKU+hHgKkKByzfn4v2dnVJCEmVxFbPz50agx46K/25GeWjAREmiGM3wY
	aWmO7rZJSZYIpMXPsv8Cv5p3dp6TtUUARNkvVfGlfNNIJk4EGe5N4usYtcVhM2gzOeFAw6g0N9A
	PPlfSerAud9kg+Yu1l3VJzYhRhNj91OSOgylYdSeXgtm0Y4anvrbf2/xXRuDOqlt+0G8C0GGWXm
	febeFHztVR4vCiU3ye2WTs+Jcd7jrkxTa+772kXtz6W3eeLKcZmZoVhHadt3sgpGApm/UlYKve8
	G6wR5yXztm6Kyn06E819KWYIGufM5ReP+t/IoRLE5+0NJO0oahkFI=
X-Google-Smtp-Source: AGHT+IEizV1iRxg0/jkvz3rtCxyATJyOMlvYGHBDNYHBQHOCyh2uT+JafGkzBCvSmWX6wyzvEHDGdg==
X-Received: by 2002:a05:6214:da6:b0:880:4736:a20e with SMTP id 6a1803df08f44-88d81278ecbmr437884256d6.2.1766784508605;
        Fri, 26 Dec 2025 13:28:28 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7d5f4sm176833206d6.40.2025.12.26.13.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 13:28:28 -0800 (PST)
Message-ID: <66c0676a-7920-4825-b916-3c00b1648a08@riscstar.com>
Date: Fri, 26 Dec 2025 15:28:25 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] dt-bindings: riscv: Add B ISA extension
 description
To: Guodong Xu <guodong@riscstar.com>, Conor Dooley <conor@kernel.org>
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, linux-serial@vger.kernel.org
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com>
 <20251222-stitch-preachy-3fab87fd6f0f@spud>
 <CAH1PCMZ7ywZ3unLy0yHYK+fFHk0y=q2cEtPnRi=qSpf=fc75rw@mail.gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <CAH1PCMZ7ywZ3unLy0yHYK+fFHk0y=q2cEtPnRi=qSpf=fc75rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/23/25 12:51 AM, Guodong Xu wrote:
> Hi, Conor
> 
> On Tue, Dec 23, 2025 at 5:17 AM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Mon, Dec 22, 2025 at 09:04:17PM +0800, Guodong Xu wrote:
>>> Add description of the single-letter "B" extennsion for Bit Manipulation.
>>> B is mandatory for RVA23U64.
>>>
>>> The B extension is ratified in the 20240411 version of the unprivileged
>>> ISA specification. According to the ratified spec, "the B standard
>>> extension comprises instructions provided by the Zba, Zbb, and Zbs
>>> extensions.
>>>
>>> Hence add a schema check rule to enforce that B implies Zba, Zbb and Zbs.
>>>
>>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>>> ---
>>> v2: New patch.
>>> ---
>>>   .../devicetree/bindings/riscv/extensions.yaml         | 19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> index 565cb2cbb49b552959392810a9b731b43346a594..385e1deb23996d294e7662693f1257f910a6e129 100644
>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>> @@ -109,6 +109,13 @@ properties:
>>>               The standard C extension for compressed instructions, as ratified in
>>>               the 20191213 version of the unprivileged ISA specification.
>>>
>>> +        - const: b
>>> +          description:
>>> +            The standard B extension for bit manipulation instructions, as
>>> +            ratified in the 20240411 version of the unprivileged ISA
>>> +            specification. The B standard extension comprises instructions
>>> +            provided by the Zba, Zbb, and Zbs extensions.
>>> +
>>>           - const: v
>>>             description:
>>>               The standard V extension for vector operations, as ratified
>>> @@ -735,6 +742,18 @@ properties:
>>>           then:
>>>             contains:
>>>               const: f
>>> +      # b comprises the following extensions
>>> +      - if:
>>> +          contains:
>>> +            const: b
>>
>> What's the value in adding b, if it depends on having all 3 of the
>> components defined individually too? Currently all "superset" types of
>> extensions are permitted without their component parts also being defined,
>> this doesn't follow convention and therefore needs to be explained.
>>
>> You obviously need this construct because the kernel does not understand
>> "b", and even if you added support for interpreting "b" to the kernel
>> this is probably still needed to make sure the ABI is maintained for
>> anything importing a devicetree from the kernel.
> 
> Yes, exactly. Unlike other single-letter extensions, "b" was ratified
> (Apr/2024) much later than its components zba/zbb/zbs (Jun/2021).
> Existing software and the kernel already expect these explicit component
> strings, so enforcing this dependency ensures cores declaring "b" will
> also be correctly understood by older software that only looks for
> zba/zbb/zbs.

I might be misunderstanding you, but I don't think extension "b"
should *require* the other three extensions.  Instead, the "b"
extension should be considered *equivalent* to the other three.
That's what I understand it to mean, anyway.
   https://github.com/riscv/riscv-b

There's no point in supporting "b" in devicetree to represent
the others if it also requires the others to be present.

I think that, instead, "b", "zba", "zbb", and "zbs" should all
be allowed.

I might even go further and harden the requirement, saying that
if you specify "b" you should *not* specify "zba", "zbb", or "zbs".
But that might not be normal practice, and it's not necessary
because they aren't in conflict.

					-Alex

> I will update the commit message in v3 to clearly explain this reasoning.
> Does it sound good to you?
> 
> Thank you for the review.
> 
> BR,
> Guodong Xu
> 
>>
>>> +        then:
>>> +          allOf:
>>> +            - contains:
>>> +                const: zba
>>> +            - contains:
>>> +                const: zbb
>>> +            - contains:
>>> +                const: zbs
>>>         # Zcb depends on Zca
>>>         - if:
>>>             contains:
>>>
>>> --
>>> 2.43.0
>>>
> 


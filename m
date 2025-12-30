Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027D19D8A8
	for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115761; cv=none; b=jqWxvb5GCVFOTl32Fe8b8f78neF/RZuc546gJ6Y/1a6xhsxgYDxGQV6MxpXS3L05FTCx1ekV/y6AFgBDayEKnzX43Yh8iFHHExfBrYHSknnsU7Wl1azXUToaOGaavQujsuz1HOx1e7oFVZODY4xlkCRAFzYm+PWaRH4ZO8R0i3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115761; c=relaxed/simple;
	bh=EGYCigrLn3174km11zrPPDHkk9dOk6f61Uivu113Aec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3Xs4E1WpWelH9nIw0YVvygff+66Adozjji/WSc3v51wwLGyajGjj+nvoAsoWFFcPrLSWUILmjcHEadhyAoZfK5hVEOF5+738g+vbFtGIA62Oqqt0qnIL/u0UUdA5NhcgGqVX5GjkhNKVSe217BeLVxe+v8QZXhAFzipD1xO7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=eUgv0fBU; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="eUgv0fBU"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c15e8b2f1aso639255485a.0
        for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767115757; x=1767720557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ClCUh7zsnhsbA19JnDKkm5LuPYmbeU70s0bhWy9c0/U=;
        b=eUgv0fBU7yQdLdVjlNYtKTBBdPVaWlUyg5CwuBAKLrjkXEpfXZSrYBKecXPUcV8geL
         mTIL8Qiie3TJzdp2McTG5BCc6O6amwEQTPgiK8mdU4btylecE3menATgEqKiis+96Jeb
         FilrAqb1PdupP740UPynxOVatGrAmUNGH19zv6pk8iF1gFuy9A9XLcv8eH7qYubzjijJ
         mQnXZVCSXLGwSLhwqnqA6xwqCZAuo07Jjz8aTeAu0r1776Skmrjn/vbXzEe3HRDoM9mT
         5X1eee7asDrktmApqlZUKrOv4Ud0bR/ivYI53LaxgO5Cqh0RmtGZj0/ojZjcdpG3sZrI
         +8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767115757; x=1767720557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClCUh7zsnhsbA19JnDKkm5LuPYmbeU70s0bhWy9c0/U=;
        b=C8mE7yXFhCduhtyNf1dLzjmiuraLC/+uIiDXS7GMbm8oKwUQryo+Al0xAHQLKNq1CV
         cSbPcQvfDbcUqrQASQDnzwyAZVxjk0OGdthPXHKGlxek/uzAK+FdSieexVV6tPywsRhu
         gUjn4sqk5nSzHJdl+BDCrI4sGMOtC2n99aRcjtYRxYVcgsPRrh9JeAiR1FqzydKibMuT
         Iv2V7qLhA+naIn9L6NbbJllsz4v5aTIZ96YOtqVcLizQqm+zY49MBZmHGc0qINDc9e5l
         0nlHR7QvPvrvNgV8dHpt8NBMr3hDZo/P1PeGHA8jnMbT0kypNTu8sDFROVe4v6CqkMhn
         sjJA==
X-Forwarded-Encrypted: i=1; AJvYcCXqrBOK40mq743i/8P9Z38KPLGITmvqkfFhcywzWtrzJ0Wyx7eHVB2EZuemVe/8CBUjtvQ+jOgbMGdApFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYd5iuMxIeit3SoCVePWH/58RESQlFXudsiA7t8YmVbaTkcuCy
	uy+KyZB0eShcSLBYnpbta/E4MVIwZUkQOj3QzvqHy/6xiXaDQiEpTQ66C7A0jILQYm0=
X-Gm-Gg: AY/fxX7rYiGJXGdzuKIRWwFbxgV4y1UnElCrFpEcU0v0QxLdoZLGQ0GUbHHBXqywyxB
	gGUeJNZns0uXM9xFrlxg9j60mw8pfqAyitg2wxoRWlN2tN3LAQmyZlm/Y49uBCNG+8Iwc1Bt75g
	wXYlHq7MBkiicxgEoh/BSHM4S/G5lHDnEcbhSkbJ0qI8inJyBnnIV0ISQ2f7qK/auG7NQU8vwTa
	fPdDTHhxNfhoRKXMlpTlcGhiYSgQC+qV1yJSnCTZfwtvq72PQtmWhwHAj9l5WzfZ+B7SsUAanQD
	0lt23tBTtsnUC6eFMwEwd08dySTchXNuhpgBHkvyJCc63LziCgid/qNNFBtEAwpeG5C+rKv+wOY
	YkEBS2fNMl/70nez8w1oatQIX+vh+KRsbPvD2LDn7CrFxhAp+t+Gu4jAMkp0UB2TaryTL6zeTyJ
	VTcB22qHwrT4T5RReYldnd0/Vpnl6DUAmYau0EmU5MQwF1O6O42zjg8ISMqFj+3w==
X-Google-Smtp-Source: AGHT+IGPvUHSrmG9Ie9qzS3Ctu9VIUpR8C4eEU8Vq5QeEjI1H5P+1EGVldpe9Aku9nrcc2iPrnzPyg==
X-Received: by 2002:a05:620a:4620:b0:892:a71a:c02 with SMTP id af79cd13be357-8c08f666f7dmr5034992285a.23.1767115757254;
        Tue, 30 Dec 2025 09:29:17 -0800 (PST)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0975ee7bfsm2551055585a.51.2025.12.30.09.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 09:29:16 -0800 (PST)
Message-ID: <dc87a3c0-8627-4328-a17a-6510ee8245ac@riscstar.com>
Date: Tue, 30 Dec 2025 11:29:14 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] dt-bindings: riscv: Add B ISA extension
 description
To: Conor Dooley <conor@kernel.org>
Cc: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
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
 <20251230-imprison-sleet-6b5a1e26d34b@spud>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251230-imprison-sleet-6b5a1e26d34b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/30/25 11:09 AM, Conor Dooley wrote:
> On Fri, Dec 26, 2025 at 03:28:25PM -0600, Alex Elder wrote:
>> On 12/23/25 12:51 AM, Guodong Xu wrote:
>>> Hi, Conor
>>>
>>> On Tue, Dec 23, 2025 at 5:17 AM Conor Dooley <conor@kernel.org> wrote:
>>>>
>>>> On Mon, Dec 22, 2025 at 09:04:17PM +0800, Guodong Xu wrote:
>>>>> Add description of the single-letter "B" extennsion for Bit Manipulation.
>>>>> B is mandatory for RVA23U64.
>>>>>
>>>>> The B extension is ratified in the 20240411 version of the unprivileged
>>>>> ISA specification. According to the ratified spec, "the B standard
>>>>> extension comprises instructions provided by the Zba, Zbb, and Zbs
>>>>> extensions.
>>>>>
>>>>> Hence add a schema check rule to enforce that B implies Zba, Zbb and Zbs.
>>>>>
>>>>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>>>>> ---
>>>>> v2: New patch.
>>>>> ---
>>>>>    .../devicetree/bindings/riscv/extensions.yaml         | 19 +++++++++++++++++++
>>>>>    1 file changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>> index 565cb2cbb49b552959392810a9b731b43346a594..385e1deb23996d294e7662693f1257f910a6e129 100644
>>>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>>>>> @@ -109,6 +109,13 @@ properties:
>>>>>                The standard C extension for compressed instructions, as ratified in
>>>>>                the 20191213 version of the unprivileged ISA specification.
>>>>>
>>>>> +        - const: b
>>>>> +          description:
>>>>> +            The standard B extension for bit manipulation instructions, as
>>>>> +            ratified in the 20240411 version of the unprivileged ISA
>>>>> +            specification. The B standard extension comprises instructions
>>>>> +            provided by the Zba, Zbb, and Zbs extensions.
>>>>> +
>>>>>            - const: v
>>>>>              description:
>>>>>                The standard V extension for vector operations, as ratified
>>>>> @@ -735,6 +742,18 @@ properties:
>>>>>            then:
>>>>>              contains:
>>>>>                const: f
>>>>> +      # b comprises the following extensions
>>>>> +      - if:
>>>>> +          contains:
>>>>> +            const: b
>>>>
>>>> What's the value in adding b, if it depends on having all 3 of the
>>>> components defined individually too? Currently all "superset" types of
>>>> extensions are permitted without their component parts also being defined,
>>>> this doesn't follow convention and therefore needs to be explained.
>>>>
>>>> You obviously need this construct because the kernel does not understand
>>>> "b", and even if you added support for interpreting "b" to the kernel
>>>> this is probably still needed to make sure the ABI is maintained for
>>>> anything importing a devicetree from the kernel.
>>>
>>> Yes, exactly. Unlike other single-letter extensions, "b" was ratified
>>> (Apr/2024) much later than its components zba/zbb/zbs (Jun/2021).
>>> Existing software and the kernel already expect these explicit component
>>> strings, so enforcing this dependency ensures cores declaring "b" will
>>> also be correctly understood by older software that only looks for
>>> zba/zbb/zbs.
>>
>> I might be misunderstanding you, but I don't think extension "b"
>> should *require* the other three extensions.  Instead, the "b"
>> extension should be considered *equivalent* to the other three.
>> That's what I understand it to mean, anyway.
>>    https://github.com/riscv/riscv-b
>>
>> There's no point in supporting "b" in devicetree to represent
>> the others if it also requires the others to be present.
> 
> The dependency can be go both ways, to also make specifying "b" mandatory
> when the three components are. That probably produces the most helpful
> devicetree ultimately.

What about DT files that specified zba+zbb+zbs before "b" was
ratified?

>> I think that, instead, "b", "zba", "zbb", and "zbs" should all
>> be allowed.
> 
>> I might even go further and harden the requirement, saying that
>> if you specify "b" you should *not* specify "zba", "zbb", or "zbs".
>> But that might not be normal practice, and it's not necessary
>> because they aren't in conflict.
> 
> I disagree completely with this "even further", since that's potentially
> actively harmful to importers of kernel devicetrees.

This is related to one of the things I mentioned to Rob that I
wanted to discuss.

This type of "equivalent" extension is problematic for DT, or I
guess, it doesn't really add any value.  I'm sure the people
ratifying "b" to be equivalent to "zba+zbb+zbs" intend for it
to simplify how the supported extensions are represented.

But it actually complicates things for DT.  If you're going
to support just "b" (which would be simpler and more concise)
then there needs to be logic that treats the two possibilities
as equivalent.  But old software won't recognize new DT files
that contain only the newer (e.g. "b") extension.

So I agree, there's active harm in doing what I suggested.

But why even bother supporting "b" if you have to *also*
support "zba+zbb+zbs" if you use it?  It adds the possibility
of new errors ("b" without "zbs", for example), while not
really enabling or representing anything new.

> If "b" is to be allowed, I'm only in favour if having it requires the
> component parts.

I'd opt for ignoring the "b" extension, and any other
"simplified" extensions that simply represent a specific
set of other extensions and nothing more.  At least for DT.

That said, this "rule" would have to be followed/agreed to
by all users of DT.

					-Alex

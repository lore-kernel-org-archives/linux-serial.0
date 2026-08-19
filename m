Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981802D593E;
	Wed, 19 Aug 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130156; cv=none; b=M/v4PbzyGH/Migpwg3Ya4ahYC+xxu11lGAeZDH/hXPF7EXPGUwPZvnkK7zXvCwkVywS9Jo0+Or/Y+Ha85pmBdVMZWhWkqq73A0QgEEPVGpP/QFUoctDILPnzPRUsv39KIEAYbjyVPMpIwIRNrhrNTjfUk2XWTBXNENQsYqZkhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130156; c=relaxed/simple;
	bh=6S8NZmzdfzwVM1J9NKUSmccKownntA1PX7hz4u95hoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wsx72XpiXdtgxy10GuUeBT2sdM1M8rzaXT378M4dm8JGx59n3EIitd79L8aD5P9mm/YipRL2VFHEbGFL6obVVmZt2cgXBfdmeRIisrlq8HZg4siUma4RN8EjaueyqsCQ5bAkXQZE4VI2+IM1SSlUhl6EfK/hG4Q7itBVkKa8b44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqAXU9NL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqAXU9NL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6311F000E9;
	Wed, 19 Aug 2026 09:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130155;
	bh=+pC6P2wFC6tgfTh3xnmrpPeXHGWYvCudx8dC6Ur2wNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hqAXU9NL7FiJugNuQJcUisU5GE4tVqUHw0cwHUNECHSEMXNcTZWvMRZJrv5rDHm/g
	 lDA+8CIBQkJHRCcFAKGh6MyxmRzXZw1TMdNhUoeYeDQeBfE7xoQSLhQqulUWYQpBDy
	 NoAkuKUDBc2TgZUOuUNIIPOMH3VxkzO0hTFa8554DRGuBaBfkC5RMBz3w1OPvzmuzn
	 D8fxK8ydue3+EVbOqamQh/ctr5dXFdz/am0qA5tLFmVSZWnJ47RsxFTdvfVqgEi3+N
	 UR39d0ejRYv1ODyW96KH4+u8AohJ70kevowJxrN/bMni45deBhlnXXpe2EgtsbD+6W
	 cxK/JEHZbAySQ==
Message-ID: <c0657108-1958-4c4c-b5f5-0eb24e81b2b4@kernel.org>
Date: Wed, 19 Aug 2026 11:02:21 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: google: Add initial dts for
 frankel/blazer/mustang
To: Doug Anderson <dianders@chromium.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
 soc@lists.linux.dev, Juan Yescas <jyescas@google.com>,
 RD Babiera <rdbabiera@google.com>, Brian Norris <briannorris@google.com>,
 William McVicker <willmcvicker@google.com>, kernel-team@android.com
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>
 <20260724-dancing-skunk-of-novelty-72c1b8@quoll>
 <CAD=FV=U0HUdjPcg+5Vx8_ag0zLd3CZx5w5SFr38p+YwRnC_G6w@mail.gmail.com>
 <CAD=FV=V2+D1m5L-0d81W3E_ih2us-SrddeBUAJtMybpQons7Ww@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAD=FV=V2+D1m5L-0d81W3E_ih2us-SrddeBUAJtMybpQons7Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/08/2026 00:13, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jul 30, 2026 at 4:32 PM Doug Anderson <dianders@chromium.org> wrote:
>>
>>>> +     /*
>>>> +      * The Pixel bootloader considers it a fatal error if it doesn't find
>>>> +      * a `ufs0` alias so it can add calibration data to the node. Until
>>>
>>> Fake node is ok, but alias won't fly because aliases are not allowed for
>>> ufs. Well, would work 10 years ago, but this is a device from ~2025 (so
>>> SoC maybe a bit earlier), thus Google already knew that they MUST talk
>>> with upstream open source maintainers before they ship such ABI.
>>>
>>> They did not talk, so you reap what you sow.
>>>
>>> There is no more excuse for a vendor to ignore open source and push
>>> whatever-ABI-they-wish into their product, if they ever want to upstream
>>> that product.
>>>
>>> I know it is not your fault, obviously. And I know that not much you can
>>> do, so that is not rant towards you nor towards Doug.
>>>
>>> You will have to keep this part of patch out of tree or fix the Pixel
>>> bootloader.
>>
>> FWIW, it actually _is_ a rant towards me, since I added the "ufs0" alias. :-P
>>
>> When I was originally bringing up Pixel 10 with upstream, the
>> bootloader had a hardcoded path to the UFS node. It looked for it at
>> "/ufs@3c400000". That certainly wasn't going to work. Downstream
>> _still_ hasn't transitioned to having a "soc@0" node to put all the
>> MMIO peripherals under, so the equivalent upstream path would be
>> "/soc@0/ufs@3c400000"
>>
>> Now, I certainly could have made the bootloader search both paths, but
>> that seemed bad to me because:
>>
>> 1. As I understand it, DT paths aren't ABI. While it feels unlikely
>> upstream would change "/soc@0/ufs@3c400000" to something else, I
>> believe upstream would feel free to and not consider it a "breaking"
>> change. This makes it feel unwise to hardcode the path in the
>> bootloader. In the past, upstream has renamed nodes to clean them up
>> and it wasn't considered a violation of the sanctity of the
>> device-tree ABI.
>>
>> 2. If #1 is untrue and we consider DT paths as ABI, it's still a bit
>> awkward. We have one bootloader base that supports multiple SoCs. The
>> unit address differs across SoCs, even though the IP block is nearly
>> the same (bootloader still adds the same type of calibration data to
>> the node). The code I started with had a bunch of #if statements for
>> the paths in various SoC variants, and that went away with the alias.
>> I suppose the bootloader needs to know the UFS base address anyway so
>> I could have probably constructed the node name based on other
>> #defines, but it still was a bit awkward.
>>
>> 3. I certainly could have searched the whole device tree for the UFS
>> node by "compatible" string, but the Pixel 10 (and future) UFS
>> controllers aren't upstream yet. We wouldn't be able to land the Pixel
>> 10 device tree without the UFS bindings landed yet and I think we're a
>> bit far away from getting the Pixel 10 UFS bindings landed...
>>
>> With all that, the "aliases" seemed like a pretty clean way for the
>> bootloader to find the UFS node. It also matched my understanding of
>> an appropriate use of an "alias".
>>
>> Any suggestions for how to resolve this? Do we go back to hardcoding a
>> path in the bootloader and cross our fingers that upstream never
>> cleans up anything that changes the path to the UFS node? Would it
>> really be terrible to allow a "ufs0" alias for this case?
>>
>> As a side note, I did "talk" to upstream shortly after adding the
>> "ufs0" node by sending the Pixel 10 patches upstream, but I guess we
>> were so focused on the overlay topic that nobody thought to comment on
>> the "ufs0" node? At the time, I'm fairly certain my resulting device
>> tree files passed schema validation at the time, too...
> 
> I guess no response / silence == my email was so dumb that it wasn't
> worth responding to? Even despite that, we still need to find a way to
> move forward, so popping back here...
> 
> I did some digging. As far as I can tell:
> 
> * Nothing in the DeviceTree specification 0.4 [1] mentions that
> aliases are deprecated.
> 
> * Nothing in the dt-schema repository [2] causes validation to fail
> when you use new aliases and there is no "allowlist" of old aliases
> that are allowed for historical reasons.
> 
> * There is a single reference in the kernel "Documentation/devicetree"
> about not using aliases to assign an "instance ID" [3].
> 
> Is there some other documentation saying "aliases == evil" that I
> missed? Maybe some email thread we're all supposed to have read?

A lot of rules are implied by other rules and this one, how Linus stated
in other thread, might be implied by no-Linuxisms as you want ordering
or stable naming of Linux /dev entries.

I understand your reason is actually different than above, but your code
does not suggest that.

Anyway, if you wanted to have aliases as ABI, it would have to be
documented. You cannot send post-factum DTS and say "we already use it".
Every ABI must be documented before usage.

And this is what my comment was about: "they MUST talk
with upstream open source maintainers before they ship such ABI."

And no, sending such DTS in your v1 is not documenting ABI. Does not count.

> 
> Is the only issue here the fact that the alias ends with a "0" and
> thus implicitly provides an "instance ID"?  Would it be OK if I
> changed my alias name to "ufs-primary" or "ufs-internal" or "ufs-boot"
> or just "ufs"? We're not using the alias to get an instance ID, but
> when I added the alias I followed the pattern of all the other aliases
> and put an number at the end.
> 
> I'm happy to attempt to fix our bootloader using whatever scheme
> upstream suggests. I'm trying to "talk to upstream" as requested, but
> for it to work I need upstream to talk back. :-)

Make your case - what is the purpose of it? Boot device? Then you have
"chosen" node for stuff between firmware and OS. There is even a
property called "bootsource". If this is not boot device, but some
calibration data for ONE given instance of IP, regardless whether you
boot from it or not, then I find such case as border-base and not worth
implementing, because basically one can come one month later with "I
need 1000 aliases because my bootloader is patching up every device
node". It's called overlays then...

Best regards,
Krzysztof

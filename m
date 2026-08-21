Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFD38E8BF;
	Fri, 21 Aug 2026 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295070; cv=none; b=JK0BBKKaF4hS59Tt1sAvqp37U/BdOmU6ZYE82YxCsWoxsKECInoG2UYvpqWEvrDUzGKysrv+SgzLeXzL3QCaS7ugSDxYRWmhZwSokhp7EPHcKifwVGVI1JyhfNJKV/D3KShnnRCMAOnEa5hR3PFbKEvsdvuhpQLhEu0X9eiRJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295070; c=relaxed/simple;
	bh=m3193OZFBal0WsEyZHzaF6/vy0omLw97GZP0jJP+5ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuggalqUnUrSUSHbDmHDuEfPodcr5G7UkotN2N6cqEIQFgWh8d8lwEhsnYOkz/dEfWkrpF8zG7J2fhdwrdb9ptkcJzqRo9yGBif/kjVQwxpKN6G1fQbfF+3YY9IB6fXs7R/Pd5wPMGFl1l0nnaHO8nzo9sz9NgKitoZTdpXZLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOWDkQe0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOWDkQe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C931F000E9;
	Fri, 21 Aug 2026 06:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787295068;
	bh=cNce5NTp3bzmktGv/kwxmMrsz/kWQy7fuPujgbA0jpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lOWDkQe0ThtRfw5LTSHUWMJF1Cg4m1Na/jFGjAR2smnFs3nVn1DmG1SnAGT2rD3pD
	 tQ0BnnkkOouH0tyPIMZnvx7gGSvTf+bz+iuvaeu/6pGwrIll1b3woRotSn3XpLKNX8
	 PxWiwQU7a7Vl3/+P8UChuXWn8/9RIN/e0dE0Ij+r5hqy4pIN3ksNfRn5m+7SjVG9aA
	 fmHf6wIXvfVJZJ62nDl1SwCIA21l0msOqTCH9zKVTI6IHNfKkiNJ6jaFAi+e2IBFkp
	 aaSWL8gBmnV9UD2lS0lkd69UfeCfZHxM+MFp7ORdqESWpF3Sbuy3uAnWeFeP4T64u3
	 uPrCk57oE5dEw==
Message-ID: <d6685094-b241-415e-9e56-d2fba75f3269@kernel.org>
Date: Fri, 21 Aug 2026 08:50:56 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: google: Add initial dts for
 frankel/blazer/mustang
To: Doug Anderson <dianders@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
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
 <c0657108-1958-4c4c-b5f5-0eb24e81b2b4@kernel.org>
 <CAD=FV=VY4AeAf=TMZfJYRo6C0iSqmL-P0GzxRvZHfnNsf+GnYQ@mail.gmail.com>
 <56db332f-a18e-4a9e-be9d-67d2e25c3666@kernel.org>
 <CAD=FV=WUMKGRUbAyd7XFFc-NGoJEKRwu4MaUnEQUDB9Mq6YYXA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAD=FV=WUMKGRUbAyd7XFFc-NGoJEKRwu4MaUnEQUDB9Mq6YYXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/08/2026 01:40, Doug Anderson wrote:
> Hi,
> 
> On Wed, Aug 19, 2026 at 11:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>>> I'm happy to document. Can you please point to how / where I would
>>
>> Description of:
>> Documentation/devicetree/bindings/ufs/ufs-common.yaml
> 
> Got it.
> 
> If you tell me that the patch won't be instantly NAKed I'd be happy to
> post an addition to this file saying:
> 
> If this UFS controller has a well-known ID <N>, a "ufsN" alias may be
> created in the "aliases" node. If this UFS controller is a singleton
> (no other UFS controllers in the system), a "ufs0" alias may be
> created in the "aliases" node.
> 
> 
>> And obviously, as with every binding/ABI, you also need open-source,
>> upstream user of this.
> 
> As I understand it, this isn't truly policy. I know DT folks often
> want to look at an open-source driver to ensure the hardware is
> described correctly. I also know that a badly written but
> "open-source" driver doesn't justify landing your bindings. ...but in
> this case, it doesn't feel like there is any complexity understanding
> what's going on.

It is a policy. We do not take unused bindings. Also we do not take
bindings for downstream, because then we would have to take a ton of crap.

> 
> 
>>> document this? As far as I can tell, no aliases are documented today,
>>
>> git grep disagrees with you, e.g. second paragraph of serial.yaml.
> 
> Ah, I see! I was looking for something more formal. Something like a
> list of allowed aliases or something that would automatically validate
> which aliases are permitted. You're just saying to document this in
> prose.
> 
> Thank you for clarifying. I didn't understand this based on your
> previous emails.
> 
> 
>>> I think I've presened my problem fairly concretely [1]. If you hate
>>
>> There is no description of the problem at [1], except "bootloader adds
>> the same type of calibration data".
>>
>> So I repeat my questions: to every UFS node? To every node? To one UFS
>> node (but how do you guarantee that?)?
> 
> I'm sure it's not what you want to hear, but I guess my answer would
> be "for these boards".

No, the question is how many aliases you need. Devices might have more
than one UFS storage, e.g. ExynosAuto.

And then someone might need to calibrate UFS and SPI NOR storage? And MMC?

> 
> In my opinion, this would be fine as an ABI contract between the
> device trees intended to run on Pixel 10 phones and the Pixel 10
> bootloader. While I'm still of the opinion that people should be

Unfortunately no, because you are coming with a generic property so it
has to be treated as generic one.

> allowed to include UFS aliases in general and it would be handy if
> that affected the "dev/ufsN" node created in Linux, I know that's not
> a popular opinion among DT maintainers. If upstream would allow a less
> "generic" sounding alias "google,ufs = <&xyz>" I could do that, but I
> doubt that would make you any happier.
> 
> 
>> I gave you two solutions, depending on actual upstream need of this. If
>> you have the second case - so not the boot device - then you basically
>> want to re-implement overlays which you cannot. Use overlays, which
>> gives you nice stable and build-time verifiable label/phandle.
> 
> I'm not quite clear on the "overlay" suggestion here. You're saying
> that we should require the base device tree to be compiled with "-@"?
> ...and not because we necessarily have any overlays upstream, but
> because the bootloader will generate an overlay dynamically? Compiling
> with "-@" would mean we could give a "ufs:" label to the UFS node and
> with "-@" that would be preserved. The bootloader could then use the
> "ufs:" label to find the node. When compiling with "-@", the exposed
> labels are essentially ABI. Did I get that right?

I am saying that if you cannot answer my questions earlier (and you did
not), thus this should be treated as adding calibration to multiple
random nodes, then essentially you are reimplementing overlays and this
won't be accepted. Instead you should use overlays.

"-@" will give you the labels in __symbols__ section, but it won't be
treated as ABI because it is not feasible. No one would remember which
boards have @ and which don't thus which labels are needed externally.
Only a comment in DTS code would prevent it from being changed.

Well, same for aliases honestly. There is no tool which would guard that
ABI.

Best regards,
Krzysztof

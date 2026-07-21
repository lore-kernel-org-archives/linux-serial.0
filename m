Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B93C5837
	for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2026 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625124; cv=none; b=gDtnM4OAtz3BPD3mHyC9SVbKeDXlVJnERAlR6QPUAlYmYaYDgjW7guo0hdtmKb6P66pQA7syJ5ig7c3T/o4ndh1Z3RotedHcekcwc54M63BQmCJiy6K5Sq3GhYKlseUHwu3yAeodPCmx6hvCcdaUmdtCPO/PQ/+Ht4wxKS2zxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625124; c=relaxed/simple;
	bh=owGjS9GEb6JZAL9yeS9UGk88aYVHU6W0zz47VKrfioU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4MTos8V4jnx4Gyym+TY/cqxzJXUIKWBwlrdSD9xaV/Fs0lVBxLaYOt6w8dOtjvo/f0It/cVcFGMBbOw7m6daExU6pgiJL/xwUpFLAQlcSXcuNLvf9roHJu4TVOAIL16VITc4X8Fw9D1GTkm1iSp/5iaC46dCeIb1Viv+1PKEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjkePxP5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjkePxP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F368C1F00A3E
	for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2026 09:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784625121;
	bh=owGjS9GEb6JZAL9yeS9UGk88aYVHU6W0zz47VKrfioU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=VjkePxP5k8UElf+ViKYNSxg1uYNg/Hdcd3ujIW2TjUCeznOdBUmHq1ERkv7nrgmri
	 HED7uyzteTCOhycKb9d05HnAARvg6H+PLABiIpeqqtRDjzHS5LhO8c4bHS74dRegC8
	 iDrk0IRA55UjEGSVEuY7JXWTNllt7uIp0gfGdb7gDodSxQ201UiAxMkDocQrW51BYc
	 3EdMGPW2RNW13qqCOMv+fsIszctTBh9ruv3AOhDhKUT+NUwWtDaTT1V1piFoBjAgKy
	 d/uScRUCDJDeZiQXLRaFiUIYPGtPTu7NIOuDgRENeoHRvTRjubAU18u8RdlheGas/m
	 CyWUcX99eBeBQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c8dbf4ef0so100084471fa.2
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2026 02:12:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp5DTYu1toPe3Ylidgknm8+w1C0llgg9PkYkDJW+HI1kWwXIIJIFc4D9x6UEDX1SG5MHlTgquz2TNBrxXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIXWD4c5/AWeYXR4S/8Tj0TLUaJZnJyz000Cu6EX7BdPLd6mNG
	QTleYKj+cJlGoFOEDHduqsRkeG9fmmkzZFSM4IALsFWHvhZU636NpbjzbaRCiJrLePZQJOYx7ys
	tAAmaVnliKKKOFIXuWvD487nnmH3UUAv0D2SxIqSI8A==
X-Received: by 2002:a2e:be27:0:b0:39e:a64f:d7a9 with SMTP id
 38308e7fff4ca-39eb274e864mr35869361fa.2.1784625119589; Tue, 21 Jul 2026
 02:11:59 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 02:11:57 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 02:11:57 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <0337442c-0278-48e7-9a69-9f11d7325f1f@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-2-c429095143ec@axiado.com>
 <20260717-prudent-indefinable-labradoodle-fcaa9e@quoll> <0337442c-0278-48e7-9a69-9f11d7325f1f@axiado.com>
Date: Tue, 21 Jul 2026 02:11:57 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdfUXBAm54RyCQXiPMxCp9pLR5mPfM5hnC6_X6O9UhyTg@mail.gmail.com>
X-Gm-Features: AUfX_mwH0TpNMo9EZd0P-t0js313q4iPqh8W5BqP6DPj-e4tX6QwH3FcJB6hj2U
Message-ID: <CAMRc=MdfUXBAm54RyCQXiPMxCp9pLR5mPfM5hnC6_X6O9UhyTg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] dt-bindings: gpio: cdns: add Axiado AX3005 GPIO variant
To: Swark Yang <syang@axiado.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Jan Kotas <jank@cadence.com>, 
	Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	=?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, 
	Boris Brezillon <bbrezillon@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Mathias Nyman <mathias.nyman@intel.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jul 2026 05:35:42 +0200, Swark Yang <syang@axiado.com> said:
> On 7/17/2026 4:33 PM, Krzysztof Kozlowski wrote:
>>
>> This should stay enum which would also make your diff easier to read.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>
>> Best regards,
>> Krzysztof
>>
>
> Hi Krzysztof,
>
> Agreed on the enum, and thanks for the tags.
>
> Since Bartosz already applied this to the GPIO tree, should I send an
> incremental patch to fix the formatting, or is it fine as-is?
>

Feel free to send a separate follow-up patch.

Bart

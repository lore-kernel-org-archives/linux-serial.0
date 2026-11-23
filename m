Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435159;
	b=hMSGeVcReaB9oMm06P0xP9+rwBe/oiusQP8XTixkYcaAHE2KTAW6e4qPAZ5YayjHhIeR
	 Hnsb48cmvgkmk4TlH+x/QoaFGc6jtGGhLsDkZNqth67i0yPXi8GBVT5/g8h5ji0wWmYYG
	 +jUL4E29beHAqvDiJ78w9ppXD1bCuPvzN9dYgsYzsRJFIGPoYy7QvDWFs1rrsh9W/DDNV
	 MVjKhia986rE+v3eoQRRMJVgYddzEh9caqQi8GtAEi86L/+cV8YF8e5OjxzWhFHc4oo5o
	 WY4CM3IpFEl2Um3+URkIpfX1bhPj4HMHzUD1PzQiy/0znvf0bFbX8u22KQFVkKW8VRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=1jrfyM8AKRsXsQr/mDzcRHfpMeGCqxxnp8QiMrGkGyA=;
	b=UbjSUFpswoeqnFPQ+9zLGUDQTKQ8GX0UF8GpbUyif8DjS1hAIgbARER+QLX1BKmQNVL0
	 ZmkwZX2o2bwMvidmAWA2uN8FMJddgpMFmSoFgm7w/fi7tqZGbYg8InoT3j30YfIONSkGa
	 SeHF/uBZJ26YSvnCKYXrm3NTXiYP/HC+ZSasGQ9rnDydOCTTreY51mPw3z/ea49c+X/Dj
	 ETBGGfOWuAQZ0KuH/iTJnH1HhVdiGhPtWJw8/D9jjwTe7f4zckXGl+zpLjjVZCdpIL98a
	 7DKU4+PsOeVrA8IFyA8uwXwkjyZPNtRytbay8u3g48YB1mAN68pT1cLXDFZ0t5MVFSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nnv4Ewzs;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A461606A32A
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 11:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A461606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nnv4Ewzs
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b88b74e54eso3711132a12.0
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 03:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435157; x=1796039957; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1jrfyM8AKRsXsQr/mDzcRHfpMeGCqxxnp8QiMrGkGyA=;
        b=Nnv4Ewzsl0zbK9WqomGclwh/k39KgQeQgXBNc/AzfBbUyum1Jwvd/YbXnXg9n29OEj
         K9Ij0DC8CzyeIq0tVeeaApk4UfsTam5BGxnvw6s/ZKMk3jvL2FWONroxYavWmgOtsFl/
         pCH33OTHEcBp5Asq6l2vD3q6q2VMRCWAkBXRC3EjS07hdKBCdtwczs0pFbPIeKRuIxID
         xUNzibHvqo+wSbbF6Xz8MLTQWy4Q05WSCpzEyqo7+RmGC8MEsJ5zTaYWtaSTJqfEMPJ+
         ja4H8aB9k1bYTHo3T4iVJsVZEdnn8ZEPeUwM/HyD1ISEGSLI8D0lV/EVTsvmkC8x4VQw
         QwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435157; x=1796039957;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jrfyM8AKRsXsQr/mDzcRHfpMeGCqxxnp8QiMrGkGyA=;
        b=j255E9g2+OuImS0K8k+dl6VBjGwK1sg8xJ2yqVdDFchF3Gqh+pYsxk+CYOt3V7FoET
         GD1085vIswBP36Wt/vPjWoJCIQnkpZfLaPMHo9US8DDlYjWNblSzTki0NMrkSUYE6xrX
         X4L1syM33lUumNvzRax1lGJqDpEIx2IsS81jaKtpUFNYWnaDsAJyf0OUQnSYFQB5VddH
         ZpHhZpucEQlHl3mG/0SxcTrB1Em0OpxLl8X8+wtZYsx4TQnn2DVjAU/Rd5OPW7nEnnBi
         aN3OJivMFPAUEp9bAI7kvZG7Oj71C2B9yy+b+nrejcnq7NRCCLOo70pAGmW6Zc4Do2+Y
         PbkQ==
X-Forwarded-Encrypted: i=1; AL+hErEoYa8FFp/Md+uPVPASALS8ftpUWtCsHCkmfdd2IjxJeBLZA2HC/P+QUXCeF+FZzLtMNT0i7/RYJxfcc78=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hU/WroqASsuwEXvwqA1cJ+MEf67gA2Arlcvem0HGLpCWypRVm
	9RMASGXLZog81yI87vGDXrOSDrPftFbAQ0AnUEc0IsGnlXe0x2S7y3jM
X-Gm-Gg: AZFdTZdj6tyMqk2ZO2kOL6WqXdp2woTXvK6x6SfZ0ELKLWP1XDpuakusKeHNWL9R89o
	TSVgTQEKQygaaMvROMbM6b1FBPd0wXJe1i3HTieNDO24cV3IBtGVZCCNCxlyw2+kr4AHZ4MjKjV
	MJ4Tn4+JvJYdJObdwn7XgTvb8OrL7p6RDmttCMbsJIUhC8TZCHZu0D5C3Gst5lLl7qJCr976yrE
	sMOLhF3X01Fcgzj3C7E2MR3/HuxGP+EisIDQcoxh6QluQKDJWEAx/LJB8d0Qk2UeRsERrP221Xl
	Ynary6NPiOxIP+Q4QJx6BbMWCeT5p3Q/YrlLJR5WpQmUHKczB2A1ucKAMZu6TI+F53ErQXvR6nU
	5anzC+Ue9JgbdJM+Zztv7O69J58UqST1HeljvxT5T04Jl0ZjGWIiXJY03peipSnj9Vb4txzPrHs
	z29f4WY5tGJBUFWg25sPCV9UpkI9Oxk8xoQCvLSfv5KkZx61DtlmKGBFWJywFrwPyEWIsO0nbA9
	MfkN4p+4WwaB17w69VAkHWDVfJ6tGAOjxKhcYL86VvslDGTPtx7fryvvgHBOq0EcliHvO9nbGRP
	ccfkqdG3YerC6LuL///mhppfldNWka204oQmMMeviCsLaV/FMmopWccI
X-Received: by 2002:a17:907:9306:b0:c3e:e677:5608 with SMTP id a640c23a62f3a-c513a5da8d0mr870341966b.12.1795435157410;
        Mon, 23 Nov 2026 03:59:17 -0800 (PST)
Received: from localhost ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae68a9asm395946466b.30.2026.11.23.03.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 03:59:17 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 14:59:13 +0300
Message-Id: <DN2KN6PFHOXG.1EWK1XUHY7IKK@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Sean Wang"
 <sean.wang@mediatek.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Daniel
 Lezcano" <daniel.lezcano@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Kees Cook" <kees@kernel.org>, "Tony Luck"
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-serial@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <phone-devel@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, "Conor Dooley"
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/7] arm64: mediatek: Add initial MT6895 and Xiaomi
 Poco X4 GT support
From: "Alexander Letuchiy" <asalde.le1@gmail.com>
To: "Roman Vivchar" <rva333@protonmail.com>, "Alexander Letuchiy"
 <asalde.le1@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <ckJZtdZ4-fPzsa3vkozNyEYYUbG9qd134hYb0hHEuq2nL8WMAR1PS87OpDfXrkU-E-85rsG1I4V99_M41j6-ewkD_41XPguDel3z8z0lmMk=@protonmail.com>
In-Reply-To: <ckJZtdZ4-fPzsa3vkozNyEYYUbG9qd134hYb0hHEuq2nL8WMAR1PS87OpDfXrkU-E-85rsG1I4V99_M41j6-ewkD_41XPguDel3z8z0lmMk=@protonmail.com>

Hi Roman,

On Mon Nov 23, 2026 at 2:41 PM MSK, Roman Vivchar wrote:
> > Bootloader dependency
> > ---------------------
> > This was tested with a modified LK bootloader that is not public.
>=20
> How are other xaga users supposed to boot the kernel? You might want to
> port uniLoader instead, or if you're on an old enough security patch you
> can even replace stock LK with U-Boot. U-Boot chainloading is also
> possible.

Right now I am replacing the stock LK with a modified one that knows
how to handle mainline DTs without expecting downstream Android nodes.

In an ideal world, I would like to replace LK directly with U-Boot as
you suggested, though U-Boot chainloading or uniLoader are also valid
options. Luckily, the security patch level isn't really a concern here =E2=
=80=94
xaga is already EOL and hasn't received official firmware updates for a
while, so LK replacement works across the final stock builds. I
definitely plan to look into a proper open bootloader setup for other
users in the future.

> > Firmware behaviour
> > ------------------
> > Two things in the stock TF-A affect what the DT describes, but not the
> > DT itself:
> >=20
> >  - TF-A rejects CPU_SUSPEND for about the first 40 seconds after boot.
> >    The vendor kernel lifts this earlier with a SiP call, so with this
> >    series the idle states only start to be used after that time.
>=20
> It might be worth porting upstream TF-A too.

Agreed, upstreaming TF-A support for MT6895 is also something I plan to
look into eventually, which would let us drop the reliance on the stock
TF-A quirks altogether.

Best regards,
Alexander

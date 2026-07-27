Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AC3FE359
	for <linux-serial@vger.kernel.org>; Mon, 27 Jul 2026 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152955; cv=none; b=HCOYXQAzE5ek8CufWMiNmCup1Bfswo2XSxVxIbn+IIP8jXnCsfdCuXM7Jl6Y6t3ZORO6vog3cOGZzrI7AaL04RibVaOUJ/u+MAztwunpN8JPJPgHUtRfm0VhCXIdNmT5DPCLhw9501RP60RiYkgncgx3EVHAx5AqRozZn9ASYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152955; c=relaxed/simple;
	bh=kfmDrO+qQlD0U/EqeMAcJh53UY92+0qZwmO7dWbUNYU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=L6q/wZH1Yfjiud051n8uO4USNBk6JfYbDy6WVHn64BWMVqFj7gknF4/oHybDz+y8sl95ysFL0uFVbMf3M+DQy+HyKou2W1+ehTJxzBfLfZn6T343xzQ5NXdlI/cwXtK0nxIBnOv0bbpX5trcgdouV4yqzPN3hSPEMR1OFhGD2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=icXP0jzp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="icXP0jzp"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69fec980a30so1133049a12.3
        for <linux-serial@vger.kernel.org>; Mon, 27 Jul 2026 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785152950; x=1785757750; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U2B5+ZNIbt5wpYmMhwGwrVTQ9DhkKPd2GAMOogsvhGQ=;
        b=icXP0jzpZCVAwrnq4xRnfV633Ty+jsBPTHIqSJILzrqHgP4no3EpT/JcBwOiqd0TOl
         tNS0lUlUUEQjEKJgzD1Vz8kJRgMYAZY8kPKqozpKvyTjFpBxTMw/Eqvbfl5F4URuGl1q
         K1i4+SAzRhtLRgQgRspcvE/Zy7yZpfhF2Oyx3R7z3KQZs4ZKt9UHY0qrIsGOL6EecOij
         Kh3Uxg1Q/b+kHG3t1GGkMxUjKe48aDvHoawjO7maC1RrooEOuQdzcmfvxdwuh0RY25NX
         hhZXLgjpEpj29J5xBpldbGsH4aGRSkyMfmdOPJ/BPMht1TQz2uhLgU7WPM7p/twWe2BJ
         zaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785152950; x=1785757750;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U2B5+ZNIbt5wpYmMhwGwrVTQ9DhkKPd2GAMOogsvhGQ=;
        b=VotICv+wQbmKa8rWUricGXXIlaawMeYFnF9PxqLFoE8sYVV3+j8V5+8rZpmTWMVPTW
         2CEOkwTH13ApdHNci0NSxBqM3Vc3YZdH+Mfn0pAtueFDefgzf0icIzRbK+30R9A2dzlT
         +w5Q5bL75kDTUTdBPdBqzhn8TB/CKf4Ra1PbkCb97Hm/WfDvs9hXC7hoHXcPAE910wN3
         ERoN+OjzR8iVilUqPP3LbEX2zpyRB9FPohUs0guwpz9zEVZhy8NZVdjjxTiMFVuOFNTn
         esIZ5Awa2y7n58nmmsUYLdrpKUsqFFb+AmArcy3KkqUsbXcMgVVXHX11C7i10VuVS/AO
         OJlQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMvOWG6Ocirgc/vmgBF0pbptk0+63ey2ecRshx9+NSLJI2pCFW1OEBfR6bBx2LAlBaR3aTvM324OZkMEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIfo1Lrn66tbXngdB0E/nJ8+JTkplv433vC2HJ7nxOuFAZ5c9
	iHdDJOn134YNclInpLxpzJudpCbahirHGAbFXK4+xo0HBB3nACtz2+IWG0wwgIUbtVc=
X-Gm-Gg: AR+sD10NSxHtjxNvli8kH9UqzwImABpwfp8J/4q3lOyVOX8FCNLvRZGv1yIQWa8l60C
	a8+4DFTYMgnhAH6qxcC9X2l60axeTDJueJhWy72lgp+G1oDgSZB5EPZbnPQcaEsF57ojwBQ2EGv
	7mIaE3dh9+h6HpcyPToa6W1sTE4k1iTloTEWFroE+TFNr9NUyWUn3SJCXW0LucdIrFRbyRXnbqk
	OBNBOy13KDDqfhmFGkKhwh4W1HCJ1kC4qMnCSnh9KLMtB6fScC0w2ReodliFhSbGqYb9/kY2cwt
	WXXXzo45a7zW2oWnXLvmdsziDr5RfeXj7bfIMGhPPyS8686RZRmXbuv6hVEHx+VBQa4QITFj69E
	F1sWtZaUFStZ3cepi+dRb00qM71FFr9lLQTP1rEQ2P+LDkVJQcZ5UHLZMwGbeyovxIRYkLkag5s
	t2wD4V5gj49lugAEvY0eyeNkdNrwoZuYJ7GIl/CkpeZx/yI3kH975bSqMN
X-Received: by 2002:a05:6402:44d4:b0:698:c1d9:8134 with SMTP id 4fb4d7f45d1cf-69fc0ff874bmr2476224a12.9.1785152949730;
        Mon, 27 Jul 2026 04:49:09 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it. [87.0.90.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb5958ea0sm2526661a12.31.2026.07.27.04.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 04:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 13:49:06 +0200
Message-Id: <DK9BWMDFMNK0.K7MAJJAZVKM0@baylibre.com>
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-serial@vger.kernel.org>,
 <dlechner@baylibre.com>, <jstephan@baylibre.com>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Carlo Caione" <ccaione@baylibre.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Matthias Brugger" <matthias.bgg@gmail.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri Slaby"
 <jirislaby@kernel.org>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: alias all enabled serial
 ports
X-Mailer: aerc 0.21.0
References: <20260727-ccaione-genio-serial-aliases-v2-0-0f2ae41a8e89@baylibre.com> <20260727-ccaione-genio-serial-aliases-v2-1-0f2ae41a8e89@baylibre.com> <a3298120-f5be-4a8a-bb71-1d6923a28d6c@collabora.com>
In-Reply-To: <a3298120-f5be-4a8a-bb71-1d6923a28d6c@collabora.com>

On Mon Jul 27, 2026 at 1:30 PM CEST, AngeloGioacchino Del Regno wrote:
> On 7/27/26 09:38, Carlo Caione wrote:
>> On most MediaTek boards only serial0 is aliased, so the remaining
>> enabled uarts get first-free ttyS line numbers from the 8250 core in
>> probe order. When the console uart defers on its clocks another uart can
>> win line 0: console=3DttyS0 then ends up on the wrong port and the boot
>> looks like a hang on the serial console, depending on probe order.
>>=20
>> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts    | 1 +
>>   arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts              | 1 +
>>   arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 2 ++
>>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts              | 2 ++
>>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi            | 1 +
>>   arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts | 4 ++++
>>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts              | 1 +
>>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts               | 2 ++
>>   arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi     | 2 ++
>>   arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi  | 2 ++
>>   arch/arm64/boot/dts/mediatek/mt8390-tungsten-smarc.dtsi   | 2 ++
>>   arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi     | 1 +
>>   12 files changed, 21 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/ar=
ch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
>> index 0e086dd487d9..63659e240b1d 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
>> @@ -20,6 +20,7 @@ aliases {
>>   		mmc2 =3D &mmc2;
>>   		serial0 =3D &uart0;
>>   		serial1 =3D &uart1;
>> +		serial2 =3D &uart2;
>>   	};
>>  =20
>>   	backlight_lcd0: backlight {
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/b=
oot/dts/mediatek/mt7622-rfb1.dts
>> index 8c3e2e2578bc..7bccad118d24 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
>> @@ -20,6 +20,7 @@ / {
>>  =20
>>   	aliases {
>>   		serial0 =3D &uart0;
>> +		serial2 =3D &uart2;
>
> Why is that serial2 and not serial1 =3D &uart2?

To tie the alias number to the SoC uart index instead of to the set of
currently-enabled ports.

The problem is that uart1 exists on mt7622 but is disabled. With serial1
=3D &uart2, the day uart1 gets enabled the aliases have to be renumbered
and uart2 silently moves from ttyS1 to ttyS2 (or we have to again mix
serial and uart number).

Also in general it keeps ttyS<N> matching the schematics' UART<N>.

Ciao,

--
Carlo Caione

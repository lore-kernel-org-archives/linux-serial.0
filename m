Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48DF3F1AB7
	for <linux-serial@vger.kernel.org>; Mon, 27 Jul 2026 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145768; cv=pass; b=aTWk7V2eNWlnIR/zKZLMinT0uWGuSvtgWZ4MrspGhTs05nIznFRPm2GS+mzNIbUV7vrMnFXDtRsGJiN7+UWa2RTReDBniD2vNWgU5HY2lvKgIT+H3NzSSsG21pRKHPntjbcSn0czgAJ3CmG+hiDMS0/yRc4y8fuha60sVk0PiyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145768; c=relaxed/simple;
	bh=GKFsuGoZcqShw3OE8shIa53+GGNk+cX4y4tCIcfTGe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQUjM+HeGurK1mf102wvFvLp6qsU448VdMsOs6QeFOv5BDaP1VE63KtubUWa+bsUubAx76WXqOOXVH8aiQAOcCSxQzAibk5ViZ7Qxzcf7thotTaJw4G3xU5XlildBAyFAxhml3z90+Fr8CgMHz7KOeqXQreOsZOSx13H6tFVgPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JLiTrrBg; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JLiTrrBg"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81f3b227a4aso29671697b3.1
        for <linux-serial@vger.kernel.org>; Mon, 27 Jul 2026 02:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785145762; cv=none;
        d=google.com; s=arc-20260327;
        b=ht/eEcJTWGq0lDO49m7K30T6yHba9sCB56jn5+RosAiBYDp4DqT8eVyHBXtXAU1JIp
         esAMeG5vUBCwxo9ufdBGqQPrKXYCEBWPzswB9l75YbWdqd1ifz6lUIh6q+0ttDFFtscm
         SHRUwIP654cUpecjB/PyVtmABrVl92he6kM7o5bBo63poAPPENJxURzDL2t9ncCXUcIw
         yQowCa/+b3XFGXImab0SuN6WP4KZRKlY7fbpGRRU+PAYC9Aw/qAgR9JUiGL9TyetTj/T
         3j73ugs9IjYmcIR/maXoPj0JPywj0v1q6/rCstzPC03gIz0pODfwDKJV0/rcD8sD6Tf7
         ftAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A9e/RTvQgyA1BXOguUTfpzmBu5ZmU5vPNlQN+p2nyUQ=;
        fh=KrTj/R3Xr/+LTxxdxCOz8GAS1GPQj3upUHcQFyUtMms=;
        b=dC4jqPBxs9ZfJawxZ3BgGkKQFh/xAMd0xM8Qn9o19IITlUeYORNegPOZFLfUka3OzJ
         xYZzLuslGIfPVtbclt8zJ9yR0gs4l3O+td3EMzEycl3mJpbY7muEAU0mypbAkOIVU6Hc
         V9PbARbS+cQFWlf6nRs/uJg1tg61SEc7+wWZDHedInNkUxcdQNfHtVGn0pozE54tuddr
         YFEqry1vKtw2VQS7vopn2/XppC5iC1LCYcy6hWFjtzIPCoMXmXd9k87kPFW5lh0J7OgF
         elRVpJ2fS3/0V6eE8wr4AdTwwN/ziezEeHfotiCt0BqIWXkbDkc6MirvYL6MFbutk11x
         XvtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785145762; x=1785750562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A9e/RTvQgyA1BXOguUTfpzmBu5ZmU5vPNlQN+p2nyUQ=;
        b=JLiTrrBgY0a5SOuZcoqbuTHq774K7T+Td1+WCDdCjcShSAi8IVh84vceTxWgafhaHi
         ub5gOj2kvVu2psLs0xiOanYS7vU+rH9Zei7i3yzKOIIWYhD5gR5btpqPIB/iS0pekEON
         Biskfu/32RFjOLYnztqaAZFl5gxQaI2Kw6Tpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785145762; x=1785750562;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A9e/RTvQgyA1BXOguUTfpzmBu5ZmU5vPNlQN+p2nyUQ=;
        b=RqBbKd2dWfobI/5y8fGbQOEyC/zIVxFACnp2vz4fBcaMAvE+eYlbrew/nqGlwu5Tnc
         zZMLg4yjcrsiN9veroYd/e5MpVORO1jjJTEm5MYANl3VMs1MnweDv28wXTgbPJhzmCT7
         bufn/K5FtvgyvoZ4pTpBiIeZaOJnQxUthpg1YF+l1pcx27ykwKwD/Pn4nLm0PwIP8CZX
         oRFiP9MEq3u/d803a0R5jjBpP/ll4OnFApVHe6ktU/P6CRDh1SMf/2VAyqCtUUC+FrE8
         eBjbJpaKvjk1cAoqGT/YHMEvsaghW39kCOkoIdqxn1yMrjJ1asXZHPwDNUGtdoHFfhvi
         PT7w==
X-Forwarded-Encrypted: i=1; AHgh+Rq6wdGa9Yu7Rk/GYF+kPbo049OH3XAecMf8BfURO7q7vDn01l7E9oOZFF8/V8zg76bSUd0SKmevg2+KZac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8U4BrKT+Wy7dG3U1216nCk7QMEyKDtq4IB1VZR9d4ve5HQ4L
	z1rKFFdubSTcVMWv3H5Y/odBmpWlsk9VB6rkn7FdlvV6Q5ayKW/0c8N9xj8xqFJC09ew1FziqfV
	sRPvlmENcEnV/aMi1q0J3FQdlCvUQxhkEWLObK6gB
X-Gm-Gg: AR+sD10IXO4x/yTeI7z7TXuhMvXEuDGYuF2umMy+ou3WcDmVKOTzQe6E5NuM4BJ9EzL
	4MkepVRPmHEJ3W61L35aYdBRFmCmioOOWISTyI0jli1kW31J0dlbipsp//uKQ87bo2QvClKGdHg
	6ql6+5CmM5vr47Xh8a6H2Ta4iJ/AECr14OtBpRxp/XHQStDSLVyAc3Hoy49Z7ZdK6Rz90G3nOw4
	zBhVyIUXLVAqaN/N/2vCG7Uml3D15E/8VkRNOcCBchrrp73lB9xBdbsfKVk7u2b5W1r5JJWzsOB
	ECd7vykQxdXefqs=
X-Received: by 2002:a05:690c:3744:b0:80c:85c6:8982 with SMTP id
 00721157ae682-81f69e5c41fmr26771557b3.65.1785145762611; Mon, 27 Jul 2026
 02:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-ccaione-genio-serial-aliases-v2-0-0f2ae41a8e89@baylibre.com>
 <20260727-ccaione-genio-serial-aliases-v2-1-0f2ae41a8e89@baylibre.com>
In-Reply-To: <20260727-ccaione-genio-serial-aliases-v2-1-0f2ae41a8e89@baylibre.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 27 Jul 2026 17:49:10 +0800
X-Gm-Features: AUfX_mymWG_ASKh7iZ4RJYyJ6_dUoLJGXydzUsgaPikOadmqrflcGR-sfKa6ifw
Message-ID: <CAGXv+5EM5P-cY2VW9MXc_iSjwq=QY1-OaV-s6W8wD8YTUvFN0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: alias all enabled serial ports
To: Carlo Caione <ccaione@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-serial@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:40=E2=80=AFPM Carlo Caione <ccaione@baylibre.com>=
 wrote:
>
> On most MediaTek boards only serial0 is aliased, so the remaining
> enabled uarts get first-free ttyS line numbers from the 8250 core in
> probe order. When the console uart defers on its clocks another uart can
> win line 0: console=3DttyS0 then ends up on the wrong port and the boot
> looks like a hang on the serial console, depending on probe order.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts    | 1 +
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts              | 1 +
>  arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 2 ++
>  arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts              | 2 ++

>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi            | 1 +
>  arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts | 4 ++++

These are the only two MediaTek-based Chromebook designs that use
Bluetooth over UART and have a second UART enabled.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # kukui & asurada-hayato

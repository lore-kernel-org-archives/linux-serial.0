Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFFC1F3B96
	for <linux-serial@vger.kernel.org>; Fri, 14 Mar 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946908; cv=none; b=ZZ2mquIhFPtQy8Y4SlWfOaIszajuxSCBCEqOqWk+aJTNLZbtuQ8NGsSn+QwNa9yqAtsWj7ZLc5iAVHoXoqgwGQPHXrCLm0omSI18PNhgXYsaiYxLdjgf1BNh2UN2PNfSrNRgrh1hR+dA6Ea6UvgyyOXH27qaL8BqPWGDG/bCW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946908; c=relaxed/simple;
	bh=Gt/9/LzPfx6RB2Ri4REYVqp1qcpJjg1U1nS59zQ5wMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0bjHm+RyjzOTCwsVvuicRlxR0dQBquvU/DIzx+cBWeO0FhGdNTA6obT9wchEpiDzpCCDcVy4UVKoNdvt4klGmzWCov9Zhe2+c5vcIRyr+2CmtgFxxDUkyQR8iCByKeU9QWQUBakqoX139X828g5kU4AgW174W1byLcYsuYHFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+Nj03o9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+Nj03o9"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30b83290b7bso19470831fa.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Mar 2025 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946905; x=1742551705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt/9/LzPfx6RB2Ri4REYVqp1qcpJjg1U1nS59zQ5wMY=;
        b=u+Nj03o9/G6Q5npypn/X5zXy0HE3LmSGtyjbWd8mdYRJwrtUgqLSPkec4dEGk/ACXL
         ooVyGaQLstHEUyYoMlCEPiIbwqiJkc7qzgG3rjA8vZ/YnO7kXSmmoJLtP6r7G0dcX3OO
         v74t5vheXTEpJbyLqpCBGk6j8eW7cgRBxv8xqQPL5KP83OqMDNpJf38npIpc63XVfEkQ
         z+HWsgdDwvT+plIZ55k7EoNcEEaq44AUxIYeiJ+O5/wU9MdyGNrStIe5r1okuenYV9OS
         tXZE/87lJTJ1IOoO2ra12tfpLsx3CbJWp2p9PrMwF1Grv3lF93Kgm3kzaitBHGnjzFit
         2d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946905; x=1742551705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt/9/LzPfx6RB2Ri4REYVqp1qcpJjg1U1nS59zQ5wMY=;
        b=ov7x2X5H3gT1qVNlONGnik9KbYRG0B9PuvmVxqevMqq9D+szVSH4ea6p0zm7urCJ6n
         UOTqKUGEJ1RNsoWqoZ9eS+QWBdoJpK9aSnWzAgjcNAMrZ+lkLuENMyhERDSbVt4nrusF
         cqk5I+Kgbzlrz+FmOateAHHDBHGItZYqwokhxx/bj8b0zcbYTd/nNLmUA2EZbrl5qOqn
         Y+W7D1AVssKFzNHE7V2CQT5iDLAFLddb0QSsNAZ6cZ5B72moGqrh5w+iJCx8pifsyz/8
         F3m6s0hAQrhBzUKcwS2AT1wfgrZqYSG+lgCdFOfKy8LARtJL+CsgwwjNlU7xwuQaIESv
         8R/A==
X-Forwarded-Encrypted: i=1; AJvYcCWzvHweezAK1bQqmxb0um0NdMwb3Y2AaX8ZRgfKdkZczAWh5j4DAN1bEkHuiPK0w95A6B8esmNX/MD0xmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszadXpnInWb+X9BxK+NUTvVw8N/MfY2mDwFoNhxgG8WmiYSOU
	mYwe6Km/NPDzVVhiuRUwDF5k2N5umF7r9MqaNDS3ueLA8OiaQnwK6mJkC0gV1gqVEXFJ5PJvuhN
	DVg6feh6IYwTUsItumlfT67elZWHavSDEuQVVkQ==
X-Gm-Gg: ASbGncuyTc4sWPsu/yOSYdwErvWd0hgrT7b/gfrVy+0h2qpGhJbRAxcZ6UV8giy51hQ
	+co5Ha/ew1Yyof3mfyM6rIenQnqYRNWvVaFT0XSbGJSw3tqkSyc88X5435cZTJN1RSxBUzV3Psd
	GROFCrcdpFiBCYARa4kA10QfI=
X-Google-Smtp-Source: AGHT+IHJo15rlSs7Va08NHOofodKMD1H1XNIRjRaa5BY0in+MTDIERdp60qoDZO21fZpfDmKsEUFpvdk8Y2VP5vuLUk=
X-Received: by 2002:a05:6512:b94:b0:545:c1e:65fb with SMTP id
 2adb3069b0e04-549c38fbccdmr671564e87.18.1741946904682; Fri, 14 Mar 2025
 03:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736522006.git.Ryan.Wanner@microchip.com> <821255840c09d8d9cebbb1f2daaedd8a7c138875.1736522006.git.Ryan.Wanner@microchip.com>
In-Reply-To: <821255840c09d8d9cebbb1f2daaedd8a7c138875.1736522006.git.Ryan.Wanner@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:08:13 +0100
X-Gm-Features: AQ5f1JqSOmT4FHz5UOAsw4lJg3-dP8L_NWpCJ5kNHWtjrkJLgD54yy-3c3bbVqU
Message-ID: <CACRpkdYYeC+2G0u0LYSUjAX_ex7MjWLhEcu7QdNXudj8BEO4PQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 2/3] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
	Dharma Balasubiramani <dharma.b@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 5:03=E2=80=AFPM <Ryan.Wanner@microchip.com> wrote:

> From: Dharma Balasubiramani <dharma.b@microchip.com>
>
> Add pinctrl bindings for microchip sama7d65 SoC.
>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

This patch applied to the pinctrl tree.

Yours,
Linus Walleij

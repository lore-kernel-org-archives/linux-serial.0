Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F61714B2;
	Thu, 24 Apr 2025 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505750; cv=none; b=mpPN6F/HOPMWucikVABry23I7V9aWy5GBE/6Z2ovBo4Nu2Ve2GN3Zbynth691P+mIpL/D+/LKgXQKH9otWydeHz0a6DwzMTR2zhfLOGqnvVoSUBxpS5NZJYZtV31KAZVmwSyvK5oCFI7Fye1eqt94iBmv/pKMwfFV84Cq+E1Zfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505750; c=relaxed/simple;
	bh=MbqWnfszZO2tpVYAjg9JWbWMTQTT2mkVql/ztM6vVPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvaPfgMeYUeNQlkknIXg9R1Lge/dmsJE/0qnAohmG0Ie/Xe/+CzgfL0Nmp1Gu6OVySoaQZtog8UpHe77A2J+HiPNhOekdAHGaIqdbF3rYtq3t9dPZ3zfL3ZdWRdjyuth6KWF0JlUM7ClgRSRGTy4A/+5gGnMbXralqYOD9EQa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1uCbVrU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1uCbVrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D6DC4AF09;
	Thu, 24 Apr 2025 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745505750;
	bh=MbqWnfszZO2tpVYAjg9JWbWMTQTT2mkVql/ztM6vVPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S1uCbVrUh4gmgegvzwAZPPVyp6WogO8Mt/f7cUv01bi7CqeCaeYlAtzZeDEO4C51y
	 LPjnnu7+oxVkI/mfyZU3WX8f+sQD6pGVuhn2uJjNXpS/Qh/h08dtLpUx+hdtFX6Z64
	 LM6zb8VMTXnFmIyl+LnC6kitOtKLSKHU8eTEwLDNUZUdvMRwVkBJvdT0c3EI7pxYuo
	 RRZZlLDpl6Eowie3D0tbeHXG8K0alH44FT70ce6sBbHpzVNbzdoHES7Vo614/GfkuM
	 xD4SbYD44OCpLhAWO1JWfPy9QR1Pirl+wvqLl0oQn7CP9rsK3c1RhOaR0vUPFZA4QT
	 rizAIYDie10qA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so2053531a12.1;
        Thu, 24 Apr 2025 07:42:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBUWwguZnX7yhW74L8P4jXQ5a8DpnPOb/z1FcPRb36X0wbnjtbSLk8pniKKOc+9COmhM1C1Pwa2zRA@vger.kernel.org, AJvYcCVWhm2ZEHSK32BeyeTXCbx2JHv9f7aO7e8dloZyCgwm+o+j11TXtEZaKd/m5UM8e4FwmR+tHZYI6398LCEA@vger.kernel.org, AJvYcCVn7XnNDzCIt0e5KFiWn1N7B5pDCxTql1BcSll0q6YPhDeC9fjqt/3LmuV6pXMlvVolAuBzhHo8zfcHBKTS@vger.kernel.org
X-Gm-Message-State: AOJu0YzLoCg2Xep8OS976sYLYWXdyh5DMGEyOSi1ZR6hd8P3gmwglFJ6
	uzDbz4ufLs+iNzCirzefeIaQ/fpygsLFt6wLE5//2Nr1UwdwkXwzzSibr2Vmq7FXqf1Sy/SIyOl
	MqiMUzZvb4RYfK5hyXAe52v0d2w==
X-Google-Smtp-Source: AGHT+IGGFqu0L47CHz2DJ5cIaB7S3hoAageJyJhrGdRr9cOUHUygoaN/XZusHvgN0Jkxp1vNsCp8qBoorCHtV0sHXWs=
X-Received: by 2002:a17:906:7305:b0:acb:b1be:4873 with SMTP id
 a640c23a62f3a-ace570cd13amr312500966b.2.1745505748560; Thu, 24 Apr 2025
 07:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-uart-binding-v1-1-eb0f6d97a654@amlogic.com>
In-Reply-To: <20250424-uart-binding-v1-1-eb0f6d97a654@amlogic.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 Apr 2025 09:42:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKD=yespd0WM90VBr_XWdppimzDzecmwNfGMV+hNSHuRA@mail.gmail.com>
X-Gm-Features: ATxdqUHKHPJdWFXmqoM4Bm1TD1_GnaXoZ-XsaWeX2h598TzyyhAIydJNjtK4jps
Message-ID: <CAL_JsqKD=yespd0WM90VBr_XWdppimzDzecmwNfGMV+hNSHuRA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: amlogic,meson-uart: Add compatible
 string for S6/S7/S7D
To: xianwei.zhao@amlogic.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 3:43=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> Amlogic S6/S7/7D SoCs uses the same UART controller as S4 SoCs and G12A.
> There is no need for an extra compatible line in the driver, but
> add S6/S7/S7D compatible line for documentation.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> This patch has been reviewed in the submission below(patch 4/7).
> https://lore.kernel.org/all/20250317-s6-s7-basic-v1-0-d653384e41f3@amlogi=
c.com/
>
> It is just sent again separately since it goes via the tty tree

The default assumption is a series is applied by 1 maintainer. If you
want maintainers to pick up a patch out of a series, it is best to ask
them in that patch. Or you have to resend like this.

Also, for bindings only adding new compatibles and no driver change,
it is fine for the sub-arch maintainer (Neil) to pick them all up.

Rob

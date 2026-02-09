Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE498311587
	for <linux-serial@vger.kernel.org>; Mon,  9 Feb 2026 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675394; cv=pass; b=grGKg8gEcuz9nodNbQwDrflNNlq9qDzA+912mgaryrmYGctvBVRSeRDsGjO/QY1WGIF6TTH7tRWM3jh3byKi+em1wSSEJpK3asnhOjppe9zPucrhIrT/XEoPtbml5HGkaYUa00+twVp9Biwwz36BgkXJ4sYSA7PKJ6BHCh59gpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675394; c=relaxed/simple;
	bh=rGfGaApf4Ln8F4Ava2/6rjzX04shlpUSCovpsO90S6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGAJxfa5o76472a30v5rofV29+EXVD19CKgfWwbeg051bDt/37GbtG3D9f9J87B7pmJsUFwuykItuKFmHRu5PI4O6s7Vt6Ocr9Uhze2WCcyxBhMUEncYk07B1XPsmktUa3wEmpo2pKq+kCqRrqq7J6sZT1uTknrMoKS260UKWH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LR0AHfnJ; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LR0AHfnJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aaecf9c325so9407315ad.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Feb 2026 14:16:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770675391; cv=none;
        d=google.com; s=arc-20240605;
        b=MDBDHtKn3BrHXB/ua+6DrjMZ9ZeVQMK3qiQ2/D8fW56o8mvUOh+ITtHJthnrDHRbNj
         SqoJdCoTIMvVk+Y3rfvLxrJWbjnlZmcHYT4EzXk/HuCm4ZzRPZxSbXs+NGPk9fVqgptz
         YU3WM05csIQFk9a3l+nLee4aILB7OHFMcr4PVuKRPmmswlL/q35Pc3ROT5E2iuVtKR9M
         alJ+77mNO8mvAzNjz08GdY7L8XZ7LGYk9XktpBBUAKiewgL+DSBU2B7lwPqdpXIMz+0A
         ZIctQu7wLKa8gGA4tVAZv3zb7SFRszkxZ1PTo9v6Tu3CHoBK9fqdE1AsqT3IP+vO9ScO
         PeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rGfGaApf4Ln8F4Ava2/6rjzX04shlpUSCovpsO90S6Y=;
        fh=0W7saiwo4Mo7bnrmZaPRJlfTgzfopgQHLKepb/NA2RA=;
        b=JK9nZFFz5qHQrESaZ8k4OtXSA4dW0e9k3sQMi0HshB7ovubd6K7bYniURHM3POjn/Y
         d/1W2x4NDsnVJ8SFdX7xbXhD52c3+9TDTnluYx85qjshlekvmKBozRe++yjqp1aaKMAg
         8jCln80aIBwKoTNZ+ouiOLoWlHTxeAlj/u7Gc/ADuWH+R+qbJJbY8XHno5Jmjlj4w/K0
         W3ZFsNeivNrvuWz0OZvmulcX+Q2+F8GVKluzsUXrnNCiJBgDWx90Yw5vtrdg0tEPAhmf
         s9TscWLfoYgpI70aGRjUgQL/F4PXwC1ZRRMshId9hcnkOdnc46ZJAfNIV1bXQamu//E9
         uEkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770675391; x=1771280191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGfGaApf4Ln8F4Ava2/6rjzX04shlpUSCovpsO90S6Y=;
        b=LR0AHfnJD/ZmjHnXKDNInHdR3VhaLhL5ONPJdRfMTYZFT134GKcE8cguDCIBJ5jB/U
         IwnbfE3XKBR17yehVjZdhyYkFFcM0MEyKiD5jGIpF635gO8cOjPAMyg8o1bPb8ifRO62
         bKfZ39DuaHxoCI91x07OlYkzjubMv9TbTcdVZ1T8zS1mX9c/YF7m/dk6Ye77m+OcYjzx
         vEv63CQLvWRTgilel3G2WhNT0gk2lfxJBInmJYLJH76IMZe2PbiD2Qb4xyrjmGP3Ajwi
         7d7lxM+APMSDB8hVZxNBpg5B4GOEVsuVtXcdFBrg+udnF/L/5/2/297NQfE+HWM58iCe
         jOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770675391; x=1771280191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGfGaApf4Ln8F4Ava2/6rjzX04shlpUSCovpsO90S6Y=;
        b=LQupkVzDGvVb8zEWminT7xnC6fhLRjT7EAod6huGYsjDplm5o73OxYCxDt4XTnUqnP
         +Xzq/kcHgGI3TZBTMt02c5zTztxtlm3oXPDG//sTyxquiMDcuHfwgXDhSbIreGGDmUvL
         nqychRhzl6zNq5r/veo0kUQaAnGwwmTAAzHRhJWOXdm90MnKHYs3vkHupiFF0RCfypPr
         S41fnpL5BOrMelJXfefVaT9MdSYFFZWmT9zXOsbadwdaRgceYZkGDY5mSUvuS60obo3I
         27XCeYhKF+gsffUFPN6422x0d3x3zLtAvrNF1tQkGRfnx87g/xt7oW3/o5cm8ZQZ0k8X
         UhvA==
X-Forwarded-Encrypted: i=1; AJvYcCWy3mdQTRUTfjbt5SlvIcWM/rKg3mlvWptupF/dcJBrPiDYCSm86lP7y6wP95QqTVxS6tmalUQ64LZoes8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqUIuPDuCsejSdDGGOBaOLhzCbRfA5FEu8enf5otciIJdKSCU
	SpFrXnqM2B09H8XBGlorsrVJ3HOp4g50kJnQix0308yNNnSdSf6AHfZ9yDD1cAknFWVqll2Koew
	t1Z3uPCv/hGP+6lkRklUp2JIbvoHaCG0=
X-Gm-Gg: AZuq6aLG2D8TrbdXi2MHAjBaaOILrXSkNpfVztu9Ci1RbUTlc/h4ZI+VPi/mKlxPJjv
	SUz4ysEdmPFa3hsU+3TkECqdVI9frAEAuiRg3CgZyvVrEl2rUhos2ImXxHeJSrRZteP1JQH38IR
	X3qNwPYg2LZpb+HCn/EdasrXLsgPd9BW/r1kRMIJXohibtw4QF90Mx1GZf5d0U+ziIKjnTpqptW
	RZGoCVAiSLoJlRXU/tq8eatGt7edtW3IXH4UiQd1Y3chyjcTkzdPZSANP3XGFJm2ZSIbXnnX1I4
	iSJ6Lbso/B0mL48pt/YcSHQ5esBz
X-Received: by 2002:a17:903:983:b0:2aa:d288:851e with SMTP id
 d9443c01a7336-2ab0fe2a8a0mr2557625ad.19.1770675390613; Mon, 09 Feb 2026
 14:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com> <20260205-a9-baisc-dts-v1-2-1212b46f95a7@amlogic.com>
In-Reply-To: <20260205-a9-baisc-dts-v1-2-1212b46f95a7@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 9 Feb 2026 23:16:19 +0100
X-Gm-Features: AZwV_Qh43dpkg6GHmPnCSKEhcU2fCrAkcN4Vfkjmxi9aGDpCASTd9MHa_ZnwnNs
Message-ID: <CAFBinCB6kgbzm7bWv-=LA_Y+zpB7DwjJ0dqiqxumwuUW97Ddvg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A9
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 7:04=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> Amlogic A9 SoCs uses the same UART controller as S4 SoCs.
> There is no need for an extra compatible line in the driver,
> but add A9 compatible line for documentation.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED542EB847
	for <linux-serial@vger.kernel.org>; Mon,  9 Feb 2026 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770675559; cv=pass; b=MVKvV3gE6gJfAPTWN4TUW2ksERc8LD0t05DVhgtyyc0XzZAmjMsqSLiY7elmzQVZuJliPSXCqK3TeB8UJaSXy7wUW1KHzNB0H/uv1x3hfAFYKIgd7wIWpXRVDPm7WyaBq7AhvrzkbVG26iVNRYGdVEi/K7WexXA5iNewhp+lVps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770675559; c=relaxed/simple;
	bh=3s9hN8LyRGBx1FfOtf5UfBxGuMC/eYfq9GbdDtMCxFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zw7/QHWraYcMmx2+ra9yLU285wClvM+8a3ipOWKYPMCfoZwb7oX1SsuIJgY2vG/6gcvHjqiEEo3bxmbQWV+GWDtxqwdGVtMQHwWr6BGbaBTR1lMoS0kkfAvMy1yT4u8OTtPajBbbJMa0rqcruP/O/czRdu2ZkgeRBuynZkhOrZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=A8P2dDqr; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="A8P2dDqr"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aad1dc8856so13855695ad.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Feb 2026 14:19:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770675557; cv=none;
        d=google.com; s=arc-20240605;
        b=GuEObOMIH4WMeeAazUCLZv/sumN+tYIKPRfB060FRNXDV40cLO4WT1ZQAA2Ssaf8Rl
         dq0WScGGMh8r+CgKtOywdbm0RHg3tCKuH4vh5S4Wq26XcceuFAR/FKrXvr1NqAmzpA2k
         yBnKjd3flnnfMTZaQMjPhfEYVMmbQxxpxWGn24RTh3zTSzDLirXxf+3BByI9+kIgn0u3
         cUMZL4zLuhKUAX0GYQddP+rqnQywkXDgTli2lz8kmKtx9t1eYdWF0KatLymCgkRvyPzL
         QWCuaII8Z4ksyS+giQpoHoZ8qs6tWHCSvE6pPxMDly8dVWsVxcCUIpr2PxosS+YfOm+b
         SB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VggFDnvvtT1KJN/nuKTxye7oCcrAlUOoRXA6xSFetf8=;
        fh=pUhBymwy+tx+FScNDHBz358q2wt34Z7puTnUnofLRa4=;
        b=Mty7tNOfikVD1gzpocgYAvUhcJS2QQzhyOjGwePfxL1+WyQ/iZhxt/mHjirGMylEJw
         t/zvl9G0xy8OuOwf+rGnv+FEjYye2MPaQELI9U2v//BjK7I60n/KhfjrvkJFtmfAnAg8
         r0wmUbZx0vypyOvxg+p8/8sVpx79p6q9A07yo2ms9EgHckCyvy2yHkZwVjY4tdfaUItR
         UYbsQRky2u3Y3UIC/iGycdkX5dWV/PgTr/n7Om/AZSBmo8O4dJ6zTlisJYq2inLCe9J8
         wiOtu2MLbN8Df34kb4+6Z11d01aVaj/qljZU4i9bNe6nq9n58efCuE50WFPIzw8lJONr
         Entw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770675557; x=1771280357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VggFDnvvtT1KJN/nuKTxye7oCcrAlUOoRXA6xSFetf8=;
        b=A8P2dDqrMxgWON+B+MtpPKpzHNMhcsmf2tzGPnNy9a7QJ+6hCn1srbfz/BoE/yfVW9
         9WnYxDw7uuRv4xFzESQG1aMviF4cilcaEXj06Ql3ImexcFeAm/63usmt0xz1X7XmaFa/
         d6DD9s1bVq1dG/CxZD76453XQovaQym6sJV4Wa2ZqybY15z5/sc9EDjmc7buwPz5LjIu
         +m07VUSjyDXqkKAdMHxAZwO5F62+zMX1BeMWbQgJJyl4wIS6qYLEQHOk5lybfbYIEYb+
         vuZGRsiYEBliWlq7usSmJ8IvnZdTK3UZIWxdbNKGEiDPoDXRIYtWSP9YZRlhNS8hNHPy
         Vaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770675557; x=1771280357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VggFDnvvtT1KJN/nuKTxye7oCcrAlUOoRXA6xSFetf8=;
        b=Evr/gsKI2iLC4PwCeISneaZj/Qq0S2xu31AdhxJgozRVxgognWXw6FWIcy8AUttyX8
         qHgWHCBdhOt9GescDtgWiybNQg3KapCFlmWewD4ePyD82JlremnSogpQicRIKUHMd6J5
         J3juVO8iijB5jBKbmH/RPh38ZjNpko5OpsG7qPG1cdbL/LZXQX42x3LXaV7Ymk7ZR1LE
         4lgZPjkLyrdZiPRd99vbXYEdcFtBSgES9SeFtvYoskXTQotE9MohlDUjy2/NgH/zatkK
         A6xCVM8ocPKylhFcAI6JZlz4LuJn0WDlGTRZI2EPCsfAMyjT7w7izDokz3eWXkmZ8yRv
         zZPw==
X-Forwarded-Encrypted: i=1; AJvYcCVIL/uv0oSv5Saj/w1ZuN0Gx2Vdl5hYX1+VOCXTpv5jR56CiBZ+9L552yC43Rb/VxaFDX0pw/IDCQc0/iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfI6rpQfDxI6kKoPSerTO/sqiJtWW+ecM8XiIY28OTpRH3lFkI
	mT9TRH8NugTRoOUkLoWwnEde7uILCLUEe6/iCPtEr2dFXPxzsIF8rKrsgg73TUN63ZTzZ4hukQz
	kzR45hRaezSvEQQR2tj6rd3pcUsOeSRg=
X-Gm-Gg: AZuq6aJYxhFvUfH+JZHBR83qXqMvIo9/GN/7OnSTW5+WQDjIWt5kP/SXK+G2yxmh/Cs
	+hbc46AFRzH9QSvFjsdw/FhK3YLPxFEKep7pTLTfWHgvdBn++glyw+J7RJXFHeGDQDuPTjbAmg9
	BH87olCKFgXa4/mEy3v2KdpcpoqM8rX9RcHFEFuwegO7iHCK07kkmMv+wFXgEvSCe1WB3YW+6A5
	RQIh6OYX8oRDArUs+WvzFtLS0ZEI7+oMeUfodftEc6GiKTF4y+4S7QcMhB/bnCkRo+yEcXS+pkD
	oKJb3VY+8WtNLbbTPo9dv83uHgBb
X-Received: by 2002:a17:903:2d1:b0:2a2:acc5:7a42 with SMTP id
 d9443c01a7336-2a95191c8e2mr124339365ad.48.1770675557411; Mon, 09 Feb 2026
 14:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com> <20260205-a9-baisc-dts-v1-3-1212b46f95a7@amlogic.com>
In-Reply-To: <20260205-a9-baisc-dts-v1-3-1212b46f95a7@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 9 Feb 2026 23:19:06 +0100
X-Gm-Features: AZwV_Qg9LUz_u7q2Di_xKsLO42NKK9yJOVult9PsUi5OKRe5xJqGAGGc88gzm-A
Message-ID: <CAFBinCDmOG74HMTo7AtYPUhWCJu3_e0XjE=CKuDWOdwfq21ygA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: add support for A9 based Amlogic BY401
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
[...]
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts b/ar=
ch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts
> new file mode 100644
> index 000000000000..ad35a3292d49
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2026 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "amlogic-a9.dtsi"
> +/ {
> +       model =3D "Amlogic A311DY3 BY401 Development Board";
> +       compatible =3D "amlogic,by401", "amlogic,a9";
> +       interrupt-parent =3D <&gic>;
Shouldn't this go into amlogic-a9.dtsi (I can't see why different
boards may choose a different default interrupt-parent)?

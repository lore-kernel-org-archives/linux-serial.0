Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248B2D7DF3
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949962; cv=none; b=DWo6b3QTNCLBlHeFVirbkZ6XftuXQ+xQZXc+yOiAYw2WbN+SsMXJsp+mHyHIk9vAzljTEN0g61oojFyf0J9RKRKTxQ9OKf2dlWtKL5UedCO0SAGwxCmVhfTooBhH7olhXUmf63z43xhCuLhG5TVeg6Kjl0YyVD8cZ2XuRsOiMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949962; c=relaxed/simple;
	bh=cY9/xtA0TZ6WYOEBgpITN3csZ75r+olVcAUkkJGnqO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjQq9PU5u2qApTIzD7PAe+wNAjxUDzbQt1G2sPzwh5LrA+O7UnUE6BCWiOUjGHZDAdyb/ZYQa0n8N4XtwLptqpwMD8CWFJEEh4upZaQ9UMvnjx7oudee20ZwpvYsn8r7BWq8it+U58QvBI7BlxPzyTFEYzj1vja8ujeg+8z/V7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=y238o34i; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="y238o34i"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6420c08f886so6411153d50.3
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 21:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765949959; x=1766554759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFqMWNctIpaDjfvcIDvHAL/YeS1NSnOIH4BsKBfjtTQ=;
        b=y238o34ixPrcCJnqmA7uYd/vRIXBsTzzPRlVhmDgylZ7C4LFaFVyJfCO3qq8K138bf
         mM27DD29oFDxCeFtMIgmijuruSFvonxYInJUv4Eu70u3f4mMoJCoTrhIqOYmrVwDTQG8
         /qT5lgQyJiMnDhc2vub0RHRHeAXwswwwqQra/RXQVOv3fYB17hWOLNRFx8a+tjFawIIK
         VR8+GvvcEec9KnLS4r0VxzbEIGZ80fL4Jw47Gwl3G9HVO0dNZ6au6UGPyxTjDBoWrp6q
         t/gniJavneoZQ69lviVjdUJfm3mWR8yK5we5b48Havkj7r5cXT3vv5yaEIKMBEOItwIh
         36HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949959; x=1766554759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFqMWNctIpaDjfvcIDvHAL/YeS1NSnOIH4BsKBfjtTQ=;
        b=lTZWPgSOSebeSbPDixOmD8JeQ8Jy9ZnJtjl2K82+MVFIkBwEhIrxnJtq44IledKEKb
         ZOpiYuDQMp31fYyVAlMTnKMvtFgWEi/oeWPW9BypZFrEY5QwL7xeOmW0FyKn6NOUar77
         4zxY6SvooyH+RyIWpopcZyp/mdi4SeOqv6g5DlaPhgxlDviIOhdOthTa8UaIwY11g41Q
         uxqWRnzVtlJpFgiQDIcQCdde8NZXiWLr8tLMxUeaRj2Pm1IFfTaV4Qn7BTe9BAroff3O
         8wQ03avP72bLnCRNXw7Zu+ldvIEjvM+pFPNHqFxcdnF3FgLg/TCL9OQ2f6+KJghjr8GK
         GHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTdveVGO79A6DguLI2kvdDSMNL65QyvxwaIUvGxXA0S0cQ36cfDqWJt40vv0NtaDg/K1hmXb2EUXaID8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXdEQQPlBUQp6frRwmNe6PSp8xbDbRBxA+xGaswulgMp00ksye
	aisqbB49/EiCYt7T3E3LRRFieNbXl/M5CAyy/6m/esPzZtWn5leXfC5qeXC7+HbCeTjErQI16Lk
	UJ3W42oyCERu1xzJmsaWUkBb4QH1uA/H97sYciyzmtA==
X-Gm-Gg: AY/fxX7yuu11/qlZshzHWCjyb8CK5jFOh0g8clwxZ8Mt+87cIk7is7eFQIwfDbxr/Ls
	TS7lUb23bT3w6L38VtPMNgkA+wcFKuYccwT644sqzE4fLfZu8ajt5sRNteFuRajqWrNM7jraTpX
	b4kl+N7n/86cI2kKfHSn7AAGCY1oLx7/W7pU2unNwssXuoSpNqNF+YZ1uoRWm69jY7wnaA2LBzz
	1vrUK8PUAGctKk6ZFjhu+zGIkGXpVCTKnRwMWyYnkZcSNNJM7I+jG0zgXGQ20jNkmzdOgbOe1vH
	0MhqG9kuWcZjnaUUrlyPIxIAbDzzoDL0GUI1XjsGpvwY
X-Google-Smtp-Source: AGHT+IGSLd2D2CSBzO+dXKH5DPKZo2JqHs6vGoM0Jjm0zJelF/ajgOSwoF4diEZ/hiPlfZ5/gCZA1dHDDTMrAvqUwxc=
X-Received: by 2002:a05:690e:169e:b0:644:6e20:da76 with SMTP id
 956f58d0204a3-6455566786bmr13919702d50.73.1765949959383; Tue, 16 Dec 2025
 21:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com> <b0857d3b-5b82-47c1-8415-ec9b2046e704@kernel.org>
In-Reply-To: <b0857d3b-5b82-47c1-8415-ec9b2046e704@kernel.org>
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 17 Dec 2025 13:39:08 +0800
X-Gm-Features: AQt7F2qTG9PP4QLt2CMlTWty4KDFsvhiC7T3NbO41z80jrBzYmPUXv5sSOzmWfQ
Message-ID: <CAH1PCMaD3WCNaaY3+V-72X9wA1GNF-BHpPixDSK3y_qQ+EX3dA@mail.gmail.com>
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:35=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 16/12/2025 14:32, Guodong Xu wrote:
> > SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant.
> > Add nodes of uarts, timer and interrupt-controllers.
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> >  arch/riscv/boot/dts/spacemit/k3.dtsi | 529 +++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 529 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts=
/spacemit/k3.dtsi
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..cb27b790716fdd6dc2bc89c=
28dd2588a596a5af9
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> > @@ -0,0 +1,529 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (c) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
> > + * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +     #address-cells =3D <2>;
> > +     #size-cells =3D <2>;
> > +     model =3D "SpacemiT K3";
> > +     compatible =3D "spacemit,k3";
> > +
> > +     aliases {
> > +             serial0 =3D &uart0;
> > +             serial2 =3D &uart2;
> > +             serial3 =3D &uart3;
> > +             serial4 =3D &uart4;
> > +             serial5 =3D &uart5;
> > +             serial6 =3D &uart6;
> > +             serial7 =3D &uart7;
> > +             serial8 =3D &uart8;
> > +             serial9 =3D &uart9;
> > +             serial10 =3D &uart10;
>
> These are not properties of the soc, but the board DTS.

Thank you Krzysztof, I will fix that in the next version.

Best regards,
Guodong Xu

>
> Best regards,
> Krzysztof

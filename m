Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFC200BA1
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577319; cv=none; b=GyemLNzyoO1rh4kp44CCrYPPSjCyegZ82uDB6k4/fqlblKW7CMlbUDWBT0NulEXqsDIKO5rMjeTGwiBBMtxU0KbVPucGCqJRHhQLCllwL0SPEPok1ktUhiAOmLEgH+Mpf7iQxe4dnK/DnF5Xx+gwLvsHTswgX2vQeOb8a/poKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577319; c=relaxed/simple;
	bh=uW93kY0+OZCRekYhUWm/qQ0d+bv3Ef14UmeWSYv06cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlbTMbQ6wWPb/Xsy4/++fVTV5H4qSOE7yP9G6kaKiKG9JB5oQRnOZB9tdJb5L9jExkZbmmyVhqDX1zQjg+ZYSH9MpQ5+md22EvKNldHrPl5KVTfEHvIILcQ20DjciViyEbQOhYc8srvz6ZS+gubsxu/ftCgwZDdkhnWC8TnGF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOfBmC5S; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOfBmC5S"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so526045a12.0
        for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 00:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757577317; x=1758182117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/Zni9gQlrJqNXECo6PJyQCl0lpKWQXeS/S54r6ee38=;
        b=GOfBmC5S42YcrCrrMbZ5jwxBkT5P+nlczpqfYQy1V22cSJi9KRMqEGkwIH2RJqFFpR
         jLiK8ujHiMeSN39H22OlgtZWyZIjfbu71ZsZ0tbWn/5RV1u8kTYUiEDEuvX7KWGpg52n
         LcWS1QQRuGV2gmoELKhEJR1kPHWnTm4wR7Lx1QUA3WBeJOR6gg511RP72wgD9CHlPu0j
         0Oy0q4KoSt3XVVRYK30YlpzRm9rcpwN3WLt9eJjlVxTtrtI1HuQlRr/+jfn7VbW/eK15
         EaB2r0vR+Clu+a01t/0E7zpML2n4Sgw3KyWwpnN+Z8y39gkvA8Xj+F5uKNVXwAN35ua0
         w61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577317; x=1758182117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/Zni9gQlrJqNXECo6PJyQCl0lpKWQXeS/S54r6ee38=;
        b=rJF01gfOV40mBgMAKZdwIhXYH2JeG0FRu5Jz/Cltybwli8KXqjVZUdfduoudzagMTy
         mMSy9x9RdJeJ7kR3nzadn9PzC4d5Klkvmx5TXZuWLMK2nCEkSt0XMPzhT7G4yIkjCqMQ
         2W3o3rUT7i4GG1wuuxok3ZqtBzupTby2GMR3jPQuGC6C0oXM82djWTF+xfbp0YcMInj3
         vjs5LyCeoBqr6H9WksDmxiqpfeWXm3bQfVI9JnLzLJupd/jN6OOt3qR0USvygsRi6oOJ
         lym6Kjk2epE+bAtgibWfhdjQr/9DtQHOPEFRo+PODJzT6R+ddAjKliRUNhKbXavGOBkS
         Xd7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6KorKIpXWh+eCRGM+f7+uU+SQ4ciZe7XQACA0WR5l3S75DkQiEnb0rj2fMbVYd4awJxe2MboBIXOSbVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6iDkVMgvutwG9D4BZPjzHkJXKMhamENh36NeDHTLrPLqo4wiv
	xocXwJX2co9guwRdt4JxMDMXnysiW7fGYEJgCCtyVAIVTDESpEV/KI9igSvpbIlbeWDqDFvQ84v
	H+cpYx46K9CzvD8jrWmid0eikASSmILc=
X-Gm-Gg: ASbGnctXU9YjOBR81Sfv7c7l1o/he6hfG/22t0C21JIAocFvb4Z/+zVugXcHI6PCAmU
	GygPjTtDfOKre6V7fXpHRa1jfBgRzndaxjzI/kviasUrA7XKQrdFvcSs/ecMhjQMACaCqp1ua+O
	m4y22xtw/mRfqih14fcgMUs/yUZ4BI2He4SjbDMdMMRwCjsgO3S2LFh88/QFOtAVV8Oi4B53cxQ
	sNe8Wy1dg==
X-Google-Smtp-Source: AGHT+IEQYL88af+znhDJjCoMbmK7lED2mZrcyiOVZkFqEOFz4gATF4l90/Zv3H30LLZwTPuhz78xnP1a64hjMASXg/8=
X-Received: by 2002:a05:6402:4406:b0:62c:34ed:bbed with SMTP id
 4fb4d7f45d1cf-62c34edbf2fmr7977478a12.19.1757577316373; Thu, 11 Sep 2025
 00:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757318368.git.zhoubinbin@loongson.cn> <2f93b8f20c6e93a15258888998e926814bfd0adf.1757318368.git.zhoubinbin@loongson.cn>
 <20250910-fast-seahorse-of-valor-bf6c86@kuoka>
In-Reply-To: <20250910-fast-seahorse-of-valor-bf6c86@kuoka>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 11 Sep 2025 15:55:03 +0800
X-Gm-Features: AS18NWBY0ItJVlEtg4-Jrs_bUJGB4ODfYLmQ4u0lZWjWBEGzhnR72KNCiw8ZDmQ
Message-ID: <CAMpQs4K-6Re=-gELPEg8kP_NKR5_1U=BD6fnXM3wgUF+eMtpGg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] LoongArch: dts: Add uart new compatible string
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Haowei Zheng <zhenghaowei@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof:

Thanks for your reply.

On Wed, Sep 10, 2025 at 4:27=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Sep 09, 2025 at 08:11:20PM +0800, Binbin Zhou wrote:
> > Add loongson,ls2k*-uart compatible string on uarts.
> >
> > Co-developed-by: Haowei Zheng <zhenghaowei@loongson.cn>
> > Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  arch/loongarch/boot/dts/loongson-2k0500.dtsi | 2 +-
> >  arch/loongarch/boot/dts/loongson-2k1000.dtsi | 2 +-
> >  arch/loongarch/boot/dts/loongson-2k2000.dtsi | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/loongarch/boot/dts/loongson-2k0500.dtsi b/arch/loonga=
rch/boot/dts/loongson-2k0500.dtsi
> > index 588ebc3bded4..357de4ca7555 100644
> > --- a/arch/loongarch/boot/dts/loongson-2k0500.dtsi
> > +++ b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
> > @@ -380,7 +380,7 @@ tsensor: thermal-sensor@1fe11500 {
> >               };
> >
> >               uart0: serial@1ff40800 {
> > -                     compatible =3D "ns16550a";
> > +                     compatible =3D "loongson,ls2k0500-uart", "ns16550=
a";
>
> You clearly never bothered to actually test this against own code.

Sorry, perhaps I should have included more detailed descriptions in
the binding file.

As per Chapter 15 of the Loongson-3A5000 manual[1], the Loongson UART
registers and functionality are compatible with the NS16550A. However,
generic 16550A drivers cannot support full serial port capabilities,
such as hardware flow control.

Based on your feedback in the V3 patchset[2], I attempted to use
compatible fallbacks to avoid API breakage.

These fallbacks match according to the Makefile's compilation
order[3]. Therefore, if 8250_loongson exists, it will prioritize
matching ls2k_* compatible; otherwise, it will fallback to ns16550a.

[1]: https://loongson.github.io/LoongArch-Documentation/Loongson-3A5000-use=
rmanual-EN.pdf
[2]: https://lore.kernel.org/all/51f564ea-9507-40b4-a943-23bdd330e6d6@kerne=
l.org/
[3]: https://elixir.bootlin.com/linux/v6.16/source/drivers/tty/serial/8250/=
Makefile

>
> NAK
>
> Best regards,
> Krzysztof
>

--=20
Thanks.
Binbin

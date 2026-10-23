Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792768376;
	b=145mw65scyyDX9M1Xh9ZzyW77biKhql3pXHEFFudpyqiqN/09S6bUy1rzmPbhOnJv/uT
	 4nn5A4eHr1RKAAmy9+o6TrwPFzsyHgxL6GYd12YB9NLmV4E9BpcvK4BifyyNDMh2oeVSz
	 n++TTQEaUe6Yk8hEOfasylR47A1IhWC3WoLxWop8CCxG5+uhZbM4Uj/kBbK+xAujGf0V0
	 k6L5JII6xZcswX+JzfiRlDip+zTfKJL85HIVKJd5xxNWEXQ9dRTICh1K9nhNV5rj1l7MK
	 L382xwG8mjv1BFflkG7Hz7WxZ6CyzIdq1DP5pzAc/eGhje/0jU/OFis1cHQV8OSXjnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qg7iB6bscMTGZD77CGgbdOimAao7FC1LowqN4FOrg2M=;
	b=hGBhzKArpr5cuTpvwftzMc5nttugBYZ9DSrNErjJAcK9MI2Ut424qabAExEkbWsnYohr
	 4pF515kN0cPUDFNvGM463r2mRUTKHp8Kdh+Lf2MzcS6DdcyM1s/7msy1UL9PcUMYj61dO
	 Lc95FitYCUTjdd+3qgLErHY4rLfRLg/UKdfigCHlyHQqbhcjRpEpD3X0hQZql6hQrzVdt
	 xNQAm8eFGENu3xa4L1nQmLU/TCxJiIRZ6+0qIDiPoow4D51+jpDt9K5eh6FRW01Q4r8AF
	 BA6Ct64JquO+ntOLoxgWd2rXyGVyIM4D3ecjKXD9fTZ3swaoIl69Mnwp3MR21UTi6dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EWGG0AQy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47EB606A320
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 15:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C47EB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EWGG0AQy
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4322d310e7so152629866b.0
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 08:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792768374; cv=none;
        d=google.com; s=arc-20260327;
        b=gI1ayRo3+6whlkwE8dCJCLLXpRgLo7NL86OeS6qDAjGftmV7Qb0QFqocHCtDZ0mNUW
         +t9SYvIl/Ai7VX+0z7pSNJCIsbxElOAW7HYGpTJSOhzfjr5c0TcesqGtDLLAbphMY/+O
         ZfZ1HbeA39o0YsVx+QCMU3R7lXdYrCmzU5LY1NwDby0IXQS8zgACDQ2Jw0msaNuvwBHd
         VyuE2giTmPbRKn2FLBixeeMLiqBgZut7J0gH934rwyBnKrr6PFTcviXsex29g3+hAjn6
         rgwfKSLfUw8J+NvBffJ3qzeX2tOK3teI9DvzE5WbRsQKAnswyPluECZi0gOmLe+NZhtz
         gLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qg7iB6bscMTGZD77CGgbdOimAao7FC1LowqN4FOrg2M=;
        fh=5XNrVrEo858AEbmNj6o5FWuxSPKejnKwHJqL2oxFhh0=;
        b=cWVm3QbXyK4DB5lubQiCpWTcBtOf7VjIHvcdl/YavJ4TOubmiKds4S5mBfeXgFILDq
         LcqPCjZYgk+F8/SzHMMOn6KOoHEv0icncowu/JZuURU+xym8Mnuxk1NVrxs0DwW0YYYo
         rC5VmBtT95CVWbUqmhIfYeC1qKHkiq4JhZqTo/G2j4V+fdQsY/y97hNCNxry5w6yVx9D
         ALRbqqK2dPV6R/s8TnrP4MhGM5twNNdSAIQPbnVRNkUbWqMmmA0zy7ySAySNiat7YOLQ
         wONJV2QayWwTbXJBhOwG0SeNUyKsGzRY7d8S7nk/7t52kHb3Zo5/ZMOa50VQxwU3oy+o
         UUHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792768374; x=1793373174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qg7iB6bscMTGZD77CGgbdOimAao7FC1LowqN4FOrg2M=;
        b=EWGG0AQy2mGqncgCdvHiz4YaQrECiIJLSYoSBJ5NHSMunVaPrfVvlknF0DuKclSyUu
         qCI+SC31yn2BoepSszw36L8zEOeJf3mj1C+D4RWWBxJtXYB2LTHf6W93JTSrrS2tbVzs
         /SQReJc0ZT5f5ckNvF9/2aGpl92C17PlbkNdMVJA5oXvMmF+vXB88XDBSUj9y7ltGHUP
         BTYzibNxNnm+toKAgpaXdQcTZofbUnRLAei86WuXqw/qCERy4xLDn/4N2yb15w5YuWpR
         tTItHoUSIzfZpdy67qzB/9sXgsSl6pFGsuiTQZ/aoJmzMu5gZzNPmNFlS4+8RELQzJB4
         YcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768374; x=1793373174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qg7iB6bscMTGZD77CGgbdOimAao7FC1LowqN4FOrg2M=;
        b=NCWLriqkRaQi4ba2uakHzh8C84RvXaYmf17JzT3L6pTzxsBV4kdk02dLJCOgps8wBE
         ohTDWX0hagJ0M7TfStu5DNKvEDMFBRSvNI86/5x4Kld4+o8tj2slq8q156zNEkH/7bQU
         JkWQt+9JMOmVrTN9KpeNnwdklymipSHnpK/2lW6PpI48GxOpXB40tgrzasKKmYhok1y4
         kMZnfk8h+S2V8TioPl1dumdi7QTSo+FYL+aJw+bT23nqSTdx4MxiSo0q25nyufO8CwTb
         PxDzO0C5NfQcWsLQaJPdh32QYRQCIGNib09DLrTcnbhFL3c228pHL2YsVnRKEyDJzL4E
         1A1w==
X-Forwarded-Encrypted: i=1; AKwUvBy2vT7Rc5uSKOFI4/91c7G5jAClONjdGgLX673fZlo1scM20adYgSUodv277R6MGS2X93tmgY1lsQojX9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLESH0yShkaEqsRBFDRASYzOA5g5fvAHLYw4pKrt9fWxpsWM8JQ
	BU8Nlcf8grrKvEDQzdX+KFgfGYZ4rATf/8y4a70s4xinqPhSfC4mEjIW87rJAiNwHk/BFhaz2lK
	7gMlgCtKtV3ySM/j1kaNRZut8FQKhGtY=
X-Gm-Gg: AYBFou3jV7uA0o4IC0W9Ru/gEsnWDE0BCRFktEwsHDCGZ0QBUKZTV4cO13xMMfOTKi0
	iW2xPZksvwLptYfjeBO0MlgkSa0YMayuwmJ8VHSN0suu1cTIb+R4r/I0pHPBvNYmul+7Hj0/Y8s
	sQ4bRPFpzbZ19aGAPG8u5/EiR8TwqP7/mvACc8wOeW2/sRX6BfI5pCvVZOh1q9XrvepnidnB5Mf
	cF65tmoj+/1vIMJSKfMKhsA2tNAGXo269bgSkIAwVcahw4CZgw6PYIGh3y+Jfoud40of/MSXOgw
	ZSMVSJfHksppquXFaBvT1oOyj+TtQzC5j+LshSuPXLdhn+CaMcOjBPhwsMRIwqhwLzPxYp2b+5C
	8gVVYEVciTvXYZiv3j7PLfWzovOCTdD2+DgApiWcPkcJYPGcgx9OXwX/hcfICtmIrGLm7lVHQp9
	iMUJS1OglujVf2JiVd59fCKiUD6YAZyADHJ0g5QcAOpya5mLaIXUV6hq2NqGeM9bpPAIl61JfOB
	NwamxSOqKGij60Zv9FeWGnlM07huA==
X-Received: by 2002:a17:907:3e12:b0:c29:22cf:b0f5 with SMTP id
 a640c23a62f3a-c46a922dee5mr411130066b.33.1792768373956; Fri, 23 Oct 2026
 08:12:53 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
 <20261023-submit-h616-uart-fifo-v1-v1-2-e4a3bae2eba8@gmail.com> <atseYvQUYvpMFEIM@ashevche-desk.local>
In-Reply-To: <atseYvQUYvpMFEIM@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 09:12:40 -0600
X-Gm-Features: AclHuK8N0aoS8N5_iVP1byTsJlqPWe2cGv2Z_GYIPJWKyo5TvqjUOKI8du6YHIo
Message-ID: <CADvTj4pRW9q6VyQ=nLi8q0mMF8LgccfO4eqAeqgzzgOkDno1dw@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: 8250_dw: configure the Allwinner H616 UART
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:44=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 23, 2026 at 01:33:50AM -0600, James Hilliard wrote:
> > H616 has 256-byte transmit and receive FIFOs, but its optional DesignWa=
re
> > component parameter register reads as zero. Generic 16550 probing leave=
s
> > the port using the 16-byte FIFO configuration and its trigger-level tab=
le.
> > DMA attachment also depends on a FIFO size being available during probe=
,
> > so these ports do not reach the existing 8250 DMA path.
> >
> > Use a fixed port configuration for the H616 compatible, with a 256-byte
> > transmit load and the documented receive thresholds of 1, 64, 128 and 2=
54
> > bytes. Select the quarter-full receive trigger by default.
> >
> > Skip optional-register probing for this fixed configuration. H616 has
> > debug-divisor and RS485 control registers at the offsets used to detect
> > DesignWare hardware RS485 and fractional-divisor support. Probing these
> > offsets writes unrelated registers and can select incompatible callback=
s.
> > Keep the BUSY-safe integer divisor hook and software RS485 handling.
> >
> > Use the existing SKIP_SET_RATE quirk to keep the UART clock enabled dur=
ing
> > termios changes. Its clock is a gate on the shared APB2 source, rather =
than
> > an independent baud-rate generator.
> >
> > Attach DMA from the fixed configuration before registering the port. Th=
e
> > 8250 core installs its FIFO defaults during registration, after the pro=
be's
> > FIFO-size test. Configure single-byte RX and TX bursts because the
> > peripheral request can correspond to just one character. The existing
> > startup path requests the firmware-described channels and falls back to
> > PIO when they are unavailable or the port is a kernel console.
>
> ...
>
> >       /* Internal 8250 only */
> >       UART_PORT_AIROHA                =3D 124,
> >       UART_PORT_AIROHA_HS             =3D 125,
> > +     UART_PORT_DW_APB_256    =3D 126,
>
> Why? Besides the poorly chosen name, what prevents us from modifying the
> corresponding parameters at probe time by leaving the one of the existing
> types?

The new type was primarily a way to reuse the core's FIFO configuration
table, including the RX trigger mapping. H616 uses thresholds of 1, 64,
128 and 254 bytes, whereas PORT_16550A maps the same FCR bits to 1, 4, 8
and 14 bytes. Overriding only fifosize and tx_loadsz would leave
rx_trig_bytes reporting and selecting the wrong thresholds.

The core already has get_rxtrig/set_rxtrig callbacks, though. I'll rework
this to retain PORT_16550A, supply the H616 FIFO parameters during setup,
and use those callbacks for the correct trigger mapping.

>
> ...
>
> >  struct dw8250_platform_data {
> >       u8 usr_reg;
> >       u32 cpr_value;
> > +     /* Use a fixed configuration instead of probing optional register=
s. */
> > +     unsigned int type;
> > +     unsigned int dma_maxburst;
>
> This sounds like a hack.  Why do we need type here? The address of platfo=
rm
> data is enough, no?

The type member selected the new table entry and also identified the
fixed-configuration path. The matched platform-data pointer can select
the H616 setup directly, including bypassing the incompatible optional
register probes. I'll remove the type member and use that instead.

>
> >       unsigned int quirks;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B48171B6
	for <linux-serial@vger.kernel.org>; Thu, 30 May 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058604; cv=none; b=MVTazb4BiY0xlFkH9DyHLp+N7aOwGFWSaS21NAdtPcijsNcfplttpmbGkJ57JKf6Zb1MWDLEs58E3fiQQeekC+GzoFU7sbH/Ir/U/Q2FyZPZDdNgWGepLNayZaT402FKsNXcVjQcQBmJuKmUlReYHP6pQ26ME6PELRA5C+Hw2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058604; c=relaxed/simple;
	bh=5lPEc5yVvXfy5xHN7NJ1MGi4/BA5kf2rdtCVoPXAHLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBw4rbbXbgunjLAVDTVG+Ev47Jjp2rfAR+eoHpy63UY9DKHPWEFl4I+1b26yqA9U8pVdGHNBVetxe3SmU9HKite3+GINeu3S7hl1ruikh25ZtwDh/otLDau2/KsaY6YV+TlRJZgylVQn0CW7uss6wRC/Y9MEVMUKKBkmUv0WfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zXqL1rX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zXqL1rX"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso10502a12.0
        for <linux-serial@vger.kernel.org>; Thu, 30 May 2024 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717058601; x=1717663401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIungYlLLm/88bUfHAWA9yyqvj5B21yLMgFZirqe2GE=;
        b=2zXqL1rXx1ktsblkUS2EkHp/Zuyb/LxVI0+1TfluVZLPUYa2mOasdA/IdLqvuVlaJL
         XBOlpIPBkNyEDgtfcZ/GKvZszXLKtk6Ymd6EPDfJWeoo5IXzab7Oe5s3jYluSbHfBLvG
         D3j0lkSnQGDzghEGWCiFBRY4Y97AwoHFzxJzHDwJoH1Thzsc/zZk//B095s31fdtDVQS
         jQmCxWmmmQxM5n20oyhK9trzJR5xIQUOjeW5CDJgGw9CX91PazUTtMZUpTd7BqnT3uhK
         wSjYS2QxogD8jX8ml6VdcSlrFmUHBmot2M8dBcSuQ0oQ2SwTBFFDndhZ4RDdP2P5dBJZ
         OZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058601; x=1717663401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIungYlLLm/88bUfHAWA9yyqvj5B21yLMgFZirqe2GE=;
        b=aF2+ydtpOkM/1fh0DIkFHqCnESwQgqwAU1rTLtpTEFx+lHZQwuO8Y8BsukyHMWSkoR
         6ZYSkygLEUaIHuV23cRLtmzmOP8yirD39vB1g+YKnUjVHnx2h0dgh6bgCfPcZeOeWA0r
         hzflt2mimpL0Sash9+r2MefMzIIIV4YUm7tWUBi+KXBuU92XRMFgRzhYdLDvhPPk7qF9
         la/EeObmO4jbJ0lnaRpY95oL5F9ami0j54IZB96TPgDVYHVt2GcHduLmypS2pHl+oTpI
         +oCKWrFd03JQ+KoO25KervOB8+mnmTBMQ0l+cTfJHa/QOvs8h4FRKmL+RZbr3GCw96lT
         6LFw==
X-Forwarded-Encrypted: i=1; AJvYcCXjWRmpqFGEnj5/ZiLP7usAdbxyGf1d3tw3O4JNb19V6OV2nWSF7ycAI7IVbdUR4kD1GLEd+8WREu0BewFa0QMpr0pBiSCzgexJ0z0f
X-Gm-Message-State: AOJu0Yxz+H8DIDkyDviEYPLKyISi20y5cvgBMldRgW3lh0gLzYwiZzPs
	M6E2pS0QtkBVzTdRMpT1Fkdu5TwEw3/0HbrO4Ef9WSNiC+P4irxlIr+9UkqHyIMFHeiTb5AD4VH
	XKEygvxVTxTGHSQMwm7oPExDMnobAyATUnjk=
X-Google-Smtp-Source: AGHT+IHx8Dydq+riFuMhZGjUR/rHUsDceSADAwx6lobyo5M6S2EYM9iJat5JNucibeh4gaWqYkUQDP3ROcddvlVakTs=
X-Received: by 2002:a05:6402:31b8:b0:57a:1a30:f5cf with SMTP id
 4fb4d7f45d1cf-57a1a30fcd5mr81193a12.0.1717058600679; Thu, 30 May 2024
 01:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-drop-counted-by-ports-mxser-board-v1-1-0ab217f4da6d@kernel.org>
 <d7c19866-6883-4f98-b178-a5ccf8726895@kernel.org> <2024053008-sadly-skydiver-92be@gregkh>
 <09445a96-4f86-4d34-9984-4769bd6f4bc1@embeddedor.com> <68293959-9141-4184-a436-ea67efa9aa7c@kernel.org>
 <6170ad64-ee1c-4049-97d3-33ce26b4b715@kernel.org>
In-Reply-To: <6170ad64-ee1c-4049-97d3-33ce26b4b715@kernel.org>
From: Bill Wendling <morbo@google.com>
Date: Thu, 30 May 2024 01:43:03 -0700
Message-ID: <CAGG=3QU6kREyhAoRC+68UFX4txAKK-qK-HNvgzeqphj5-1te_g@mail.gmail.com>
Subject: Re: [PATCH] tty: mxser: Remove __counted_by from mxser_board.ports[]
To: Jiri Slaby <jirislaby@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-serial@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 1:41=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 30. 05. 24, 10:33, Jiri Slaby wrote:
> > On 30. 05. 24, 10:12, Gustavo A. R. Silva wrote:
> >>
> >>
> >> On 30/05/24 09:40, Greg Kroah-Hartman wrote:
> >>> On Thu, May 30, 2024 at 08:22:03AM +0200, Jiri Slaby wrote:
> >>>>>   This will be an error in a future compiler version
> >>>>> [-Werror,-Wbounds-safety-counted-by-elt-type-unknown-size]
> >>>>>       291 |         struct mxser_port ports[] __counted_by(nports);
> >>>>>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>>     1 error generated.
> >>>>>
> >>>>> Remove this use of __counted_by to fix the warning/error. However,
> >>>>> rather than remove it altogether, leave it commented, as it may be
> >>>>> possible to support this in future compiler releases.
> >>>>
> >>>> This looks like a compiler bug/deficiency.
> >>>
> >>> I agree, why not just turn that option off in the compiler so that th=
ese
> >>> "warnings" will not show up?
> >>
> >> It's not a compiler bug.
> >
> > It is, provided the code compiles and runs.
> >
> >> The flexible array is nested four struct layers deep, see:
> >>
> >> ports[].port.buf.sentinel.data[]
> >>
> >> The error report could be more specific, though.
> >
> > Ah, ok. The assumption is sentinel.data[] shall be unused. That's why i=
t
> > all works. The size is well known, [] is zero size, right?
> >
> > Still, fix the compiler, not the code.
>
> Or fix the code (properly).
>
> Flex arrays (even empty) in the middle of structs (like
> ports[].port.buf.sentinel.data[] above is) are deprecated since gcc 14:
> https://gcc.gnu.org/pipermail/gcc-patches/2023-August/626516.html
>
> So we should get rid of all those. Sooner than later.
>
Yes! Please do this.

-bw

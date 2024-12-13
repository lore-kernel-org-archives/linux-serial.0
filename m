Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224D17D2
	for <linux-serial@vger.kernel.org>; Fri, 13 Dec 2024 00:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734051346; cv=none; b=oXlid0Oazo8MUzdPWMDUcO3ol0K6IMI0KqhNzVfzfPMUUJdFIeGh3hwWAxeWBnUbZfb4SWBhnYvxJ6zYv8xJKi8gQ/mN3o5Etf/tNlpSdf/L/x4wn7BcKVjZ5EkG4yzhbezt5me40PAa2ftSThd/KPdWjlR4arBvmNAbsIPq79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734051346; c=relaxed/simple;
	bh=D2Ri12qgS1tt6Ue4FUWRMak4bNjguZ3CDIzSeT5EJQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7/4SZpJ3EqtQlCXHabF6DI+FTBDE+AkaSAngYzHoNPTOAcZhADJ9rd2wzeWD9OZ2Vo7SVQI3u6KvH2HLTXlSja+pY1wfiMBMdA/WUxchHAvk86qnFtvxqrlNcr2pjB2zUxOVHj8y67tXAyxFP5m4Qw6Pi/NlSfKYbV2nmRe+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JmZcJv4q; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JmZcJv4q"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30227c56b11so10799801fa.3
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2024 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734051341; x=1734656141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcTT0FmNV2c5bD1oBd/LU2lmJVRRZF1Sdah2uNcst1c=;
        b=JmZcJv4qbT1vVaN6CzUnEVoxxxhouBUygNvlr1qsRIq6WZ1G6NFdYE7H7Q1a+GDSNr
         /LLsqcEXFytbcDVdnVeINtsPtmJNvZioyIw+8/7g+Cf13TrdOf5Ss19Hq569lzNtQCOH
         pJ8+HRSaehcmcYcZgX/TYgiAOTNHL7SRjpWTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734051341; x=1734656141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcTT0FmNV2c5bD1oBd/LU2lmJVRRZF1Sdah2uNcst1c=;
        b=JHDm1DexhMz+4ymkuNtHV2Uanx0oMYTGul6/dthjM6aOguPL1DoU1Zc0BOyYXSlF6W
         RfIv3JhTOiQtAyctJ/yGLfpwCLBLyQI/eLDHs8MDn+YYOSYvQ9pwVALYZlcrxbcP851Z
         vu1luQj1wQAANoObsIE2Cx8TJcFbLponPvgEaH//3hJfaUsChNMYcTdw1uCMb76/BUHm
         fXrYZRgMEJohD2AEFRPBziwCnSXF3P/5oxTJQoz+duWIW2nwEMrsGEllKRzOLDivSY9/
         J5UEd42kiVNWQKvS+bhTZrVIXDCdrbsXWTo0xOZrEhpnlQuWI7mtbCuMVLFRCYnc3pPr
         yAnA==
X-Forwarded-Encrypted: i=1; AJvYcCXNKXnDOQD/OOj8NDBuvEGd3OARTlO4cL8Dr59RaEAr5q7BNDJ1z8fdqSjvj+ABBaC4MREoRuIT1A1F0WE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5L83Dau4LT4y6xH5w8/tznXcmrc6UV2XqlILKehs16OuE+PA
	hxw4n6hSj7LLhyhbNhyQWWlC3OcYjFpQgbM6W2xgLtdOV6dD10qJr5r3q+I5W2YLqDeIYjE0fQt
	cTw==
X-Gm-Gg: ASbGncuNXoXvjxXwnBXkUzcXyFWJLfgZYkZtwjUdxLj8Ef2I2WPxTin+cuEDgVfUi2T
	l9Cii+b1kezj6/TDAt3qvHjeOQNt5rkUaM+TJ+2PDAPLsQAi2cxs26AuoMACeK6MRWf0uwxvXZt
	Z6UOgPDzd3HACPNn9l3FjacvrLHkMqNFn7Vuf/p6k6KaGGYa6gaW5dEVZ1n8zAn6f6XoVaGOYRn
	dE6y0+kc2EDfANEo+4sKLGo2O9fC/iZF4ZZZS3Jifn4T+atOHhdSVqtDsE3ZGD56I8Xd4rWaoOa
	jDGOO3gRAnqgCukcbCh6FZsd
X-Google-Smtp-Source: AGHT+IFEBZqpB3+PeZ4Rjid+Gx+jIj/EqYgEgRCwAOWvSqax0il+sM2bGmMy491O6tYpOYLQRWoPQw==
X-Received: by 2002:a2e:3c05:0:b0:302:2293:163c with SMTP id 38308e7fff4ca-302544c90a4mr1771611fa.39.1734051341101;
        Thu, 12 Dec 2024 16:55:41 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3021cbf8d0esm15109871fa.55.2024.12.12.16.55.39
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 16:55:39 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3004028c714so11058161fa.2
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2024 16:55:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+F6v14JXtUnDS9+9j3c9pIkO1c2/cd0ogpK07Jtlc0Z6eFjZr4AmiWRyb+e3mkxGa74/8G+/Ehk0eBsA=@vger.kernel.org
X-Received: by 2002:a05:651c:154a:b0:301:12:1ed6 with SMTP id
 38308e7fff4ca-3025443fd1emr2004261fa.11.1734051339191; Thu, 12 Dec 2024
 16:55:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211153955.33518-1-tjarlama@gmail.com> <20241211153955.33518-2-tjarlama@gmail.com>
In-Reply-To: <20241211153955.33518-2-tjarlama@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 12 Dec 2024 16:55:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xz2QqqTT+1Rmqq8hVEqQeF5-X=vgXKOjFe=y9FQVuDAQ@mail.gmail.com>
X-Gm-Features: AbW1kvbEOd0BlJ40yO5tbFJkxTLqckOiZmGfJuwh68hNQBkDbIpadlljHlKbfMk
Message-ID: <CAD=FV=Xz2QqqTT+1Rmqq8hVEqQeF5-X=vgXKOjFe=y9FQVuDAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kgdb: Add kgdb_mem2ebin function for converting
 memory to binary format
To: Amal Raj T <tjarlama@gmail.com>
Cc: danielt@kernel.org, jason.wessel@windriver.com, 
	stephen.s.brennan@oracle.com, amalrajt@meta.com, osandov@osandov.com, 
	linux-debuggers@vger.kernel.org, linux-serial@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 11, 2024 at 7:40=E2=80=AFAM Amal Raj T <tjarlama@gmail.com> wro=
te:
>
> From: Amal Raj T <amalrajt@meta.com>
>
> Add a new function kgdb_mem2ebin that converts memory
> to binary format, escaping special characters
> ('$', '#', and '}'). kgdb_mem2ebin function ensures
> that memory data is properly formatted and escaped
> before being sent over the wire. Additionally, this
> function reduces the amount of data exchanged between
> debugger compared to hex.
>
> Signed-off-by: Amal Raj T <amalrajt@meta.com>
> ---
>  include/linux/kgdb.h   |  1 +
>  kernel/debug/gdbstub.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 76e891ee9e37..fa3cf38a14de 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -322,6 +322,7 @@ extern struct kgdb_io *dbg_io_ops;
>
>  extern int kgdb_hex2long(char **ptr, unsigned long *long_val);
>  extern char *kgdb_mem2hex(char *mem, char *buf, int count);
> +extern char *kgdb_mem2ebin(char *mem, char *buf, int count);
>  extern int kgdb_hex2mem(char *buf, char *mem, int count);
>
>  extern int kgdb_isremovedbreak(unsigned long addr);
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index f625172d4b67..6198d2eb49c4 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -257,6 +257,37 @@ char *kgdb_mem2hex(char *mem, char *buf, int count)
>         return buf;
>  }
>
> +/*
> + * Convert memory to binary format for GDB remote protocol
> + * transmission, escaping special characters ($, #, and }).

Why exactly are those characters special? What considers them special
and so why do you need to escape them? I guess you really just care
about avoiding # and $ and you're using '}' as your escape character
so you need to escape that too?

Your function comment should describe the escaping method and ideally
provide a few examples.


> + */
> +char *kgdb_mem2ebin(char *mem, char *buf, int count)

One of the two buffers seems like it should be "const", right? That
would help document which was input and which was output. I guess
"mem" is the input?

"count" should be "size_t"

Presumably there should be two counts talking about the sizes of each
buffer, or at least some documentation should be in the function
comment talking about the fact that "buf" needs to be twice the size?


> +{
> +       char *tmp;
> +       int err;
> +
> +       tmp =3D buf + count;

Could use a comment that the buffer needs to be 2x long to handle
escaping and that you'll use the 2nd half as a temp buffer.


> +
> +       err =3D copy_from_kernel_nofault(tmp, mem, count);
> +       if (err)
> +               return NULL;
> +       while (count > 0) {

If you change `count` to `size_t` the above test won't work because
it'll be unsigned. Still probably better to use `size_t`, but just a
warning that you'll have to change the condition.


> +               unsigned char c =3D *tmp;
> +
> +               if (c =3D=3D 0x7d || c =3D=3D 0x23 || c =3D=3D 0x24) {
> +                       *buf++ =3D 0x7d;

Don't hardcode. Much better to use '}', '#', '$'


> +                       *buf++ =3D c ^ 0x20;
> +               } else {
> +                       *buf++ =3D c;
> +               }
> +               count -=3D 1;
> +               tmp +=3D 1;

count--;
tmp++;

> +       }
> +       *buf =3D 0;

Why is the resulting buffer '\0' terminated when the source buffer
isn't? Adding this termination means that the destination buffer needs
to be 1 byte bigger, right?

...or maybe the source buffer doesn't actually have any embedded '\0'
characters and you're using this for termination to the other side? It
would be good to clarify.

In other words, if the input is 2 bytes big:
'}}'

The output buffer will be 5 bytes big:
'}]}]\0'

> +
> +       return buf;

What exactly is this return value? It points right past the end of the buff=
er?

You seem to just use it as an error value (NULL means error, non-NULL
means no error). Why not return an error code then?

-Doug

Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDC233D6B
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087472; cv=none; b=Nt+PTX5X+aKXfG/gMA7nr46YWgCH3NGA5CflGp7EBOYRewb/zYlQ/g1VsFSXYqrmkuBty4fEydegcuSf6RHQtw5BLKNzjRruOA8e6o55qNSbu0n/K3NFgbSEVwxX5pTB+G0LCVRR+3KXZ6uMcsDVRQG570AnkWFagZXxG+b+ChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087472; c=relaxed/simple;
	bh=tPmkC98W7OTKqBtV49IwWiImDhxD8gmPOBXk3WDMLJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ls8sDL2PBsbaZVtOFxWpGgktX6cKsVPXJvovlq5eHHXAzEdJLZ9CJ3pXU/oss3wXpv+22+5q/w2ENOD0b3zVa2yV5i37QvyjbIVpY/XmHbzKf0QrXufT72aRZgZyZV68x00My282ux8RnETb/WqBSxrDptJ89sZsFYoj1HVFtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ge3N4LqW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ge3N4LqW"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso2818371e87.2
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 09:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731087468; x=1731692268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPmkC98W7OTKqBtV49IwWiImDhxD8gmPOBXk3WDMLJ0=;
        b=Ge3N4LqWxSWk7/mttIDYp70O5LCADqjVXGNA7L87Zk6AB5tiWwOO3nCSV4AlxTm78F
         O0xWUuwt6dxoEMDfcBO2i7VfgoNZJz2KoNwEELjeBUVnpYg1Hxq8qXfytJOBHfbG7/c5
         1FAia6RQ+51m/VNHX23ft/YyNPZSIWSVmll6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087468; x=1731692268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPmkC98W7OTKqBtV49IwWiImDhxD8gmPOBXk3WDMLJ0=;
        b=RyuxiaQk4M+av3CpvOeoPy22jibNTqwUuBrEe4drgRnNUa957QzJy5TYF6n+UXZ3WO
         c8UVjWL1S7cOwkyxPUk/SwzBaPqG2UBlYzNYMiog5Toxen+UNdDqTfRBL+iYqP1sNnPk
         0lKG3VNfjCflDIf445PuM8h+K6LBqQDZOpCO6izvi/dFQ24sxzlJv0LMyM0+xMEnzHDP
         s4JtghRl7naNoWRX47w8mD1znuGjzRmO9XAlzwRrLVHQlOIMQx7nP/fYX+8iOqi/lFq3
         NTG7ZVAMruMj44oPUwF3fgYigQuObOCuoaTSukYXp3kbvrKGi+/q7KHrh2yhIuLdbB+G
         YigA==
X-Forwarded-Encrypted: i=1; AJvYcCXE9QayL3UlVvM54nWN/56ssIw8wC5TFdM7NJ0oYDjc0cD4qFe0pO6TJATibCjeT06Q8gHFJWb2zbhi5Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBk4/8PxpLietTWL9lXKBiXTPPNV9B7XbGEkYj1fs8SA/H0qq/
	AsUaX4OoLrgm2xQ/S/eup+SlG1xe7obPkH7d8XcLoVu/SkRQmpyYzN59YYnjcIe2BAztFF2BjqX
	aVA==
X-Google-Smtp-Source: AGHT+IFJWv5Mz2DapPwlJKQk6KXintTaY4YhCxfGGwJutx6NN+hc1JBhVbwL4tOTW8aYvzXHJcxaHg==
X-Received: by 2002:a05:651c:50d:b0:2fb:3445:a4af with SMTP id 38308e7fff4ca-2ff20207980mr20485161fa.21.1731087467967;
        Fri, 08 Nov 2024 09:37:47 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff179010e0sm7348531fa.52.2024.11.08.09.37.46
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 09:37:47 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso2818292e87.2
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 09:37:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPxtCZsnMXsEozJAJhX+uxSV2k9auTFe6haLkaBcAed9o8iJs0Ixa42UzBqmnsgUGR37C+BqgDHSLlJs8=@vger.kernel.org
X-Received: by 2002:a05:6512:3a90:b0:53b:1e70:6ad0 with SMTP id
 2adb3069b0e04-53d862e2e89mr2144388e87.27.1731087466531; Fri, 08 Nov 2024
 09:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zy093jVKPs9gSVx2@telecaster> <CAD=FV=UZKZ_RL73+JLjeW2FmAfifSyXqLV3M30XzmJSPE9Trzw@mail.gmail.com>
 <Zy1lyACVnZK4xwuW@telecaster> <CAD=FV=U2eiG1TuTq48VL+kNCxN6qp_ZcDk3o_6p3B_ENOspQ9Q@mail.gmail.com>
 <Zy45mCCGZ9sHsXTT@telecaster>
In-Reply-To: <Zy45mCCGZ9sHsXTT@telecaster>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 8 Nov 2024 09:37:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WN5Nzjs2KowMbTij8CZ+T_eZxJ5rLdyyBDk-1H_Dj3cg@mail.gmail.com>
Message-ID: <CAD=FV=WN5Nzjs2KowMbTij8CZ+T_eZxJ5rLdyyBDk-1H_Dj3cg@mail.gmail.com>
Subject: Re: kgdb replacing newline with CRLF in custom query response
To: Omar Sandoval <osandov@osandov.com>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Amal Raj T <amalrajt@meta.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-serial@vger.kernel.org, linux-debuggers@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 8, 2024 at 8:17=E2=80=AFAM Omar Sandoval <osandov@osandov.com> =
wrote:
>
> On Fri, Nov 08, 2024 at 07:31:19AM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Nov 7, 2024 at 5:13=E2=80=AFPM Omar Sandoval <osandov@osandov.c=
om> wrote:
> > >
> > > On Thu, Nov 07, 2024 at 05:08:58PM -0800, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Thu, Nov 7, 2024 at 2:23=E2=80=AFPM Omar Sandoval <osandov@osand=
ov.com> wrote:
> > > > >
> > > > > Hi everyone,
> > > > >
> > > > > Amal is working on adding a custom query packet to kgdb for getti=
ng the
> > > > > kernel's vmcoreinfo. The rationale and details are available here=
:
> > > > > https://github.com/osandov/drgn/wiki/GDB-Remote-Protocol-proposal=
:-linux.vmcoreinfo-query-packet
> > > > >
> > > > > vmcoreinfo is about 3kB, so we were hoping to avoid hex-encoding =
the
> > > > > response and doubling the time it takes to transmit over a slow s=
erial
> > > > > connection. Instead, we were hoping to use the escaped binary for=
mat,
> > > > > which escapes the characters #$}* and leaves other bytes untouche=
d.
> > > > >
> > > > > We ran into a problem, though: vmcoreinfo contains newline charac=
ters,
> > > > > which the serial core replaces with CRLF; see commit c7d44a02ac60
> > > > > ("serial_core: Commonalize crlf when working w/ a non open consol=
e
> > > > > port").
> > > >
> > > > FWIW, the problem predates that commit, but that commit at least mo=
ved
> > > > it to be someplace common. Before that some serial drivers were
> > > > hardcoding it... ;-)
> > > >
> > > >
> > > > > This effectively corrupts the data and causes a checksum
> > > > > mismatch.
> > > > >
> > > > > We'd love some input on how to work around this, especially from =
the
> > > > > kgdb maintainers. Here are a few options, in descending order of =
my
> > > > > preference:
> > > > >
> > > > > 1. Disable the LF -> CRLF replacement while sending binary data.
> > > > > 2. Escape the newlines using some other custom scheme.
> > > > > 3. Give up and hex-encode the response.
> > > >
> > > > I haven't tried prototyping it, but what about moving the LR -> CRL=
F
> > > > code to kdb_msg_write(). It would be really easy to do this in the
> > > > case where we're doing "dbg_io_ops->write_char()" since we're alrea=
dy
> > > > processing character at a time. It would be harder to do this when
> > > > also sending the output to the various console, but may not _too_
> > > > hard? You could loop searching for "\n" and send all the characters
> > > > before the "\n", then send a "\r", then send the "\n" and all the
> > > > characters up to the next "\n".

Actually, looking at this again, I wonder if we even need to do any
transformation before sending it to the various consoles. Probably
not. I think it's _just_ the write_char() path that needed it?


> > > > If you did this then you'd lose the "\n" to "\r\n" combination in t=
he
> > > > gdb stub, but _probably_ that doesn't matter?
> > >
> > > That sounds reasonable. I was concerned whether this would affect
> > > anything else using the ->poll_put_char() tty operation, but kgdb see=
ms
> > > to be the only user, does that sound right?
> >
> > Right. As far as I can tell, kgdb is the only user of poll_put_char().
>
> Ah, one other concern, though: only uart_poll_put_char() does the CRLF
> replacement, but there are other tty_operations that don't, like
> hvc_poll_put_char(). So if we move that to kdb_msg_write(), then we'll
> be adding extra '\r' for other tty types. Would that be a problem?

I honestly don't know. I guess also it can be noted that if we do it
in kdb_msg_write() then the write_char() path can even take us to
places that don't invoke uart_poll_put_char(). For instance
"ehci-dbgp.c" registers its own io_module...

Bleh. It _probably_ wouldn't be a big deal to do the LF -> CRLF for
all these, but I don't know for sure. I guess worst case you could add
some flag in the "dbg_io_ops" and figure out how to set it just for
UARTs?


-Doug

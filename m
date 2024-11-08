Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3320721E
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079900; cv=none; b=ZS8Mp3rNqLlneqjJzLh9hx5cqbF8yDVXpAXpYDlmek+chFlhtV30wH5jjNncn2tJbMEo86M4ayWeyuOo7HYwCIkIbYi6aK2sWNGcjyXb0rHp2CDBKT05RXUTR6sOWeW+h5F54gYyhq1QPSnWvtPrRUAf92VPofu1d+CzwGRIWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079900; c=relaxed/simple;
	bh=LguMVM4sVGeBIk+UXhhvzkbgqAyeZTN09fcokG5c3Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQXGWgVO3M25WSu4tm8NGcdJvwcQw3lwWDAJ98yIzuoTjtvEque1bevukLu5Tp/lqMbgakgzv3Ac/TlgUWtzH3t0X/71Chz2cRcePTNgAxy8BMSbeZF/keqxW01M3K90n3GM//R87i2XpUvEERT1RyJMdqZo+MJ7mf63FUPTUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JJ4UgpOW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JJ4UgpOW"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e8607c2aso2611966e87.3
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 07:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731079896; x=1731684696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LguMVM4sVGeBIk+UXhhvzkbgqAyeZTN09fcokG5c3Ts=;
        b=JJ4UgpOWjYpgting2tzM2tQYGKAuCp4rtWgdGEQ1c0h1ejCgcW0vOWiRzOJHI2Q9L2
         H0bg6i+GmefQFpQH4j+Cax2+wHTcNuD1WuF6xOFtCRiZrBPEmmdGp6jQy1GL2iMhkk8T
         5JC+hkC4D1BLbuH90CijKtcNjEUHKM7odnqk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731079896; x=1731684696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LguMVM4sVGeBIk+UXhhvzkbgqAyeZTN09fcokG5c3Ts=;
        b=MMFZDZaaHIrrcZa2OI9jba9Ewdb0ev2rbf44l+e4mo+MN5ppUngoPxGTSgEwB2aDOn
         mvvFYyoZg0o69ealWsvz/OirzzcxRlMvHpc0CBjkUyMEyO/Mf7nMnR6nJqpngQJTmE4n
         5Rlu93MxakrGlb5AvZWGssyPIsW9DOm4htDJ8rcoXG9sasuHjY1KKYqJeyW5DPAt3/Ch
         I+geufaA66QAmoUGajAhds4oev3tiRCmgHzcnTPnUgLpjaJJV9iXwhqfzJAS/q/iSnJ5
         8kdSgwJR0z5qhYxeKRPcZemQGvpKcuWTm2RAQxd0HoyRDuOz599nmdUNbwOj2ccCdJkT
         D0wA==
X-Forwarded-Encrypted: i=1; AJvYcCXvH6y45rj5i0IxSUSAaStmBcYYyX/pKHDV0nzl6R14WXTRES2j8xnGs0cGuWm5weh4hntRJ00fkHa+qnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJIgO49N0sSXUE9BHh0emlaDKL9o9ZdEB/CLiy+TUPtUYhJSTr
	al8n+pmgEF35cUdKOH+NmlHD8wrypb9TvfDqHIGYtCDHpeDaSRUldZf/3qigXBaQVu18B08RRJo
	65w==
X-Google-Smtp-Source: AGHT+IHW4wHsq9NxPqwjfgZ9hlHPmUkfcrsNjr3xja/sBK7JHHNUh1ER90fojHCkAeoudOlvAMr8nQ==
X-Received: by 2002:a2e:be20:0:b0:2f5:11f6:1b24 with SMTP id 38308e7fff4ca-2ff201b3185mr20812711fa.18.1731079895538;
        Fri, 08 Nov 2024 07:31:35 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17991a25sm6899601fa.79.2024.11.08.07.31.34
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 07:31:34 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e8607c2aso2611802e87.3
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 07:31:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi9L7vT0cM/K/NVx0uKYurvJvEsjLLeH0r7ZHf0+HPR1utB8fecjpe9wr7XfR+qBXr0jgU9qsxHSN83Nw=@vger.kernel.org
X-Received: by 2002:a2e:a813:0:b0:2fe:fec7:8adf with SMTP id
 38308e7fff4ca-2ff2029fed5mr18554131fa.38.1731079893927; Fri, 08 Nov 2024
 07:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zy093jVKPs9gSVx2@telecaster> <CAD=FV=UZKZ_RL73+JLjeW2FmAfifSyXqLV3M30XzmJSPE9Trzw@mail.gmail.com>
 <Zy1lyACVnZK4xwuW@telecaster>
In-Reply-To: <Zy1lyACVnZK4xwuW@telecaster>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 8 Nov 2024 07:31:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U2eiG1TuTq48VL+kNCxN6qp_ZcDk3o_6p3B_ENOspQ9Q@mail.gmail.com>
Message-ID: <CAD=FV=U2eiG1TuTq48VL+kNCxN6qp_ZcDk3o_6p3B_ENOspQ9Q@mail.gmail.com>
Subject: Re: kgdb replacing newline with CRLF in custom query response
To: Omar Sandoval <osandov@osandov.com>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Amal Raj T <amalrajt@meta.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-serial@vger.kernel.org, linux-debuggers@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 7, 2024 at 5:13=E2=80=AFPM Omar Sandoval <osandov@osandov.com> =
wrote:
>
> On Thu, Nov 07, 2024 at 05:08:58PM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Nov 7, 2024 at 2:23=E2=80=AFPM Omar Sandoval <osandov@osandov.c=
om> wrote:
> > >
> > > Hi everyone,
> > >
> > > Amal is working on adding a custom query packet to kgdb for getting t=
he
> > > kernel's vmcoreinfo. The rationale and details are available here:
> > > https://github.com/osandov/drgn/wiki/GDB-Remote-Protocol-proposal:-li=
nux.vmcoreinfo-query-packet
> > >
> > > vmcoreinfo is about 3kB, so we were hoping to avoid hex-encoding the
> > > response and doubling the time it takes to transmit over a slow seria=
l
> > > connection. Instead, we were hoping to use the escaped binary format,
> > > which escapes the characters #$}* and leaves other bytes untouched.
> > >
> > > We ran into a problem, though: vmcoreinfo contains newline characters=
,
> > > which the serial core replaces with CRLF; see commit c7d44a02ac60
> > > ("serial_core: Commonalize crlf when working w/ a non open console
> > > port").
> >
> > FWIW, the problem predates that commit, but that commit at least moved
> > it to be someplace common. Before that some serial drivers were
> > hardcoding it... ;-)
> >
> >
> > > This effectively corrupts the data and causes a checksum
> > > mismatch.
> > >
> > > We'd love some input on how to work around this, especially from the
> > > kgdb maintainers. Here are a few options, in descending order of my
> > > preference:
> > >
> > > 1. Disable the LF -> CRLF replacement while sending binary data.
> > > 2. Escape the newlines using some other custom scheme.
> > > 3. Give up and hex-encode the response.
> >
> > I haven't tried prototyping it, but what about moving the LR -> CRLF
> > code to kdb_msg_write(). It would be really easy to do this in the
> > case where we're doing "dbg_io_ops->write_char()" since we're already
> > processing character at a time. It would be harder to do this when
> > also sending the output to the various console, but may not _too_
> > hard? You could loop searching for "\n" and send all the characters
> > before the "\n", then send a "\r", then send the "\n" and all the
> > characters up to the next "\n".
> >
> > If you did this then you'd lose the "\n" to "\r\n" combination in the
> > gdb stub, but _probably_ that doesn't matter?
>
> That sounds reasonable. I was concerned whether this would affect
> anything else using the ->poll_put_char() tty operation, but kgdb seems
> to be the only user, does that sound right?

Right. As far as I can tell, kgdb is the only user of poll_put_char().

-Doug

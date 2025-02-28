Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2892157A55;
	Fri, 28 Feb 2025 04:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740717582; cv=none; b=Nht/t4ADQGGPdX7fB4mSsgGFUbrKGpVVEYR1i6CkWMpmQO7xRQiFYvq5ln46e6lmI/4/XSiOTq7//YIah2vYWmHFLE6K4eS2sR6WoKto5Xfl9xqlq5DYlmum+gkcU8pc1xRHaTD2s6grtTckMj/ohwgGvFYpmj6x9CMqgLp/4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740717582; c=relaxed/simple;
	bh=8aZ49bvuDjKomHLXgnAinIV22zHwW7rGZjJkxM4aF6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXpPhPy+NBmls4pcICkKAZ3IE1V4z3LDbqogzA6UQv+I7Ee8duEeMR349mXKNKU6IwJXUdupJi+VbJ7RGHfJCQIVIAnCOEc6dad5DCpaLdGo+00Mp4/BBUfUQvkHDYJDt8wiRsUFr9Pxiyh9QzsQtKU7RcetKqWM1wg3NHrPAg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQJMXive; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQJMXive"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0ba9825e9so116194185a.0;
        Thu, 27 Feb 2025 20:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740717579; x=1741322379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9smtCjYcxndzyuV/cVbRKleBRB09EObWKV/3vjpHQ1g=;
        b=lQJMXive/ZdwDpWPLc8K9r4gdh+HlkLwTmvYTy4+9RpNbmPGNVvCinYH3R6SDk5qzs
         dpzwRisbALVsiEwmv4zkX5FoP9FWQpdmfS7do/DPO4U+8Py8yfDXISCI3yVgCnoqf/+w
         PoL47bn9fIDLxoYGu/OSufRau6JKsAdj8LbpmEDpIxavriLBV8VAkuaDZUlcXwNWzza3
         hyMym8VJtohDv3dPzW98NpGoY2hy7zL16XBn+sOUZGijqo1SF3rNxCop0tvDO4aySyu0
         rdEWgaO602H5w2/D3RkL+lTJU14ABq2dAA7K2vcfwXXinDaKCfqQhpity4RxLGC1M9Ej
         gLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740717579; x=1741322379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9smtCjYcxndzyuV/cVbRKleBRB09EObWKV/3vjpHQ1g=;
        b=nonWlFPa3u6aUJlJAJQMg/XYOTk2TkPk0MMeXirOW4tv87Yzgz9tJ/RBFWZLQliz2E
         pu59WqFKARfKTF/h0fITgtTTE3R7gyhnqlJJsB3vzxo/1fkAlFO8DRqlMMOoUJXZ7jTc
         3CIBEiFxVyyS6os2Dolc3LzSvApCCm8DOH/Uieo89LOro3mR0d2/R8XfY0wUxnnti6Q8
         nMays+Zl/0RIP5CjLjbVlFVezQuJn05zrFpdQBpQK6Cd0H7hPegfZfbfYcmYZtprQcO6
         FkWH7cj5cO1Du96HfnMuWUBXFgOBMlq9cfSFzzOOVNAZ4g8cJj7AoqPvQN2bGyRcqWov
         M+aw==
X-Forwarded-Encrypted: i=1; AJvYcCV2JGbtrIb2Qmgi7cCpG//tgttICrsjk/hfNTzvknvDL/UuSf/uP6wlQzJJvzr1DYp0jKBJYdzp8aHxkGal@vger.kernel.org, AJvYcCXkJpuKp6LA/Nwvy15NcL2Wl6CTAzmWX97KA1NoRwgNFfsWXeTjTpzH8IbJe/ZSmPv9HDPl0KHSSER7e9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwyfcU8pTEhSMzJKMs3LAfyt89o2Gu5LimRy9XbKNV+zJuH1E
	vhSeKZngmPcXZPQtno5L5Zz9WGutO+PwyxEqnqPh4sQcHJQdbKVx
X-Gm-Gg: ASbGncuLgd9zdVUZXLsmOyPVfnJyYrZACvqw9gHnUQr3Wlc8uYWqdD8aDhzkh5LoGkk
	GezLa/FQsx0yPT4lFo/MmoVtxDBcIzp/e5sEGobAl8OmEzXWAMy+0aHhF4TVZh96ZFlY/OpiUfu
	j/VkbzTT7nrj8aC9VBnOPJkCKDPwPUTHTAOAufooZqslp04bpqGhyTuG9LdT1nkp/B5/x7Qp3+W
	emwwuBSIHfSxVyXL4CIS0t7WdCVVO4X9NDoVCCEOcpC9e+iSIRIzYF3WTim09Ku5rvzfEmchlbw
	4YiJixAK5Ti3p04uvdCIom9Pq/OOiSr524Lyeo8Ip8ftfjw=
X-Google-Smtp-Source: AGHT+IGg3xj8a/rl8KC65AhaGGrHyAEQ1UUGT9knkuDeL97ZFJI6SYvvRE+VeaebdQysoYooaCB1Xg==
X-Received: by 2002:a05:620a:f04:b0:7c0:a5f4:4df with SMTP id af79cd13be357-7c39c4cd3e9mr304731185a.34.1740717579497;
        Thu, 27 Feb 2025 20:39:39 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:5bd2:dbc7:4aba:299e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9fe97sm199383585a.73.2025.02.27.20.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:39:38 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject:
 Re: [PATCH v5 1/2] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Thu, 27 Feb 2025 23:39:30 -0500
Message-ID: <10956921.NyiUUSuA9g@nerdopolis2>
In-Reply-To:
 <CAHp75Vdr1yNamVMP12X2bZs5=PL=R+Lsio5b+ba_NaPOsvzobA@mail.gmail.com>
References:
 <20250224123915.2859682-1-adamsimonelli@gmail.com>
 <10194425.EvYhyI6sBW@nerdopolis2>
 <CAHp75Vdr1yNamVMP12X2bZs5=PL=R+Lsio5b+ba_NaPOsvzobA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, February 26, 2025 2:22:20 PM EST Andy Shevchenko wrote:
> On Wed, Feb 26, 2025 at 3:39=E2=80=AFPM Adam Simonelli <adamsimonelli@gma=
il.com> wrote:
> > On Tuesday, February 25, 2025 11:19:04 AM EST Petr Mladek wrote:
>=20
> ...
>=20
> > > My proposal is to call:
> > >
> > > #ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> > >       add_preferred_console("ttynull", 0, NULL);
> > > #endif
> > >
> > > somewhere in the kernel code. The question is where.
> > > I wonder if the following would work:
> > >
> >
> > > #ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> > > static int __init ttynull_default_console(void)
> > > {
> > >       add_preferred_console("ttynull", 0, NULL);
> > >       return 0;
> > > }
> > > console_initcall(ttynull_register);
> > > #endif
> > >
> > OK, actually in earlier revisions locally, I did actually have
> >
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index dddb15f48d59..c1554a789de8 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3712,6 +3712,11 @@ void __init console_init(void)
> >         initcall_t call;
> >         initcall_entry_t *ce;
> >
> > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > +       if (!strstr(boot_command_line, "console=3D"))
>=20
> Just a side note: strstr() is fragile as theoretically "console=3D" can
> be part of an argument unrelated to the console, like
> foo=3D"bar,baz,console=3D10,key=3Dvalue". Although I haven't checked if t=
his
> is allowed by cmdline parser (lib/cmdline.c).
>=20
Dang, good call. As a crude test, console=3Dttynull=3D results in a panic, =
so it
does look like it allows =3D's in parameter values, as it looks like it is
handling the =3D...

Gotta find a better way to parse it if I'm to do the `add_preferred_console`
route, Maybe I can try get_option...

What do you think of the placement of it too?
> > +               add_preferred_console("ttynull", 0, NULL);
> > +#endif
> > +
> >         /* Setup the default TTY line discipline. */
> >         n_tty_init();
> >
> >
> >
> > Which worked as far as I could tell, at least on x86. Not sure if that =
was the
> > right place, and yeah, I was trying to better copy how CONFIG_VT_CONSOL=
E worked
> > because I thought that was more correct.
>=20
>=20





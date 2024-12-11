Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FE1DC1B7;
	Wed, 11 Dec 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931655; cv=none; b=ePtwWJUjSHlGkebG3QNs145ImNaXZBHgBaeqwtnPaaSagJkk5Tbgr144SbAVFmib2hO+s1+k4NaSarNnwdHdM3rrd6G7VBAQesPNOTITkU+BssYykx3TS6QnBF1C6qxKeCGf8l03GdKlCX/L24ZUklJgJki/XQwvfaMnKcp/z+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931655; c=relaxed/simple;
	bh=1U8GK/HBucve5Vzw5j16yO01zfpQDeQjIe+KfymSWZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNWVuQo0nUsZbVqGXTwoMRX1kTSRePvJ/lJ39soU0ZZo1+1+i6/yefijfmcl5Zdyp1unzhKlRIdR+iUo/cWhumUtYvmQ2KRyL0JPVgH1TK3Aw6/53+CiJAHUhPhSXX2BDOGsrkxp+nx0N9xpJ8sJX7hk6Gn+sNG2Ld8O2h0LcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiTWoFIM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiTWoFIM"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so3847951a91.2;
        Wed, 11 Dec 2024 07:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733931653; x=1734536453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyPH0vNprLsOG5WPdlnV967EHGFbdM9XNa/iKD/HvM8=;
        b=WiTWoFIMvpQ3yCTl5lt+57Q3DTtklI7Xg5GoxjjaM6v8ewTrNrtdhJ+WdugklYRshz
         Vgf4J/JosToX9PK+s1XGtLfYPD74CLkN6s3LNgsNC97NOsL3+NpAYkWwd805PUla8NGe
         NXeoENXBVy/rszbXvT/i6b3Fc3kALc/bAr5xF+M2EAbrADLC0MgkuKwepsv4c3u2uDWG
         E7n9SUV6T/sCgXe7E42W2KoHKzcz7sVpMJUBoabY1HStHzCvVA40HR63JOeXLZMgmqhn
         NEcFTqnDGzrSuSMK9siia6dqDaZtPEHjdmQoQYiAxrV9vtp/7oMGj3dn1aMtb7ikkkOB
         LpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931653; x=1734536453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyPH0vNprLsOG5WPdlnV967EHGFbdM9XNa/iKD/HvM8=;
        b=S+fyg0KQW3o4GlhJaRNF5ip6oUA9bLvhhQeodfFr9Rk9cRhDudamzI/o5sZPbO/K6Q
         zr76ykK6W/OjCJ5g5J3PFlzB6Vqun1PqwkWn5Fip9+XmFg8Ui7kPb8MicWSjNP1b65ap
         /YOxBCaxb6rzKeuUIsp0zBrmjP5LAHcp2oU7Y2wCF+RgPqyQO+LfEHIM2GtrxqHQKdOT
         aFdJAKhBGPHH8qeGI5+6gwrIsGQi0WqeJ0SpgIHgAImBqpc6qi2uY2JGvi78pEDvqZMJ
         xdPAnVYbhi2cRDJnuy5/3uCLwmofAkDBx9FEJhboEePLfamIAr1JV5TwB/7d++sd5H84
         RhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0b1phZy6ENQGw68E/dwRBa499PeDQZjLYbsGULv7q4PlcUIvErBKJZFsjp4gKY8LA1Du6Y1oE0jg2dH+z@vger.kernel.org, AJvYcCW1XkMWA/WSchcaaJ6gu4To7rLld6qPpuUl35Y+M2MfXTT55M24FuqUwsvCHD72y/Ne5DIZ2FOhjpHiyNMntXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUt6OXf8QaOM1ZQ4ffxJLRj+ta/Jx+Jp5b675IKoSzeJh3Q02
	AzGmWoJp05Jh8+q0bXg6j2t9U+pFqCYuk7ANy3cOxzSranKrRzZY0rLpkv3QyY4VnBOl8DfSsdC
	ARRpuHLZ1u7+i4bEC9JudaB5vp7k=
X-Gm-Gg: ASbGncuFUqQdJ3NgCutHty5jsGU/krXap5icBPR1HOws0TQztrntnqgoF4/v2ZSzU/t
	cAfw7L/VYeiohwLT08OYOiG6XcAYg7U3ny74yepg6WbT3XOUHRocRlQJ70zlW8as5qBkBzw==
X-Google-Smtp-Source: AGHT+IF8Ne3g6aTlUh65xevQPLWMYZf/8LrauTVMmzWwSw1t6WGq8BZUZ16zLWp8pj8yoKgXRT/EmCzWE5s+7foXOEg=
X-Received: by 2002:a17:90b:38cc:b0:2ee:7a4f:9265 with SMTP id
 98e67ed59e1d1-2f127fc7463mr5778636a91.15.1733931652526; Wed, 11 Dec 2024
 07:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210133448.3684593-1-tjarlama@gmail.com> <20241210133448.3684593-3-tjarlama@gmail.com>
 <Z1hbT4OtEO9gz5Dg@aspen.lan>
In-Reply-To: <Z1hbT4OtEO9gz5Dg@aspen.lan>
From: Amal <tjarlama@gmail.com>
Date: Wed, 11 Dec 2024 15:40:41 +0000
Message-ID: <CAOfKSRNGdeFgidKoD9wpvce2HZnOEXyXt5mbeMqmr90RTe9XqA@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: Move LF -> CRLF replacement from serial
 console to kdb
To: Daniel Thompson <daniel@riscstar.com>
Cc: danielt@kernel.org, dianders@chromium.org, jason.wessel@windriver.com, 
	stephen.s.brennan@oracle.com, amalrajt@meta.com, osandov@osandov.com, 
	linux-debuggers@vger.kernel.org, linux-serial@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:16=E2=80=AFPM Daniel Thompson <daniel@riscstar.co=
m> wrote:
>
> On Tue, Dec 10, 2024 at 05:34:47AM -0800, Amal Raj T wrote:
> > From: Amal Raj T <amalrajt@meta.com>
> >
> > The current implementation of `poll_put_char` in the serial console dri=
ver
> > performs LF -> CRLF replacement, which can corrupt binary data. Since k=
db
> > is the only user of `poll_put_char`, this patch moves the LF -> CRLF
> > replacement logic to kdb.
>
> This description only explains why it is safe to change
> uart_poll_put_char() but...
>
>
>
> > Link: https://lore.kernel.org/linux-debuggers/Zy093jVKPs9gSVx2@telecast=
er/
> >
> > Signed-off-by: Amal Raj T <amalrajt@meta.com>
> > ---
> >  drivers/tty/serial/serial_core.c | 4 ----
> >  kernel/debug/kdb/kdb_io.c        | 2 ++
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 74fa02b23772..ed18492b7f8f 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2142,8 +2142,6 @@ void uart_console_write(struct uart_port *port, c=
onst char *s,
> >       unsigned int i;
> >
> >       for (i =3D 0; i < count; i++, s++) {
> > -             if (*s =3D=3D '\n')
> > -                     putchar(port, '\r');
> >               putchar(port, *s);
> >       }
> >  }
>
> ... kgdb isn't the only user of uart_console_write() though, right?
Yes, the replacement should be only for uart_poll_put_char, fixed this in v=
2
>
>
> Daniel.

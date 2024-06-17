Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3031990BD
	for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652591; cv=none; b=hRJreL4l6a8I9BcHHgM0+lfpEpQvyKi3phKJQ8SXFgqYSMmMAzGPPbrD6yCJTsBH7vl2LiJzVnD6ULFnXL2uffkudx2tMlC5n+4D72KdwpvStst3itv4HgzDMhmEbpGE//B26D8bKVMrr0XF/mnpaO7l1Ak7xAOjPXQzDBP+nis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652591; c=relaxed/simple;
	bh=8cuQz2UmP2mjJZs6GUFp9YvP+kEirWd7y9qE5iYFTVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KFJK+9xlIsfWdGkmzYBVZ9e7obiA6o8X8g3ITNbTM/DcJUQokPeN+H7WN4i8EgKOrlPDWmxl+sE9aC85E05qr5xQ3JT8EgG4R3hTpNE8ZgV/CdVmsz1VLxPGpAvO0LO7S3VtXf9THU81c7fdmtjE+pe+LTUEPY+0bHCp9PkzIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qsDnel5T; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsDnel5T"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-57c77b21110so4157857a12.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718652589; x=1719257389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiXIJbuLM9AiKCrkAru4erNGygZvBZwC1BER3jDffD8=;
        b=qsDnel5TgN7CtbmzX/NkXLFRtY/qb2JPfv2SBJJV/sBxJS0ci5LG6xSaidEYajVdy1
         46dsVEJuSYL6c+ynMn/C3gdvZQ228KzF7axhwCYSPz7obL16QkSvQI/II7hxJkDhbqIe
         MNhGNUKTTTfY+JwPfSeDsC2odKUxcQk2MvYeFeyTERoQkgEZOdLAR+YokkK0df+OTi5J
         91CHchej2DlLyPKiKfvSJQzswux76FdY3CcIKnppuEELItLAyRC/fC15PKPYltwvwoch
         h8uWkIBV+Husjm2aP6zxR4YjEG33t4VwPhBxiBe87Y+UG35po5VJVCXIOn6tiRnI0xEg
         ownw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718652589; x=1719257389;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HiXIJbuLM9AiKCrkAru4erNGygZvBZwC1BER3jDffD8=;
        b=wNlWPkYiCBVgiGW0A4gnVb1ohVa+ennGUaNGC4rDgI3vE1gjrZikAHwU25Top3snuN
         ehAGJlfPThBZ2MlZEOprPlsVHiSkbG3/7Li3pS7x2H1VpFXZLRIljHPlL6QSWySLbKsh
         06raesr7u+lBTZMWe3jiudqQAU1QaZHUgc5JUFC/ClV87GOTV8+GbzJu/dd8caIY8Qq0
         /82BOoUDHl4bm5dVYmsj6HJjjyy5Xxp2cbyBM/fnjxNkoUnwln8jvFDF9q/Ap8l5x+e7
         ThdtFJypjm5+1cIAQgpf8qd06noSnWiZ0FXl9g6QgmMKPcDQkczKfJs7YPP0w5KHFCaM
         r9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX7qMz7MNHebZ9HsFXaVbMoL0QW8IfJCg9MOj+JbDeGv/qKptHKKqtKCBF2mYkmVFzkcAdubaJamab2UfD8NoB4qP8kBm0zs4/NQRRu
X-Gm-Message-State: AOJu0YyIevnCRzkgoPGcFw4vaBhu+BGH6GQU0Ns3Ac/JFL2qgaFdJItD
	uLSDN2K0jvR7cuhF5zU53Kt7yGOOYUF6LI8q8aT+QLnfatkld20qrONUEQolWh67nSzugqarpGT
	RlQ==
X-Google-Smtp-Source: AGHT+IE+p0qWaICcOkHIWSwAXKqcsMLbzGj61pTdnBKLT1q8RUdq3tg3Ab8TycaL0HnRkIkBuint1KLrXqU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:530e:b0:57c:e715:4cbe with SMTP id
 4fb4d7f45d1cf-57ce7154daamr4553a12.3.1718652588722; Mon, 17 Jun 2024 12:29:48
 -0700 (PDT)
Date: Mon, 17 Jun 2024 21:29:39 +0200
In-Reply-To: <VI1PR05MB6782D0D70A2A313434013F9ACBCC2@VI1PR05MB6782.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <VI1PR05MB67825BD1C2EFCFCBF7521F7ECBC72@VI1PR05MB6782.eurprd05.prod.outlook.com>
 <VI1PR05MB6782D0D70A2A313434013F9ACBCC2@VI1PR05MB6782.eurprd05.prod.outlook.com>
Message-ID: <ZnCOozJy0slUYF_u@google.com>
Subject: Re: [LSM/Landlock] Adding ability to sandbox TTYs
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "COHEN-SCALI Remi (AMPERE)" <remi.cohen-scali@renault.com>
Cc: "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Sun, Jun 16, 2024 at 06:02:03PM +0000, COHEN-SCALI Remi (AMPERE) wrote:
> A feature request on landlock is about sandboxing ttys management.

For completeness, this feature request about TTY IOCTL restrictions is at [=
1].
The idea was originally explained in [2], to protect processes on the same =
TTY
from messing with each other through the TTY IOCTLs.  In that proposed appr=
oach,
the policy decision is guided by the nesting of Landlock domains of the pro=
cess
and the TTY, similar to how it is decided for ptrace-ability.

[1] https://github.com/landlock-lsm/linux/issues/5
[2] https://lore.kernel.org/all/20230822.ua3aib8Zaile@digikod.net/

> I'd like to propose an api for this feature but before I'd like to hear f=
rom
> you about what could be proposed to developers.
>
> Of course the standard approach can be provided for "locking" access to s=
ome
> syscalls. It will allow a dev to setup a ttys mngt for his app and then l=
ock
> it. However I think this will not be enough for most of the use case for
> applications making an intensive usage of tty framework.
>
> So I will go first by proposing a standard approach. But in a second step=
, and
> for also allowing apps having an intensive ttys framework usage to use
> landlock, I think it could be interesting to propose another approach:
>
> something as... providing the app a way to define several configurations =
and
> allow it to switch from one to another or ...

I'm not sure I follow your proposal there.  I assume that by "configuration=
" you
mean a Landlock domain (an enforced Landlock ruleset)?  In that case, I don=
't
see what the advantage of that would be.  -- If an attacker has taken contr=
ol
over the sandboxed process, they would be able to switch between these
configurations as needed and it would be just as effective security-wise as
having only a single configuration which enforces the lowest common denomin=
ator.

Generally, once a Landlock ruleset has been enforced, that enforcement is n=
ot
reversable and is inherited to all new subprocesses and threads as well.

Am I missing something?


> PS: I saw @gnoack proposals about this tty handling in landlock and they =
seems
> to be, at least, a good starting point. I'm also looking at several apps =
using
> teletypewriter management (gtkterm, minicom, vterm, shells and one I
> specifically love and use, emacs).

The current status quo is that distributions with new kernels are largely
requiring CAP_SYS_ADMIN for the most dangerous TTY IOCTLs which have been u=
sed
for privilege escalation in the past.  These IOCTLs are (a) TIOCSTI, as wel=
l as
(b) TIOCLINUX with its copy-paste subcommands TIOCL_SETSEL, TIOCL_PASTESEL =
and
TIOCL_SELLOADLUT.  These patches are independent of Landlock and are alread=
y in:

(a) 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
(b) 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste subcom=
mands")

(This is also documented in tty_ioctl(4) and ioctl_console(2).)

=E2=80=94G=C3=BCnther

Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB292AEED
	for <linux-serial@vger.kernel.org>; Thu, 12 Jun 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736643; cv=none; b=u3rUYgugCWgNu0sOaz9NT26APEQt0syeoRQEJt5/HmAnJUxTuBtePnxKsARNNvO1I17+xqQ6whlXud0P/YKwtm1dEQ20SHQHyHpbVjJoQ/eUaqW/SN8N1hAr7W4VQREfdZvhHGDdCHrnsEssfpSK8iJW1/Tzu1hgvYZgvTxAYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736643; c=relaxed/simple;
	bh=FsjKzATE2fBcfCRDnaoVj2USddLsymJIPPzcUtqYzs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vnjt1MCv35z8MVYPninL17ebl7mGTCtxULL6o+Iky9jt1X7nJTrlbImOcpcA8F/YhrooNTas4ryPUwUo/qav7U6iqogsDRnOBsK/6SIYjzPe7T7nk6vWXohzPM2tAKBmdpTU4TxtAlyjMK9Kd0E/ow49o82aiIM92xPgPKPXPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D7XScwff; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D7XScwff"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a361b8a664so898926f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 12 Jun 2025 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749736639; x=1750341439; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uWIybPnFMO+iPTF1D7X2vHTnG4Ra9zFxBSdBlVwLzyQ=;
        b=D7XScwffSPpuo1FjJw7y9xXs8XqQ7kB72+1uyeWPvNCOsOgnVZ5qUmhnLmkkl47P8Q
         TCIgi/kGRspXC1DAoTSqDTP/XJY+EIM7rJWeG4kQ38b9gEGRUVUw0Nz5hQ8U+THIUuVR
         gPGD8ftcv/amVRcvZC/Glx6Ealo3sLcRChX4G6JYN6kCrvWewfGpdRkdxZNnunoxRq9m
         SdDR3kgz94+457XDMuXybhIoPMM3ChGXNb7v0CiVfsm/FiHBStIqc6BMUJKohCum5cbU
         lQ3iRyu1YDTltneD9t8r9FGqnhz1ZUSzykbBpiiyNWfbZdzyQKr5lZgMYaCZMaCVSaz1
         MjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749736639; x=1750341439;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWIybPnFMO+iPTF1D7X2vHTnG4Ra9zFxBSdBlVwLzyQ=;
        b=BhbJGLmCGXffqSRP/I7iS6YfG6N0kegzaXw5sfI3PeA/yI7bzXPv/3ihq+bBM9cbjB
         iMF+LCGIy0X7WYUxP4C31hucedQObAVhiEc/w/apaNRXBvuCirzU507WXelmsah2ZMbt
         sYOmHIfHAXfi+d190iarW4pHDaQajpQUq0bNixNA7u0A+NC7dsDwQWP1E9hEsT/rtkA0
         M+762wXgm027WxL8SpJRlauy+Bpt2WKFIn+fYMf4lmzWzNJN72tmA5UdS0FXXIPbUD/2
         Gt7A6ZuN4jEY6jCe+OeEVjcoTEL3Rf74hy/OrgmNJYHLS9wmkY7ZI4lmQtFt8mE6j1rf
         MTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE+WCPeB6IujKyhzk8y3EpJ0wACTc2uHlxsLJ+OtvVeg9SsWRQDBS04f42+VJviANZlTtKkrqqd6wwrnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OO+Mo7MP+OTLmhRoqbLFRsgjPOYZLId1oCw/nqxe8uahB019
	bsLd3s/lTRb45euqBtjMEbrV/yl5Xt1JOaGi4booeCB3Ckw0jq5Pf2sylScq9nySvEE=
X-Gm-Gg: ASbGncuFZ/JyWT/Je1jtfmVTbphJ1N2xNnqPzvon/Jrs0Las6cEC9hM5HwdX5RE29QD
	h32ayDEdMhGTLKG8SGrgWbwon0hMICYRckHYYED2t940t4fB6D8LOWWW7+30bdrzFwc2XHd/Nr/
	3FOGnZskYomyMFX9aXLuD35xC+DSqmhEKWUx3pZrEhM8h58YeeTm7+62LTJIg1saxSTHt8VWAw/
	E/LkK5DE9SvEZzcKugxCWxPEOCQyE11yxuza5haco8lQQkObW5tk7UzcfOaOwEOuHZmpNb5D8Lh
	WNJDfybqoYK1t3dXrKTQTn7kWW0ztKNlFjet/trch5dmV22m9OgVcZDQ6LNpPefB
X-Google-Smtp-Source: AGHT+IHHTgsF4plb+4cSFCswnZ1BoRaKntWrXC3dKLfejS0J5Ju71cHUfrXuDzUBs/xWMfkadhCSvw==
X-Received: by 2002:a05:6000:420b:b0:3a5:52b3:103b with SMTP id ffacd0b85a97d-3a5586dce0bmr5309298f8f.4.1749736639382;
        Thu, 12 Jun 2025 06:57:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e61b65esm14131675ad.12.2025.06.12.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 06:57:18 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:57:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
Message-ID: <aErcrCKcsi9cpANY@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
 <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com>
 <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>

On Tue 2025-06-10 16:18:22, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jun 10, 2025 at 1:03 PM Marcos Paulo de Souza
> <mpdesouza@suse.com> wrote:
> >
> > On Mon, 2025-06-09 at 13:13 -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Fri, Jun 6, 2025 at 7:54 PM Marcos Paulo de Souza
> > > <mpdesouza@suse.com> wrote:
> > > >
> > > > All consoles found on for_each_console are registered, meaning that
> > > > all of
> > > > them are CON_ENABLED. The code tries to find an active console, so
> > > > check if the
> > > > console is not suspended instead.
> > > >
> > > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > > ---
> > > >  drivers/tty/serial/kgdboc.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/serial/kgdboc.c
> > > > b/drivers/tty/serial/kgdboc.c
> > > > index
> > > > 85f6c5a76e0fff556f86f0d45ebc5aadf5b191e8..af6d2208b8ddb82d62f33292b
> > > > 006b2923583a0d2 100644
> > > > --- a/drivers/tty/serial/kgdboc.c
> > > > +++ b/drivers/tty/serial/kgdboc.c
> > > > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char
> > > > *opt)
> > > >         console_list_lock();
> > > >         for_each_console(con) {
> > > >                 if (con->write && con->read &&
> > > > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > > > +                   (con->flags & CON_BOOT) &&
> > > > +                   ((con->flags & CON_SUSPENDED) == 0) &&
> > >
> > > I haven't tried running the code, so I could easily be mistaken,
> > > but...
> > >
> > > ...the above doesn't seem like the correct conversion. The old
> > > expression was:
> > >
> > > (con->flags & (CON_BOOT | CON_ENABLED))
> > >
> > > That would evaluate to non-zero (true) if the console was _either_
> > > "boot" or "enabled".
> > >
> > > The new expression is is:
> > >
> > > (con->flags & CON_BOOT) && ((con->flags & CON_SUSPENDED) == 0)
> > >
> > > That's only true if the console is _both_ "boot" and "not suspended".
> >
> > My idea here was that the users of for_each_console would find the
> > first available console, and by available I would expect them to be
> > usable. In this case, is there any value for kgdboc to use a console
> > that is suspended? Would it work in this case?
> >
> > I never really used kgdboc, but only checking if the console was
> > enabled (which it's always the case here) was something that needed to
> > be fixed.
> >
> > Maybe I'm missing something here as well, so please let me know if I
> > should remove the new check.
> 
> So it's been 5 years since I wrote the code, but reading that I was
> checking for:
> 
>   (con->flags & (CON_BOOT | CON_ENABLED))
> 
> Makes me believe that this was the case when I wrote the code:
> 1. Early boot consoles (earlycon) were not marked as CON_ENABLED but
> were instead marked as CON_BOOT.
> 2. Once consoles became non-early they were moved to CON_ENABLED.
> 
> ...and the code was basically looking for any consoles with a matching
> name that were either boot consoles or normal/enabled consoles.
> 
> Is that a plausible theory? It's also possible that I just was
> confused when I code things up and that I really meant to write:

It is easy to get confused by the register_console() code. And
it has been even worse some years ago.

Anyway, the current code sets CON_ENABLED for all registered
consoles, including CON_BOOT consoles. The flag is cleared only
by console_suspend()[*] or unregister_console().

IMHO, kgdboc_earlycon_init() does not need to care about
console_suspend() because the kernel could not be suspended
during boot. Does this makes sense?

Also it does not need to care about unregister_console() because
the unregistered console won't be listed by for_each_console().

[*] The 1st patch in this patchset updates console_suspend()
    to set CON_SUSPENDED instead of clearing CON_ENABLED.
    It helps to make it clear that it is suspend-related.


Resume:

I would remove the check of CON_ENABLED or CON_SUSPENDED
from kgdboc_earlycon_init() completely.

IMHO, we should keep the check of CON_BOOT because we do not
want to register "normal" console drivers as kgdboc_earlycon_io_ops.
It is later removed by kgdboc_earlycon_deinit(). I guess
that the code is not ready to handle a takeover from normal
to normal (even the same) console driver.

To make it clear, I would use:

	for_each_console(con) {
		if (con->write && con->read &&
		    (con->flags & CON_BOOT) &&
		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
			break;
	}

And I would do this change as the 1st patch in the patchset
before we change the flag modified by console_suspend().

Best Regards,
Petr

Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3718C034;
	Tue, 17 Jun 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152772; cv=none; b=hG5kAOtywesWIHZvZDUfEEUPiWj3GaCvmCgK8PaWKPcuJCZEYSY3dLOjwFFtIEPNYfsO/g9NFLQinDNh95dvdjaFC282wanr2MvbNHIRLp1kVqdBjLADEHc1w2g7FTAJFjaHFN78GVkNdwXw8/a8YpL4aDpso2mpM+AjHXISnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152772; c=relaxed/simple;
	bh=q7w5+CTnJ0yLDPAwJSUlND9pevORmQQFzUJ/Y7Mz7jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBjxUzxQoPLKMDoYMz8d2j6p7c4x5PsD5tkmBFxmtLR19c4TtGPP3ViMUd6R/Eq1ZERIUcfwEp2U6H4Ccba43aPrWLwS2JqmK1vNVImbRrMjNtopP5AnooYMBAUu3RTlAvjIEY0B8QVwffxZARdMboqG/QcZKGjJD3SGWwvqAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5313ea766d8so1330083e0c.0;
        Tue, 17 Jun 2025 02:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152767; x=1750757567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpyRO35mdNeXwjpxX8WgCP2jvjoVuRIOBEbtU0BIjNU=;
        b=DsXDtu3+FsLlsxUHAyrHcB2/NNuis0LkaOKaZn/ZB17cib3VPZdKWoic6YkLLROagG
         RxKlOJPu34Z9xgtxVR1hQo8/Hb2Z1fzOtntGltdb14KxidO3VTVKVcEs+KXW4yZ0SmcJ
         QsycMvm3jOE9DC+fVuGhwk07iXb+oIHLxXZJqUVtNXvulpYKPXel8+2prw6Jd+fBXS4O
         iNW5+JaHUGN4AKhwsU4RFSc+/6MwvUlE/jktymftD6q03/l558g6JCpWkuINQLQBqF7O
         v7ebl9zpmohgQIFf8Cu/CwQoqYh0zVfPVsnSu8WEjdJKzgP0qTrRfNtfOPup+IGb2D1A
         QZVg==
X-Forwarded-Encrypted: i=1; AJvYcCWCmK+PZ6Z7yExxaara/Xu9zfTKfD4lOhX18j1qNvPxn3U7WftjOyphHlExTmPjW40pOJse7s6SqQ1URV/n@vger.kernel.org, AJvYcCXTQfjHg7vF+CYTB4XjSdQ+9B0xqXwHbTpplz6Vq0TDOLwI5Zdjg1yaj6TWOs0IyiIZARM0b2E87ac6ack=@vger.kernel.org
X-Gm-Message-State: AOJu0YydLiqWDtSdXALwtW8t9ZYaRB9VUj78dhT//naPPS8WYjRgCkw3
	bVqK9keRgACvZMeuwmch9Tj4FXft3viaeb3OVKV6nuaL0k1n9wwA4F2BFY1PYogh
X-Gm-Gg: ASbGnctCfo9PDK0skWZCGdKUQzqdh73Y4PpNPN1AlTHwl/P2E4zNzftSWZ1zJb4T3jO
	Y91X6O60WzDOAjMMA2kCdhdQKzELCJOPvM1zb4DN4s/4LTl/bjOgl3xX9+oPiaVzrGjxHJAdFEE
	XLq24MkIGJ6uIh9PL4Xi1O1V+XVg5GMHnfSZmj8qqhJBEeljEeZf0p/IfSOyoHYQkEM/Y7F1vkX
	pEjpPm2w7zNN9SUY0VgEsKtTsa2ynlC0hSeNHBY6ts3mIAq4tTIqHbu5muUiRrjIuVmOtBpEhfq
	oLkeltXhXVGBbluVQBfaJnPRUDq0nus/wNqEKfxDlv2NWLi3Cwo4d2KN23brHMp+AI2XWvR7Uj0
	J7e+WfPZdDcz5bzsjcB1mcCFDNtXSHWvNV6zxvKg=
X-Google-Smtp-Source: AGHT+IH9XZjos/K8EMOSEmRI9McTtuJvEjHbJ0fJCrOsgyj2bTk11VwH98wTG/uLCl4cOQOaK0TIkQ==
X-Received: by 2002:a05:6122:2b1a:b0:530:720b:abe9 with SMTP id 71dfb90a1353d-531497442d1mr6333258e0c.7.1750152766999;
        Tue, 17 Jun 2025 02:32:46 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5313dd7a7c4sm1559455e0c.1.2025.06.17.02.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:32:45 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5313ea766d8so1330067e0c.0;
        Tue, 17 Jun 2025 02:32:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzPy8xNPBNnVD4uU/ZBuYKChj4uZyviEbhXE0XzwvKgvA3ADZp/hnn4oaij9FxApw/Y/1MjnPbXfg3UYk=@vger.kernel.org, AJvYcCXy+Z3X3BRlMv+GOEEulz2G3vylJt9u1XT0t6W/1NDkjiiONFSw152peP3M3vAuVQjQ3iIoB8m4PDGIusFw@vger.kernel.org
X-Received: by 2002:a05:6122:547:b0:529:2644:8c with SMTP id
 71dfb90a1353d-531497d3ee3mr7253853e0c.8.1750152765304; Tue, 17 Jun 2025
 02:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-7-f427c743dda0@suse.com> <aFAkD2i0ceH6qYQz@pathway.suse.cz>
In-Reply-To: <aFAkD2i0ceH6qYQz@pathway.suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Jun 2025 11:32:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXN4Xf1o03cYU3ug_gRdFtBXJC5Nvvt9U6UeP=U2AQTTA@mail.gmail.com>
X-Gm-Features: AX0GCFtvZQSD4F-97UDxOqiDqN4VEggSrDhztYpPcqEOiEQEvpc1f_0ccYJ9a2M
Message-ID: <CAMuHMdXN4Xf1o03cYU3ug_gRdFtBXJC5Nvvt9U6UeP=U2AQTTA@mail.gmail.com>
Subject: Re: [PATCH 7/7] printk: Don't check for CON_ENABLED on console_unblank
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Mon, 16 Jun 2025 at 17:27, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2025-06-06 23:53:49, Marcos Paulo de Souza wrote:
> > All consoles found on for_each_console_srcu are registered, meaning that all of
> > them are already CON_ENABLEDed.
> >
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  kernel/printk/printk.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 658acf92aa3d2a3d1e294b7e17e5ee96d8169afe..8074a0f73691cfc5f637361048097ace1545c7c0 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3360,7 +3360,7 @@ void console_unblank(void)
> >               if (flags & CON_SUSPENDED)
> >                       continue;
> >
> > -             if ((flags & CON_ENABLED) && c->unblank) {
> > +             if (c->unblank) {
>
> It might actually make sense to check is_console_usable() here.

My first thought was: one more to convert to a better name!
But the actual function is already called console_is_usable() ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

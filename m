Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F34238D34
	for <linux-serial@vger.kernel.org>; Wed, 12 Mar 2025 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786971; cv=none; b=JXOpBYc0M5oQpZGXBRamKi3egPERBwvrTeY6BXH666T82LsdJM9kDqta+AGNSEMbbRu7zVWSLOP99f+whqx/+TIzD97g0AcxEUQRGntYKmQ15lqcW2retA9W8KlO/uIpf2BqB18cJLI17qFgO2WbjXk/wwOP6+t6mYXOV93jpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786971; c=relaxed/simple;
	bh=mTQmbOpwPB9pHwv2w8Sm4aaZLhSRhEt1a/8lwIIgvZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLcCBgArP5C4is8PAD7ykdE+H8BWKU/MS9R6JcWAiKr1Gk4ub+IwZ0yyG6vGD5lwam5W+jnQqcFk/52zsQuUQpFLfOvOLutaOWrpIcpk3GjziSMUyou39BT4mO8oQq87KSYbPO3MW39XgMXysLaqNdbw84EA/9/yNauNeszdDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QSvyL0lB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QSvyL0lB"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913d45a148so2946883f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 12 Mar 2025 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741786967; x=1742391767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TRL+XzLRP8H1n4f8VQBF9LgIUiEPLdcwsw8vod0mrbw=;
        b=QSvyL0lBI/hJ72R7Bs5cC9zFX3wIKA8NCb3xsUMqyt36yxByx7bcjjbeorv7GbgBXv
         6qBPgpDi33Sif5Gha00t4FDzAoXwW9eCbQfWjgqDubP3TMq89U5XIlL7n3dlc1yMvmAl
         ldVJmNccUMmhmKz2ec/JNKvA3FZslAIzhc0TCC9f/ZAB+vitK6AmIegSJMjdXMMaK5hc
         eVA0/OM/cQDYswmoCHjx9SJ9K7emqRcUgUPmEuyBjZqsAD06DKchOMDg/c/o9DcVXHM4
         zoNYWYWmMv+jR+PARHYp4+rJMPLjwZMLI5VSxM5ylz+hpEsBG3qg2IYO7KgZoBdXeUOG
         GuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786967; x=1742391767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRL+XzLRP8H1n4f8VQBF9LgIUiEPLdcwsw8vod0mrbw=;
        b=CdB5uhpGNoev4o8fWwX1zYkgmeNL3w2lqIQ4fp9UoG7YPs+SqDVX12VlWtPY9C6sny
         xgZIPxmz0qkvKzhNCO9QzkszoLJFCgg9G7aX9yXMmvI0Z90lj5zazshtfXVvBK8Lph3a
         gSxJYJ40Z5cA8Tc0ttVsWrl1E/RbtbaWu9y2OXIIGzsQCJOzFLVXEwjnyeM4or8ImXVk
         9vQzfzV70VAkCUnV+z4iHoEZ96huzk4SbfGHsVkqX6CSwcy80dmAe5xkAjKRvYl6cUac
         /dvZp35dcxR2ZfpEPgsEiJuiEnB/4QmI/e4/3qlzGbheQq1YPT/v1cTaLeG0WCodyjLw
         fbsg==
X-Forwarded-Encrypted: i=1; AJvYcCUXzsx1AOK9R+TkF7Et41yVmZfcH6p7bfv7lE0n9xpEKob5KqkRqGVQMPKLVHowtnInlA1ThZbnGCQcQWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNG7SeEkp6HPeaHJZNlAcwLFQtyy33dYLuRxQplA925/QOVSJ
	S0jYg/NtbgLnglaLXOqC2jcz6NjIrOc5xFnuw/D4/9Q1eH3vSxQSoQJfEoVsqxU=
X-Gm-Gg: ASbGncvT65voOkHulzaj+0vmL1spkfhwxXNdOz9uV3+bOPphKdMXzOtl4QdWTh/5UYA
	mAESJGOSRjdBefuwbxgKjYbX5z9nOQtj1cxHyzm0gtkr2F3AuOSLjMDluxS83xjHh5dbXTuIBjk
	IWjJoGNM7qGxjJEAf9qgHcXD1l1A4uMojM6bB2rwRmiQiff/QY3BKN6icYIaDReCn9ETrfwl07p
	AeCZZ02NVxbrBMFPH6tZuhRHAz3xP3BE/uCQjSU+wtMwJ7IOBDvf/sQ+kauKaTbnw5UxW/xYUNE
	eoYgCqi18zcyrK6vWW6lvHxAYFbWo5hhVzxlKmn+fGXtYEs=
X-Google-Smtp-Source: AGHT+IHFQzTn4zPksAQ8B6QTY+mXcs727bLPbUIT+fCCiNEek6fqMg+/r97172WN0N8oMR4cP0dBRA==
X-Received: by 2002:a05:6000:144d:b0:391:139f:61af with SMTP id ffacd0b85a97d-39132d8c768mr15352561f8f.32.1741786967439;
        Wed, 12 Mar 2025 06:42:47 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a7a455dsm21742895e9.40.2025.03.12.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:42:47 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:42:45 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Adam Simonelli <adamsimonelli@gmail.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v6 3/3] tty: Change order of ttynull to be linked sooner
 if enabled as a console.
Message-ID: <Z9GPVVTnngGbmbuv@pathway.suse.cz>
References: <20250304035447.3138221-1-adamsimonelli@gmail.com>
 <7969025.Sb9uPGUboI@nerdopolis2>
 <CAHp75VfadXS8Z2G6U_DcOOZFFmaOSn_9uQN_N7Psse3kiSGj0g@mail.gmail.com>
 <4451040.8hb0ThOEGa@nerdopolis2>
 <CAHp75VdogqwA2qJBp5Sp-tuJbKvmj9mLuop8GZP+vLVeJNg2DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdogqwA2qJBp5Sp-tuJbKvmj9mLuop8GZP+vLVeJNg2DQ@mail.gmail.com>

On Thu 2025-03-06 09:10:29, Andy Shevchenko wrote:
> On Thu, Mar 6, 2025 at 6:22 AM Adam Simonelli <adamsimonelli@gmail.com> wrote:
> >
> > On Wednesday, March 5, 2025 1:52:00 PM EST Andy Shevchenko wrote:
> > > On Wed, Mar 5, 2025 at 4:06 AM Adam Simonelli <adamsimonelli@gmail.com> wrote:
> > > > On Tuesday, March 4, 2025 1:51:52 AM EST Andy Shevchenko wrote:
> > > > > On Tue, Mar 4, 2025 at 5:55 AM <adamsimonelli@gmail.com> wrote:
> 
> ...
> 
> > > > > >  obj-y                          += vt/
> > > > >
> > > > > + blank line.
> > > > >
> > > > > > +# If ttynull is configured to be a console by default, ensure that it is linked
> > > > > > +# earlier before a real one is selected.
> > > > > > +obj-$(CONFIG_NULL_TTY_DEFAULT_CONSOLE) \
> > > > > > +                               += ttynull.o
> > > > >
> > > > > Here is the question: are you sure that all console drivers that exist
> > > > > in the kernel happen to be here? Have you grepped the source tree for
> > > > > checking this?
> > > > >
> > > > Grepping for console_initcall, the only other places I see outside of
> > > > drivers/tty/ is
> > > >
> > > > arch/mips/fw/arc/arc_con.c
> > > > arch/mips/sibyte/common/cfe_console.c
> > > > arch/powerpc/kernel/legacy_serial.c
> > > > arch/powerpc/kernel/udbg.c
> > > > arch/powerpc/platforms/powermac/setup.c
> > > > arch/um/drivers/stderr_console.c
> > > > arch/xtensa/platforms/iss/console.c
> > > > drivers/s390/char/con3215.c
> > > > drivers/s390/char/con3270.c
> > > > drivers/s390/char/sclp_con.c
> > > > drivers/s390/char/sclp_vt220.c
> > >
> > > Which means you need to test your stuff on those cases, to see how the
> > > linker order is done there. It might be that your change wouldn't work
> > > there as expected (quick workaround is to mark the new option as
> > > depends on !S390 && !PPC and so on.
> 
> > It will be difficult to test other arches, I mean I guess it is possible with
> > QEMU, and cross-building, though I did do an experimental test on x86:
> >
> > Making it temporarily adding an architecture specific console like
> > powerpc/some mips/s390/arches with Xen enabled.
> 
> Thanks. Make sure the summary of this gets into the commit message.
> Also consider updating the relevant documentation under
> Documentation/, if any.

Honestly, I am not sure what is the preferred behavior here. I am not
familiar with the arch-specific consoles.

But it made me think and investigate the various console drivers.
It is a kind of a mess and I am not sure that I understand it correctly.

Anyway, I suggested to use "add_preferred_console()" in console_initcall()
in the v5 review, see https://lore.kernel.org/r/Z73teICMWNx7BiHT@pathway.suse.cz

And I expected that it would be enough and the hack with linking order
won't be needed anymore.

Now, I see that I was wrong. The problem is that many console drivers
call register_console() in console_initcall(). Such consoles would be
registered by default when their register_console() is called before
the ttynull.c calls add_preferred_console().

By other words, the hack with the linking order is still needed to
call add_preferred_console() in time.

Resume: From my POV, the solution with add_preferred_console() in
	console_initcall() still relies on the linking order.
	So, v6 is not better than v5.

	IMHO, v6 is actually be worse, see below.

> > -------------------------------------------------------------------------------
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 05c5aa951da7..bcd248c44fc8 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -1159,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
> >
> >         e820__setup_pci_gap();
> >
> > +       add_preferred_console("ttyS", 0, NULL);
> > +
> >  #ifdef CONFIG_VT
> >  #if defined(CONFIG_VGA_CONSOLE)
> >         if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
> > -------------------------------------------------------------------------------
> >
> > to see what /proc/consoles will look like, to pretend that x86 is an arch that
> > sets a console somewhere, and I get:
> >
> > ttynull0             --- (EC    )  242:0
> > ttyS0                -W- (E  p a)    4:64
> >
> > and I got console messages to ttyS0 with no issue.
> >
> > which in my mind is acceptable I would think. ttynull is first in the list,
> > which is desired effect of CONFIG_NULL_TTY_DEFAULT_CONSOLE, it doesn't have to
> > be _exclusive_ AFAIK, especially if there are long-time default consoles that.
> > users or the hardware expects.
> >
> >
> > The only arch that seems to _unconditionally_ add a console without some other
> > circumstance, like boot loader env var, and command line option, or firmware
> > flag, or suboption (like CONFIG_SERIAL_PMACZILOG_CONSOLE) is Jazz.
> >
> > Like platforms/powernv adds it if CONFIG_HVC_OPAL is disabled, or the firmware
> > is missing "FW_FEATURE_OPAL". I would assume that a user of this situation
> > turning on CONFIG_NULL_TTY_DEFAULT_CONSOLE in addition, will just get ttynull
> > and hvc in /proc/consoles instead of just hvc. Could that cause something to
> > break?
> 
> > Correct me if I am wrong, I could very very very well be wrong.
> 
> I leave this to Petr to comment as I'm not that expert in the area.

It depends on the expectations. I see two possibilities:

1. view:

   CONFIG_NULL_TTY_DEFAULT_CONSOLE is disabled by default.
   We could assume that people would enable it only when they really
   want to use ttynull for /dev/console. And they do not mind when
   some other platform-specific console is enabled as well.

   Note that we do not need the hack with the linking order for this.
   A solution is to call add_preferred_console() directly in
   console_init(). It has already been used in an earlier version, see
   https://lore.kernel.org/all/10194425.EvYhyI6sBW@nerdopolis2/

   To make it clear. I consider this as a cleaner and more reliable
   solution than using the linking order hack.


2. view:

   The new config option wants to prefer "ttynull" when CONFIG_CONSOLE_VT
   is disabled. So, it is an alternative for "ttyX" from "vt".

   A conservative approach would be to enable it by default in the same
   situations where "ttyX" from "vt" is enabled by default.

   To make "ttynull" behave the same as "vt" would require using:

     + register_console() in console_initcall().
     + the same console_initcall() ordering => move ttynull.o
	    linking order

   => going back to v5 approach.


I would normally prefer the conservative approach. But I hate the
dependency on the linking order. It is so non-intuitive and
fragile.

So, I personally prefer to call add_preffed_console() directly in
console_init() in the end. I guess that
CONFIG_NULL_TTY_DEFAULT_CONSOLE won't be used on architectures
with a better native console. So, it will be good enough
in practice.

Best Regards,
Petr

PS: I am sorry that you have already sent two more versions
    in the meantime. But I was not able to answer this quickly.
    I needed to find time and understand the various aspects.

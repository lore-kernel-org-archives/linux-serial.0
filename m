Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EDE311C0C
	for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727938; cv=none; b=KsFek7Qa0rY1zv0vampkW1udw9fXEmn0xSG5TRg93qamVEcDrwb90XCayW84thIry69VgSxqVT0HyQ20zagzl/nkcRrLvk2jUA1uiegybDhQ+LDqdqmIe5O4/iEI6lBTn8VMZXOIue+suBGrMZGRhDM0XnnFDZthYGgN9+/+dyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727938; c=relaxed/simple;
	bh=lXkqiFRoO59/Ufx7OxqzsjNwUUA6MMMGcCPsezc9mAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW7Pco3D261ejwjVsyIdBacnMY4+fuw13qGlNTd1TI27iSTXxNrnSA7BQ1AkNaM0L8QhN9O7d/IdgZ5XugiOuAAP904bplB2yOXL/JV3MVX+VcHBN2e3q6MQF/CbwQ7rPwjPzWdibIQouz7Dg/bROpsg6u92BmqvSydV24/d1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KItbkweM; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KItbkweM"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd630so8528484a12.2
        for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2025 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758727934; x=1759332734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0I65Cdfmrr8vZUIQrq2WUvttPueHtjZMKXuWscVZDM=;
        b=KItbkweMfMgmPpwvkGWGyBTf/HexmpuHsK+QPFAOqFBcO8TBMW4GPrZ2K3dS5ughAk
         s607mThzM5INgfL/4gDh2P6SKmHvha7+JTnZC9vIRDlzeh47W2f9O5cVZSh72jlKKY++
         yHT2ZU7fUeWd2d7z8H0z1UDNCJ98B/o3kQcg3v5BGAzfXfkm55GfhJlmIHIfXVI2+Y3J
         aVaTczESvTder1+kL4UNJDubOTKD9rAoJIciysqBn9XA4OIgthRb934NhBydjN0VJSDF
         pBZQqrUuuUvGK4qNV/Ve8tDQ+doGWs8qvryxEIz7K0TjW/9F5Cvn+e1B2kwEzkXV93ev
         R+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727934; x=1759332734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0I65Cdfmrr8vZUIQrq2WUvttPueHtjZMKXuWscVZDM=;
        b=xBDJ8EUeYyVIjk6aJXEd4RtR2pQo0bOK2yyfCKgNWOjDOWl4qG2670N1vv3w3ZWc0T
         aCoBrXKWGoA2Xg5X2M9gEgTxt+WYgy4YTYh/EZWUa7C2pWWZxZVMpVl5woADES8Jsihi
         e/DMbSBBbtnvdWDbEf6yWjd+CMWlfTKIbBQKoLu/fA4IDdL1vKV5j1WSa7Dyi7Iypsfa
         KZ00EQiQMyfnl7pGeH1XKNfSYnTn1hOBGuQ3cZbfp5cUfL5AP44jShwinvgMlVEXWHwp
         s/sGMGe9BMI1n75AJCMwAEZu6+9kdb2cm5k/sFa3WwfgxTGKDtMrko9kWz66yCpIo3yD
         sDYg==
X-Forwarded-Encrypted: i=1; AJvYcCVNDABnYzpKVV3IjodW9XGTe/uouKKt32QuPl2mQgXD07IsUFi6mZuyS7MG2ljCcA2NA2dtBxJxRw3BBjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPE2q4zyqGa5Q6BjDXYhVkajVTVg1xJtHdbqUGB/poX6WN4k5
	QMWjzgA/6sPF9BbtZ9hTvPLq8WZxOK0TrS02aqLTT48Xeim/Qebfu6MvkBpsC+Jb8xTzF2J13g7
	ZxKCM5hsE5g==
X-Gm-Gg: ASbGnctiEVYjEDuc8jkS4/Zm04GlUwGECfouv1o4XedLZBZgXtfBouT10e1g8GhaGuq
	aomlRvfgwcVFraq02LFagPpHWLBx6tXC5EcFWmyX6TQh1FEPzFyENxzsq8KUaofHOYP2XIAunU6
	76PsZ9kHPWfJlQ/UkrSVC+IKz5z4xFKUTqcNVkkpivVl3izUmLyFV9xIze/D2oNoUs8BQixZvQ7
	4V6S6zhaCQEm4nSeXO9kwbmo/m+Cn+kMKM4mnb1zgqJv/WH6sqBjYUg7iPVahzPtckIMCfd5DS/
	jq3JIyw1lF1gLQPnOeETo89oOuCwIrltpwI/w2jtoekTWgw+4bNaoAAXJm+Dw3eTZ+ZbqsHjeFU
	yVTf5eGUW15VN2mpNTI5b/aI1ig==
X-Google-Smtp-Source: AGHT+IEpn8Hn2X8eRiAhhuk5c3P2Whqu7kOKOowHkUsxQ8AlS3TiHZmNBrhAKSKtCijMma9Ejf27AA==
X-Received: by 2002:a05:6402:354b:b0:634:505c:fc9a with SMTP id 4fb4d7f45d1cf-63467786e4amr6322787a12.10.1758727934318;
        Wed, 24 Sep 2025 08:32:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d06a15sm13439978a12.1.2025.09.24.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:32:13 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:32:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [RFC 0/1] serial: 8250: nbcon_atomic_flush_pending() might
 trigger watchdog warnigns
Message-ID: <aNQO-zl3k1l4ENfy@pathway.suse.cz>
References: <20250822142502.69917-1-pmladek@suse.com>
 <84qzwzbr90.fsf@jogness.linutronix.de>
 <aNFR45fL2L4PavNc@pathway.suse.cz>
 <84348eju8a.fsf@jogness.linutronix.de>
 <aNO7Qjv_iSUSifTv@pathway.suse.cz>
 <84348crpi3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84348crpi3.fsf@jogness.linutronix.de>

Added Andred Murray into Cc.

On Wed 2025-09-24 14:48:12, John Ogness wrote:
> On 2025-09-24, Petr Mladek <pmladek@suse.com> wrote:
> > I tried to implement some naive solution, see below. I think that
> > it can be described as the 2nd layer of ownership.
> >
> > It does not look that complicated. It might be because I used it only
> > in two paths which do the writing. And it is possible that it does
> > not work properly.
> 
> It is an interesting approach and is one that I tend to prefer.
> 
> > Then I got another idea. It might even easier.
> >
> > I think that it might actually be enough to block the kthread when
> > any CPU is in emergency context, for example, by using a global
> > atomit counter.
> 
> This is the quick idea that usually comes first. Basically introducing
> an emergency_in_progress() to keep the kthreads out. My problem with
> this is that it causes _all_ consoles to synchronize with each other,
> which we worked hard to get away from. Yes, I realize Linus rejected the
> "store the backtrace, then print it" implementation, which limits the
> effectiveness of parallel printing. Nevertheless, I would prefer to work
> towards returning to parallelization, rather than reducing it further.

Let me play the devil advocate for a while.

IMHO, keeping the kthreads running in parallel for a synchronous
emergency report opens a can of worms.

Yes, the kthreads might be fast enough when the emergency context
is busy with a slow console. But they might also cause repeated
takeovers for "every" message when a kthread starts emitting
each new message just to lose the ownership after few characters.

Honestly, blocking the kthreads during an emergency does not look
that bad to me.

> > I am not sure if you already started working on it. I rather share
> > my naive ideas early so that I do not duplicate the effort.
> > It is possible that you have been there.
> 
> Thanks. Yes, I tried various ideas like this. But your version does go
> about it differently. Although I am seeing the same problems. My
> comments below.
> 
> > +void nbcon_context_put_flush_prio(struct nbcon_write_context *wctxt)
> > +{
> > +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> > +	struct console *con = ctxt->console;
> > +	ret = 0;
> > +
> > +	if (!nbcon_context_try_acquire(ctxt, false))
> > +		return -EPERM;
> 
> This is my main concern. If a context has set the flush_prio to
> something higher, it _MUST_ set it back down later. This cannot be best
> effort. A failed acquire does not mean that a context with the same
> priority is the owner (for example, it could be a NORMAL context that is
> in an unsafe section). Remember that there are owners that are not
> printers.
> 
> So now we have a similar situation as nbcon_reacquire_nobuf(): we need
> to regain ownership so that we can undo something we setup. And that is
> the problem we are trying to solve in the first place. Maybe since this
> moves the problem from NORMAL to EMERGENCY, the busy-waiting is
> acceptable.
>
> As you mentioned, there is the problem that the flushing context could
> change hands multiple times before the flush_prio is restored. And there
> is also the recursive case where a WARN could happen within a WARN, or a
> WARN could happen and then in an NMI another WARN. All these cases
> probably mean that it needs to be a per-prio counter rather than simply
> a single prio so that each context can increment/decrement their prio.

Thanks a lot for showing all the problems.

It might be easier when we combine it with the first approach. I mean
to block only the console-specific kthread from
__nbcon_atomic_flush_pending_con(). By other words, block
the kthread from __nbcon_atomic_flush_pending_con() instead of
emergency_enter() and store the counter in struct console.


Summary:

We currently have the following solutions for the original
problem (hardlockup in nbcon_reacquire_nobuf()):


1. Touch the watchdog in nbcon_reacquire_nobuf()

   Pros:
	+ trivial

   Cons:
	+ Two CPUs might be blocked by slow serial consoles.


2. Yield nbcon console context ownership between each record
   and block all kthreads from emergency_enter/exit API

   Pros:
	+ Only one CPU is blocked by slow serial console
	+ Prevents repeated takeovers for "every" new message

   Cons:
	+ More complex than 1
	+ Completely give up on parallel console handling in emergency


3. Yield nbcon console context ownership between each record
   and block only one kthread from __nbcon_atomic_flush_pending_con()

   Pros:
	+ Only one CPU is blocked by slow serial console
	+ Parallel console handling still possible in emergency

   Cons:
	+ More complex than 1   (similar to 2)
	+ Possible repeated takeovers for "every" new emergency message


Well, releasing the console context ownership after each record
might solve also some other problems [*]

I am going to try implementing the 3rd solution and see how
complicated  it would be.

It would be possible to change it two 2nd easily just by
using a global counter and updating it in emergency_enter/exit API.


[*] Andrew Murray is trying to do similar thing with console_lock
    and the legacy_kthread, see
    https://lore.kernel.org/r/20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk

    He told me off-list that he saw similar problems also with nbcon_thread.
    I am not sure but it will likely be related to
    __nbcon_atomic_flush_pending_con() blocking a nbcon console context
    for too long.

Best Regards,
Petr

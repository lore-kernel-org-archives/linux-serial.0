Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF935C1BD
	for <linux-serial@vger.kernel.org>; Fri,  2 Oct 2026 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928866; cv=none; b=C0on0WW4wlNZmoKEYwOTB/Jow8vmAShKAjt4rqQwrVwUGaD2AAUBLQ5eqCru+UOSQztQcs/oiz/z/njXvAGAIvAHo6StdWjjR7fZE9sgFiAQfZO00DoOXgl38vr5dD+m4rIC7UhP+Xoai4eBVordV/t+aLDp8QgB3ecgw7v2OIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928866; c=relaxed/simple;
	bh=lUjsj/zkzOnzY9LSr0WPam4i8+l8opVo1V9Pswn+IGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia8LS6femYGek5FSPooJT7fxQo7qE6w1T6i6D34hRqwucxVGUEeRkh8ogqvWMOzT1Nj0JBmlymRz9Ucx11msGu/6JiaT5z+lq0Ar5Nmyn8EqPHAJEBni1pu84+KuvPTofsIIveR0doFXd20M0hblEonPIbA7i79OjBVTgO6Xb3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EmMScdV2; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EmMScdV2"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b059eae96so1642024f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 02 Oct 2026 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790928862; x=1791533662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B2gYiRdzNQHv1M+pzNmzpe4igCpVm4DThoeMguavKds=;
        b=EmMScdV247d75hz0AkZ9YFJZDM6oNPY3NKIi8+4k8uHP8QcQq4fRJ1ht1aODupjDTE
         UxIvEVQ4OvZANgszYyNWMJiQ11u+kK9XhKGdysKIJlEoVM2jVw5z9HYXNrkQKKoQ0KFv
         u0lSYRNXN7HHn65xXwzMR5p4LZW1mTa62nFwi38j5yoJVYuZhtfFrK0uAW6lNPZaDANY
         2oL8WNX78bkjLmPqpP3tyJgHAtXcXVj9HJpcoOSU868SXczXc89pqgKrgQWNEHwG7i0U
         kMI/o0KNIgTS7M4VdYjBjvcmWukbVAwq4D5008TiR1yc2S+c/KOxS64nV3amUgSurx1X
         pEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790928862; x=1791533662;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B2gYiRdzNQHv1M+pzNmzpe4igCpVm4DThoeMguavKds=;
        b=eeuXepj2GX8Fu/P1PBCToUeyMqo4ZcXdnzH12GoR7LpzOWSFOnu8CprMJoAJfdnBAd
         hM522pRqMzpGurHXEBHfWFg/EPoRWRmr++QGQYc3FHPaZnO/J835kgqdndkqm4CKFT7T
         8Kp3x1EO1JFsJM9UDoNggHaenT/4OtvtIBo6YDy6sDLn+1HdkZrYh0YCf+sZyBBuhWLX
         lM3ZS3gNfKBmFB7sKrhAg5nJFvso/yIXGm0pcCYnJKNVu1eIDIa5WwX1HPzA1nPRMGEY
         /6cd/7doYFzUzPRK57oqSad04HrjydS9/pfSC9rzjC3Np23pPcds8Ri5kHnnz4wbyX8u
         Ggsw==
X-Gm-Message-State: AFuF++mANMNRUh52I7nHhXsTL1fTvlicIn9fh5NjDrN+a978YMjoYz4k
	dyOIOeFIju8SV9PllFkDM6MEGikeJZSMPgYDBFYcW1b/QK0cdWcD0f2KIAknuazoHyA=
X-Gm-Gg: AYBFou3JUklfpBcWT239ud+3qiRVRDr61oTNbwUfc3ghjg3GoDmBWkudRrH9Nd+DR3w
	58TztKaA5UOG7yleeOHcjf1q3q1qgJBAU5e8K0eS39Id9IbJ/wT3kb/M5u/08BBhFIpZQlIHvFp
	hbvQ6HEAsswJVt14Mvb6rjk8OTD/WvQAlFngljPQsz8HD3Vz8BqWopuYAuJ+Nmhsl/PAb88r0rr
	MjIvt3aWqEo3GGfhuf1MbYPWCpNshHhDUsy3B7f/OeiEBUEWFVulHg6rEoCsC7rs0vVz/F2BPck
	rZhPEfy7mM97o/RjXrEUf2ZbQFOPbB8dHjzxsysOHhglcTXa99oWqbzQoB8cAKmZgyOJaYi0nO6
	lTZFutHN38BlEuD3spxNROG8lkzQXJNlSZL9k5Z+vyC1QGw1YAQflzJis8R536lowj7KJegYKbe
	ndQXEgpuEF+g0hW/ndUp615rVHxQx+Nd4k1uZgajEybsdh327FpOy4rIiBFdtw135tKvt3Zhkn
X-Received: by 2002:a05:600c:4454:b0:49f:f922:1dc1 with SMTP id 5b1f17b1804b1-4a0276a0e46mr32937455e9.28.1790928862090;
        Fri, 02 Oct 2026 01:14:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027734b49sm64339675e9.10.2026.10.02.01.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:14:21 -0700 (PDT)
Date: Fri, 2 Oct 2026 10:14:19 +0200
From: Petr Mladek <pmladek@suse.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/1] braille: nbcon: Allow to use a serial console
 with NBCON API as Braille console
Message-ID: <ar9n2__RhOeiXRgC@pathway.suse.cz>
References: <20261001140727.124398-1-pmladek@suse.com>
 <20261001140727.124398-2-pmladek@suse.com>
 <20261001142407.84C721F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001142407.84C721F000FF@smtp.kernel.org>

On Thu 2026-10-01 14:24:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] console: deadlock in braille_write() from atomic/IRQ context
> - [High] console: infinite loop in braille_write() when CONFIG_PRINTK is disabled
> --
> 
> commit 0bb1344e643dce4e38416fdf04095c16fe6023c8
> Author: Petr Mladek <pmladek@suse.com>
> 
> braille: nbcon: Allow to use a serial console with NBCON API as Braille console
> 
> This patch integrates the Braille console with the NBCON API by allowing
> braille_write() to attempt acquiring NBCON ownership before writing. It
> simulates the original locking using nbcon_braille_try_acquire() and routes
> output through write_atomic() or write_thread() callbacks.
> 
> > diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
> > --- a/drivers/accessibility/braille/braille_console.c
> > +++ b/drivers/accessibility/braille/braille_console.c
> [ ... ]
> > @@ -62,14 +62,50 @@ static void braille_write(u16 *buf)
> [ ... ]
> > +	if (braille_co->flags & CON_NBCON) {
> > +		if (panic_on_this_cpu()) {
> > +			/*
> > +			 * This should be good enough in practice. Most/all
> > +			 * serial console drivers have the atomic callback.
> > +			 */
> > +			if (!braille_co->write_atomic)
> > +				return;
> > +
> > +			local_irq_save(flags);
> > +			/* NBCON API strictly requires the ownership. */
> > +			if (!nbcon_braille_try_acquire(braille_co, &wctxt)) {
> > +				local_irq_restore(flags);
> > +				return;
> > +			}
> > +		} else {
> > +			braille_co->device_lock(braille_co, &flags);
> > +			while (!nbcon_braille_try_acquire(braille_co, &wctxt))
> > +				cpu_relax();
> > +		}
> > +	}
> 
> [Severity: High]
> Could this lead to a deadlock? braille_write() can be invoked by VT
> notifiers from atomic or IRQ contexts (e.g., from keyboard interrupts or
> console_flush_all()). By calling device_lock() and spinning on NBCON
> ownership with a cpu_relax() loop, if the interrupted context already holds
> the lock (like an active nbcon flush), nbcon_braille_try_acquire() will
> permanently return false, causing an infinite busy-loop.

The short answer is that we should be on the safe side because it
used to work with the legacy uart 8250 console driver which took
port->lock as well.

It should work when the code under port->lock:

   + is called with disabled interrupts.
   + do not call VT code (the is no reason to do so).
   + use only printk_deferred() (or better no printk() at all.

All the conditions should be fulfilled. Otherwise, it would cause
deadlocks even when the serial console driver is used for printk()
in the non-Braille mode.

> [ ... ]
> > @@ -102,7 +138,24 @@ static void braille_write(u16 *buf)
> [ ... ]
> > -	braille_co->write(braille_co, data, c - data);
> > +	if (braille_co->flags & CON_NBCON) {
> > +		nbcon_write_context_set_buf(&wctxt, (char *)data, c - data);
> > +		if (panic_on_this_cpu())
> > +			braille_co->write_atomic(braille_co, &wctxt);
> > +		else
> > +			braille_co->write_thread(braille_co, &wctxt);
> 
> [Severity: High]
> Does this violate the write_thread API constraints? The
> include/linux/console.h documentation specifies that write_thread must
> strictly execute in a task context. Since braille_write() can be called
> from an atomic or IRQ context, invoking the kthread-specific callback here
> could be unsafe.

It should be OK for all the currently converted serial console drivers
which are candidates for the Braille console. We might need to revisit
this in the future.

> > +	} else {
> > +		braille_co->write(braille_co, data, c - data);
> > +	}
> [ ... ]
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> [ ... ]
> > @@ -678,8 +687,14 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
> >  static inline bool nbcon_kdb_try_acquire(struct console *con,
> >  					 struct nbcon_write_context *wctxt) { return false; }
> >  static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
> > +static inline
> > +bool nbcon_write_context_is_braille(struct nbcon_write_context *wctxt) { return false; }
> >  static inline bool console_is_usable(struct console *con, short flags,
> >  				     bool use_atomic) { return false; }
> > +static inline bool nbcon_braille_try_acquire(struct console *con,
> > +					     struct nbcon_write_context *wctxt) { return false; }
> 
> [Severity: High]
> Could this cause a hard lockup if CONFIG_A11Y_BRAILLE_CONSOLE is enabled
> but CONFIG_PRINTK is disabled?
> 
> Since this fallback stub unconditionally returns false, the
> while (!nbcon_braille_try_acquire(...)) cpu_relax(); loop in braille_write()
> will never terminate when triggered by terminal output.

Good point!

But there is a bigger problem. kernel/printk/nbcon.c is compiled only
when CONFIG_PRINTK is enabled. We expected that con->write*()
callbacks will be called only when there are printk() messages.

The Braille console is a new use-case. It uses con->write() callbacks
even for non-printk messages.

A proper solution would be to allow building nbcon.c even when
CONFIG_PRINTK is disbled. But we would need to review the entire
design.

A short term workaround is to make Braille console dependent on
CONFIG_PRINTK. It might be good enough in practice. I mean this:

diff --git a/drivers/accessibility/Kconfig b/drivers/accessibility/Kconfig
index 6b2f79d1f1b8..bd5db30e9aab 100644
--- a/drivers/accessibility/Kconfig
+++ b/drivers/accessibility/Kconfig
@@ -20,6 +20,7 @@ if ACCESSIBILITY
 config A11Y_BRAILLE_CONSOLE
 	bool "Console on braille device"
 	depends on VT
+	depends on PRINTK
 	depends on SERIAL_CORE_CONSOLE
 	help
 	  Enables console output on a braille device connected to a 8250


Best Regards,
Petr

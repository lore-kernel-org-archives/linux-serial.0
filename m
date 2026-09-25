Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9654AC165
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346871; cv=none; b=HrmyPvu6EYskT1g57OvabSkmuQav3zipz1PeEeGtrsNuQUxXqWtG3YzJjczfJfnfLq08sTndJVx3WDF3a785dhPjiFooiOBAH97DfECvnpainZAGSdk3XttcZaSYTbzL/tCWEExAJ4hFjKc0GZRfzKl5qBG3AXx6/4OtkIURwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346871; c=relaxed/simple;
	bh=il+wEG3AtIzGlK5bGCdksKp2QOycmjV+Bh3XYtN8+zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsmNDGYrl3+lhL4MmfQujdwZxmtbsrYHa5rZYrlgksB1lqmJJ8oqwJ7aGma4s5BY/2QKPUBeAXQUT7Jo82/L2VD57w5P1f0CC9kz1HxOHZK/v+ftDeuwqyc1ZHF6mH7wXr2wtVX2ipbnOqqPPOEzrvtOfALggyr044bl+mTQG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ugf+amk1; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ugf+amk1"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so6080545e9.0
        for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790346858; x=1790951658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+cqV5QZnriB3z7y6e0i2pSd1fJ+pgI9FmJRPQglWgqU=;
        b=Ugf+amk13rzmWecFPG3tM/+bFAKLpUXi+6bIA7Nc3DwYUxC03FHy3HGO0OoCUG948x
         TBXu47ds6LqxeuiRqARi6cF9xGz682eYCh0fwEa5B9u/pKhzkZiTlXkDStEDBRe9XIj4
         IQHNhTfPbgU7YNAdfIn5kp/fCKPaAiqR3dI5hKK59zANnghmwqzuL/UAIUZLzMGy9PI/
         AAvcR3918jXj1JtMucQn0YKyDl7VZ8ytG1IXf5hgMrsSDziGDoC51kQNVwywrUqDON0/
         UeJE6UYv+A0+EE2caXDs6kglzGOUTOAU5HVq5wHBsU/gn0Q3G4IEfUuHeeO0ueC1TnAC
         enXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790346858; x=1790951658;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cqV5QZnriB3z7y6e0i2pSd1fJ+pgI9FmJRPQglWgqU=;
        b=RF6Sd5zlRSV7VfAOl3M5lQvu0CJeqpxTDraf0acUNvZyiyFgAoPdCAPotNZtn0t7RH
         j7hiodWT9y+Ifl6ljN+SeBkwnyWdlqnerjxiXFlVh89J+23F2fs4sBl/ddbI/8VtVk5w
         F+EXRR3U7fy87W2oD82bMGx6GwQR5w885Vqb1VOiRIKf7/2rQO3ZUFol7qQZeyQlVxtl
         iVXIexbjTGsR21rwhqCg0WqwKKx1ZvQ71DMzHEM/BfpbWgmckJdq82efrQV8docSYnNE
         3SB8UhPUew3kIA+ZMICGJGGG40O9s4Yxy2iH2O+gjzIIq3LtCS14z0FFsQz6oRE+qauw
         vXqw==
X-Forwarded-Encrypted: i=1; AKwUvBw4wYCa3oNk+y536IvS+2ZOf2zifox34UUKZfF/oW5iEfecTgdXZcQAyyfHgtoI1BmaNsoxpnGEKhjRpeI=@vger.kernel.org
X-Gm-Message-State: AFuF++kPuUDfRRWDo5eLga7Yyn/CXXLUqT5tCx0zMhql08N3kbemDaPy
	PbWSkdu1fwfKmA2vwrHIb8N6eBdbsElT0lGXJtWxz6WaMT1j/Dd0rAi71ULJZHUA18g=
X-Gm-Gg: AYBFou34xNB13wc0OLSBFDsDmsltnEPppxyy4MHAfUrwKeg98R+LE54g6caqGf3q7lk
	N8u4/NYJLgvFKN9Og+iLT4So/xh/qA/QtKGdN940IjGqMV8Z9lyJrEkreW37ox37jrk4imSpvpz
	vdJ+hJ2TCaLLI2LuM+fqFCfJTWpZlxkqikhQUC84UKIrm5yQ75vHW3h1IgMNv4psenfOUiiyOos
	unorCQFfJByirUocgugOxfPvFuC3IcrpGJtc7oZQA5zTggaeZv+W+K1/Rc6+qoQw/eagVODgUk3
	wGpsmKrBAAdW9D+iWdzbReRqT6xMozeVvQQHx9kCcUfadJy6PBC97+5mI09K12bvK/LXUrOMWxW
	aJkFkrYL9QW06xOx6exKQxwrthuyAacCUG22cGPOK6xdVXDL0KAus47PxPhoLdRSOou1hZFcrtd
	12mWdTHUq7XVE8p6/FjdbgdvHLJVbEXvxd8UlMJyHAajXJij7td2j4Q5ZLNl5CAy+Z1JVV
X-Received: by 2002:a05:600d:8653:10b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-49fe70151ebmr77731185e9.9.1790346857984;
        Fri, 25 Sep 2026 07:34:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff023f12esm64270415e9.0.2026.09.25.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:34:17 -0700 (PDT)
Date: Fri, 25 Sep 2026 16:34:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: nbcon: Introduce Braille helpers
Message-ID: <araGZN5_ixhM4AXh@pathway.suse.cz>
References: <20260922072558.98854-1-pmladek@suse.com>
 <20260922072558.98854-2-pmladek@suse.com>
 <87fqyxigqj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fqyxigqj.fsf@jogness.linutronix.de>

On Fri 2026-09-25 15:54:52, John Ogness wrote:
> On 2026-09-22, Petr Mladek <pmladek@suse.com> wrote:
> > These helpers will be used when calling console->write_atomic
> > in the Braille console driver.
> >
> > The Braille console is not registered as a standard printk console.
> > Instead, it is integrated with the virtual terminal (VT) and writes
> > data using the legacy con->write() callback of the associated serial
> > console driver.
> >
> > When the underlying console driver is converted to the NBCON API, the
> > Braille console needs to use the con->write_atomic() callback instead.
> > This callback must be synchronized by acquiring the nbcon console context.
> >
> > Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> 
> This is not 8250 specific. But I am not sure which commit you want to
> mark as Fixes.
> 
> For 62627bf0cadf ("kdb: Adapt kdb_msg_write to work with NBCON
> consoles") there was no Fixes tag.

You are right. I somehow though that it was connected with the uart
8250 serial console. But the code allows to use it with other console
drivers as well.

Well, I guess that the driver was created for a particular Braille
device. I wonder if there exists Braille devices working with
other serial ports which are compatible...

I could omit the Fixes tag. But I think that in practice it is
primary for the uart 8250 driver.

> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  include/linux/console.h |  8 ++++++
> >  kernel/printk/nbcon.c   | 59 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 67 insertions(+)
> >
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index 502d1abe3f50..d780f6de303a 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -615,6 +615,10 @@ extern bool nbcon_allow_unsafe_takeover(void);
> >  extern bool nbcon_kdb_try_acquire(struct console *con,
> >  				  struct nbcon_write_context *wctxt);
> >  extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
> > +extern bool nbcon_is_braille(struct nbcon_write_context *wctxt);
> > +extern bool nbcon_braille_try_acquire(struct console *con,
> > +				      struct nbcon_write_context *wctxt);
> > +extern void nbcon_braille_release(struct nbcon_write_context *wctxt);
> >  
> >  /*
> >   * Check if the given console is currently capable and allowed to print
> > @@ -678,8 +682,12 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
> >  static inline bool nbcon_kdb_try_acquire(struct console *con,
> >  					 struct nbcon_write_context *wctxt) { return false; }
> >  static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
> > +static inline bool nbcon_is_braille(struct nbcon_write_context *wctxt) { return false; }
> >  static inline bool console_is_usable(struct console *con, short flags,
> >  				     bool use_atomic) { return false; }
> > +static inline bool nbcon_braille_try_acquire(struct console *con,
> > +					     struct nbcon_write_context *wctxt) { return false; }
> > +static inline void nbcon_braille_release(struct nbcon_write_context *wctxt) { }
> >  #endif
> >  
> >  extern int console_set_on_cmdline;
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index d17704fe93ae..a5e053ffe4da 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -2002,3 +2002,62 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
> >  	 */
> >  	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb));
> >  }
> > +
> > +/**
> > + * nbcon_is_braille - Checks whether the nbcon write context is using Braille console
> > + *
> > + * @wctxt:	checked nbcon write context
> > + *
> > + * Return: True when the write context is associated with a Braille console.
> > + *	   Othrewise, return false.
> > + *
> > + * Context: Can be called in any context but only when Braille console is
> > + *	registered and the struct console could not disappear.
> > + */
> > +bool nbcon_is_braille(struct nbcon_write_context *wctxt)
> > +{
> > +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> > +	struct console *con = ctxt->console;
> > +
> > +	return con && con->flags & CON_BRL;
> > +}
> > +
> > +/**
> > + * nbcon_braille_try_acquire - Try to acquire nbcon console for braille_write()
> > + *
> > + * @con:	The nbcon console to acquire
> > + * @wctxt:	The nbcon write context to be used on success
> > + *
> > + * Context:	braille_write() for emitting a single buffer on Braille console.
> > + *
> > + * Return:	True if the console was acquired. False otherwise.
> > + *
> > + * Braille console is not registered as a proper printk consoles. Instead,
> > + * it is integrated with the graphical virtual terminal.
> > + *
> > + * This function acquires the nbcon console using priority NBCON_PRIO_EMERGENCY.
> > + */
> > +bool nbcon_braille_try_acquire(struct console *con,
> > +			   struct nbcon_write_context *wctxt)
> > +{
> > +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> > +
> > +	memset(ctxt, 0, sizeof(*ctxt));
> > +	ctxt->console = con;
> > +	ctxt->prio    = NBCON_PRIO_EMERGENCY;
> > +
> > +	return nbcon_context_try_acquire(ctxt, false);
> > +}
> 
> This is really the same thing as nbcon_kdb_try_acquire().
> 
> As you mentioned in your cover letter, it is a bug that
> nbcon_kdb_try_acquire() enters an unsafe section because @unsafe is a
> bool rather than a usage counter.
> 
> Since we have limited bits for struct nbcon_state, we need to stop
> entering unsafe within nbcon_kdb_try_acquire(). As I mentioned in the
> response to your cover letter, all the other CPUs should be quiesced
> anyway.

I working on v2 today morning and looked at it from different angles.
I decided to send v2 where I described my thoughts, see
https://lore.kernel.org/all/20260925141729.173943-1-pmladek@suse.com/

I guess that we need another solution at least for PREEMPT_RT.
But I am not sure how to do so correctly.

Sigh, the Braille console is quite a hack. I am afraid that the NBCON
API is not ready for this use case. IMHO, the most similar user
is nbcon_legacy_emit_next_record() which is used to flush nbcon
consoles from the legacy loop when some early console driver is
still registered.

Best Regards,
Petr

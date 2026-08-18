Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B923FD969
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039514; cv=none; b=MIru3akeMgKIQuRBfdR0JOoBveb29wgk2YvS+sYKyv+gWS3XODb5NenvoPFSkGi3i/tsgAMjOYhWy2x2SQpoRC+XopCFqGjHO8pBGtt79U5IyWrNealfB9CDFznFzn9tMuyqqr4pCtrbS+Hc/nz7sRwWSlgIvahpFpyHJE7vsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039514; c=relaxed/simple;
	bh=+TL5RIW1sQcLdmF+sEaMUOxeOhPPrZWABcWxG3wJ7Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ruy/8rPURXATFTgC79Zlz1OXRvbOO7OTq2HEAvq/70Rpnd+4u5dbKZXewojaa6eEINngrPlztl4QoSeiQwsJvUFRWmqDZNGGpPL5sWIq/xS3F766YWyysbkbsrUizqFqXpv5U4RtO/AB6P5v/HsGSzN4sB44xYg4LyqjiTO9Y/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A5OVMKRN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A5OVMKRN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4998e0916faso23785155e9.2
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787039511; x=1787644311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ytGWt1YRdjzr+JNfsHCwKEMc0toTnk6HqTBPGuje0Qk=;
        b=A5OVMKRNR3xo1amzcd6bPhweBWXyhU3+TCk7p8AjVbXW2ZL3UL3Ft6BFOetny3kJW3
         xige7m5BAZ9xjk3xaUQOfrUik3KIQ8Md7JWzUUSo7vZUAIGNDZ08HLxAxhBmBy4J3M83
         D/Wk7Ed9Bp1x8rQJqDSjt/9pw9b46qSmwkLgOe4WhmVPXZNAtuJJ3lbWGuoJqS5Df8+i
         A+Nol7l7a5DxUhwYRSuVbmyvIqEPnKq5D1xIKpzxUzDHOfgt5HWLi644X5nYNs5Nb/jB
         Eu3FR3CgxS/OQYD6xxFDnHMlAJYq0spDvchewJVbbQSEbKVFaJJpNY4fldhPfDkGy0Qm
         bMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787039511; x=1787644311;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ytGWt1YRdjzr+JNfsHCwKEMc0toTnk6HqTBPGuje0Qk=;
        b=nWVNUAwl1zts7hZLeL//pDrxfxiYfMlSiCxJhOqH8yTtpIkH05j6owWvZ5It8RBZJ7
         tSTDaDiQXso/U2V14F3QM8/v5B8X75ga2AJkmueSN/ZoiXfundM1InCaEG/EWJN9Goj1
         l+sGJ16zsAK1nyIUM/ehrLzXgkWq1FpTdExmwT5IXOUrt5mfw+smsDnqQkevaA2iCTym
         d13DfoJMyaVcTsRGDYGstF/hYi2by8kZWet0griQXMNtOnkWBYmUEvVqZxTW98bDzSdt
         AZeruunPR7HAAgT9OeuA4Q0d8xmVaVA43dyKPuuxgejbT2W3pmwpcU+vygf6zEHyiepY
         VW+w==
X-Forwarded-Encrypted: i=1; AHgh+RqYNnNIhKsKlHNdf7NH1j9fU1MzQZFNQn+xROJMDXRaKziKvaO/emafwuwBVQsjiv8XryExJpgG8GuTQls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0GUiBqyF2VZjmBdjDbryLl4nWGx+sSCdiZwsc9EttZhQCXspY
	KN9kPunBdag0tS80I+M0CsiGABXNnyVqXM6jypEy8or5TcnPyQuxmcxiqHuaqwHaM6w=
X-Gm-Gg: AR+sD12YAbeaHPiADZq0wgqm+bFUu0PT1ARHTfWqtN4HZxn7i6ny84z7EEaKq2LHylO
	D7iXZMi4vweq2unhDukr2q4Z77+5jJEndwPlC4pl0QL8quXCd9E3oE/2Bk+qzQVvchZxp9RNFH2
	iWEJLuwbOt1K58siPr0uLbbcwCbj8uow9sXmhPXd0E8ko6/+biSjpZJEX+pDra2PH7ZXrefhm0A
	zgOy8hsyocQ3qiPsh9snTmO97rCbOxgrufp9HurTOZksA4X+N2U5DoqrmS+GOCG7GvuXJ3rBPpC
	OO7J3hmu0sBWooQ2Cc4vdVYzfWmkythsmwQ7kAIj8nAJHSlSrZzQIcIGl/DyXzF2qu/3NDkZoPq
	0eqkAtKQoF3calxPENy9cvNWu9BjUFgGUiOSOvzdp59p7qnSJszT3JN4itbvL4whlZDcH6bSQ+f
	bJTw5d2d6vAOPX7ZARO5XfLvODhFfQ2zAjm0/CSArnF3zbBy6EOBDdRqI3gHSIzg==
X-Received: by 2002:a05:600c:628c:b0:499:87f3:a2a3 with SMTP id 5b1f17b1804b1-49987f3a33emr537700105e9.15.1787039511205;
        Tue, 18 Aug 2026 00:51:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b77f41sm9298971f8f.27.2026.08.18.00.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:51:50 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:51:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Kees Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-serial@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <aoQPFC7d8mSuNZMh@pathway.suse.cz>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>

On Tue 2026-08-18 07:25:13, Jon Hunter wrote:
> Hi John,
> 
> On 29/07/2026 13:04, John Ogness wrote:
> > Implement the necessary callbacks to switch the 8250 console driver
> > to perform as an nbcon console.
> > 
> > Add implementations for the nbcon console callbacks:
> > 
> >    ->write_atomic()
> >    ->write_thread()
> >    ->device_lock()
> >    ->device_unlock()
> > 
> > and add CON_NBCON to the initial @flags.
> > 
> > All hardware access in the callbacks is within unsafe sections.
> > The ->write_atomic() and ->write_thread() callbacks allow safe
> > handover/takeover per byte and add a preceding newline if they
> > take over from another context mid-line.
> > 
> > For the ->write_atomic() callback, a new irq_work is used to defer
> > modem control since it may be called from a context that does not
> > allow waking up tasks. During suspend/resume the irq_work is not
> > used as this has been shown to cause suspend problems for some
> > hardware. Upon resume, any pending modem control is performed.
> > 
> > Note: A new __serial8250_clear_IER() is introduced for direct
> > clearing of UART_IER during console writing (which will not be
> > holding the port lock for atomic printing or KDB/KGDB). This
> > allows restoring a lockdep check to serial8250_clear_IER() in
> > a follow-up commit.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> I accidently responded to V9, but responding here with the same report for
> completeness.
> 
> This change is causing a boot regression for our Tegra20 and Tegra30
> platforms. Reverting this on top of -next fixes the issue. Previously with
> V5 I did not see a boot issue only an issue in suspend. So far I have not
> had chance to dig any further.

Interesting.

Another clue, mentioned in the v9 thread [1], is that the boot
regression does not happen with v11 when "keep_bootcon" option
is used.

The "keep_bootcon" option causes that the boot console driver stays
registered even when the full featured driver gets registered
later.

The most important effect is that the printk kthreads can't
be used as long as any boot console driver is registered.
All drivers need to be called in the legacy loop in this case.
There are two reasons for this:

  1. Boot console drivers are synchronized only by
     the legacy console_lock (console_sem). port->lock
     is available only for the full featured driver.

  2. There is no easy way to match boot console and
     full featured console drivers working on the same
     HW.

So, the regression seems to happen when the printk kthreads
start being used.

Jon, could you please share the full log when "keep_bootcon"
is used?

[1] https://lore.kernel.org/all/20260724103654.133654-1-john.ogness@linutronix.de/

Best Regards,
Petr

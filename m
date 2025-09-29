Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32A239570
	for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147370; cv=none; b=H4sjUC73oPl9/nakUHhq8gCByNUL6rjwm7OwIRaRY30GULoJI/jjXrh6fLZRiGxGnhYmY+W5BhmYlWCcxrNpd/W9NpMGkX9hHa9jij+edFANVPwUpFb5+jP2BkLpqKiQYC9f1X26Op/MBFCv+w3QOXL0VagzgtWCYfKNMM12af8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147370; c=relaxed/simple;
	bh=OLwcOYUdxUpMjIFZ5BGZmv0LLP8AkmkGehIrLfqGQXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vlw4EUmvjS38K6DNcBySnBZVUaqnynUL1EbqMQHkSa4H8BQNyzshIm9A59b0HTqrAT69c7MkQpsuDFiWk6E7jaVt0bWmEu+YLMqY3VMr1cCgJSudmWblZKtT8Dg+sTUvRic17E0rHDIj6rHNrnajfEasRcwtGms0EeyjR8weE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wr+xqsnG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wr+xqsnG"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3d80891c6cso197224866b.1
        for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 05:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759147366; x=1759752166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOuv00OSV8dqBnGq20Wy0KRnlY3nSnPvwEkTxMlG5xg=;
        b=Wr+xqsnGqANybgMrZr7WYtd7aIfaCZw3PvaZeFgPOrdaFKqZVUNmpgykyAzuYq0CHv
         8jHR0wbf+2Ap7eaNLbwbNpAwcSxIey12rc74iZ/CufzbDuizIjPPeyVi+O3OdP9jcMIW
         N1em+SdrkHac/Ig83d8+w7gv6ICp9QP68yuPC2pnsRjQt4aoI9dtNwbpmOC9eECEU2Du
         wC/iWwUFgKlcReED5geh/Wtc+IxGzo3hU65ttN86PmE0hu/lvOTB36YrKC5P0uf+PaOo
         GNl8IvOqNLbFIxvshYpHCOZQtSTSYfFFahg0srp1N8vKOcWSeOz1JqMpM8WPhjYLsT7h
         WJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759147366; x=1759752166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOuv00OSV8dqBnGq20Wy0KRnlY3nSnPvwEkTxMlG5xg=;
        b=LSQPgoQOEu0E/tisxI5SoL8Dj1E8dgJdSAwCUzv7s6L42eBsXN3N8/4lNUZq6hEqj8
         VvhZszuT1tgqIpKo7dmA6JGRuGVm9lCQZhLbANM6RlPqfAte7N24aqnyRYKmvtSfRJou
         iFRcrfkat13WOOTIEDX4Pgv+vS3JVKJ/jsTMJNM+cNspsBFU3U5flKetM38druhf4I7b
         cRgpvYL7anUhpBLLK7o6jZQZNJFwhhdgKZapHfMgHHZ5bV+1Xm6WxgEnzEnndAuFwBOM
         da9KxhJG1VJApAEUQ58yyVgaglgYA8zbe7rBerg+RnwJxWT03x6fKiEfULTj3sRy9nln
         byDA==
X-Forwarded-Encrypted: i=1; AJvYcCUC64cp8Rs18M6FEwmQi3rPncAxgxnUeB17wlhAMD4UIDZd8rBwhBiqHsFiItYVJXtol4qqB2WP3tLYSNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyi0ko9MOWs/idpgJTIOz8bEMZZJWUpBK006AZKR+ZOXE1SVDD
	m5VgkBauQTP7676iLkdli0O+lL1otniB+hMcqoqvy8TWdk+dtMSbsu5QjM9rmgEiLP4=
X-Gm-Gg: ASbGncu00Gy9m1FnNiO2pNtvHs9azvYf4xORpcCgii5h7phUInMGwhU8gwttU6sXTih
	7f3nL97n9POwlzSYNdC54QQS/bXcigrx4DxPXaHFlU0v3jxrJB4zql9/6KPw5r8NtstoBM2WAxt
	6wBZuLy8lwfvYDJBmB3FcEJ8I3eYxUYY0BzX8l12LFqpJTHNqpkV5TBggOoNlUovDixOq5sX5P8
	3SNtnZbQabI3QLSkjoXjQ+RPKjL1xfROkar/mDzumV0ctckhnJTSSSyZ5540P+hRGlbfcM8eg4u
	SlFbzV2VWiRla0tPPKawPO/+uaQws7L4BEZreE6XfdPY1XH+MZ6b9rJxjAIHJEpBvg6Mj+TexDt
	H75hH6hE/TcEQBiAuK1Np4I/oyDFGl+UXF10H
X-Google-Smtp-Source: AGHT+IG8g3zFJKrr/fZ6OBwagK+1LzES4rRvE0rabBsl3Q4R+Jm0TAGLlXqVqS/4J8S7RbelSPly8Q==
X-Received: by 2002:a17:906:f58b:b0:b29:57b0:617f with SMTP id a640c23a62f3a-b4138f4576amr31550066b.1.1759147366306;
        Mon, 29 Sep 2025 05:02:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e4f3844dasm224383566b.45.2025.09.29.05.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:02:45 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:02:42 +0200
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
Subject: Re: [PATCH 1/3] printk/nbcon: Block printk kthreads when any CPU is
 in an emergency context
Message-ID: <aNp1YogXZh6dObzI@pathway.suse.cz>
References: <20250926124912.243464-1-pmladek@suse.com>
 <20250926124912.243464-2-pmladek@suse.com>
 <841pnti8k2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841pnti8k2.fsf@jogness.linutronix.de>

On Fri 2025-09-26 16:43:33, John Ogness wrote:
> On 2025-09-26, Petr Mladek <pmladek@suse.com> wrote:
> > In emergency contexts, printk() tries to flush messages directly even
> > on nbcon consoles. And it is allowed to takeover the console ownership
> > and interrupt the printk kthread in the middle of a message.
> >
> > Only one takeover and one repeated message should be enough in most
> > situations. The first emergency message flushes the backlog and printk
> > kthreads get to sleep. Next emergency messages are flushed directly
> > and printk() does not wake up the kthreads.
> >
> > However, the one takeover is not guaranteed. Any printk() in normal
> > context on another CPU could wake up the kthreads. Or a new emergency
> > message might be added before the kthreads get to sleep. Note that
> > the interrupted .write_kthread() callbacks usually have to call
> 
>                   .write_thread()

Oh my muscle memory ;-)

> > nbcon_reacquire_nobuf() and restore the original device setting
> > before checking for pending messages.

[...]

> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -1674,10 +1696,18 @@ void nbcon_cpu_emergency_exit(void)
> >  	unsigned int *cpu_emergency_nesting;
> >  
> >  	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> > -
> >  	if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
> >  		(*cpu_emergency_nesting)--;
> >  
> > +	/*
> > +	 * Wake up kthreads because there might be some pending messages
> > +	 * added by other CPUs with normal priority since the last flush
> > +	 * in the emergency context.
> > +	 */
> > +	if (!WARN_ON_ONCE(atomic_read(&nbcon_cpu_emergency_cnt) == 0))
> > +		if (atomic_dec_return(&nbcon_cpu_emergency_cnt) == 0)
> > +			nbcon_kthreads_wake();
> 
> Although technically it doesn't hurt to blindly call
> nbcon_kthreads_wake(), you may want to do it more formally. Maybe like
> this:
> 
> 	if (!WARN_ON_ONCE(atomic_read(&nbcon_cpu_emergency_cnt) == 0)) {
> 		if (atomic_dec_return(&nbcon_cpu_emergency_cnt) == 0) {
> 			struct console_flush_type ft;
> 
> 			printk_get_console_flush_type(&ft);
> 			if (ft.nbcon_offload)
> 				nbcon_kthreads_wake();
> 		}
> 	}
> 
> I leave it up to you.

I agree that this is better. I'll use it in v2.

> With the static+initializer change:
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks a lot for quick review.

I am going to send v2 when the panic state API patchset (in -mm tree)
gets accepted upstream.

Best Regards,
Petr

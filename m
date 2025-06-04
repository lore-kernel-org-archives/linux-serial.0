Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4172C859
	for <linux-serial@vger.kernel.org>; Wed,  4 Jun 2025 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749035342; cv=none; b=g63npuS3p77vm8/B1Vxtt2XNcx5P24NGXoXgj5hn24M/88XNUYneOeR63hiiROgfepDhZ3TZfuPn/ypn8mM/wQCG84h2AxqYf0dQmzVKRdd7BIUW8Drg1zPiPmZ/K26uuQkuDM75moPESy8vLBQF4uAVxelVEoS3u/pn1IomPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749035342; c=relaxed/simple;
	bh=pyi5fUpMBDA7xVdsAPRF/Q9ktcBAwK+luYZR5u5s9nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0vr6UVGRmPXRhskzvcVkyZQyEwC77Kq91udT8Qt4GbzXWkWM+mthgeRDcs6xDQT11uUOmsq0qvKz63gzS6u6NMKi2x7LRWI+ewxAfTb2FJ06rGyfYlFDZwYrOA+tLij2GlVWYnC2fS15mb3lja838g4uAWcaLWk2xJqSiIIxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q0zvDwY0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q0zvDwY0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450cf0025c0so47929325e9.3
        for <linux-serial@vger.kernel.org>; Wed, 04 Jun 2025 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749035338; x=1749640138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fo/dL6h3Yr2vVYWODP4+BLrzuTaAimU3j5bsgQKsn4o=;
        b=Q0zvDwY0swWxGlE/TZiC//TqzmYPhSYjLpoSYruYkWgeIwLPHFBVCthpSOv/Ko+OO2
         iMQLwREAH8l+0FZFfq4fTTBwENWld6ODLklbd4hrUZnhjQUn2MR1jO5hCV4E+FiyiZHj
         Bzs/jYV/szgH7zAhuHRbwCUErbmrJY1+53jXlWP4gbTQpj5EAmsEGwa+N1sN1cs7fmI2
         Xq+g3o9Rq5+74ORETwKfvtqW+QQR+Amr3OorAUrr+B8ra73mwU5mTb34YMuQwA4TMKVM
         sxAlPm+Ojcu1UpFHvs06CNYV1nwbnu1I4yN2U4pymFB7dr91CxNiVwlY2s9HKVv8Di6D
         0x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749035338; x=1749640138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fo/dL6h3Yr2vVYWODP4+BLrzuTaAimU3j5bsgQKsn4o=;
        b=e1ysACzZnj7/WcFORqXjCWmmsoVm6cyn7cCd3DLwTTff7yTdc7nuvPGOrimiayA1P+
         H+0vhQE4Q8cqwZ/MD1c1KQgzXgl+VzQhKz5uuWLA/TuNKXv6QWVZYbTHV8Vk7YKqGVVp
         LtU7bl/4KSM7fg4mZ8M3+vnFY144r011D8C9ObGqzkdM7C/ADkSzm4OkRvmInYjw4drg
         sp7P7pez3DcdKXoOY61Un65s237iXJtdiKt6xkj4v03j9nFAkurSHx0LJaUdbq7+oXEM
         HN0BqgZV2k+qiO/vmTeyScjzoOdkKNefJn29FbHR2XURdalubPJih7AIVMbrn3o31XGh
         96CA==
X-Forwarded-Encrypted: i=1; AJvYcCXnLh5H5Tv9mo5d+IOPNbf6dQq58YDfmSBem6j22wT1YZe6yCfBoPR3aRMC0VWlfLykuUef/AAGcsOOI+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgAaFl+QBmjE0DRDyyAE6mVq7eTfYRxhSRHiv9ScOZB1jDH88
	gRbS027qVJlDYHoMEy+FdKeoJe/TjwCrW0NBNYSE/3xGxGKq0sUpmARP91xdrKw4ko8=
X-Gm-Gg: ASbGncvFaX1iWYs5qiyIPOkjbedu01saeMg5A/Gc/UK1ptkVba251FCIB0YDZWGR8Ut
	Ox08ZKWhBiJZhJZxFVRB+fS357h24XZwDLk/AqPHs3FQvF55Cq1N5oNtF2FmqHZ9BOrWp5oSQUg
	dpaPX/zRhNCkcnQ/AKGRcc3jWK/tX+7PUU+AC9W2MiiRb9W7WIJuY8fFRW0fV6F6LPbAHScxQYr
	VF5klmi6KXpkm3hEjb8mAXHEhYpYgtg434ApxymHyZybxFu1Yhf+crIB7D6MuBdxhN8RTz3aqIi
	z7kiJc45PTc5/UgbBuL0xC8nZOlnIHs1i6DRhtz0ajbaTwkpw7HJ7Q==
X-Google-Smtp-Source: AGHT+IGzwTw0APJOBCPXYsgbi3L8T2cF37ouY+tpV3tVwkWBF2/qFMnNgv0OYaykSm6L6gQBiWeTzQ==
X-Received: by 2002:a05:6000:430a:b0:3a3:7593:81a1 with SMTP id ffacd0b85a97d-3a51d967d6emr1755178f8f.43.1749035338282;
        Wed, 04 Jun 2025 04:08:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd3506sm101742875ad.156.2025.06.04.04.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 04:08:57 -0700 (PDT)
Date: Wed, 4 Jun 2025 13:08:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
Cc: 'Michael Kelley' <mhklinux@outlook.com>,
	'John Ogness' <john.ogness@linutronix.de>,
	'Ryo Takakura' <ryotkkr98@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: Problem with nbcon console and amba-pl011 serial port
Message-ID: <aEApOPTqbVOR35F_@pathway.suse.cz>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>

On Wed 2025-06-04 04:11:10, Toshiyuki Sato (Fujitsu) wrote:
> > On 2025-06-03, John Ogness <john.ogness@linutronix.de> wrote:
> > > On 2025-06-03, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
> > >>> 4. pr_emerg() has a high logging level, and it effectively steals the console
> > >>> from the "pr/ttyAMA0" task, which I believe is intentional in the nbcon
> > design.
> > >>> Down in pl011_console_write_thread(), the "pr/ttyAMA0" task is doing
> > >>> nbcon_enter_unsafe() and nbcon_exit_unsafe() around each character
> > >>> that it outputs.  When pr_emerg() steals the console, nbcon_exit_unsafe()
> > >>> returns 0, so the "for" loop exits. pl011_console_write_thread() then
> > >>> enters a busy "while" loop waiting to reclaim the console. It's doing this
> > >>> busy "while" loop with interrupts disabled, and because of the panic,
> > >>> it never succeeds.

I am a bit surprised that it never succeeds. The panic CPU takes over
the ownership but it releases it when the messages are flushed. And
the original owner should be able to reacquire it in this case.

But maybe, this does not work well on virtualized systems when the
virtualized CPUs do not run at the same time.

> > >>> Whatever CPU is running "pr/ttyAMA0" is effectively
> > >>> stuck at this point.
> > >>>
> > >>> 5. Meanwhile panic() continues, calling panic_other_cpus_shutdown(). On
> > >>> ARM64, other CPUs are stopped by sending them an IPI. Each CPU receives
> > >>> the IPI and calls the PSCI function to stop itself. But the CPU running
> > >>> "pr/ttyAMA0" is looping forever with interrupts disabled, so it never
> > >>> processes the IPI and it never stops. ARM64 doesn't have a true NMI that
> > >>> can override the looping with interrupts disabled, so there's no way to
> > >>> stop that CPU.
> > >>>
> > >>> 6. The failure to stop the "pr/ttyAMA0" CPU then causes downstream
> > >>> problems, such as when loading and running a kdump kernel.

Thanks a lot for this great analyze. It makes sense. It must have been
hard to put all the pieces together.

> > >
> > > [...]
> > >

> This is a proposed fix to force termination by returning false from
> nbcon_reacquire_nobuf when a panic occurs within pl011_console_write_thread.
>  (I believe this is similar to what John suggested in his previous reply.)
> 
> While I couldn't reproduce the issue using sysrq-trigger in my environment
>  (It seemed that the panic was being executed before the thread processing),
> I did observe nbcon_reacquire_nobuf failing to complete when injecting an
> NMI (SError) during pl011_console_write_thread. 
> Applying this fix seems to have resolved the "SMP: failed to stop secondary
> CPUs" issue.
> 
> This patch is for test.
> Modifications to imx and other drivers, as well as adding __must_check, 
> will likely be required.
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 11d650975..c3a2b22e6 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2577,8 +2577,10 @@ pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt
>  		}
>  	}
>  
> -	while (!nbcon_enter_unsafe(wctxt))
> -		nbcon_reacquire_nobuf(wctxt);
> +	while (!nbcon_enter_unsafe(wctxt)) {
> +		if (!nbcon_reacquire_nobuf(wctxt))
> +			return;
> +	}
>  
>  	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_busy)
>  		cpu_relax();
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 8f10d0a85..ae278b875 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -604,14 +604,14 @@ extern void nbcon_cpu_emergency_exit(void);
>  extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
>  extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
>  extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
> -extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
> +extern bool nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
>  #else
>  static inline void nbcon_cpu_emergency_enter(void) { }
>  static inline void nbcon_cpu_emergency_exit(void) { }
>  static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
>  static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
>  static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
> -static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
> +static inline bool nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
>  #endif
>  
>  extern int console_set_on_cmdline;
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index fd12efcc4..ec016bb24 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -909,14 +909,18 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
>   * output buffer because that has been lost. This function cannot be used to
>   * resume printing.
>   */

Please, add a comment explaining the new return value. Something
like:

 * Return:	True when the context reacquired the owner ship. The caller
 *		might try entering the unsafe state and restore the original
 *		console device setting. It just must not access the output
 *		buffer anymore.
 *
 *		False when another CPU is in panic() and a busy waiting for
 *		the ownership is not safe. It might prevent stopping this
 *		CPU and create further complications, especially on virtualized
 *		systems without proper NMI. The caller should bail out
 *		immediately without touching the console device or
 *		the output buffer.

It is very long. But I think that a good explanation might safe people
troubles in the future.

> -void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
> +bool nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
>  {
>  	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
>  
> -	while (!nbcon_context_try_acquire(ctxt))
> +	while (!nbcon_context_try_acquire(ctxt)) {
>  		cpu_relax();
> +		if (other_cpu_in_panic())
> +			return false;
> +	}
>  
>  	nbcon_write_context_set_buf(wctxt, NULL, 0);

It would make sense to set the NULL buffer even when returning "false".

> +	return true;
>  }
>  EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);

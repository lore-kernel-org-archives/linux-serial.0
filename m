Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9C3112AB
	for <linux-serial@vger.kernel.org>; Wed, 10 Sep 2025 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495646; cv=none; b=FCOu6DIzbGKdCPdh9n88IfI4xtY79q5hgzyv2fa8bEGDYz4ILKRyz1jBD5KLpi5XR8xfTwpxNgoJccNBZ9cOucWGhd4r4C2yuGTVCq4pjZ4EsLF1gMGhPaqMP/lXSigByegwinuciruYbfSXI5LpTW41Kyw8IW9wB+ZfGMX1h8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495646; c=relaxed/simple;
	bh=ie0qX73VnCJyZIRsHoLgMFK7Ugx90OjEqw6Db2YUj3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is8/JmdF4cJm909itZyMOyRe6/32wcZeDXuks0+MfBj4pu6ewsqUx1TAkYnwbBQTK3pck/gAP6vaCLb070cn6u+A85S1nVJT8T4z93EmEyBM3vpcPWX2np/8P+jIrsqew6ecGb0fMRYQfW7U7MBKZU1legs9PSPstDOqiuXSHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qke//qdq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qke//qdq"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b046f6fb230so82573466b.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Sep 2025 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757495642; x=1758100442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mucp5qjMCiDYXEEdcE/hCtMOO2KOtom4zvHQRAQZjKM=;
        b=Qke//qdqA1bFABUm6ZJBMnn4cqhK+iMCPsCmnrmMHpCHpv3mehc/QP254zZTAgfoyU
         EcS80bGrEqZ+/ddiXVxDLrtQE5AQk645PqP3qj9ZboRV8BL7t/BU5Te+Ird1o222mV6d
         pok34HVm0RtpHWrMdptxTWLbQM4yQtXU1o0uZGq540rb+tlVGfKopSecu7rI+iMiPu5s
         UnYdiac6oCqqoBOm/w0612slCGIT154F4XVImPcg+mF03j04UVIHgc02LzEZ7+1glXwd
         eY/WnBNJJ+XZAbY2nngpREQtuWr4SzBXFHl1znuTLj2nywwkbeaY7LHeBfI68Sbvne0Q
         Cf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757495642; x=1758100442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mucp5qjMCiDYXEEdcE/hCtMOO2KOtom4zvHQRAQZjKM=;
        b=Hg87IkBwTpp25FstpvM0hE1EYWstUpLCubQqSwKwlL5AeaOfOhinyMXxRItQ9g7Exv
         zPrYtH54NdqZ8OBmaLPB9XsWA4vC0M2o8rOqDpz0z+YT0wYcgqR3lDiro/8MxptdFvBm
         s7C1TQr9DYStqrtvHyjGx17ZN4rntlR2en44+DCkSJl6bRtKzmG8tfioXhktR87Nnci/
         cO0I5Nv5QxCMCl7+TrYukiq0P7ojs9GeElyJLt9f4ZtmAPiCIVSUmnIYGk0ur5UgLcaz
         IXbqek1+m6aOJWBSeTpi7AjEI56Cr8Q4tFG44fLpBMedkv485LN2osmA46Jnm66Rp4xW
         Ofrg==
X-Forwarded-Encrypted: i=1; AJvYcCV/Y57Wui+Eru7kfdgHyvEDl5UY+/uLSxL5RFRk+6Yy5nsa93Rvq2XBidMnnKPMQE+rOJFSik+rKRRd4eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypkcBnnMo3DNwEpNpzrYGEBxzmpOeuPG1X2EzH1CRtmey+oBhg
	kfkibrgpw2cl65TmASc5jobJPrOwrovo33svJKi+duZNGEYzKv5Cr3KDPy1nzcCmVV29nzmS2VH
	9ng2tsIU=
X-Gm-Gg: ASbGncvD2EJDegbngMuqfDTegp/VaCBiFyLnXn072oR2Fe2P9MQfJ2CMwnrigJVtAP0
	Ga8uH9h5ZOvpig+8kwyjJUvk5dMxuSdfnPxApahpPXkoq6LH5JAzQD96TJo1uTtH6nLRBuMtu7A
	lFVWAAKaLNQoyoq+T+gAzuJcjX3TdoGtgt8ybFlcg4Hi0gjZ8Qoyhq/QZhn04UbCUYsRA2PFvop
	ysDaVQHRaN0MdFqkHQSTJuNZPpQd0vNvjozbnAWnCbX36jxOad2hdzrFQf4yH36s+bffcCh438n
	D1Wk/7Vxz79e1hA5NxGrTdoX5hD+JSv5d3p4mKK43fG+FT3aSypvftsfwJHfzmb5oByEfIDQ6Pd
	PIKw8/ejKzuIwez2v3UsA9fqBN66wMFLLWNfN
X-Google-Smtp-Source: AGHT+IFp9Nc6SHbNlggO44okgu09OUKRUTi0NcxChzJgDIFKLVskR5YT/J1iD1U1fN3zdWVMs+mOoQ==
X-Received: by 2002:a17:906:2c02:b0:b07:88ad:cca2 with SMTP id a640c23a62f3a-b0788add049mr150579466b.23.1757495642501;
        Wed, 10 Sep 2025 02:14:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830ab345sm130211066b.25.2025.09.10.02.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:14:02 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:14:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: John Ogness <john.ogness@linutronix.de>, senozhatsky@chromium.org,
	rostedt@goodmis.org, linux-serial@vger.kernel.org,
	Michael Cobb <mcobb@thegoodpenguin.co.uk>
Subject: Re: Lock contention with console kthreads
Message-ID: <aMFBWJWqv3KsaaZU@pathway.suse.cz>
References: <CALqELGwr=XWA2iD-7wa1jOigx3pfEnTnaGWUMQX_A5MWe3DN_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALqELGwr=XWA2iD-7wa1jOigx3pfEnTnaGWUMQX_A5MWe3DN_g@mail.gmail.com>

On Tue 2025-09-09 21:14:21, Andrew Murray wrote:
> Hello,
> 
> Since commit 5f53ca3ff83b ("printk: Implement legacy printer kthread
> for PREEMPT_RT"), and only when PREEMPT_RT is enabled, legacy consoles
> use a kthread to write out to the device. This is beneficial for boot
> time when using a slow console such as a serial port. However, this
> gain can be short-lived as console_on_rootfs in init/main.c appears to
> act as a synchronisation point.
> 
> legacy_kthread_func holds console_lock when flushing, and is held for
> a long period of time during boot.

This is the main principle of the legacy loop.

At the very beginning, printk() emitted the messages to the console(s)
directly. But it slowed everything. Several CPUs were waiting for
the serial console...

In v2.4.10 (Aug 2001), printk() started using console_trylock().
Other CPUs were allowed to store new messages and skip emitting them
when the trylock failed. The owner of the console_lock became
responsible for flushing everything.

I believe that we could change this rule for the printk kthread,
see below.

> Towards the end of boot,
> console_on_rootfs is called which calls filp_open("/devconsole"). This
> does a tty_lookup_driver which uses the console_device function to
> obtain the tty_driver. console_device attempts to acquire
> console_lock. At this point in time, with a (very) slow UART, progress
> through kernel_init_freeable is halted waiting for the lock,
> eliminating the gains of offloading to a kthread. If this could be
> avoided, then boot time would be improved.
> 
> I also see something similar with an nbcon console (with
> b63e6f60eab45b16a1bf734fef9035a4c4187cd5 on 8250), with
> console_on_rootfs being held up by the writeout, as far as I can tell
> this is due to lock contention in many places, for example with long
> delays acquiring uart_port_lock_irq.
> 
> These issues can easily be reproduced by adding 'initcall_debug=1
> loglevel=10' on a 8250 console at 9600 bps.
> 
> I know the legacy printer and nbcon work relate to PREEMPT_RT rather
> than boot time, and so I thought I'd point out my observations as it
> seems we're pretty close to getting boot time benefits from this work
> as well.
> 
> Assuming my observations are correct, are these known issues,

I hear about this issue for the first time. But I am not surprised.
The description of the problem makes perfect sense.

> is there any interest in accepting patches to address them?
> Or pointers for a direction forward?

IMHO, it is worth fixing. It is ugly to slow down the boot by
the speed of the serial console.

I would suggest to modify legacy_kthread_func() and flush one
record-per-cycle and get/release the console_lock() in each cycle.

Something like, inspired by nbcon_kthread_func():

static int legacy_kthread_func(void *unused)
{

wait_for_event:

	wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());

	do {

		if (kthread_should_stop())
			break;

		console_lock();

		progress = console_flush_all_one_record(&next_seq, &handover)
		if (handover)
			break;

		__console_unlock()
		cond_resched();
	} while(progress);

	return 0;
}

, where console_flush_all_one_record() would implement one inner-cycle
  from console_flush_all(), something like:

static bool console_flush_all_one_record(u64 *next_seq, bool *handover, bool *any_usable)
{
	any_progress = false;
	*any_usable = false;

	printk_get_console_flush_type(&ft);

	cookie = console_srcu_read_lock();
	for_each_console_srcu(con) {
		short flags = console_srcu_read_flags(con);
		u64 printk_seq;
		bool progress;

		/*
		 * console_flush_all() is only responsible for nbcon
		 * consoles when the nbcon consoles cannot print via
		 * their atomic or threaded flushing.
		 */
		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
			continue;

		if (!console_is_usable(con, flags, !do_cond_resched))
			continue;
		*any_usable = true;

		if (flags & CON_NBCON) {
			progress = nbcon_legacy_emit_next_record(con, handover, cookie,
								 !do_cond_resched);
			printk_seq = nbcon_seq_read(con);
		} else {
			progress = console_emit_next_record(con, handover, cookie);
			printk_seq = con->seq;
		}

		/*
		 * If a handover has occurred, the SRCU read lock
		 * is already released.
		 */
		if (*handover)
			return false;

		/* Track the next of the highest seq flushed. */
		if (printk_seq > *next_seq)
			*next_seq = printk_seq;

		if (!progress)
			continue;
		any_progress = true;

		/* Allow panic_cpu to take over the consoles safely. */
		if (other_cpu_in_panic())
			goto abandon;
	}

	console_srcu_read_unlock(cookie);

	return any_progress;

abandon:
	console_srcu_read_unlock(cookie);
	return false;
}

This function would be used also in console_flush_all(), something
like:

static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
{
	struct console_flush_type ft;
	struct console *con;
	bool any_progress;
	bool any_usable;
	int cookie;

	*next_seq = 0;
	*handover = false;

	do {
		any_progress = console_flush_all_one_record(next_seq, handover, &any_usable);

		if (*handover)
			return false;

		/* Allow panic_cpu to take over the consoles safely. */
		if (other_cpu_in_panic())
			return false;

		if (do_cond_resched)
			cond_resched();
	} while (any_progress);

	return any_usable;
}

BTW: I see one more advantage. The new code will take console_srcu_read_lock()
     only around one record. It might remove contention also in the global
     SRCU machinery.

Warning: The above code is just a concept. It is not even compile tested.

Best Regards,
Petr

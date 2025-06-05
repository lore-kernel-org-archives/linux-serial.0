Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15C25C813
	for <linux-serial@vger.kernel.org>; Thu,  5 Jun 2025 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130804; cv=none; b=ExqKgsiyjNnqhibQH2uM2OaTSeopTvAbPmh2JuBqBm0h7aNfPqSSOpq67TQPPQQSYyY1uWKv5xoN3kBGj7/x5hmrHxKwVuD+j6k3D5PHwnwMcN5TvqLQAkaDP4Ih7ET+vYG9EmyrLqnQkUb6dr5eQkVMSOE+gChXpYPhbkZSPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130804; c=relaxed/simple;
	bh=tgS3SpZCcRNbT32cBtNadl0yn/nCO9nc5YZLr3wr3Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyG/j5Lz/sxj8nfci9FmL/uNoL56j4UrHEEoFyYj/J27baIpIRKJRNrKWc4ZAIKYzf0UHt0rM84/tSJrtTkJ1YkFqOjzuQeM3J5uwa8JwSsjJZP9XqwBrCJ8gKBghzr1Ani8bV8PEyiTbeOsIA+qbNRlO+bc9cLgNHrA6pil/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FJI3RuT7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FJI3RuT7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso9850805e9.0
        for <linux-serial@vger.kernel.org>; Thu, 05 Jun 2025 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749130800; x=1749735600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bP6Mi+TCFYvRv9eQrxJhAmd4okSErfMO0PNQOu+BxFA=;
        b=FJI3RuT7F+wTpZ96Yu3xcuMTzKCnmpPMRlzxfdMyilUdemySPkFX5Y5i7i2+3fJ+nW
         sWS0ItbxSLQbBWd/GQ4KBfOriq9PXcrG00YAsErgmDCLnszu//yGQDGjcjBbZpdD7o1e
         niSBWUd74QfZliIwMw4LeRyw6GdBjAhQEu99ZGtyz9d6aN1qsElndjWH1o7uyNM+bpN/
         QUMBnDZB5LzSrhpmv1NjTKH/SGu53jeHf+TFq13U3jMB4I7w0Q9jGVpGRegeabJFvSk8
         BJYYGdQOGcFtnX+su0sL9b/GDuKgLeHVL2yAWW2Fsykr7j/J/C8E2X2PKP31dGUOgBbj
         4TxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749130800; x=1749735600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP6Mi+TCFYvRv9eQrxJhAmd4okSErfMO0PNQOu+BxFA=;
        b=ch7i5dmpPci85fuGch7gVRZTkfUDPqHKAWByIoYjuKpcTVDOTivG+n+JHbC4xS9TZz
         hUHtXqYRIfOEE1acccopKHVOrHbCGV8WWHBH+ZgThbip1KyRtgtbW0TTvbN+We3S/PrQ
         A8zfvZTanBEqcyLu7c9KtGVhYf8Nah55wdMzUVv93n9yKvpx0LYYwZ7xMqNuT/Tqn68C
         OHkcbONb8emqSloHN5MSdj6OdTjnw3rgolaqRNz7sqI2vwKn/KlrWh/G2QEkQl/+20cq
         xoYSduG9jPhs9wnUuCIHHrjfsZqQ1gw2i20hvNZbKAXmfdzjAYFUuVFEHsGLA444POB6
         FOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbbIFn3OPXgQ+V8ovQHMGC0epFEIN1pf2XfBuyxUMMFZI54J/Femk89/P1TcC5wabuNy7tT34zs10f9yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdXqjOW+YWXx/RR7MG3iEVZ+yauZW7vxQjxi8m4B7M9zHR5qc
	wDt9gh3+GnVK02dhhnLTX6t7XV703F4a6iL2oVIXOUpxzwliuxgsYmKLuUPsd1bl6jM=
X-Gm-Gg: ASbGncsPZYBmWRQfH2DPU6Jde/o/TGFK3mdclVEsXKoQrCA449uV4OltCryeNGovVl4
	hXYgQUrHSmqrWqmj+PG8qfS9UYMt6+ctUyeAxDP9xIHZH+N6Wo/JIqZpkIyxxqJQbtzp1wPMEwI
	aGIVzm9mQdcXUgTjYElKJYUciFvfJQTZ+BrZ9nPW66aXWb1e7rtr7zgEZfEH70O8WWdxC/M+tER
	Goz9/KWs7dstx0Itro/g0j/P0PMaU2dRnjxkni1SL/IAuecFzNWMwsuxf2LD8CMuDi0EmMxRMXo
	qabB51JYF8zuctV8nc/4AzgJUshyGsGfepUxLn1NlYILc1pV+0LQaQ==
X-Google-Smtp-Source: AGHT+IF2c7EYFNH2h0X+wzdkc9uuWQqPvDA2Db1Nws8D8+Y3I4ZjFHdE9Ad1uXCt0IcsZXEKXBgWxg==
X-Received: by 2002:a05:6000:26d2:b0:3a4:fc37:70f5 with SMTP id ffacd0b85a97d-3a51d97663dmr5364280f8f.58.1749130800462;
        Thu, 05 Jun 2025 06:40:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8b26sm119087735ad.9.2025.06.05.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:39:59 -0700 (PDT)
Date: Thu, 5 Jun 2025 15:39:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	'Michael Kelley' <mhklinux@outlook.com>,
	'Ryo Takakura' <ryotkkr98@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: Problem with nbcon console and amba-pl011 serial port
Message-ID: <aEGeARVcCwqcoHb8@pathway.suse.cz>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEApOPTqbVOR35F_@pathway.suse.cz>
 <84o6v3ohdh.fsf@jogness.linutronix.de>
 <aEBNLMYVUOGzusuR@pathway.suse.cz>
 <TY4PR01MB13777CC92C858572B9C19394FD76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY4PR01MB13777CC92C858572B9C19394FD76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>

On Thu 2025-06-05 05:27:56, Toshiyuki Sato (Fujitsu) wrote:
> Hi John and Petr,
> 
> > On Wed 2025-06-04 13:56:34, John Ogness wrote:
> > > On 2025-06-04, Petr Mladek <pmladek@suse.com> wrote:
> > > > On Wed 2025-06-04 04:11:10, Toshiyuki Sato (Fujitsu) wrote:
> > > >> > On 2025-06-03, John Ogness <john.ogness@linutronix.de> wrote:
> > > >> > > On 2025-06-03, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
> > > >> > >>> 4. pr_emerg() has a high logging level, and it effectively steals the console
> > > >> > >>> from the "pr/ttyAMA0" task, which I believe is intentional in the nbcon
> > > >> > design.
> > > >> > >>> Down in pl011_console_write_thread(), the "pr/ttyAMA0" task is doing
> > > >> > >>> nbcon_enter_unsafe() and nbcon_exit_unsafe() around each character
> > > >> > >>> that it outputs.  When pr_emerg() steals the console, nbcon_exit_unsafe()
> > > >> > >>> returns 0, so the "for" loop exits. pl011_console_write_thread() then
> > > >> > >>> enters a busy "while" loop waiting to reclaim the console. It's doing this
> > > >> > >>> busy "while" loop with interrupts disabled, and because of the panic,
> > > >> > >>> it never succeeds.
> > > >
> > > > I am a bit surprised that it never succeeds. The panic CPU takes over
> > > > the ownership but it releases it when the messages are flushed. And
> > > > the original owner should be able to reacquire it in this case.
> > >
> > > The problem is that other_cpu_in_panic() will return true forever, which
> > > will cause _all_ acquires to fail forever. Originally we did allow
> > > non-panic to take over again after panic releases ownership. But IIRC we
> > > removed that capability because it allowed us to reduce a lot of
> > > complexity. And now nbcon_waiter_matches() relies on "Lower priorities
> > > are ignored during panic() until reboot."
> > 
> > Great catch! I forgot it. And it explains everything.
> > 
> > It would be nice to mention this in the commit message or
> > in the comment above nbcon_reacquire_nobuf().
> > 
> > My updated prosal of the comment is:
> > 
> >  * Return:	True when the context reacquired the owner ship. The caller
> >  *		might try entering the unsafe state and restore the original
> >  *		console device setting. It must not access the output buffer
> >  *		anymore.
> >  *
> >  *		False when another CPU is in panic(). nbcon_try_acquire()
> >  *		would never succeed and the infinite loop would	prevent
> >  *		stopping this CPU on architectures without proper NMI.
> >  *		The caller should bail out immediately without
> >  *		touching the console device or the output buffer.
> > 
> > Best Regards,
> > Petr
> 
> Thank you for your comments and suggestions.
> 
> After consideration, 
> I believe that there is no problem with forcibly terminating the process when 
> nbcon_reacquire_nobuf returns false at the pl011 driver level, 
> as in the test patch.
> 
> It feels a bit harsh that a thread which started processing before the panic
> and then transferred ownership to an atomic operation isn't allowed to perform
> cleanup during panic handling or the grace period before the CPU halts.
> 
> I would like to hear your opinion on this.
> If nbcon_reacquire_nobuf() could acquire ownership even after the panic, 
> then driver-side modifications might not be necessary. 
> (The responsibility to complete the process without hindering the panic process
> would still remain.)
> 
> Would it be difficult to make an exception to the rule,
>   "Lower priorities are ignored during panic() until reboot,"
> depending on the situation?

Good question.

The following two problems came to my mind:

1. As John, pointed out, the fact that non-panic CPUs are not
   able to acquire the context allowed to simplify the implementation.

   I think that it is primary about nbcon_waiter_matches(),
   nbcon_owner_matches(), and the related logic. It was documented by
   the commit 8c9dab2c55ad7 ("printk: nbcon: Clarify rules of
   the owner/waiter matching").

   But it seems that nbcon_owner_matches() is safe even without the rule.
   The race is prevented either by disabling interrupts and preemption
   or by taking device_lock().

   The rule prevents a race in nbcon_waiter_matches(). But it seems
   that in the worst case, more CPUs might end up busy waiting.
   And it would be acceptable during panic().

   So, this need not be a big problem in the end.


2. If we allowed non-panic() CPUs to acquire the ownership, it would
   increase the risk that the panic CPU will not be able to
   flush the messages.

   But maybe, the problem is only when the architecture supports
   proper NMI and non-panic CPUs might be stopped anywhere.

   It should be less problem on architectures without proper NMI
   where the non-panic CPU could not be stopped in the problematic
   situation.

   So, maybe, we could relax the rule on architectures without
   proper NMI.


The question is if it is worth it. Is the clean up really important?

Note that the clean up will never be guaranteed on architectures with
a proper NMI. They would stop the non-panic CPUs, including the printk
kthread, anywhere.

And I guess that the console devices will be initialized after the
reboot anyway.

Best Regards,
Petr

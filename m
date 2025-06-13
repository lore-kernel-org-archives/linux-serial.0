Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD572D23B4
	for <linux-serial@vger.kernel.org>; Fri, 13 Jun 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811979; cv=none; b=fAQSLkXrwIE9j2949GXy7lfiJFeJGiFRtRW0G5dISO8w9NouShwntoQGykJKQbiFcASt/k5k7WIvaGLCrzukDE4bDLjMMkWUpQ36GugOBlYi4nd3pbwmqdNbSdqvDNnH7IGBDfxbkRLspo11i8+io5sN85SJZjKVnOspsdBmd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811979; c=relaxed/simple;
	bh=dATxbca+ASPlW96U0TtaJ9IYiEu9l+L7yn537Xj305s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn4oGVYiNDMlDoz4wHRbqGy4xPgZKd7yFYqT9+hkE1n+qvpw2WAdmc8RjM5qRkDgDTfj60K/9vyc5GW/Cunrjc/1WDzjdoAxII7GVR/t5Snvft/rJ7LdaszQ3QqhljlVG7eRCM5M24cm9GZFUur0o5WA4xBKnd6T39cnczZjtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A0KZniRP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A0KZniRP"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a54836cb7fso1260503f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Jun 2025 03:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749811975; x=1750416775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DgWvQag2QGzdzZH71/CBz+H5MGX3oMtaddibtY3jjg8=;
        b=A0KZniRPtIf+/Dk4oZqLCVOk7dzRtrYgyq5fdGaFbZidLLdkFG28l1bair95aKNug+
         k0QuN5Sa0MLF3PZSjNrmUlwivQI9HEvkRVeyEuguwUZGU41sFrrTl0ndu4dGkDmrTtRD
         TDUS/BVuI8r7cpB1aKmXgyXNZx7VH7iVkE7tidVTnREetfWaGEvciB25r/LvhjgWhQu/
         kKsu6/40ySOkjMu0WnbITbnRufgNgXaCRQhqNAI9gjiyCY10DYvdZYE6iOLpSMvt7uTt
         6ko3L8oNgCoFSfDyn68uewSFFUnFg4Z935ogrJ8rwXvQXN+MZC3yqsRPN/Har2jghieK
         Rwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749811975; x=1750416775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgWvQag2QGzdzZH71/CBz+H5MGX3oMtaddibtY3jjg8=;
        b=q3tIwmf/bH1bdXu72N65j8zBCEYMeA4kKmZv2VqKR3d58cn5so8Pz6ta3UpS8svFJB
         9hHRTVVJPZLIfF3dkx+tL1lvvIEsNUCVzH1i4wb/FoyYD+eInV9WiGIycG47vc8P5+P1
         US009ZaDIFtoWu7kpknPEdvzasPuIIh6178uSLooi5lW3mmTmqscHX9iCbGbotZUjvSF
         hl0Diwyd6fzcaY8uXlcBz0fwqppSNIV4KsU5IIm/di6v5ZxSg0UvtFmJZwJPW4iG9Dx7
         /ZRV1T86BZg1hPovD45Tds3swT6xnChrJa9eg5bqzjcM/gspSs9dT7bQqeeiGA+ZuZ9e
         nL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFE44zKTrqS3xzvhjOfMEak2Xc2nLP8OMxYmhdbi/sqpaVos8NXiqhBsLoziFOZi/LlptPVFR/ciJaE24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Sn2CJnqG3dy8Ht4mK84MY14nZHmzvBrV6woE2G6m97T3P4Qv
	VTMIYFciJWLBNJBYAWounMc33g72ljD+yN9rzmOfw4N3A6fWQtBZrc6Ys/Nvo8mzA1w=
X-Gm-Gg: ASbGncs9nnnj1Mz7Eg6dBtpL+uriiribnL1kBMXINomK8pEsjc+G2bKDiIvuq0FN0Nw
	nfmTqEY9JiB2DIi3jdYj4WMlHQ8gtrknFSOCLihNXZLGKxjI2cRcOrprmDPBGrmJecVTtmil12e
	/Y7t25TiYfhqnhPoZMLENAsRmghYgao8gco2vh1dIfjhk4Onh5TYVkaAyh2u32+a2tS3ZzBRXg/
	rroG2Jrxrw8UZI9hQU9vvhsT4xGojg7pmGmjycaO131UeQOBmK+qwpb39LRVZdRtsS+OxtM7wcg
	UuspMKn3Lczv1NHGif/Bk6e0ntlf30G1JOA5+nDmABKdt4NonwjsfnUW4PmV+JYx
X-Google-Smtp-Source: AGHT+IHJOeLrZP5NvvZh4tWyIjAn3K7bzr2Vcb2r/+QXO+h/w0YFHvsR1/KLQStT6Bew+1GfqtSw2g==
X-Received: by 2002:a05:6000:2582:b0:3a4:f722:f00b with SMTP id ffacd0b85a97d-3a5686e4287mr1798399f8f.11.1749811975195;
        Fri, 13 Jun 2025 03:52:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900060c5sm1273973b3a.45.2025.06.13.03.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:52:54 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:52:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
Message-ID: <aEwC81RhvveGP73Y@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
 <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com>
 <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
 <aErcrCKcsi9cpANY@pathway.suse.cz>
 <CAD=FV=WFWviPPR6VWmsN2-+vzRDoU6oTNH=EP6z1usG4EDR3+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WFWviPPR6VWmsN2-+vzRDoU6oTNH=EP6z1usG4EDR3+w@mail.gmail.com>

On Thu 2025-06-12 16:16:09, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 12, 2025 at 6:57 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > > > > > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char
> > > > > > *opt)
> > > > > >         console_list_lock();
> > > > > >         for_each_console(con) {
> > > > > >                 if (con->write && con->read &&
> > > > > > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > > > > > +                   (con->flags & CON_BOOT) &&
> > > > > > +                   ((con->flags & CON_SUSPENDED) == 0) &&
> > > > >
> > > > > I haven't tried running the code, so I could easily be mistaken,
> > > > > but...
> > > > >
> > > > > ...the above doesn't seem like the correct conversion. The old
> > > > > expression was:
> > > > >
> > > > > (con->flags & (CON_BOOT | CON_ENABLED))
> > > > >
> > It is easy to get confused by the register_console() code. And
> > it has been even worse some years ago.
> >
> > Anyway, the current code sets CON_ENABLED for all registered
> > consoles, including CON_BOOT consoles. The flag is cleared only
> > by console_suspend()[*] or unregister_console().
> >
> > IMHO, kgdboc_earlycon_init() does not need to care about
> > console_suspend() because the kernel could not be suspended
> > during boot. Does this makes sense?
> 
> Yeah, makes sense to me.
> 
> > Resume:
> >
> > I would remove the check of CON_ENABLED or CON_SUSPENDED
> > from kgdboc_earlycon_init() completely.
> >
> > IMHO, we should keep the check of CON_BOOT because we do not
> > want to register "normal" console drivers as kgdboc_earlycon_io_ops.
> > It is later removed by kgdboc_earlycon_deinit(). I guess
> > that the code is not ready to handle a takeover from normal
> > to normal (even the same) console driver.
> 
> I'm not sure I understand your last sentence there. In general the
> code handling all of the possible handoff (or lack of handoff) cases
> between kgdboc_earlycon and regular kgdboc is pretty wacky. At one
> point I thought through it all and tried to test as many scenarios as
> I could and I seem to remember trying to model some of the behavior on
> how earlycon worked. If something looks broken here then let me know.

Later update: The code is safe. The scenario below does not exist,
	      see the "WAIT:" section below.


I am not familiar with the kgdb init code. I thought about the
following scenario:

1. kgdboc_earlycon_init() registers some struct console via

	kgdboc_earlycon_io_ops.cons = con;
	pr_info("Going to register kgdb with earlycon '%s'\n", con->name);
	if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) != 0) {

   and sets

		earlycon_orig_exit = con->exit;
		con->exit = kgdboc_earlycon_deferred_exit;


2. Later, configure_kgdboc() would find some "preferred" console
   and register it via

	for_each_console_srcu(cons) {
		int idx;
		if (cons->device && cons->device(cons, &idx) == p &&
		    idx == tty_line) {
			kgdboc_io_ops.cons = cons;
[...]
	err = kgdb_register_io_module(&kgdboc_io_ops);

   , where kgdb_register_io_module would call deinit for the
   previously registered kgdboc_earlycon_io_ops:

	if (old_dbg_io_ops) {
		old_dbg_io_ops->deinit();
		return 0;
	}

   , where kgdboc_earlycon_deinit() might call the .exit() callback

		kgdboc_earlycon_io_ops.cons->exit(kgdboc_earlycon_io_ops.cons);


BANG: If both "kgdboc_earlycon_io_ops" and "kgdboc_io_ops" pointed to
      the same struct console then this might call .exit() callback
      for a console which is still being used.

      But I am wrong, see below.

WAIT:

I have got all the pieces together when writing this mail).
I see that the code is safe, namely:

static void kgdboc_earlycon_deinit(void)
{
	if (!kgdboc_earlycon_io_ops.cons)
		return;

	if (kgdboc_earlycon_io_ops.cons->exit == kgdboc_earlycon_deferred_exit)
		/*
		 * kgdboc_earlycon is exiting but original boot console exit
		 * was never called (AKA kgdboc_earlycon_deferred_exit()
		 * didn't ever run).  Undo our trap.
		 */
		kgdboc_earlycon_io_ops.cons->exit = earlycon_orig_exit;
	else if (kgdboc_earlycon_io_ops.cons->exit)
		/*
		 * We skipped calling the exit() routine so we could try to
		 * keep using the boot console even after it went away.  We're
		 * finally done so call the function now.
		 */
		kgdboc_earlycon_io_ops.cons->exit(kgdboc_earlycon_io_ops.cons);

	kgdboc_earlycon_io_ops.cons = NULL;
}

It calls kgdboc_earlycon_io_ops.cons->exit() only when
unregister_console() tried to call the original con->exit()
which was reassigned to kgdboc_earlycon_deferred_exit()...

Updated resume:

It looks to me that even normal console can be used by
kgdboc_earlycon_io_ops and we could remove even the check
of the CON_BOOT flag.

My expectation:

If a "struct console" is registered then the driver is used
by printk() and it should be safe even for kgdboc_earlycon,
as long as it has both "con->write" and "con->read" callbacks.

So the check in kgdboc_earlycon_init() might be:

	for_each_console(con) {
		if (con->write && con->read &&
		    (!opt || !opt[0] || strcmp(con->name, opt) == 0))
			break;
	}

Heh, I hope that you were able to follow my thoughts and I did not
create even bigger confusion.

Best Regards,
Petr

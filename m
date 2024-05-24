Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7212CD8E
	for <linux-serial@vger.kernel.org>; Fri, 24 May 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566788; cv=none; b=kClbcaHLiT69HSy2cMC+RxO9aFSAbTvKuRvalR5NHa5sxeTJ7csP5ISdoc74qFlmbJKnJlPs9eTKmw1DBS4oSMJrZZP9plhJ+an5jtlEk/grSax0fYvws/A9Y0/nHjIA3aGat9ZL6Ox4jWk8tkbJvuwgFXkzE3X/76fps80miLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566788; c=relaxed/simple;
	bh=82mkFygbtJaVrCjw/PUlhYzljYnOGty8J6y0Q+rtRGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnvYRtHAQMVvWI6o7Oxm7/Z7V7Eidunq4gUZl5EYRKVBz0EScM71DfnYy5HNQMOKp4cxU0EhxdTe8ej6yEPkh/euMDcHOudGGc9aZK+3ze4suL035/ca/BmXiHcBPYgqh4uKTOaBm9rkHqjLH7jmEUj11zNU9N0vJiX28QyNJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QoWtJICg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QoWtJICg"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-578517c8b49so1374494a12.3
        for <linux-serial@vger.kernel.org>; Fri, 24 May 2024 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716566784; x=1717171584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aspiAaqCZWzBnZpgjxuqliZeFnw2Ogu20iqEsAO4NRI=;
        b=QoWtJICgt6fvk0E65a+z38VFpiCZBrikXZo4Iwdef+ISOVREVE3ygN07MRk9HN34jq
         ZWVsnFWUUDYgALPzifasFmTDqjYruFCQs35h4mZAFsk1iMwV3WqC6BALGS18nwO0bu5o
         fz5B5kR0TKRVKivdYDlsRz5iKpP/Qqfl5LuHEdXp9nl2NrvJV1+abAdAFu8LyNhNKDSC
         JL2RCvpzV7ZKFwN/YrzYZmP31boL3F1mZ/qLc/GinV/a5ySZ5cyvnlxOASrMKVlgc1ic
         R9GvFNLPZoXqZXAHHB7v3u8WHPMHSR6E2xySfaZbIZsxQH/mjB3VqXoyWuj5lBQHISpJ
         cSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716566784; x=1717171584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aspiAaqCZWzBnZpgjxuqliZeFnw2Ogu20iqEsAO4NRI=;
        b=TbDc11lYMfagBnQxofurbCty3V5QVAMSHKfOqE5j9mSy9TENvMS8l1XnxJlYELZsnD
         dRKyG9vfm/+UcoLq2BvzXtvtnw2MVhQ0F4uppI7RTUecWXGpYeCwg52/ShGqe2ljRfYi
         8VvSU1774ys3bm18wsLd6SK6X5W6td/sHNatsycb6qMMCd7lS7HGGyxqv29j5oc9GDe6
         u/VVXUFcGF8iBljYPWYzS7kDpI4+6Om9g4CXj0fkqP4zQ3zSJMqumkBSqRsJAE9977XQ
         wxRUxO4apNJIH7hRPYgZPkYTRrs/1DNR8uGSDOHVe3QkFzzyBDcFHE2BCsyHgp61GIar
         EIOw==
X-Forwarded-Encrypted: i=1; AJvYcCUEXWbcMpom7wRKeKTQbiy5dcKXMhYyeuyqifxJmOG82OQVLbK8GGZ3Sq6n/diIiMEv8aM25Hqkx8AvoKVLKZ9SugRKroucu3uLW7nH
X-Gm-Message-State: AOJu0Yz23rmEX7O5oPHdJqlpjmP2/JO04MZHqhFcSUYX97CozRRNgmNO
	QjvC1TVlJmKJp+L03UzxEWfj1enBf5SUL5tc4mxm6ogtp2jK4iKAEU+Xm3cQLqo=
X-Google-Smtp-Source: AGHT+IGJGq18W0VBT2FNOdw8Qfew2OpHvlSElMx6z25jq79CzVVuHcZPGcLmm7dZXRM29/vdmZkOuQ==
X-Received: by 2002:a50:a683:0:b0:578:55a3:8b52 with SMTP id 4fb4d7f45d1cf-57855a3a941mr1343156a12.8.1716566784464;
        Fri, 24 May 2024 09:06:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785233bfddsm1920135a12.3.2024.05.24.09.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:06:24 -0700 (PDT)
Date: Fri, 24 May 2024 18:06:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/7] printk: Save console options for
 add_preferred_console_match()
Message-ID: <ZlC6_Um4P4b-_WQE@pathway.suse.cz>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-2-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327110021.59793-2-tony@atomide.com>

Hi,

I have finally found time to looks at this again.

On Wed 2024-03-27 12:59:35, Tony Lindgren wrote:
> Driver subsystems may need to translate the preferred console name to the
> character device name used. We already do some of this in console_setup()
> with a few hardcoded names, but that does not scale well.
> 
> The console options are parsed early in console_setup(), and the consoles
> are added with __add_preferred_console(). At this point we don't know much
> about the character device names and device drivers getting probed.
> 
> To allow driver subsystems to set up a preferred console, let's save the
> kernel command line console options. To add a preferred console from a
> driver subsystem with optional character device name translation, let's
> add a new function add_preferred_console_match().
> 
> This allows the serial core layer to support console=DEVNAME:0.0 style
> hardware based addressing in addition to the current console=ttyS0 style
> naming. And we can start moving console_setup() character device parsing
> to the driver subsystem specific code.
> 
> We use a separate array from the console_cmdline array as the character
> device name and index may be unknown at the console_setup() time. And
> eventually there's no need to call __add_preferred_console() until the
> subsystem is ready to handle the console.
>
> Adding the console name in addition to the character device name, and a
> flag for an added console, could be added to the struct console_cmdline.
> And the console_cmdline array handling could be modified accordingly. But
> that complicates things compared saving the console options, and then
> adding the consoles when the subsystems handling the consoles are ready.

Honestly, I think that the separate array was a bad decision.
It breaks the preferred console handling.
Also I wonder if this duplicates another matching.

Let me explain this in in more details.

First, about breaking the preferred console:

The patchset still causes the regression with /dev/console association
as already reported for v3, see
https://lore.kernel.org/r/ZWnvc6-LnXdjOQLY@alley

I used the following kernel command line:

   earlycon=uart8250,io,0x3f8,115200 console=ttyS0,115200 console=tty0 ignore_loglevel log_buf_len=1M

The patchset caused that /dev/console became associated with
ttyS0 instead of tty0, see the "C" flag:

	original # cat /proc/consoles
	tty0                 -WU (EC    )    4:1
	ttyS0                -W- (E  p a)    4:64

   vs.

	patched # cat /proc/consoles
	ttyS0                -W- (EC p a)    4:64
	tty0                 -WU (E     )    4:1


I have added some debugging messages which nicely show the reason.
In the original code, __add_preferred_console() is called twice
when processing the command line:

[    0.099312] __add_preferred_console[0]: ttyS, 0 (preferrred_console == 0)
[    0.099982] __add_preferred_console[1]: tty, 0 (preferrred_console == 1)

The patchset causes that it is called once again here:

[    0.216268] __add_preferred_console: Updating preferred console: ttyS, 0 [0]
[    0.216271] task:swapper/0       state:R  running task     stack:0     pid:0     tgid:0     ppid:0      flags:0x00000000
[    0.216318] Call Trace:
[    0.216327]  <TASK>
[    0.216337]  sched_show_task.part.0+0x1dd/0x1e7
[    0.216355]  __add_preferred_console.part.0.cold+0x29/0xa4
[    0.216374]  add_preferred_console_match+0x8e/0xb0
[    0.216391]  serial_base_add_prefcon+0x9c/0x140
[    0.216408]  serial8250_isa_init_ports+0x144/0x160
[    0.216423]  ? __pfx_univ8250_console_init+0x10/0x10
[    0.216439]  univ8250_console_init+0x1c/0x30
[    0.216452]  console_init+0x122/0x1c0
[    0.216466]  start_kernel+0x44a/0x590
[    0.216480]  x86_64_start_reservations+0x24/0x30
[    0.216493]  x86_64_start_kernel+0x90/0x90
[    0.216506]  common_startup_64+0x13e/0x141
[    0.216528]  </TASK>

This extra call tries to add "ttyS, 0" once again and it hits this
code:

static int __add_preferred_console(const char *name, const short idx, char *options,
				   char *brl_options, bool user_specified)
{
[...]
	/*
	 *	See if this tty is not yet registered, and
	 *	if we have a slot free.
	 */
	for (i = 0, c = console_cmdline;
	     i < MAX_CMDLINECONSOLES && c->name[0];
	     i++, c++) {
		if (strcmp(c->name, name) == 0 && c->index == idx) {
			if (!brl_options)
---->				preferred_console = i;
			set_user_specified(c, user_specified);
			return 0;
		}
	}


The code thinks that "ttyS0" has been mentioned on the command line
once again. And preferred_console is _wrongly_ set back to '0'.

My view:

The delayed __add_preferred_console() is a way to hell.

The preferences are defined by the ordering on the command line.
All entries have to be added when the command line options are
being proceed to keep the order.

A solution might be to store "devname" separately in
struct console_cmdline and allow empty "name". We could
implement then a function similar to
add_preferred_console_match() which would try to match
"devname" and set/update "name", "index" value when matched.

Note that we might also need to add some synchronization
if it might be possible to modify struct console_cmdline
in parallel.


Second, about the possible duplication:

I might get it wrong. IMHO, in principle, this patchset tries
to achieve similar thing as the "match()" callback, see
the commit c7cef0a84912cab3c9 ("console: Add extensible
console matching").

The .match() callback in struct console is to match, for example,
console=uart8250,io,0x3f8,115200 when the uart8250 driver
calls register_console() when it is being properly initialized
as "ttyS".

BTW: The .match() needs saved options because it internally calls
     .setup() callback. IMHO, this is a very ugly detail
     which complicates design of the register_console() code.


Both approaches try to match a "driver/device-specific name" with
the generic "ttySX".

    console=uart8250,io,0x3f8,115200	=> ttyS0
vs.
    console=00:00:0.0,115200		=> ttyS0


Where console=uart8250,io,0x3f8,115200 is handled by:

    - "uart" is added to console_cmdline[]
    - matched directly via newcon->match() callback

vs. console=00:00:0.0,115200

    - 00:00:0.0 is added to conopt[]
    - "ttyS0" added to console_cmdline[] when "00:00:0.0" initialized
    - "ttyS0" is then matched directly


Question: Would it it be able to use the existing .match() callback
	  also to match the DEVNAME?

	  Or somehow reuse the approach?

	  Could register_console() know how to generate possible
	  DEVNAME for the given struct console?


Best Regards,
Petr

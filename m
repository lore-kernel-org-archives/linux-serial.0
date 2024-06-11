Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002901420B8
	for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2024 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093839; cv=none; b=ivJGjGfoCqmWPO5oTpH3YZAZUD+5/3aZj7RzFyh60PeCZp+lYu2h+FY9voaf5kiVOlyJb3a+4ys85VEB95OdLXiQjZDrMbG8MewvGwD2AdhOubowrNSsHBNN5zHSeaM4OLpsUpNUZ8FjpfyipqePl9ACQ/T42RIxC+mCCA68UL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093839; c=relaxed/simple;
	bh=u0BfZ1AFP88vZkU09TimzUUtpnKGaH53iRLndXi7KL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ingFua1gw87seyzWVvXotAz033SWzULQuVeEQeweKvjkFEgi1MKKC8VYrkfyNMS0Txd5MCY65V4ybg8s86ntx0Kk7Lh8ciDDIS4GrsEGfpVt686cE5iDgwXt1PP1B7Fg9f+r163CvBpDTl2VoHu2R9dYHxVrRAXqnW1+iDRFT/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q6I6lRES; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q6I6lRES"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6269885572so1102009966b.1
        for <linux-serial@vger.kernel.org>; Tue, 11 Jun 2024 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718093834; x=1718698634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvWwJHoslKxzYQEyZt0kRIQQEEIv+HxKbmQGiJlqUBo=;
        b=Q6I6lRESzI9FbTKPnFYwzOEErEkZZCTkN7jpc8PN8FxzYfM6DxAKdGepEDp/XSZpwD
         7Umym0lkoLBlH/IfaUtNExTlc2CVPMFeI5xhi1reU4VvaNqAUAI8smzTJ83yU4Ye4aqq
         cGTs7NsrPA0j1R2wAIEwLwXmkKyAgNOquLiOL8hAnsfrgZbH2f8wLqHuKOmN5gB2A+Ct
         I5B3W+sABftRmac93Gnl1aG8Cd0l9pjOir3eU3ZyATaKcoOpGJE+VGJNuviftzLAeYVc
         uYgt89yMynwoajmLo0Enh1KEqHEPPe3biFPa1ch99qXScCgwIUUjrDDDd2dscMnVHnS6
         f8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718093834; x=1718698634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvWwJHoslKxzYQEyZt0kRIQQEEIv+HxKbmQGiJlqUBo=;
        b=IuP2xNiJ+cj4WcZGBAXZSZxFTJHROBKZl8rXkAkixttrqYkbCoJL4ig+sx7oCvjxQT
         b/VJeWeQDZJT9m+rVhLwTOrA69h9mpmYEQgCBLc6Wt67cbDRsEPddKg2jZj59djTfkY9
         88DH0RuECJxobBuoOfjsvbqog1vzl/vOQF4kwr1rfLJH5UcPNQ5LszY/GM8tKYACef6B
         UcjOV+yPRiQmSfUTopCGm1jVAvR+FxdtUkhcWDz+IKv482BBS2KaL7COrDGBYpxH42fN
         SjvlPU+XEeJ5WJQVshAY6iCv3TOELOiQVbSEU/lX8D7mq5uJTp/rwYqz/yjzQymXDovg
         5IxA==
X-Forwarded-Encrypted: i=1; AJvYcCVNS4TlhXWQZwei7ytj0n04punyopmfOQX6kcKMinE6fMQgsxw8XgzIh+cQ5E2bNJ0vLPVXnrOxc4bfQDiAlLM6e6VdXP1zMhCmGMeV
X-Gm-Message-State: AOJu0YwM3LcpdFghOooTFcjHMeprGrwUUB4P3kEnKpIJkT8fGwpEYB3n
	inD3utemgE6UdGRuz1s7cn5CyeVD0zYyChKIDWjlG5bI7rhZc0++28tellnkb3A=
X-Google-Smtp-Source: AGHT+IEW+VMlgnEm8d+NPvOefgNm9zVog8jv3zVzuxt091u/i+AkhuT8sftwCLy4kiYesmQ7l9LWmw==
X-Received: by 2002:a17:906:28c1:b0:a62:5094:817 with SMTP id a640c23a62f3a-a6f34c9a737mr137605766b.11.1718093834077;
        Tue, 11 Jun 2024 01:17:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef61aa6afsm510437066b.101.2024.06.11.01.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:17:13 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:17:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Track command line console positions to fix
 console order
Message-ID: <ZmgIB2lQaW9oqn3O@pathway.suse.cz>
References: <20240606114149.118633-1-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606114149.118633-1-tony.lindgren@linux.intel.com>

On Thu 2024-06-06 14:41:46, Tony Lindgren wrote:
> Recent changes to allow using DEVNAME:0.0 style console names caused a
> regression to the kernel command line handling for the console options.

Sigh, I have missed that it has already ended in the mainline via
the tty tree :-/

Honestly, I would prefer to revert it and implement it a clean way.
I see a lot of existing and possible problems:

1. Where and how is DEVNAME:0.0 defined?

   The only documentation seems to be in
   Documentation/admin-guide/kernel-parameters.txt for the console=
   parameter:

<paste>
               <DEVNAME>:<n>.<n>[,options]
                        Use the specified serial port on the serial core bus.
                        The addressing uses DEVNAME of the physical serial port
                        device, followed by the serial core controller instance,
                        and the serial port instance. The options are the same
                        as documented for the ttyS addressing above.

                        The mapping of the serial ports to the tty instances
                        can be viewed with:

                        $ ls -d /sys/bus/serial-base/devices/*:*.*/tty/*
                        /sys/bus/serial-base/devices/00:04:0.0/tty/ttyS0

                        In the above example, the console can be addressed with
                        console=00:04:0.0. Note that a console addressed this
                        way will only get added when the related device driver
                        is ready. The use of an earlycon parameter in addition to
                        the console may be desired for console output early on.
</paste>

   This seems to be a brand new bus.

   Is it stable?
   Is it documented in Documentation/ABI/stable/?

   It seems that the feature will cover "only" serial consoles.
   But DEVNAME is a generic name. It might make more sense to
   call it "SERIAL_BASE_DEVNAME" or "SERIAL_DEVNAME" or "SBASE_DEVNAME" or so.

   Anyway, console= is an interface with the user space. We will need to
   maintain the backward compatibility "forever".

      => we should think twice about the interface !!!


2. On my test system (kvm) I get

	# ls -d -1 /sys/bus/serial-base/devices/*:*.*/tty/* | sort -t. -k 2n
	/sys/bus/serial-base/devices/00:00:0.0/tty/ttyS0
	/sys/bus/serial-base/devices/serial8250:0.1/tty/ttyS1
	/sys/bus/serial-base/devices/serial8250:0.2/tty/ttyS2
	/sys/bus/serial-base/devices/serial8250:0.3/tty/ttyS3
	[...]
	/sys/bus/serial-base/devices/serial8250:0.30/tty/ttyS30
	/sys/bus/serial-base/devices/serial8250:0.31/tty/ttyS31

   So, the DEVNAME:X.Y to ttySZ mapping is:

	00:00:0.0	-> ttyS0
	serial8250:0.1	-> ttyS1
	serial8250:0.2	-> ttyS2
	serial8250:0.3	-> ttyS3
	[...]
	serial8250:0.30	-> ttyS30
	serial8250:0.31	-> ttyS31

    Why is ttyS0 associated with "so ugly" DEVNAME "00:00"
    while the rest uses "nice" DEVNAME "serial8250"?

    I would expect:

	serial8250:0.0	-> ttyS0
	serial8250:0.1	-> ttyS1
	serial8250:0.2	-> ttyS2
	[...]



3. The delimiter between "DEVNAME" and X.Y numbers is ":".
   But ":" is also part of the sample DEVNAME "00:00"

   Is it a good idea?

   Is the current naming scheme a well known historic one
   or something invented for the new bus?


4. /sys/bus/serial-base/devices/ contains few more entries:

	# ls -d -1 /sys/bus/serial-base/devices/* | sort -t. -k 2n
	/sys/bus/serial-base/devices/00:00:0
	/sys/bus/serial-base/devices/00:00:0.0
	/sys/bus/serial-base/devices/serial8250:0
	/sys/bus/serial-base/devices/serial8250:0.1
	/sys/bus/serial-base/devices/serial8250:0.2
	/sys/bus/serial-base/devices/serial8250:0.3
	[...]
	/sys/bus/serial-base/devices/serial8250:0.30
	/sys/bus/serial-base/devices/serial8250:0.31


    Are "00:00:0", "00:00:0.0", and "serial8250:0" pointing to
    the same device?

    Could all 3 device names be used for console=DEVNAME:0.0?

    Why the "expected" serial8250:0.0 is missing?


5. The code on the printk side seems to be much more complicated
   than it might be, see below.


> The last preferred console added gets used for init. This is documented
> in the comments for add_preferred_console(). Now the kernel command line
> options for console=ttyS0,115200 console=tty0 are wrongly handled and
> cause the /dev/console to be associated with ttyS0 instead of tty0.
> 
> This happens because we are calling __add_preferred_console() later on
> from serial8250_isa_init_ports() after console_setup() and the console
> gets treated as the last added preferred console. As the DEVNAME:0.0 style
> console device is not known at console_setup() time, and we need to call
> __add_preferred_console() later.
> 
> Let's fix the issue by reserving a position in console_cmdline for a
> deferred console, and then populate the reserved entry before calling
> __add_preferred_console().

Honestly, this looks like a hack.

The original patchset added:

	struct console_option {
		char name[CONSOLE_NAME_MAX];
		char opt[CONSOLE_OPT_MAX];
		char brl_opt[CONSOLE_BRL_OPT_MAX];
		u8 has_brl_opt:1;
	};

	/* Updated only at console_setup() time, no locking needed */
	static struct console_option conopt[MAX_CMDLINECONSOLES];


to keep DEVNAME entries from:

	struct console_cmdline
	{
		char	name[16];			/* Name of the driver	    */
		int	index;				/* Minor dev. to use	    */
		bool	user_specified;			/* Specified by command line vs. platform */
		char	*options;			/* Options for the driver   */
	#ifdef CONFIG_A11Y_BRAILLE_CONSOLE
		char	*brl_options;			/* Options for braille driver */
	#endif
	};

	/*
	 *	Array of consoles built from command line options (console=)
	 */
	static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];

Note that the structures include similar elements except that:

  + @name in console_option is "DEVNAME" style while
    @name in console_cmdline is "ttyS" style name

       => confusing

    it is even more confusing after this patch which added
    @devname into console_cmdline


  + @opt vs @options
  + @brl_opt vs. @brl_options
  + @has_brl_opt vs. NULL pointer semantic

       => many inconsistencies => even more confusion

  + always vs. CONFIG_A11Y_BRAILLE_CONSOLE

       => inconsistent, prone to even compilation bugs

  + nothing vs. @user_specified

       => inconsistent, another complexity, solved hacky way in this patch


OK, it made some sense in the original patchset because you wanted
to keep DEVNAME aside.

But it seems that it just adds complications now.


[ Side note ]

I even do not line the part in drivers/tty/serial/serial_base_bus.c
I guess that:

static int serial_base_device_init(struct uart_port *port,
[...]
		return dev_set_name(dev, "%s:%d.%d", dev_name(port->dev),
				    ctrl_id, port_id);


is related to

int serial_base_add_preferred_console(struct uart_driver *drv,
				      struct uart_port *port)
{
	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
			       port->ctrl_id, port->port_id);


The code should create matching strings => ideally, it should be
shared. But there is not even comment. And it does not even use
the same integer printf format (%d vs. %i) => it can't be
grepped easily.

IMHO, all these small details together create a maintenance nightmare[*].

[*] "Nightmare" might look like a too strong word. Well, there
    were added many "features" to the console registration
    code over the few decades. And it became a real nightmare
    to understand the "rules" and maintain it. You see it yourself.
    Any changes in this area easily create regressions.


> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2426,6 +2426,24 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
>  	console_set_on_cmdline = 1;
>  }
>  
> +/* Checks if a console is the last user specified preferred console */
> +static bool is_last_user_prefcon(int position)
> +{
> +	struct console_cmdline *c = console_cmdline;
> +	int last_user_specified = -1;
> +	int i;
> +
> +	for (i = 0; i < MAX_CMDLINECONSOLES; i++, c++) {
> +		if (!c->name[0] && !c->devname[0])
> +			break;
> +
> +		if (c->user_specified || c->devname[0])

What is the logic behind this, please?

c->user_specified should be set for all entries which were
added by console= parameter. It should be set by
reserve_deferred_console() for the allocated slot
in console_cmdline[]. And if we set the flag there
then this function should not be needed.

> +			last_user_specified = i;
> +	}
> +
> +	return position == last_user_specified;
> +}
> +
>  static int __add_preferred_console(const char *name, const short idx, char *options,
>  				   char *brl_options, bool user_specified)
>  {
> @@ -2542,9 +2581,26 @@ static int __init console_setup(char *str)
>  __setup("console=", console_setup);
>  
>  /* Only called from add_preferred_console_match() */
> -int console_opt_add_preferred_console(const char *name, const short idx,
> -				      char *options, char *brl_options)
> +int console_opt_add_preferred_console(const char *devname, const char *name,
> +				      const short idx, char *options,
> +				      char *brl_options)
>  {
> +	struct console_cmdline *c = console_cmdline;
> +	int i;
> +
> +	/* Populate a reserved console based on devname */
> +	for (i = 0; i < MAX_CMDLINECONSOLES; i++, c++) {
> +		if (!c->name[0] && !strcmp(c->devname, devname)) {
> +			strscpy(c->name, name);
> +			c->index = idx;
> +			c->options = options;
> +#ifdef CONFIG_A11Y_BRAILLE_CONSOLE
> +			c->brl_options = brl_options;
> +#endif
> +			break;

Is there any advantage to have both console_cmdline[] and
conopt[] arrays, please?

reserve_deferred_console() already reserved the slot in
console_cmdline[] by filling c->devname[]. It could have
saved also c->options, c->brl_options there. Then we would not need
to copy them here.

I would prefer to just delete kernel/printk/conopt.c.

Instead, we should re-use __add_preferred_console() also for adding
entries where "SERIAL_BASE_DEVNAME" is defined instead of
"name", "index".

Something like (not even compile tested):

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8b746eeb77fa..c69cd7605836 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2444,18 +2444,23 @@ static bool is_last_user_prefcon(int position)
 	return position == last_user_specified;
 }
 
-static int __add_preferred_console(const char *name, const short idx, char *options,
+static int __add_preferred_console(const char *name, const short idx,
+				   const char *sbase_devname, char *options,
 				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
 	int i;
 
+	if (!name && !sbase_devname)
+		return -EINVAL;
+
 	/*
 	 * We use a signed short index for struct console for device drivers to
 	 * indicate a not yet assigned index or port. However, a negative index
-	 * value is not valid for preferred console.
+	 * value is not valid when the console name and index are defined on
+	 * the command line. 
 	 */
-	if (idx < 0)
+	if (name && idx < 0)
 		return -EINVAL;
 
 	/*
@@ -2463,9 +2468,10 @@ static int __add_preferred_console(const char *name, const short idx, char *opti
 	 *	if we have a slot free.
 	 */
 	for (i = 0, c = console_cmdline;
-	     i < MAX_CMDLINECONSOLES && (c->name[0]);
+	     i < MAX_CMDLINECONSOLES && (c->name[0] || c->sbase_devname[0]);
 	     i++, c++) {
-		if (strcmp(c->name, name) == 0 && c->index == idx) {
+		if ((name && strcmp(c->name, name) == 0 && c->index == idx) ||
+		    (devname && strcmp(c->name, name) == 0)) {
 			if (!brl_options)
 				preferred_console = i;
 			set_user_specified(c, user_specified);
@@ -2476,7 +2482,10 @@ static int __add_preferred_console(const char *name, const short idx, char *opti
 		return -E2BIG;
 	if (!brl_options)
 		preferred_console = i;
-	strscpy(c->name, name, sizeof(c->name));
+	if (name)
+		strscpy(c->name, name, sizeof(c->name));
+	if (sbase_devname)
+		strscpy(c->sbase_devname, sbase_devname, sizeof(c->sbase_devname));
 	c->options = options;
 	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);


The function matching sbase_devname in serial_base_bus.c should
iterate over entries in console_cmdline and ignore entries
with !c->sbase_devname[0].

On success, the function should just set @name to "ttyS" and
@index to the matching one.

On the contrary, the cycles in register_console() would ignore
entries with !c->name[0].

And we are done. There should not be needed any special changes in
the logic for preferred console.

If the users defines a non-existing console=SBASE_DEVNAME:X.Y then
c->name and c->index will never be set. But it is OK. It will be
the same as when user defines a non-existing console=blabla
on the command line.

Best Regards,
Petr

PS: I am sorry that I did not pay more attention to the original
    patchset. I was overloaded, had healthy issues, and it was
    not easy to balance the priorities.

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v5 3/3] printk: fix double printing with earlycon
Date: Thu, 16 Mar 2017 16:30:13 +0900
Message-ID: <20170316073013.GC464@jagdpanzerIV.localdomain>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170315102854.1763-4-aleksey.makarov@linaro.org>
 <20170315165858.GJ3977@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170315165858.GJ3977@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, Petr Mladek <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/15/17 17:58), Petr Mladek wrote:
[..]
> On Wed 2017-03-15 13:28:52, Aleksey Makarov wrote:
> > If a console was specified by ACPI SPCR table _and_ command line
> > parameters like "console=ttyAMA0" _and_ "earlycon" were specified,
> > then log messages appear twice.
> > 
> > The root cause is that the code traverses the list of specified
> > consoles (the `console_cmdline` array) and stops at the first match.
> > But it may happen that the same console is referred by the elements
> > of this array twice:
> > 
> > 	pl011,mmio,0x87e024000000,115200 -- from SPCR
> > 	ttyAMA0 -- from command line
> > 
> > but in this case `preferred_console` points to the second entry and
> > the flag CON_CONSDEV is not set, so bootconsole is not deregistered.
> > 
> > To fix that, introduce an invariant "The last non-braille console
> > is always the preferred one" on the entries of the console_cmdline
> > array and don't try to check for double entries.  Then traverse it
> > in reverse order to be sure that if the console is preferred then
> > it will be the first matching entry.

overall this approach looks interesting. but I need to look more at
this, since I'm not really familiar with this console registration thing.

your reverse traversal, Aleksey, makes sense to me, but there might be
things I'm missing.

> > @@ -1902,20 +1902,25 @@ static int __add_preferred_console(char *name, int idx, char *options,
> >  	int i;
> >  
> >  	/*
> > -	 *	See if this tty is not yet registered, and
> > -	 *	if we have a slot free.
> > +	 * Don't check if the console has already been registered, because it is
> > +	 * pointless.  After all, we can not check if two entries refer to
> > +	 * the same console if one is matched with console->match(), and another
> > +	 * by name/index:
> > +	 *
> > +	 *	pl011,mmio,0x87e024000000,115200 -- added from SPCR
> > +	 *	ttyAMA0 -- added from command line
> > +	 *
> > +	 * Also this allows to maintain an invariant that will help to find if
> > +	 * the matching console is preferred, see register_console():
> 
> It is an interesting idea.
> 
> I just wonder if the check for duplicates was there for a serious
> reason. It is hard to say because it was already in the initial git
> commit. In each case, MAX_CMDLINECONSOLES is 8. There is not much
> space for duplicates.

hm. as Petr mentioned, device tree may have its own console preferences
specified via stdout-path or linux,stdout-path. which ends up in
	of_console_check()->add_preferred_console().
so we may look at a mix of command line, ACPI port redirection and DT.
DT may have aliases, etc. but I still suspect that that strcmp() is
probably not be completely pointless. some drivers call add_preferred_console()
directly, passing entries that might present in command line. e.g.
	add_preferred_console("ttyS", 2, "115200");



by the way.
we might have a memory leak there.

drivers/of/base.c

bool of_console_check(struct device_node *dn, char *name, int index)
{
	if (!dn || dn != of_stdout || console_set_on_cmdline)
		return false;
	return !add_preferred_console(name, index,
				      kstrdup(of_stdout_options, GFP_KERNEL));
}

printk/printk.c

static int __add_preferred_console(char *name, int idx, char *options,
				   char *brl_options)
{
	struct console_cmdline *c;
	int i;

	/*
	 *	See if this tty is not yet registered, and
	 *	if we have a slot free.
	 */
	for (i = 0, c = console_cmdline;
	     i < MAX_CMDLINECONSOLES && c->name[0];
	     i++, c++) {
		if (strcmp(c->name, name) == 0 && c->index == idx) {
			if (!brl_options)
				selected_console = i;
			return 0;
		}
	}
	if (i == MAX_CMDLINECONSOLES)
		return -E2BIG;
	if (!brl_options)
		selected_console = i;
	strlcpy(c->name, name, sizeof(c->name));
	c->options = options;
	braille_set_options(c, brl_options);

	c->index = idx;
	return 0;
}

int add_preferred_console(char *name, int idx, char *options)
{
	return __add_preferred_console(name, idx, options, NULL);
}



kstrdup()-ed stdout options passed from of_console_check() are getting
lost when:

  a) __add_preferred_console() returns -E2BIG
  b) __add_preferred_console() finds a duplicate entry in console_cmdline


> I would feel more comfortable if we keep the check for
> duplicates here.

I would agree.

	-ss

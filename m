From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v9 4/4] serial: pl011: add console matching function
Date: Mon, 15 Aug 2016 16:10:19 +0300
Message-ID: <aaf6c8c4-d3a5-35cf-daff-0309a6bb073f@linaro.org>
References: <20160811153152.755-1-aleksey.makarov@linaro.org>
 <20160811153152.755-5-aleksey.makarov@linaro.org>
 <20160815123934.GJ1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160815123934.GJ1041@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org



On 08/15/2016 03:39 PM, Russell King - ARM Linux wrote:
> On Thu, Aug 11, 2016 at 06:31:41PM +0300, Aleksey Makarov wrote:
>> +/**
>> + *	pl011_console_match - non-standard console matching
>> + *	@co:	  registering console
>> + *	@name:	  name from console command line
>> + *	@idx:	  index from console command line
>> + *	@options: ptr to option string from console command line
>> + *
>> + *	Only attempts to match console command lines of the form:
>> + *	    console=pl011,mmio|mmio32,<addr>[,<options>]
>> + *	    console=pl011,0x<addr>[,<options>]
>> + *	This form is used to register an initial earlycon boot console and
>> + *	replace it with the amba_console at pl011 driver init.
>> + *
>> + *	Performs console setup for a match (as required by interface)
>> + *	If no <options> are specified, then assume the h/w is already setup.
>> + *
>> + *	Returns 0 if console matches; otherwise non-zero to use default matching
>> + */
>> +static int __init pl011_console_match(struct console *co, char *name, int idx,
>> +				      char *options)
>> +{
>> +	char match[] = "pl011";	/* pl011-specific earlycon name */
> 
> This is inefficient - the compiler will probably store "pl011" in the
> rodata section, then allocate an array on the stack, and them memcpy()
> it onto the stack.  This is really a false optimisation.
> 
>> +	unsigned char iotype;
>> +	unsigned long addr;
>> +	int i;
>> +
>> +	if (strncmp(name, match, 5) != 0)
> 
> Just do:
> 
> 	if (strncmp(name, "pl011", 5) != 0)
> 
> here, and let the compiler work it out - it'll probably place "pl011"
> in the rodata section, and use a pointer to it rather than messing around
> with the stack.

Thank you, I will change it.

> What if "console=pl011x,..." is passed?  Should this be matched too?
> Maybe this should compare with "pl011," to ensure that the name is
> correctly terminated?

You are right, if the argument 'name' is longer than just "pl011" it
will wrongly match.  But note that it's always just name of the console
without ',' and parameters that is passed in the 'name' argument.  So I
think we should just use strcmp() here.

BTW, the function univ8250_console_match() from
drivers/tty/serial/8250/8250_core.c probably has the same issue.

Thank you
Aleksey Makarov

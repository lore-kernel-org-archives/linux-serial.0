From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Sat, 13 May 2017 20:48:40 +0900
Message-ID: <20170513114840.GA420@tigerII.localdomain>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170509082915.GA13236@bistromath.localdomain>
 <20170511082433.GA421@jagdpanzerIV.localdomain>
 <20170511084158.GB421@jagdpanzerIV.localdomain>
 <20170512125729.GO3452@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170512125729.GO3452@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Sabrina Dubroca <sd@queasysnail.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (05/12/17 14:57), Petr Mladek wrote:
[..]
> I have tried to reproduce the problem and started kernel with
> console=ttyS1 console=ttyS0 in qemu. It created:
> 
> 	console_cmdline = {{
> 				.name = "ttyS";
> 				.index = 1;		// from ttyS1
> 			   },{
> 				.name = "ttyS"
> 				.index = 0;		// from ttyS0
> 			   }};
> 	preferred_console = 1;		// ttyuS0;
> 
> 
> Then register_console() is called twice here. First time
> from con_init() that registers:
> 
> 	static struct console vt_console_driver = {
> 		.name		= "tty",
> 		.write		= vt_console_print,
> 		.device		= vt_console_device,
> 		.unblank	= unblank_screen,
> 		.flags		= CON_PRINTBUFFER,
> 		.index		= -1,
> 	};
> 
> 	It does not match and it is not enabled here.
> 
> 
> 2nd times from univ8250_console_init() that registers:
> 
> 	static struct console univ8250_console = {
> 		.name		= "ttyS",
> 		.write		= univ8250_console_write,
> 		.device		= uart_console_device,
> 		.setup		= univ8250_console_setup,
> 		.match		= univ8250_console_match,
> 		.flags		= CON_PRINTBUFFER | CON_ANYTIME,
> 		.index		= -1,
> 		.data		= &serial8250_reg,
> 	};
> 
> 	It matches both console_cmdline entries because index = -1.
> 	The first tested is selected.

yes, that's what I observed on my host. I didn't try it with qemu,
just 86_64. and the behaviour was different.

[..]
> In fact, it always was kind of random because both init calls are
> defined as
> 
> 	console_initcall(con_init);
> 	console_initcall(univ8250_console_init);
> 
> They are put into special elf section and called from console_init()
> the following way:
> 
> 	call = __con_initcall_start;
> 	while (call < __con_initcall_end) {
> 		(*call)();
> 		call++;
> 	}
> 
> By other words, the order depends on the linking order which is
> kind of weak order enforcement.
> 
> I am not sure if we broke some backward compatibility or actually made
> it more predictable in the long term.

well, we changed the behaviour. some automated scripts somewhere might
get broken. so may be this is the case when "a bug" becomes "a feature".
well, just saying.

	-ss

From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Sun, 14 May 2017 23:37:50 +0300
Message-ID: <7d312633-d040-240d-ec06-ed296b5251ae@linaro.org>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170509082915.GA13236@bistromath.localdomain>
 <20170511082433.GA421@jagdpanzerIV.localdomain>
 <20170511084158.GB421@jagdpanzerIV.localdomain>
 <20170512125729.GO3452@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170512125729.GO3452@pathway.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org



On 05/12/2017 03:57 PM, Petr Mladek wrote:
> On Thu 2017-05-11 17:41:58, Sergey Senozhatsky wrote:
>> On (05/11/17 17:24), Sergey Senozhatsky wrote:
>>> On (05/09/17 10:29), Sabrina Dubroca wrote:
>>> [..]
>>>> That's caused a change of behavior in my qemu setup, with this cmdline
>>>>
>>>>      root=/dev/sda1 console=ttyS1 console=ttyS0
>>>>
>>>> Before, the kernel logs appeared on ttyS1, and I logged in with ttyS0
>>>> (with my setup, ttyS1 is a file and ttyS0 is unix socket). Now, the
>>>> kernel logs go to ttyS0. I need to swap the two console= parameters to
>>>> restore behavior.
>>>>
>>>> There might be some other problem (in qemu?) though, because adding
>>>> console=tty0 anywhere on that cmdline makes the logs appear on both
>>>> tty0 and one ttyS* (but only one of them, and the ordering of the
>>>> ttyS* matters).
>>>
>>> thanks for the report.
>>>
>>> so we have ttyS1 first and ttyS0 last.
>>> after commit in question, register_console() iterates console_cmdline
>>> in reverse order so we see ttyS0 first, then we hit `if (newcon->index < 0)'
>>> condition, set newcon to ttyS0, because we iterate in reverse order now, and
>>> break out. so we enable ttyS0, instead of ttyS1.
>>>
>>> previously, we iterated console_cmdline from index 0 and saw ttyS1 first.
>>> so the same `if (newcon->index < 0)' condition would set newcone to ttyS1,
>>> and, thus, we would enable ttyS1, not ttyS0.
>>
>> Alexey,
>> can we have preferred console at offset 0 (not at console_cmdline_cnt - 1)
>> and restore the previous register_console() iteration order?
> 
> This will not help. ttyS0 is the last console defined on the command
> line. Therefore it is the preferred one. It means that it will be
> moved to offset 0 and hit first.
> 
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
> 
> 
> Hmm, I have no idea how to fix this. This is the case where
> a registered console matches more entries from the command line.
> The fix that caused this regression fixed exactly this situation
> and we wanted to make the preferred console first.

The problem is that when we are registering a new console,
we walk over the `console_cmdline` list and match _only one_ of
the specified consoles, contrary to what stated in
Documentation/admin-guide/serial-console.rst:

	You can specify multiple console= options on the kernel
	command line. Output will appear on *all* of them.

I emphasized all here.  Moreover, it is impossible to fix this
without deep reworking of all the console framework.

So specifying same console twice (with different lines) is pointless --
only one of them will be used for kernel logs.  You don't have to
specify it in command line if you just want to login on it
and don't want to see kernel logs on it.

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

The order in which consoles are registered is not relevant.
It's command line parameters order that matters.

> I am not sure if we broke some backward compatibility or actually made
> it more predictable in the long term.

I believe that we broke the way an old unfixed bug shows itself.

But reproducing this bug requires to specify the same console
in command line twice (with different lines), which is pointless
so I would say it is irrelevant.

Thank you
Aleksey Makarov

From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Fri, 26 May 2017 12:37:12 +0300
Message-ID: <4e679bec-4804-9791-fc2b-0e96ad67d511@linaro.org>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170509082915.GA13236@bistromath.localdomain>
 <20170511082433.GA421@jagdpanzerIV.localdomain>
 <20170511084158.GB421@jagdpanzerIV.localdomain>
 <20170512125729.GO3452@pathway.suse.cz>
 <7d312633-d040-240d-ec06-ed296b5251ae@linaro.org>
 <20170518154918.GE8621@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170518154918.GE8621@pathway.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org



On 05/18/2017 06:49 PM, Petr Mladek wrote:
> On Sun 2017-05-14 23:37:50, Aleksey Makarov wrote:
>> 
>> 
>> On 05/12/2017 03:57 PM, Petr Mladek wrote:
>>> On Thu 2017-05-11 17:41:58, Sergey Senozhatsky wrote:
>>>> On (05/11/17 17:24), Sergey Senozhatsky wrote:
>>>>> On (05/09/17 10:29), Sabrina Dubroca wrote: [..]
>>>>>> That's caused a change of behavior in my qemu setup, with
>>>>>> this cmdline
>>>>>> 
>>>>>> root=/dev/sda1 console=ttyS1 console=ttyS0
>>>>>> 
>>>>>> Before, the kernel logs appeared on ttyS1, and I logged in
>>>>>> with ttyS0 (with my setup, ttyS1 is a file and ttyS0 is
>>>>>> unix socket). Now, the kernel logs go to ttyS0. I need to
>>>>>> swap the two console= parameters to restore behavior.
>>>>>> 
>>>>>> There might be some other problem (in qemu?) though,
>>>>>> because adding console=tty0 anywhere on that cmdline makes
>>>>>> the logs appear on both tty0 and one ttyS* (but only one of
>>>>>> them, and the ordering of the ttyS* matters).
>>>>> 
>> 
>> The problem is that when we are registering a new console, we walk
>> over the `console_cmdline` list and match _only one_ of the
>> specified consoles, contrary to what stated in 
>> Documentation/admin-guide/serial-console.rst:
>> 
>> You can specify multiple console= options on the kernel command
>> line. Output will appear on *all* of them.
> 
> and from the other mail:
> 
>> Last mentioned 'console=' (preferred console) is the console that 
>> should become /dev/console.  Its driver is returned by
>> console_device(). In other respects the last mentioned console is
>> not special, so I believe it is irrelevant to the report.
> 
> Thanks a lot for explanation. I missed these pieces.
> 
> But this also means that your commit cf39bf58afdaabc0b ("printk: fix
> double printing with earlycon") helps only when the duplicate of the
> boot console is defined as the preferred one.
> 
> Well, the reverse order of searching the console_cmdline might help
> also in other cases but it is weird approach.
> 
> 
>> I emphasized all here.  Moreover, it is impossible to fix this 
>> without deep reworking of all the console framework.
> 
> IMHO, the same is true also for fixing the bug with double printing
> correctly. The current fix helps in some situations but it might
> break others. The question is how many people will see the good and
> "bad" effects.

I meant that it is difficult to fix the bug that only one line
(first matched) of registered console device receives kernel logs.
That is because of 'index' field of struct console can refer to only one
tty line.

I re-evaluated the "printk: fix double printing with earlycon"
patch and still think it is ok as it breaks only situations
that should not happen, when different lines of the same
console are registered in console_cmdline. But I agree that
someone else with more experience should decide.

- The reason why logs appear twice is that earlycon is not
deregistered after non-early consoles are available.

- Earlycon is not deregistered because in some cases
flag CON_CONSDEV is not set for any of the new non-early
consoles.

- That flag is not set when two entries of console_cmdline
array refer to the same console.  We match the first entry,
it is not preferred and the flag CON_CONSDEV is set only
for preferred console.

- So I changed the order of array walk so that if there
are two entries referring to the same console, last one is matched.
If we specify a console as prefered (last entry in command line)
that means that we expect a driver will eventually register
its console and for that driver we will match the last
entry and the earlycon will be deregistered.

- The subtle question is why we deregister earlycon only
when CON_CONSDEV is set (i. e. only for preferred console).
That check for CON_CONSDEV was initially introduced in

d37bf60de0b4 console: console handover to preferred console

and then refactored in

4d09161196c9 printk: Enable the use of more than one CON_BOOT (early console)
8259cf434202 printk: Ensure that "console enabled" messages are printed on the console

The reason is that some consoles can be registered later or earlier
and if we deregister earlycon when the first non-early console
is registered, we can lose some lines of log.  To prevent that
we specify the console *which is being watched* as preferred
(the last console in the console_cmdline array) and
deregister earlycon only when kernel registers its driver.

> BTW: I wonder if we really need to add consoles defined by ACPI SPCR
> table into the console_cmdline array.

The console_cmdline array is the place where we add descriptions
of consoles that should receive log output.  ACPI SPCR specifies exactly
that information, and I believe it should go to that array.
I don't quite follow your concern.

> I am even more curious when
> seeing the following code in drivers/acpi/spcr.c:
> 
> int __init parse_spcr(bool earlycon) { [...] if (earlycon) 
> setup_earlycon(opts);
> 
> err = add_preferred_console(uart, 0, opts + strlen(uart) + 1); }
> 
> It seems that we setup (register) the early console before we add it
> to the console_cmdline array. Do we really need to call
> add_preferred_console() for these early consoles?

Yes we need.  When we setup an earlycon, we enable output
to that console immediately.  Drivers can register its real
non-early consoles much later so we just add description
of that consoles to the console_cmdline arraly so that
when the driver registers a matching driver, earlycon is replaced
by a regular device.  Or maybe I don't understand your concern here.

> If we do not call add_preferred_console() here, it should fix the
> duplicate output as well. Or do I still miss something?

Yes it will "fix", but the output will be from earlycon.
We want to replace earlycon with non-early console eventually
and that is why we call add_preferred_console() here.

Thank you
Aleksey Makarov

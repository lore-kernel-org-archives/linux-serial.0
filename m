From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH 1/2] printk: Unconditionally unregister boot consoles if
 in init section
Date: Fri, 7 Jul 2017 08:58:01 +0100
Message-ID: <0212d098-e307-2ea1-cb41-1e81d545da56@imgtec.com>
References: <1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com>
 <20170707044537.GB7478@jagdpanzerIV.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707044537.GB7478@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 07/07/17 05:45, Sergey Senozhatsky wrote:
> On (07/06/17 11:38), Matt Redfearn wrote:
>> Commit 4c30c6f566c0 ("kernel/printk: do not turn off bootconsole in
>> printk_late_init() if keep_bootcon") added a check on keep_bootcon to
>> ensure that boot consoles were kept around until the real console is
>> registered.
>> This can lead to problems if the boot console data and code are in the
>> init section, since it can be freed before the boot console is
>> deregistered. This was fixed by commit 81cc26f2bd11 ("printk: only
>> unregister boot consoles when necessary").
>> The keep_bootcon flag prevents the unregistration of a boot console,
>> even if it's data and code reside in the init section and are about to
>> be freed. This can lead to crashes and weird panics when the bootconsole
>> is accessed after free, especially if page poisoning is in use and the
>> code / data have been overwritten with a poison value.
>> To prevent this, always free the boot console if it is within the init
>> section.
>>
>> Fixes 81cc26f2bd11 ("printk: only unregister boot consoles when necessary").
>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> well... hm. don't specify `keep_bootcon' if your bootcon access initdata?
> keeping `early_printk' sometimes can be helpful and people even want to
> use `early_printk' as a panic() console fallback (because of those nasty
> deadlocks that spoil printk->call_console_drivers()).
>
> if someone asked to `keep_bootcon' but we actually don't keep it, then
> what's the purpose of the flag and
> 	pr_info("debug: skip boot console de-registration.\n")?

Sure, but as a user, how are you supposed to know that? And if your 
kernel is configured with SLAB poisoning, when the earlycon resident in 
initdata is freed all of it's text and data is replaced with a poison 
value, meaning it definitely won't work anymore anyway, and will instead 
likely just panic the kernel, often with a completely meaningless 
message (I know, because that's how I tracked down the need for this patch).
With this patch, the earlycon will only be unregistered if it is in the 
init section and will no longer be functional anyway. Perhaps it would 
be better to change the structure to make that more explicit, something 
like:

                 if ((con->flags & CON_BOOT) && 
init_section_intersects(con, sizeof(*con))) {
/*
                          * Make sure to unregister boot consoles whose 
data
                          * resides in the init section before the init 
section
                          * is discarded. Boot consoles whose data will 
stick
                          * around will automatically be unregistered 
when the
                          * proper console replaces them.
*/
unregister_console(con);
                 }

Thanks,
Matt

>
>
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index a1db38abac5b..b5411f44eed4 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2660,7 +2660,7 @@ static int __init printk_late_init(void)
>>   	int ret;
>>   
>>   	for_each_console(con) {
>> -		if (!keep_bootcon && con->flags & CON_BOOT) {
>> +		if (con->flags & CON_BOOT) {
>>   			/*
>>   			 * Make sure to unregister boot consoles whose data
>>   			 * resides in the init section before the init section
> what about bootconsoles that are still not getting de-registered due
> to keep_bootcon in register_console()?
>
> 	-ss

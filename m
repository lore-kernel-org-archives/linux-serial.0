From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v7 1/5] of/serial: move earlycon early_param handling to
 serial
Date: Thu, 31 Mar 2016 21:21:34 +0300
Message-ID: <56FD6AAE.3090001@linaro.org>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1459431629-27934-2-git-send-email-aleksey.makarov@linaro.org>
 <20160331163203.GC10256@kroah.com> <56FD5894.3060105@linaro.org>
 <20160331173732.GA10567@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160331173732.GA10567@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 03/31/2016 08:37 PM, Greg Kroah-Hartman wrote:
> On Thu, Mar 31, 2016 at 08:04:20PM +0300, Aleksey Makarov wrote:
>>
>>
>> On 03/31/2016 07:32 PM, Greg Kroah-Hartman wrote:
>>> On Thu, Mar 31, 2016 at 04:40:23PM +0300, Aleksey Makarov wrote:
>>>> From: Leif Lindholm <leif.lindholm@linaro.org>
>>>>
>>>> We have multiple "earlycon" early_param handlers - merge the DT one into
>>>> the main earlycon one.  It's a cleanup that also will be useful
>>>> to defer setting up DT console until ACPI/DT decision is made.
>>>>
>>>> Rename the exported function to avoid clashing with the function from
>>>> arch/microblaze/kernel/prom.c
>>>>
>>>> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
>>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>> ---
>>>>  drivers/of/fdt.c              | 11 +----------
>>>>  drivers/tty/serial/earlycon.c |  2 +-
>>>>  include/linux/of_fdt.h        |  2 ++
>>>>  3 files changed, 4 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>>> index 3349d2a..b50f775 100644
>>>> --- a/drivers/of/fdt.c
>>>> +++ b/drivers/of/fdt.c
>>>> @@ -805,7 +805,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
>>>>  
>>>>  #ifdef CONFIG_SERIAL_EARLYCON
>>>>  
>>>> -static int __init early_init_dt_scan_chosen_serial(void)
>>>> +int __init early_init_dt_scan_chosen_stdout(void)
>>>>  {
>>>>  	int offset;
>>>>  	const char *p, *q, *options = NULL;
>>>> @@ -849,15 +849,6 @@ static int __init early_init_dt_scan_chosen_serial(void)
>>>>  	}
>>>>  	return -ENODEV;
>>>>  }
>>>> -
>>>> -static int __init setup_of_earlycon(char *buf)
>>>> -{
>>>> -	if (buf)
>>>> -		return 0;
>>>> -
>>>> -	return early_init_dt_scan_chosen_serial();
>>>> -}
>>>> -early_param("earlycon", setup_of_earlycon);
>>>>  #endif
>>>>  
>>>>  /**
>>>> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
>>>> index 067783f..7aae655 100644
>>>> --- a/drivers/tty/serial/earlycon.c
>>>> +++ b/drivers/tty/serial/earlycon.c
>>>> @@ -209,7 +209,7 @@ static int __init param_setup_earlycon(char *buf)
>>>>  	 * don't generate a warning from parse_early_params() in that case
>>>>  	 */
>>>>  	if (!buf || !buf[0])
>>>> -		return 0;
>>>> +		return early_init_dt_scan_chosen_stdout();
>>>>  
>>>>  	err = setup_earlycon(buf);
>>>>  	if (err == -ENOENT || err == -EALREADY)
>>>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>>>> index 2fbe868..5cfe322 100644
>>>> --- a/include/linux/of_fdt.h
>>>> +++ b/include/linux/of_fdt.h
>>>> @@ -63,6 +63,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
>>>>  				     int depth, void *data);
>>>>  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
>>>>  				     int depth, void *data);
>>>> +extern int early_init_dt_scan_chosen_stdout(void);
>>>>  extern void early_init_fdt_scan_reserved_mem(void);
>>>>  extern void early_init_fdt_reserve_self(void);
>>>>  extern void early_init_dt_add_memory_arch(u64 base, u64 size);
>>>> @@ -91,6 +92,7 @@ extern void early_get_first_memblock_info(void *, phys_addr_t *);
>>>>  extern u64 of_flat_dt_translate_address(unsigned long node);
>>>>  extern void of_fdt_limit_memory(int limit);
>>>>  #else /* CONFIG_OF_FLATTREE */
>>>> +static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
>>>
>>> Doesn't this change the default logic?  Today you are returning 0 if you
>>> don't have this config option set,
>>
>> I am not sure I understand this.  Which return value do you mean?
>>
>> 1. early_init_dt_scan_chosen_stdout()
>>
>> Today if CONFIG_OF_FLATTREE is not set then early_init_dt_scan_chosen_stdout() does not exist.
> 
> It "exists" in that you return -ENODEV, right?  Look at the place where
> you called this function,

It's param_setup_earlycon() so see below for explanations.

> previously you returned 0, now you return this
> function call's return value.
> 
>> 2. param_setup_earlycon()
>>
>> Today we have 2 handlers for "earlycon" option.  One (in fdt.c) is for the option without args,
>> and another (earlycon.c) always expects agrs.  But both return 0 for the opposite cases becasue they
>> can not check what another hander returns.
>>
>> Now we have just one handler and it can return correct value.
> 
> I don't understand.

This patch deletes early_param("earlycon", setup_of_earlycon) from fdt.c and
keeps early_param("earlycon", param_setup_earlycon) in earlycon.c.

Assume "earlycon" kernel command line parameter was passed without arguments.

Before this patch:

early_init_dt_scan_chosen_stdout() is called from setup_of_earlycon()
where its return value is returned to parse_early_param()

After this patch:

early_init_dt_scan_chosen_stdout() is called from param_setup_earlycon()
so we should return its return value from param_setup_earlycon() if we want
to pass it to parse_early_param().

>>>  and now you return -ENODEV, did you
>>> test this out?
>>
>> Yes, I tested it.
> 
> On what platforms?  With what configurations?

platform: QEMU
configuration options: with/without acpi, dt
command line options: with/without "earlycon", "earlycon=..."

Thank you
Aleksey Makarov

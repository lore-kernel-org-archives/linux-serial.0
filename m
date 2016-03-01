From: Aleksey Makarov <amakarov.linux@gmail.com>
Subject: Re: [PATCH v3 1/7] of/serial: move earlycon early_param handling to
 serial
Date: Tue, 1 Mar 2016 20:52:45 +0300
Message-ID: <56D5D6ED.7050806@gmail.com>
References: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
 <1456749726-30261-2-git-send-email-aleksey.makarov@linaro.org>
 <56D5AC3B.3090806@hurleysoftware.com> <56D5C3F8.5050102@linaro.org>
 <56D5D035.2060704@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56D5D035.2060704@hurleysoftware.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 03/01/2016 08:24 PM, Peter Hurley wrote:
> On 03/01/2016 08:31 AM, Aleksey Makarov wrote:
>>
>>
>> On 03/01/2016 05:50 PM, Peter Hurley wrote:
>>> On 02/29/2016 04:41 AM, Aleksey Makarov wrote:
>>>> From: Leif Lindholm <leif.lindholm@linaro.org>
>>>>
>>>> We have multiple "earlycon" early_param handlers - merge the DT one into
>>>> the main earlycon one. This means the earlycon early_param handler does
>>>> not just return success if no options are specified.
>>>
>>> Why is this patch necessary?
>>>
>>> Is this cleanup or required for some reason in other parts of this
>>> series?
>>
>> It's a cleanup.
>>
>> Also, without this, the series has to introduce a new (third) handler for "earlycon=".
> 
> Not if it were opt-in like OF is via the same blank
> "earlycon" parameter.

So you are suggesting to enable ACPI earlycon with just "earlyon" without 
any arguments to this paramener, right?  That's good idea as OF and ACPI
can not be used simultaneously to specify earlycon.  Actually that is
how it worked in the original submussion. I will change this in the next version.

Still I think that having this parameter parsed in one place is a good idea.
Or would you prefer to drop this patch?

>>>> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
>>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>>> ---
>>>>  drivers/of/fdt.c              | 11 +----------
>>>>  drivers/tty/serial/earlycon.c |  3 ++-
>>>>  include/linux/of_fdt.h        |  2 ++
>>>>  3 files changed, 5 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>>> index 3349d2a..0547256 100644
>>>> --- a/drivers/of/fdt.c
>>>> +++ b/drivers/of/fdt.c
>>>> @@ -805,7 +805,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
>>>>  
>>>>  #ifdef CONFIG_SERIAL_EARLYCON
>>>>  
>>>> -static int __init early_init_dt_scan_chosen_serial(void)
>>>> +int __init early_init_dt_scan_chosen_serial(void)
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
>>>> index 067783f..d217366 100644
>>>> --- a/drivers/tty/serial/earlycon.c
>>>> +++ b/drivers/tty/serial/earlycon.c
>>>> @@ -17,6 +17,7 @@
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/init.h>
>>>>  #include <linux/io.h>
>>>> +#include <linux/of_fdt.h>
>>>>  #include <linux/serial_core.h>
>>>>  #include <linux/sizes.h>
>>>>  #include <linux/of.h>
>>>> @@ -209,7 +210,7 @@ static int __init param_setup_earlycon(char *buf)
>>>>  	 * don't generate a warning from parse_early_params() in that case
>>>>  	 */
>>>>  	if (!buf || !buf[0])
>>>> -		return 0;
>>>> +		return early_init_dt_scan_chosen_serial();
>>>>  
>>>>  	err = setup_earlycon(buf);
>>>>  	if (err == -ENOENT || err == -EALREADY)
>>>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>>>> index 2fbe868..56b2a43 100644
>>>> --- a/include/linux/of_fdt.h
>>>> +++ b/include/linux/of_fdt.h
>>>> @@ -63,6 +63,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
>>>>  				     int depth, void *data);
>>>>  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
>>>>  				     int depth, void *data);
>>>> +extern int early_init_dt_scan_chosen_serial(void);
>>>>  extern void early_init_fdt_scan_reserved_mem(void);
>>>>  extern void early_init_fdt_reserve_self(void);
>>>>  extern void early_init_dt_add_memory_arch(u64 base, u64 size);
>>>> @@ -91,6 +92,7 @@ extern void early_get_first_memblock_info(void *, phys_addr_t *);
>>>>  extern u64 of_flat_dt_translate_address(unsigned long node);
>>>>  extern void of_fdt_limit_memory(int limit);
>>>>  #else /* CONFIG_OF_FLATTREE */
>>>> +static inline int early_init_dt_scan_chosen_serial(void) { return -ENODEV; }
>>>>  static inline void early_init_fdt_scan_reserved_mem(void) {}
>>>>  static inline void early_init_fdt_reserve_self(void) {}
>>>>  static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
>>>>
>>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

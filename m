From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v7 0/5] ACPI: parse the SPCR table
Date: Wed, 6 Apr 2016 09:27:28 -0700
Message-ID: <570538F0.1030701@hurleysoftware.com>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1459873627.10130.21.camel@redhat.com> <5704E3CC.8000104@linaro.org>
 <20160406105252.GB2820@xora-haswell.xora.org.uk>
 <1459952294.10130.32.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1459952294.10130.32.camel@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, linux-acpi@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Yury Norov <ynorov@caviumnetworks.com>, "Zheng, Lv" <lv.zheng@intel.com>, linux-serial@vger.kernel.org, Len Brown <lenb@kernel.org>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Christopher Covington <cov@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 04/06/2016 07:18 AM, Mark Salter wrote:
> On Wed, 2016-04-06 at 11:52 +0100, Graeme Gregory wrote:
>> On Wed, Apr 06, 2016 at 01:24:12PM +0300, Aleksey Makarov wrote:
>>>
>>>
>>>
>>> On 04/05/2016 07:27 PM, Mark Salter wrote:
>>>>
>>>> Could you CC me on future postings of this series, please?
>>>>
>>>> So v3 fixed a problem where platforms using 8250 didn't work.
>>>> Then in v5, that fix was lost so 8250 no longer works.
>>> That fix was dropped because now this is implemented differently.  
>>> Now the code uses the existing match() member of struct console.
>>> It has already been implemented for 8250.  
>>> Probably SPCR table specifies incorrect data.
>>> It was reported that D02 board has similar issue.
>>>
>> The D02 issue referred to is the 8250 implementation they used has 32bit
>> only MMIO access which there is no manner to represent in SPCR. It also
>> doesn't use the "standard" 16550 clock rate so supplying a baud rate
>> makes it change to a random baud rate.
> 
> So, the problem with Mustang and m400 was the mmio vs mmio32.

Bummer. Maybe that firmware can use a different DBG2 port designation to
indicate it's a DesignWare 8250 (or generically 32-bit mmio).


> Right now,
> the kernel only supports mmio32 in the 8250_dw.c driver when probed with
> ACPI.

While that's true specifically for DesignWare 8250 + ACPI, that's not
true for _all_ 8250 + ACPI.


> Other x86 machines just use legacy 8250 ports which don't need
> entries in the DSDT and use legacy io.

I find that statement hard to believe. I know for a fact ia64 servers didn't,
so the assertion that SPCR + 16550 + MMIO automatically means 32-bit data width
seems unlikely.

In fact, I suspect the opposite is true; that before these arm64 designs,
SPCR + 16550 + MMIO automatically meant 8-bit data width, which is why it's
unspecified in the SPCR table.

Regards,
Peter Hurley


> The 8250_dw driver does support
> non-standard clocks specified in the DSDT. That works fine for Mustang
> and m400.
> 
> So with this quick hack, v7 is working with Mustang/m400:
> 
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 68ffc33..dade9de 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -37,6 +37,7 @@ int __init parse_spcr(bool earlycon)
>  	acpi_status status;
>  	char *uart;
>  	char *iotype;
> +	int mmio;
>  	int baud_rate;
>  	int err;
>  
> @@ -56,8 +57,8 @@ int __init parse_spcr(bool earlycon)
>  		goto done;
>  	}
>  
> -	iotype = table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY ?
> -			"mmio" : "io";
> +	mmio = table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY;
> +	iotype = mmio ? "mmio" : "io";
>  
>  	switch (table->interface_type) {
>  	case ACPI_DBG2_ARM_SBSA_32BIT:
> @@ -71,6 +72,8 @@ int __init parse_spcr(bool earlycon)
>  	case ACPI_DBG2_16550_COMPATIBLE:
>  	case ACPI_DBG2_16550_SUBSET:
>  		uart = "uart";
> +		if (mmio)
> +			iotype = "mmio32";
>  		break;
>  	default:
>  		err = -ENOENT;
> 
>>
>> We may need two 8250 subset entries, one just means no clock given, and
>> one no clock given + mmio32 only.
>>
>> Graeme
>>
>>
>>>
>>> Thank you
>>> Aleksey Makarov
>>>
>>>>
>>>>
>>>> --Mark
>>>>
>>>>
>>>> On Thu, 2016-03-31 at 16:40 +0300, Aleksey Makarov wrote:
>>>>>
>>>>> 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port
>>>>> Console Redirection Table) [2] as a mandatory ACPI table that
>>>>> specifies the configuration of serial console.
>>>>>
>>>>> Move "earlycon" early_param handling to earlycon.c to parse this option once
>>>>>
>>>>> *** PATCH  "ACPICA: Headers: Add new constants for the DBG2 ACPI table"
>>>>> *** IS JUST TO ENABLE BUILDING THE PATCHSET ON linux-next
>>>>>
>>>>> Patch "ACPICA: Headers: Add new constants for the DBG2 ACPI table" is required
>>>>> for the next patch.  It is taken from ACPICA series [3], but it has not appeared
>>>>> in linux-next yet.
>>>>>
>>>>> Parse SPCR table, setup earlycon and add register specified console.
>>>>>
>>>>> Enable parsing this table on ARM64.  Earlycon should be set up
>>>>> as early as possible.  ACPI boot tables are mapped in
>>>>> arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from setup_arch()
>>>>> and that's where we parse spcr.  So it has to be opted-in per-arch.
>>>>>
>>>>> Implement console_match() for pl011.
>>>>>
>>>>> Based on the work by Leif Lindholm [4]
>>>>> Thanks to Peter Hurley for explaining how this should work.
>>>>>
>>>>> Should be applied to next-20160331.
>>>>>
>>>>> Tested on QEMU.  SPCR support is included in QEMU's ARM mach-virt
>>>>> since 2.4 release.
>>>>>
>>>>> v7:
>>>>> - add Acked-by: Rob Herring for "of/serial: move earlycon early_param handling
>>>>>   to serial"
>>>>> - call DT earlycon initialization from the arch ACPI code, not from parse_spcr()
>>>>>   (Rafael J. Wysocki)
>>>>> - fix a few minor issues (Rafael J. Wysocki)
>>>>>
>>>>> v6:
>>>>> https://lkml.kernel.org/g/1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org
>>>>> - add documentation for parse_spcr() functioin (Yury Norov)
>>>>> - don't initialize err variable (Yury Norov)
>>>>> - add __initdata for the earlycon_init_is_deferred flag variable
>>>>> - rename the function exported in "of/serial: move earlycon early_param handling
>>>>>   to serial" to avoid clash with the function from arch/microblaze/kernel/prom.c
>>>>> - defer initialization of DT earlycon until DT/ACPI decision is made
>>>>>   (Rob Herring, Peter Hurley)
>>>>> - use snprintf instead of sprintf (Andy Shevchenko)
>>>>> - drop patch that adds EARLYCON_DECLARE for pl011 as EARLYCON_DECLARE is
>>>>>   equivalent to OF_EARLYCON_DECLARE for 4.6+ (Peter Hurley).  This means that
>>>>>   SPCR earlycon will not work on the kernels before 4.6
>>>>>
>>>>> v5:
>>>>> https://lkml.kernel.org/g/1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org
>>>>> - drop patch "serial: pl011: use ACPI SPCR to setup 32-bit access" because
>>>>>   it is ugly. Also because Christopher Covington came with a better solution [5]
>>>>> - remove error message when the table is not provided by ACPI (Andy Shevchenko)
>>>>> - rewrite spcr.c following the suggestions by Peter Hurley
>>>>> - add console_match() for pl011 in a separate patch
>>>>> - add EARLYCON_DECLARE for pl011 in a separate patch
>>>>> - add patch "of/serial: move earlycon early_param handling to serial" from
>>>>>   the GDB2 series
>>>>>
>>>>> v4:
>>>>> https://lkml.kernel.org/g/1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org
>>>>> - drop patch "ACPI: change __init to __ref for early_acpi_os_unmap_memory()"
>>>>>   ACPI developers work on a new API and asked not to do that.
>>>>>   Instead, use acpi_get_table_with_size()/early_acpi_os_unmap_memory() once
>>>>>   and cache the result. (Lv Zheng)
>>>>> - fix some style issues (Yury Norov)
>>>>>
>>>>> v3:
>>>>> https://lkml.kernel.org/g/1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org
>>>>>
>>>>> Greg Kroah-Hartman did not like v2 so I have rewritten this patchset:
>>>>>
>>>>> - drop acpi_match() member of struct console
>>>>> - drop implementations of this member for pl011 and 8250
>>>>> - drop the patch that renames some vars in printk.c as it is not needed anymore
>>>>> - drop patch that introduces system wide acpi_table_parse2().
>>>>>   Instead introduce a custom acpi_table_parse_spcr() in spcr.c
>>>>>
>>>>> Instead of introducing a new match_acpi() member of struct console,
>>>>> this patchset introduces a new function acpi_console_check().
>>>>> This function is called when a new uart is registered at serial_core.c
>>>>> the same way OF code checks for console.  If the registered uart is the
>>>>> console specified by SPCR table, this function calls add_preferred_console()
>>>>>
>>>>> The restrictions of this approach are:
>>>>>
>>>>> - only serial consoles can be set up
>>>>> - only consoles specified by the memory/io address can be set up
>>>>>   (SPCR can specify devices by PCI id/PCI address)
>>>>>
>>>>> v2:
>>>>> https://lkml.kernel.org/g/1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org
>>>>> - don't use SPCR if user specified console in command line
>>>>> - fix initialization order of newcon->index = 0
>>>>> - rename some variables at printk.c (Joe Perches, Peter Hurley)
>>>>> - enable ACPI_SPCR_TABLE in a separate patch (Andy Shevchenko)
>>>>> - remove the retry loop for console registering (Peter Hurley).
>>>>>   Instead, obtain SPCR with acpi_get_table().  That works after
>>>>>   call to acpi_early_init() i. e. in any *_initcall()
>>>>> - describe design decision behind introducing acpi_match() (Peter Hurley)
>>>>> - fix compilation for x86 + ACPI (Graeme Gregory)
>>>>> - introduce DBG2 constants in a separate patch (Andy Shevchenko)
>>>>> - fix a typo in DBG2 constants (Andy Shevchenko)
>>>>> - add ACPI_DBG2_ARM_SBSA_32BIT constant (Christopher Covington)
>>>>> - add support for ACPI_DBG2_ARM_SBSA_* consoles (Christopher Covington)
>>>>> - add documentation for functions
>>>>> - add a patch that uses SPCR to find if SBSA serial driver should use 32-bit
>>>>>   accessor functions (Christopher Covington)
>>>>> - change __init to __ref for early_acpi_os_unmap_memory() in a separate patch
>>>>> - introduce acpi_table_parse2() in a separate patch
>>>>> - fix fetching the SPCR table early (Mark Salter)
>>>>> - add a patch from Mark Salter that introduces support for matching 8250-based
>>>>>   consoles
>>>>>
>>>>> v1:
>>>>> https://lkml.kernel.org/g/1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org
>>>>>
>>>>> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
>>>>> [2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
>>>>> [3] https://lkml.kernel.org/g/cover.1458714002.git.lv.zheng@intel.com
>>>>> [4] https://lkml.kernel.org/g/1441716217-23786-1-git-send-email-leif.lindholm@linaro.org
>>>>> [5] https://lkml.kernel.org/g/1457415800-8799-1-git-send-email-cov@codeaurora.org
>>>>>
>>>>> Aleksey Makarov (4):
>>>>>   ACPICA: Headers: Add new constants for the DBG2 ACPI table
>>>>>   ACPI: parse SPCR and enable matching console
>>>>>   ARM64: ACPI: enable ACPI_SPCR_TABLE
>>>>>   serial: pl011: add console matching function
>>>>>
>>>>> Leif Lindholm (1):
>>>>>   of/serial: move earlycon early_param handling to serial
>>>>>
>>>>>  arch/arm64/Kconfig              |   1 +
>>>>>  arch/arm64/kernel/acpi.c        |  11 +++-
>>>>>  drivers/acpi/Kconfig            |   3 ++
>>>>>  drivers/acpi/Makefile           |   1 +
>>>>>  drivers/acpi/spcr.c             | 111 ++++++++++++++++++++++++++++++++++++++++
>>>>>  drivers/of/fdt.c                |  11 +---
>>>>>  drivers/tty/serial/amba-pl011.c |  56 ++++++++++++++++++++
>>>>>  drivers/tty/serial/earlycon.c   |  19 ++++++-
>>>>>  include/acpi/actbl2.h           |   7 ++-
>>>>>  include/linux/acpi.h            |   6 +++
>>>>>  include/linux/of_fdt.h          |   2 +
>>>>>  include/linux/serial_core.h     |   6 +++
>>>>>  12 files changed, 220 insertions(+), 14 deletions(-)
>>>>>  create mode 100644 drivers/acpi/spcr.c
>>>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


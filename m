From: Aleksey Makarov <amakarov.linux@gmail.com>
Subject: Re: [PATCH v4 0/4] ACPI: parse the SPCR table
Date: Thu, 3 Mar 2016 14:59:42 +0300
Message-ID: <56D8272E.20705@gmail.com>
References: <1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org>
 <56D5B5CB.7010702@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56D5B5CB.7010702@hurleysoftware.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, "Zheng, Lv" <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org



On 03/01/2016 06:31 PM, Peter Hurley wrote:
> On 02/29/2016 04:02 AM, Aleksey Makarov wrote:
>> 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port
>> Console Redirection Table) [2] as a mandatory ACPI table that
>> specifies the configuration of serial console.
>>
>> Introduce a new function acpi_console_check().  At the uart port
>> registration, this function checks if the ACPI SPCR table specifies
>> its argument of type struct uart_port to be a console
>> and if so calls add_preferred_console().
> 
> How will a user enable an earlycon on the same console as the SPCR
> console if there is no DBG2 table?

...
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] bootconsole [pl11] enabled
...
[    0.000000] Kernel command line:  root=/dev/vda1 rw systemd.show_status=no acpi=force earlycon=pl011,0x9000000
...
[    0.318248] ACPI: SPCR: adding preferred console [ttyAMA0]
[    0.318736] ARMH0011:00: ttyAMA0 at MMIO 0x9000000 (irq = 5, base_baud = 0) is a SBSA
[    0.319502] console [ttyAMA0] enabled
[    0.319502] console [ttyAMA0] enabled
[    0.319933] bootconsole [pl11] disabled
[    0.319933] bootconsole [pl11] disabled
...

Why?

> 
> 
>> Use SPCR to tell if SBSA serial driver should use 32-bit access to registers.
>>
>> Based on the work by Leif Lindholm [3]
>>
>> Should be applied to next-20160229.
>>
>> Tested on QEMU.  SPCR support is included in QEMU's ARM mach-virt
>> since 2.4 release.
>>
>> v4:
>> - drop patch "ACPI: change __init to __ref for early_acpi_os_unmap_memory()"
>>   ACPI developers work on a new API and asked not to do that.
>>   Instead, use acpi_get_table_with_size()/early_acpi_os_unmap_memory() once
>>   and cache the result. (Lv Zheng)
>> - fix some style issues (Yury Norov)
>>
>> v3:
>> https://lkml.kernel.org/g/1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org
>>
>> Greg Kroah-Hartman did not like v2 so I have rewritten this patchset:
>>
>> - drop acpi_match() member of struct console
>> - drop implementations of this member for pl011 and 8250
>> - drop the patch that renames some vars in printk.c as it is not needed anymore
>> - drop patch that introduces system wide acpi_table_parse2().
>>   Instead introduce a custom acpi_table_parse_spcr() in spcr.c
>>
>> Instead of introducing a new match_acpi() member of struct console,
>> this patchset introduces a new function acpi_console_check().
>> This function is called when a new uart is registered at serial_core.c
>> the same way OF code checks for console.  If the registered uart is the
>> console specified by SPCR table, this function calls add_preferred_console()
>>
>> The restrictions of this approach are:
>>
>> - only serial consoles can be set up
>> - only consoles specified by the memory/io address can be set up
>>   (SPCR can specify devices by PCI id/PCI address)
>>
>> v2:
>> https://lkml.kernel.org/g/1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org
>> - don't use SPCR if user specified console in command line
>> - fix initialization order of newcon->index = 0
>> - rename some variables at printk.c (Joe Perches, Peter Hurley)
>> - enable ACPI_SPCR_TABLE in a separate patch (Andy Shevchenko)
>> - remove the retry loop for console registering (Peter Hurley).
>>   Instead, obtain SPCR with acpi_get_table().  That works after
>>   call to acpi_early_init() i. e. in any *_initcall()
>> - describe design decision behind introducing acpi_match() (Peter Hurley)
>> - fix compilation for x86 + ACPI (Graeme Gregory)
>> - introduce DBG2 constants in a separate patch (Andy Shevchenko)
>> - fix a typo in DBG2 constants (Andy Shevchenko)
>> - add ACPI_DBG2_ARM_SBSA_32BIT constant (Christopher Covington)
>> - add support for ACPI_DBG2_ARM_SBSA_* consoles (Christopher Covington)
>> - add documentation for functions
>> - add a patch that uses SPCR to find if SBSA serial driver should use 32-bit
>>   accessor functions (Christopher Covington)
>> - change __init to __ref for early_acpi_os_unmap_memory() in a separate patch
>> - introduce acpi_table_parse2() in a separate patch
>> - fix fetching the SPCR table early (Mark Salter)
>> - add a patch from Mark Salter that introduces support for matching 8250-based
>>   consoles
>>
>> v1:
>> https://lkml.kernel.org/g/1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org
>>
>> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
>> [2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
>> [3] https://lkml.kernel.org/g/1441716217-23786-1-git-send-email-leif.lindholm@linaro.org
>>
>> Aleksey Makarov (4):
>>   ACPI: parse SPCR and enable matching console
>>   ACPI: enable ACPI_SPCR_TABLE on ARM64
>>   ACPI: add definitions of DBG2 subtypes
>>   serial: pl011: use ACPI SPCR to setup 32-bit access
>>
>>  arch/arm64/Kconfig               |   1 +
>>  drivers/acpi/Kconfig             |   3 +
>>  drivers/acpi/Makefile            |   1 +
>>  drivers/acpi/spcr.c              | 138 +++++++++++++++++++++++++++++++++++++++
>>  drivers/tty/serial/amba-pl011.c  |   2 +
>>  drivers/tty/serial/serial_core.c |  14 +++-
>>  include/acpi/actbl2.h            |   5 ++
>>  include/linux/acpi.h             |  15 +++++
>>  8 files changed, 177 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/acpi/spcr.c
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

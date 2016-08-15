From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v9 0/4] ACPI: parse the SPCR table
Date: Mon, 15 Aug 2016 16:51:35 +0300
Message-ID: <4a6b2746-0cdf-4481-485b-651bf7526631@linaro.org>
References: <20160811153152.755-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160811153152.755-1-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org



On 08/11/2016 06:31 PM, Aleksey Makarov wrote:
> 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port Console
> Redirection Table) [2] as a mandatory ACPI table that specifies the
> configuration of serial console.

Hi Rafael,

The 4/4 patch just got an ACK from Russell.  Can you consider to merge
this patchset please?

Thank you
Aleksey Makarov

> 
> Move "earlycon" early_param handling to earlycon.c to parse this option once
> 
> Parse SPCR table, setup earlycon and register specified console.
> 
> Enable parsing this table on ARM64.  Earlycon should be set up as early as
> possible.  ACPI boot tables are mapped in
> arch/arm64/kernel/acpi.c:acpi_boot_table_init() called from setup_arch() and
> that's where we parse spcr.  So it has to be opted-in per-arch. When
> ACPI_SPCR_TABLE is defined initialization of DT earlycon is deferred until the
> DT/ACPI decision is done.
> 
> Implement console_match() for pl011.
> 
> Based on the work by Leif Lindholm [3]
> Thanks to Peter Hurley for explaining how this should work.
> 
> Should be applied to v4.8-rc1
> Tested on QEMU and ThunderX.
> SPCR support is included in QEMU's ARM64 mach-virt since 2.4 release.
> 
> v9:
> - rebase to v4.8-rc1
> - fix compilation for !CONFIG_SERIAL_EARLYCON case
> - add Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> for ACPI part
> - move constant check out of loop (Yury Norov)
> - add '\n' to info message
> 
> v8:
> - rebase to next-20160520
> - remove the patch "ACPICA: Headers: Add new constants for the DBG2 ACPI table"
>   as it have got to linux-next
> - add Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Reviewed-by:
>   Peter Hurley <peter@hurleysoftware.com> (but see below)
> - fix the patch "serial: pl011: add console matching function".  The patch by
>   Christopher Covington [4] specifies that SBSA uart does 32-bit access to
>   registers and this breaks the match function.  In this series the function
>   was changed to match when SPCR specifies both mmio32 and mmio access.
>   I removed Acked-by: Greg from this patch because of these changes.
> 
> v7:
> https://lkml.kernel.org/g/1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org
> - add Acked-by: Rob Herring for "of/serial: move earlycon early_param handling
>   to serial"
> - call DT earlycon initialization from the arch ACPI code, not from parse_spcr()
>   (Rafael J. Wysocki)
> - fix a few minor issues (Rafael J. Wysocki)
> 
> v6:
> https://lkml.kernel.org/g/1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org
> - add documentation for parse_spcr() functioin (Yury Norov)
> - don't initialize err variable (Yury Norov)
> - add __initdata for the earlycon_init_is_deferred flag variable
> - rename the function exported in "of/serial: move earlycon early_param handling
>   to serial" to avoid clash with the function from arch/microblaze/kernel/prom.c
> - defer initialization of DT earlycon until DT/ACPI decision is made
>   (Rob Herring, Peter Hurley)
> - use snprintf instead of sprintf (Andy Shevchenko)
> - drop patch that adds EARLYCON_DECLARE for pl011 as EARLYCON_DECLARE is
>   equivalent to OF_EARLYCON_DECLARE for 4.6+ (Peter Hurley).  This means that
>   SPCR earlycon will not work on the kernels before 4.6
> 
> v5:
> https://lkml.kernel.org/g/1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org
> - drop patch "serial: pl011: use ACPI SPCR to setup 32-bit access" because
>   it is ugly. Also because Christopher Covington came with a better solution [4]
> - remove error message when the table is not provided by ACPI (Andy Shevchenko)
> - rewrite spcr.c following the suggestions by Peter Hurley
> - add console_match() for pl011 in a separate patch
> - add EARLYCON_DECLARE for pl011 in a separate patch
> - add patch "of/serial: move earlycon early_param handling to serial" from
>   the GDB2 series
> 
> v4:
> https://lkml.kernel.org/g/1456747355-15692-1-git-send-email-aleksey.makarov@linaro.org
> - drop patch "ACPI: change __init to __ref for early_acpi_os_unmap_memory()"
>   ACPI developers work on a new API and asked not to do that.
>   Instead, use acpi_get_table_with_size()/early_acpi_os_unmap_memory() once
>   and cache the result. (Lv Zheng)
> - fix some style issues (Yury Norov)
> 
> v3:
> https://lkml.kernel.org/g/1455559532-8305-1-git-send-email-aleksey.makarov@linaro.org
> 
> Greg Kroah-Hartman did not like v2 so I have rewritten this patchset:
> 
> - drop acpi_match() member of struct console
> - drop implementations of this member for pl011 and 8250
> - drop the patch that renames some vars in printk.c as it is not needed anymore
> - drop patch that introduces system wide acpi_table_parse2().
>   Instead introduce a custom acpi_table_parse_spcr() in spcr.c
> 
> Instead of introducing a new match_acpi() member of struct console,
> this patchset introduces a new function acpi_console_check().
> This function is called when a new uart is registered at serial_core.c
> the same way OF code checks for console.  If the registered uart is the
> console specified by SPCR table, this function calls add_preferred_console()
> 
> The restrictions of this approach are:
> 
> - only serial consoles can be set up
> - only consoles specified by the memory/io address can be set up
>   (SPCR can specify devices by PCI id/PCI address)
> 
> v2:
> https://lkml.kernel.org/g/1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org
> - don't use SPCR if user specified console in command line
> - fix initialization order of newcon->index = 0
> - rename some variables at printk.c (Joe Perches, Peter Hurley)
> - enable ACPI_SPCR_TABLE in a separate patch (Andy Shevchenko)
> - remove the retry loop for console registering (Peter Hurley).
>   Instead, obtain SPCR with acpi_get_table().  That works after
>   call to acpi_early_init() i. e. in any *_initcall()
> - describe design decision behind introducing acpi_match() (Peter Hurley)
> - fix compilation for x86 + ACPI (Graeme Gregory)
> - introduce DBG2 constants in a separate patch (Andy Shevchenko)
> - fix a typo in DBG2 constants (Andy Shevchenko)
> - add ACPI_DBG2_ARM_SBSA_32BIT constant (Christopher Covington)
> - add support for ACPI_DBG2_ARM_SBSA_* consoles (Christopher Covington)
> - add documentation for functions
> - add a patch that uses SPCR to find if SBSA serial driver should use 32-bit
>   accessor functions (Christopher Covington)
> - change __init to __ref for early_acpi_os_unmap_memory() in a separate patch
> - introduce acpi_table_parse2() in a separate patch
> - fix fetching the SPCR table early (Mark Salter)
> - add a patch from Mark Salter that introduces support for matching 8250-based
>   consoles
> 
> v1:
> https://lkml.kernel.org/g/1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org
> 
> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
> [2] https://msdn.microsoft.com/en-us/library/windows/hardware/dn639132(v=vs.85).aspx
> [3] https://lkml.kernel.org/g/1441716217-23786-1-git-send-email-leif.lindholm@linaro.org
> [4] https://lkml.kernel.org/g/1457415800-8799-1-git-send-email-cov@codeaurora.org
> 
> Aleksey Makarov (3):
>   ACPI: parse SPCR and enable matching console
>   ARM64: ACPI: enable ACPI_SPCR_TABLE
>   serial: pl011: add console matching function
> 
> Leif Lindholm (1):
>   of/serial: move earlycon early_param handling to serial
> 
>  arch/arm64/Kconfig              |   1 +
>  arch/arm64/kernel/acpi.c        |  11 +++-
>  drivers/acpi/Kconfig            |   3 ++
>  drivers/acpi/Makefile           |   1 +
>  drivers/acpi/spcr.c             | 111 ++++++++++++++++++++++++++++++++++++++++
>  drivers/of/fdt.c                |  11 +---
>  drivers/tty/serial/amba-pl011.c |  56 ++++++++++++++++++++
>  drivers/tty/serial/earlycon.c   |  19 ++++++-
>  include/linux/acpi.h            |   6 +++
>  include/linux/of_fdt.h          |   2 +
>  include/linux/serial_core.h     |   9 +++-
>  11 files changed, 216 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/acpi/spcr.c
> 

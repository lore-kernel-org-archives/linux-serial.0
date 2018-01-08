From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2 1/2] acpi, spcr: Make SPCR avialable to other
 architectures
Date: Mon, 8 Jan 2018 07:46:28 -0500
Message-ID: <c01c8d7b-91d1-70fc-69dd-d5fde0bcab0b@redhat.com>
References: <20171211155059.17062-1-prarit@redhat.com>
 <20171211155059.17062-2-prarit@redhat.com> <20171213124533.GA32362@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171213124533.GA32362@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, Bhupesh Sharma <bhsharma@redhat.com>, Lv Zheng <lv.zheng@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org, mark.salter@redhat.com
List-Id: linux-serial@vger.kernel.org

[Sorry everyone for the late response, I went away on vacation and pushed this
off until I returned.]

On 12/13/2017 07:45 AM, Lorenzo Pieralisi wrote:
> [+Mark, Graeme]
> 
> In $SUBJECT, s/avialable/available
> 
> On Mon, Dec 11, 2017 at 10:50:58AM -0500, Prarit Bhargava wrote:
>> Other architectures can use SPCR to setup an early console or console
>> but the current code is ARM64 specific.
> 
> I see nothing ARM64 specific in current code (apart from some
> ACPICA macros with an ARM tag in them) please explain to me
> what's preventing you to reuse current code on x86.

Ah, I didn't notice that.  I thought the ACPICA macros were ARM specific.  I'll
rework this patchset with that in mind.

> 
>> Change the name of parse_spcr() to acpi_parse_spcr().  Add a weak
>> function acpi_arch_setup_console() that can be used for arch-specific
>> setup.  Move flags into ACPI code.  Update the Documention on the use of
>> the SPCR.
>>
>> [v2]: Don't return an error in the baud_rate check of acpi_parse_spcr().
>> Keep ACPI_SPCR_TABLE selected for ARM64.  Fix 8-bit port access width
>> mmio value.  Move baud rate check earlier.
> 
> This does not belong in the commit log.

Yes, but some maintainers like to see what changed between v1 & v2.

> 
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-serial@vger.kernel.org
>> Cc: Bhupesh Sharma <bhsharma@redhat.com>
>> Cc: Lv Zheng <lv.zheng@intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Timur Tabi <timur@codeaurora.org>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |   6 +-
>>  arch/arm64/kernel/acpi.c                        | 128 ++++++++++++++++-
>>  drivers/acpi/Kconfig                            |   7 +-
>>  drivers/acpi/spcr.c                             | 175 ++++++------------------
>>  drivers/tty/serial/earlycon.c                   |  15 +-
>>  include/linux/acpi.h                            |  11 +-
>>  include/linux/serial_core.h                     |   2 -
>>  7 files changed, 184 insertions(+), 160 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 6571fbfdb2a1..0d173289c67e 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -914,9 +914,9 @@
>>  
>>  	earlycon=	[KNL] Output early console device and options.
>>  
>> -			When used with no options, the early console is
>> -			determined by the stdout-path property in device
>> -			tree's chosen node.
>> +			[ARM64] The early console is determined by the
>> +			stdout-path property in device tree's chosen node,
>> +			or determined by the ACPI SPCR table.
>>  
>>  		cdns,<addr>[,options]
>>  			Start an early, polled-mode console on a Cadence
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index b3162715ed78..b3e33bbdf3b7 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -25,7 +25,6 @@
>>  #include <linux/memblock.h>
>>  #include <linux/of_fdt.h>
>>  #include <linux/smp.h>
>> -#include <linux/serial_core.h>
>>  
>>  #include <asm/cputype.h>
>>  #include <asm/cpu_ops.h>
>> @@ -177,6 +176,128 @@ static int __init acpi_fadt_sanity_check(void)
>>  	return ret;
>>  }
>>  
>> +/*
>> + * Erratum 44 for QDF2432v1 and QDF2400v1 SoCs describes the BUSY bit as
>> + * occasionally getting stuck as 1. To avoid the potential for a hang, check
>> + * TXFE == 0 instead of BUSY == 1. This may not be suitable for all UART
>> + * implementations, so only do so if an affected platform is detected in
>> + * acpi_parse_spcr().
>> + */
>> +bool qdf2400_e44_present;
>> +EXPORT_SYMBOL(qdf2400_e44_present);
> 
> My eyes, this is horrible but it is not introduced by this patch. It
> would have been much better if:
> 
> drivers/tty/serial/amba-pl011.c
> 
> parsed the SPCR table (again) to detect it instead of relying on this
> horrible exported flag.

It looks like Timur & you had a discussion and the current consensus is to keep
the code the same.

> 
>> +
>> +/*
>> + * Some Qualcomm Datacenter Technologies SoCs have a defective UART BUSY bit.
>> + * Detect them by examining the OEM fields in the SPCR header, similar to PCI
>> + * quirk detection in pci_mcfg.c.
>> + */
>> +static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
>> +{
>> +	if (memcmp(h->oem_id, "QCOM  ", ACPI_OEM_ID_SIZE))
>> +		return false;
>> +
>> +	if (!memcmp(h->oem_table_id, "QDF2432 ", ACPI_OEM_TABLE_ID_SIZE))
>> +		return true;
>> +
>> +	if (!memcmp(h->oem_table_id, "QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
>> +			h->oem_revision == 1)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +/*
>> + * APM X-Gene v1 and v2 UART hardware is an 16550 like device but has its
>> + * register aligned to 32-bit. In addition, the BIOS also encoded the
>> + * access width to be 8 bits. This function detects this errata condition.
>> + */
>> +static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
>> +{
>> +	bool xgene_8250 = false;
>> +
>> +	if (tb->interface_type != ACPI_DBG2_16550_COMPATIBLE)
>> +		return false;
>> +
>> +	if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE) &&
>> +	    memcmp(tb->header.oem_id, "HPE   ", ACPI_OEM_ID_SIZE))
>> +		return false;
>> +
>> +	if (!memcmp(tb->header.oem_table_id, "XGENESPC",
>> +	    ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 0)
>> +		xgene_8250 = true;
>> +
>> +	if (!memcmp(tb->header.oem_table_id, "ProLiant",
>> +	    ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 1)
>> +		xgene_8250 = true;
>> +
>> +	return xgene_8250;
>> +}
>> +
>> +int acpi_arch_setup_console(struct acpi_table_spcr *table,
>> +			    char *opts, char *uart, char *iotype,
>> +			    int baud_rate, bool earlycon)
>> +{
>> +	if (table->header.revision < 2) {
>> +		pr_err("wrong table version\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	switch (table->interface_type) {
>> +	case ACPI_DBG2_ARM_SBSA_32BIT:
>> +		snprintf(iotype, ACPI_SPCR_BUF_SIZE, "mmio32");
>> +		/* fall through */
>> +	case ACPI_DBG2_ARM_PL011:
>> +	case ACPI_DBG2_ARM_SBSA_GENERIC:
>> +	case ACPI_DBG2_BCM2835:
>> +		snprintf(uart, ACPI_SPCR_BUF_SIZE, "pl011");
>> +		break;
>> +	default:
>> +		if (strlen(uart) == 0)
>> +			return -ENOENT;
>> +	}
>> +
>> +	/*
>> +	 * If the E44 erratum is required, then we need to tell the pl011
>> +	 * driver to implement the work-around.
>> +	 *
>> +	 * The global variable is used by the probe function when it
>> +	 * creates the UARTs, whether or not they're used as a console.
>> +	 *
>> +	 * If the user specifies "traditional" earlycon, the qdf2400_e44
>> +	 * console name matches the EARLYCON_DECLARE() statement, and
>> +	 * SPCR is not used.  Parameter "earlycon" is false.
>> +	 *
>> +	 * If the user specifies "SPCR" earlycon, then we need to update
>> +	 * the console name so that it also says "qdf2400_e44".  Parameter
>> +	 * "earlycon" is true.
>> +	 *
>> +	 * For consistency, if we change the console name, then we do it
>> +	 * for everyone, not just earlycon.
>> +	 */
>> +	if (qdf2400_erratum_44_present(&table->header)) {
>> +		qdf2400_e44_present = true;
>> +		if (earlycon)
>> +			snprintf(uart, ACPI_SPCR_BUF_SIZE, "qdf2400_e44");
>> +	}
>> +
>> +	if (xgene_8250_erratum_present(table)) {
>> +		snprintf(iotype, ACPI_SPCR_BUF_SIZE, "mmio32");
>> +
>> +		/* for xgene v1 and v2 we don't know the clock rate of the
>> +		 * UART so don't attempt to change to the baud rate state
>> +		 * in the table because driver cannot calculate the dividers
>> +		 */
>> +		snprintf(opts, ACPI_SPCR_OPTS_SIZE, "%s,%s,0x%llx", uart,
>> +			 iotype, table->serial_port.address);
>> +	} else {
>> +		snprintf(opts, ACPI_SPCR_OPTS_SIZE, "%s,%s,0x%llx,%d", uart,
>> +			 iotype, table->serial_port.address, baud_rate);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(acpi_arch_setup_console);
> 
> EXPORT_SYMBOL() ? Why ?
> 
> BTW, why do we need an arch hook ? I do not see anything that prevents
> you from using this code on x86 systems - is there anything arch
> specific in the SPCR specification itself ?

See above comment.  But also keep in mind I have seen a lot of x86 systems that
do not define the ACPI table version correctly.  The table version is 0 or 1,
and the current spec says it must be 2.  It looks like ARM requires 2.

> 
>> +
>>  /*
>>   * acpi_boot_table_init() called from setup_arch(), always.
>>   *	1. find RSDP and get its address, and then find XSDT
>> @@ -230,10 +351,11 @@ void __init acpi_boot_table_init(void)
>>  
>>  done:
>>  	if (acpi_disabled) {
>> -		if (earlycon_init_is_deferred)
>> +		if (console_acpi_spcr_enable)
>>  			early_init_dt_scan_chosen_stdout();
>>  	} else {
>> -		parse_spcr(earlycon_init_is_deferred);
>> +		/* Always enable the ACPI SPCR console */
>> +		acpi_parse_spcr(console_acpi_spcr_enable);
>>  		if (IS_ENABLED(CONFIG_ACPI_BGRT))
>>  			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
>>  	}
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 46505396869e..9ae98eeada76 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -79,7 +79,12 @@ config ACPI_DEBUGGER_USER
>>  endif
>>  
>>  config ACPI_SPCR_TABLE
>> -	bool
>> +	bool "ACPI Serial Port Console Redirection Support"
>> +	default y if ARM64
> 
> You need to remove the selection in arch/arm64 then. Also, moving away
> from a non-visible config may have consequences on ARM64, Graeme and
> Mark are more familiar with the SPCR dependencies so please chime in.

Ok, I'll double check this.

> 
>> +	help
>> +	  Enable support for Serial Port Console Redirection (SPCR) Table.
>> +	  This table provides information about the configuration of the
>> +	  earlycon console.
>>  
>>  config ACPI_LPIT
>>  	bool
>> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
>> index 324b35bfe781..f4bb8110e404 100644
>> --- a/drivers/acpi/spcr.c
>> +++ b/drivers/acpi/spcr.c
>> @@ -16,65 +16,18 @@
>>  #include <linux/kernel.h>
>>  #include <linux/serial_core.h>
>>  
>> -/*
>> - * Erratum 44 for QDF2432v1 and QDF2400v1 SoCs describes the BUSY bit as
>> - * occasionally getting stuck as 1. To avoid the potential for a hang, check
>> - * TXFE == 0 instead of BUSY == 1. This may not be suitable for all UART
>> - * implementations, so only do so if an affected platform is detected in
>> - * parse_spcr().
>> - */
>> -bool qdf2400_e44_present;
>> -EXPORT_SYMBOL(qdf2400_e44_present);
>> -
>> -/*
>> - * Some Qualcomm Datacenter Technologies SoCs have a defective UART BUSY bit.
>> - * Detect them by examining the OEM fields in the SPCR header, similiar to PCI
>> - * quirk detection in pci_mcfg.c.
>> - */
>> -static bool qdf2400_erratum_44_present(struct acpi_table_header *h)
>> -{
>> -	if (memcmp(h->oem_id, "QCOM  ", ACPI_OEM_ID_SIZE))
>> -		return false;
>> -
>> -	if (!memcmp(h->oem_table_id, "QDF2432 ", ACPI_OEM_TABLE_ID_SIZE))
>> -		return true;
>> -
>> -	if (!memcmp(h->oem_table_id, "QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
>> -			h->oem_revision == 1)
>> -		return true;
>> -
>> -	return false;
>> -}
>> -
>> -/*
>> - * APM X-Gene v1 and v2 UART hardware is an 16550 like device but has its
>> - * register aligned to 32-bit. In addition, the BIOS also encoded the
>> - * access width to be 8 bits. This function detects this errata condition.
>> - */
>> -static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
>> +int __weak acpi_arch_setup_console(struct acpi_table_spcr *table,
>> +				   char *opts, char *uart, char *iotype,
>> +				   int baud_rate, bool earlycon)
>>  {
>> -	bool xgene_8250 = false;
>> -
>> -	if (tb->interface_type != ACPI_DBG2_16550_COMPATIBLE)
>> -		return false;
>> -
>> -	if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE) &&
>> -	    memcmp(tb->header.oem_id, "HPE   ", ACPI_OEM_ID_SIZE))
>> -		return false;
>> -
>> -	if (!memcmp(tb->header.oem_table_id, "XGENESPC",
>> -	    ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 0)
>> -		xgene_8250 = true;
>> -
>> -	if (!memcmp(tb->header.oem_table_id, "ProLiant",
>> -	    ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision == 1)
>> -		xgene_8250 = true;
>> -
>> -	return xgene_8250;
>> +	snprintf(opts, ACPI_SPCR_OPTS_SIZE, "%s,%s,0x%llx,%d", uart, iotype,
>> +		 table->serial_port.address, baud_rate);
>> +	return 0;
>>  }
>>  
>> +bool console_acpi_spcr_enable __initdata;
>>  /**
>> - * parse_spcr() - parse ACPI SPCR table and add preferred console
>> + * acpi_parse_spcr() - parse ACPI SPCR table and add preferred console
>>   *
>>   * @earlycon: set up earlycon for the console specified by the table
>>   *
>> @@ -86,13 +39,13 @@ static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
>>   * from arch initialization code as soon as the DT/ACPI decision is made.
>>   *
>>   */
>> -int __init parse_spcr(bool earlycon)
>> +int __init acpi_parse_spcr(bool earlycon)
>>  {
>> -	static char opts[64];
>> +	static char opts[ACPI_SPCR_OPTS_SIZE];
>> +	static char uart[ACPI_SPCR_BUF_SIZE];
>> +	static char iotype[ACPI_SPCR_BUF_SIZE];
>>  	struct acpi_table_spcr *table;
>>  	acpi_status status;
>> -	char *uart;
>> -	char *iotype;
>>  	int baud_rate;
>>  	int err;
>>  
>> @@ -105,48 +58,6 @@ int __init parse_spcr(bool earlycon)
>>  	if (ACPI_FAILURE(status))
>>  		return -ENOENT;
>>  
>> -	if (table->header.revision < 2) {
>> -		err = -ENOENT;
>> -		pr_err("wrong table version\n");
>> -		goto done;
>> -	}
>> -
>> -	if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>> -		switch (ACPI_ACCESS_BIT_WIDTH((
>> -			table->serial_port.access_width))) {
>> -		default:
>> -			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
>> -		case 8:
>> -			iotype = "mmio";
>> -			break;
>> -		case 16:
>> -			iotype = "mmio16";
>> -			break;
>> -		case 32:
>> -			iotype = "mmio32";
>> -			break;
>> -		}
>> -	} else
>> -		iotype = "io";
>> -
>> -	switch (table->interface_type) {
>> -	case ACPI_DBG2_ARM_SBSA_32BIT:
>> -		iotype = "mmio32";
>> -		/* fall through */
>> -	case ACPI_DBG2_ARM_PL011:
>> -	case ACPI_DBG2_ARM_SBSA_GENERIC:
>> -	case ACPI_DBG2_BCM2835:
>> -		uart = "pl011";
>> -		break;
>> -	case ACPI_DBG2_16550_COMPATIBLE:
>> -	case ACPI_DBG2_16550_SUBSET:
>> -		uart = "uart";
>> -		break;
>> -	default:
>> -		err = -ENOENT;
>> -		goto done;
>> -	}
>> -
>>  	switch (table->baud_rate) {
>>  	case 3:
>>  		baud_rate = 9600;
>> @@ -165,43 +76,36 @@ int __init parse_spcr(bool earlycon)
>>  		goto done;
>>  	}
>>  
>> -	/*
>> -	 * If the E44 erratum is required, then we need to tell the pl011
>> -	 * driver to implement the work-around.
>> -	 *
>> -	 * The global variable is used by the probe function when it
>> -	 * creates the UARTs, whether or not they're used as a console.
>> -	 *
>> -	 * If the user specifies "traditional" earlycon, the qdf2400_e44
>> -	 * console name matches the EARLYCON_DECLARE() statement, and
>> -	 * SPCR is not used.  Parameter "earlycon" is false.
>> -	 *
>> -	 * If the user specifies "SPCR" earlycon, then we need to update
>> -	 * the console name so that it also says "qdf2400_e44".  Parameter
>> -	 * "earlycon" is true.
>> -	 *
>> -	 * For consistency, if we change the console name, then we do it
>> -	 * for everyone, not just earlycon.
>> -	 */
>> -	if (qdf2400_erratum_44_present(&table->header)) {
>> -		qdf2400_e44_present = true;
>> -		if (earlycon)
>> -			uart = "qdf2400_e44";
>> +	switch (table->interface_type) {
>> +	case ACPI_DBG2_16550_COMPATIBLE:
>> +	case ACPI_DBG2_16550_SUBSET:
>> +		snprintf(uart, ACPI_SPCR_BUF_SIZE, "uart");
>> +		break;
>> +	default:
>> +		break;
>>  	}
>>  
>> -	if (xgene_8250_erratum_present(table)) {
>> -		iotype = "mmio32";
>> +	if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>> +		u8 width = ACPI_ACCESS_BIT_WIDTH((
>> +					table->serial_port.access_width));
>> +		switch (width) {
>> +		default:
>> +			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
>> +		case 8:
>> +			snprintf(iotype, ACPI_SPCR_BUF_SIZE, "mmio");
>> +			break;
>> +		case 16:
>> +		case 32:
>> +			snprintf(iotype, ACPI_SPCR_BUF_SIZE, "mmio%d", width);
>> +			break;
>> +		}
>> +	} else
>> +		snprintf(iotype, ACPI_SPCR_BUF_SIZE, "io");
>>  
>> -		/* for xgene v1 and v2 we don't know the clock rate of the
>> -		 * UART so don't attempt to change to the baud rate state
>> -		 * in the table because driver cannot calculate the dividers
>> -		 */
>> -		snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, iotype,
>> -			 table->serial_port.address);
>> -	} else {
>> -		snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
>> -			 table->serial_port.address, baud_rate);
>> -	}
>> +	err = acpi_arch_setup_console(table, opts, uart, iotype, baud_rate,
>> +				      earlycon);
>> +	if (err)
>> +		goto done;
>>  
>>  	pr_info("console: %s\n", opts);
>>  
>> @@ -209,7 +113,6 @@ int __init parse_spcr(bool earlycon)
>>  		setup_earlycon(opts);
>>  
>>  	err = add_preferred_console(uart, 0, opts + strlen(uart) + 1);
>> -
> 
> Unintended change.
> 
>>  done:
>>  	acpi_put_table((struct acpi_table_header *)table);
>>  	return err;
>> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
>> index 4c8b80f1c688..b22afb62c7a3 100644
>> --- a/drivers/tty/serial/earlycon.c
>> +++ b/drivers/tty/serial/earlycon.c
>> @@ -196,26 +196,15 @@ int __init setup_earlycon(char *buf)
>>  	return -ENOENT;
>>  }
>>  
>> -/*
>> - * When CONFIG_ACPI_SPCR_TABLE is defined, "earlycon" without parameters in
>> - * command line does not start DT earlycon immediately, instead it defers
>> - * starting it until DT/ACPI decision is made.  At that time if ACPI is enabled
>> - * call parse_spcr(), else call early_init_dt_scan_chosen_stdout()
>> - */
>> -bool earlycon_init_is_deferred __initdata;
>> -
>>  /* early_param wrapper for setup_earlycon() */
>>  static int __init param_setup_earlycon(char *buf)
>>  {
>>  	int err;
>>  
>> -	/*
>> -	 * Just 'earlycon' is a valid param for devicetree earlycons;
>> -	 * don't generate a warning from parse_early_params() in that case
>> -	 */
>> +	/* Just 'earlycon' is a valid param for devicetree and ACPI SPCR. */
>>  	if (!buf || !buf[0]) {
>>  		if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE)) {
>> -			earlycon_init_is_deferred = true;
>> +			console_acpi_spcr_enable = true;
> 
> I am not familiar with this code, I would ask Graeme and Mark to check
> if this change is correct, the logic seems correct to me but I may be
> missing some corner cases.
> 
>>  			return 0;
>>  		} else if (!buf) {
>>  			return early_init_dt_scan_chosen_stdout();
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index dc1ebfeeb5ec..875d7327d91c 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1241,10 +1241,17 @@ static inline bool acpi_has_watchdog(void) { return false; }
>>  #endif
>>  
>>  #ifdef CONFIG_ACPI_SPCR_TABLE
>> +#define ACPI_SPCR_OPTS_SIZE 64
>> +#define ACPI_SPCR_BUF_SIZE 32
>>  extern bool qdf2400_e44_present;
>> -int parse_spcr(bool earlycon);
>> +extern bool console_acpi_spcr_enable __initdata;
>> +extern int acpi_arch_setup_console(struct acpi_table_spcr *table,
>> +				   char *opts, char *uart, char *iotype,
>> +				   int baud_rate, bool earlycon);
>> +int acpi_parse_spcr(bool earlycon);
>>  #else
>> -static inline int parse_spcr(bool earlycon) { return 0; }
>> +static const bool console_acpi_spcr_enable;
> 
> The assignment in param_setup_earlycon won't compile. 

Hmm ... I'm pretty sure it did.  But I'll check that before resubmitting.

P.

> 
> Lorenzo
> 

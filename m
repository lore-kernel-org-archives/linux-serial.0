From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 15 Feb 2017 08:59:47 -0500
Message-ID: <09772d07b3d6782690728ea171ac6e9e@codeaurora.org>
References: <20170214235347.8812-1-cov@codeaurora.org>
 <6a3ea0e5-f824-380e-1c4a-3e72b160e98a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <6a3ea0e5-f824-380e-1c4a-3e72b160e98a@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redh>
List-Id: linux-serial@vger.kernel.org

On 2017-02-14 21:39, Timur Tabi wrote:
> Christopher Covington wrote:
>> The Qualcomm Datacenter Technologies QDF2400 family of SoCs contains a
>> custom (non-PrimeCell) implementation of the SBSA UART. Occasionally 
>> the
>> BUSY bit in the Flag Register gets stuck as 1, erratum 44 for both 
>> 2432v1
>> and 2400v1 SoCs. Checking that the Transmit FIFO Empty (TXFE) bit is 
>> 0,
>> instead of checking that the BUSY bit is 1, works around the issue. To
>> facilitate this substitution when UART AMBA Port (UAP) data is 
>> available,
>> introduce vendor-specific inversion of Feature Register bits. For the
>> earlycon case, implement alternative putc and early_write functions.
>> Similar to what how ARMv8 ACPI PCI quirks are detected during MCFG 
>> parsing,
>> check the OEM fields of the Serial Port Console Redirection (SPCR) 
>> ACPI
>> table to determine if the current platform is known to be affected by 
>> the
>> erratum.
> 
> Please break this up into paragraphs.

Sure

>> +	if (!memcmp(table->header.oem_id, "QCOM  ", ACPI_OEM_ID_SIZE))
>> +		if (!memcmp(table->header.oem_table_id, "QDF2432 ",
>> +				ACPI_OEM_TABLE_ID_SIZE) ||
>> +				(!memcmp(table->header.oem_table_id,
>> +				"QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
>> +				table->header.oem_revision == 0))
>> +			uart = "qdf2400_e44";
>> +
> 
> Hey, you just wrote this
> And it looks crazy
> But here's my function
> So call it, maybe?
> 
> static bool needs_qdf2400_e44(struct acpi_table_header *h)
> {
> 	const char *id;
> 
> 	/* The erratum only applies to Qualcomm Technologies SOCs */
> 	if (memcmp(h->oem_id, "QCOM  ", ACPI_OEM_ID_SIZE))
> 		return False;
> 
> 	id = h->oem_table_id;
> 
> 	if (!memcmp(id, "QDF2432 ", ACPI_OEM_TABLE_ID_SIZE))
> 		return True;
> 
> 	if (!memcmp(id, "QDF2000 ", ACPI_OEM_TABLE_ID_SIZE) &&
> 		h->oem_revision == 0)
> 		return True;
> 
> 	return False;
> }
> 
> ...
> 
> 	if (needs_qdf2400_e44(&table->header))
> 		uart = "qdf2400_e44";

Sure

>> +/*
>> + * Erratum 44 for QDF2432v1 and QDF2400v1 SoCs describes the BUSY bit 
>> as
>> + * occasionally getting stuck as 1. To avoid the potential for a 
>> hang, check
>> + * TXFE == 0 instead of BUSY == 1. This may not be suitable for all 
>> UART
>> + * implementations, so only do so if an affected platform is detected 
>> in
>> + * parse_spcr().
>> + */
>> +static bool qdf2400_e44 = false;
> 
> Please rename this to needs_qdf2400_e44

Nothing needs QDF2400 erratum 44. Software should try to detect the 
presence
of the erratum. So I think qdf2400_e44_detected or qdf2400_e44_present 
would
make sense. But those suffixes don't add substantial value in my 
opinion.

Affected hardware needs the *workaround* to the erratum. So I think
needs_qdf2400_e44_workaround makes sense. But it's pretty lengthy.

If qdf2400_e44 is too cryptic, how about qdf2400_erratum_44?

>>  static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
>>  	[REG_DR] = UART01x_DR,
>>  	[REG_ST_DMAWM] = ST_UART011_DMAWM,
>> @@ -1518,7 +1543,8 @@ static unsigned int pl011_tx_empty(struct 
>> uart_port *port)
>>  {
>>  	struct uart_amba_port *uap =
>>  	    container_of(port, struct uart_amba_port, port);
>> -	unsigned int status = pl011_read(uap, REG_FR);
>> +	/* Allow feature register bits to be inverted to work around errata 
>> */
> 
> Blank line above the comment, please.

Sure

>> +	unsigned int status = pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr;
>>  	return status & (uap->vendor->fr_busy | UART01x_FR_TXFF) ?
>>  							0 : TIOCSER_TEMT;
>>  }
>> @@ -2215,10 +2241,12 @@ pl011_console_write(struct console *co, const 
>> char *s, unsigned int count)
>>  	uart_console_write(&uap->port, s, count, pl011_console_putchar);
>> 
>>  	/*
>> -	 *	Finally, wait for transmitter to become empty
>> -	 *	and restore the TCR
>> +	 *	Finally, wait for transmitter to become empty and restore the
>> +	 *	TCR. Allow feature register bits to be inverted to work around
>> +	 *	errata.
>>  	 */
>> -	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
>> +	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr)
>> +						& uap->vendor->fr_busy)
>>  		cpu_relax();
>>  	if (!uap->vendor->always_enabled)
>>  		pl011_write(old_cr, uap, REG_CR);
>> @@ -2340,8 +2368,13 @@ static int __init pl011_console_match(struct 
>> console *co, char *name, int idx,
>>  	resource_size_t addr;
>>  	int i;
>> 
>> -	if (strcmp(name, "pl011") != 0)
>> +	if (strcmp(name, "qdf2400_e44") == 0) {
>> +		if (!qdf2400_e44)
>> +			pr_info("UART: Working around QDF2400 SoC erratum 44");
> 
> Just use pr_once(), and you can skip the "if (!qdf2400_e44)".
> Although I don't understand why you need to do that.
> pl011_console_match() should only be called once anyway, right?

Sure. In my debugging I saw it printed 3 times. Keep in mind there
are at least two UARTs, one for the DB9 socket on the front of the
chassis and connected to the BMC for Serial Over LAN. Maybe the first
hit was from earlycon or SPCR parsing, I don't really know.

>> +		qdf2400_e44 = true;
>> +	} else if (strcmp(name, "pl011") != 0) {
>>  		return -ENODEV;
>> +	}
>> 
>>  	if (uart_parse_earlycon(options, &iotype, &addr, &options))
>>  		return -ENODEV;
>> @@ -2383,6 +2416,25 @@ static struct console amba_console = {
>> 
>>  #define AMBA_CONSOLE	(&amba_console)
>> 
>> +static void qdf2400_e44_putc(struct uart_port *port, int c)
>> +{
>> +	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
>> +		cpu_relax();
>> +	if (port->iotype == UPIO_MEM32)
>> +		writel(c, port->membase + UART01x_DR);
>> +	else
>> +		writeb(c, port->membase + UART01x_DR);
> 
> I think you can ignore the UPIO_MEM32 test and always use writel(),
> even on the QDF2400.

Sure

Cheers,
Cov

--
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.

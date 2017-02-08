From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 8 Feb 2017 07:27:29 -0600
Message-ID: <f9504cde-a87a-ba99-2f72-fc3029ef5fe5@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <7151be59-000c-d50b-f8f5-5fef0c053d91@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7151be59-000c-d50b-f8f5-5fef0c053d91@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Christopher Covington <cov@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org
Cc: Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>, Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>
List-Id: linux-serial@vger.kernel.org

Robin Murphy wrote:
> Is there a reason anyone would ever want to turn this off? AFAICS you
> save a few dozen bytes in return for a kernel image which you know won't
> work properly on some hardware. That doesn't seem particularly
> worthwhile, and it's not like the PL011 driver isn't already ripe with
> unconditional vendor-specific data.
>
>> > +
>> >  config SERIAL_EARLYCON_ARM_SEMIHOST
>> >  	bool "Early console using ARM semihosting"
>> >  	depends on ARM64 || ARM
>> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> > index d4171d71a258..41e51901d6ef 100644
>> > --- a/drivers/tty/serial/amba-pl011.c
>> > +++ b/drivers/tty/serial/amba-pl011.c
>> > @@ -97,6 +97,7 @@ struct vendor_data {
>> >  	unsigned int		fr_dsr;
>> >  	unsigned int		fr_cts;
>> >  	unsigned int		fr_ri;
>> > +	unsigned int		inv_fr;
>> >  	bool			access_32b;
>> >  	bool			oversampling;
>> >  	bool			dma_threshold;
>> > @@ -141,6 +142,25 @@ static struct vendor_data vendor_sbsa = {
>> >  	.fixed_options		= true,
>> >  };
>> >
>> > +#ifdef CONFIG_QCOM_QDF2400_ERRATUM_44
>> > +static struct vendor_data vendor_qdt_qdf2400_e44 = {
>> > +	.reg_offset		= pl011_std_offsets,
>> > +	.fr_busy		= UART011_FR_TXFE,
>> > +	.fr_dsr			= UART01x_FR_DSR,
>> > +	.fr_cts			= UART01x_FR_CTS,
>> > +	.fr_ri			= UART011_FR_RI,
>> > +	.inv_fr			= UART011_FR_TXFE,
>> > +	.access_32b		= true,
>> > +	.oversampling		= false,
>> > +	.dma_threshold		= false,
>> > +	.cts_event_workaround	= false,
>> > +	.always_enabled		= true,
>> > +	.fixed_options		= true,
>> > +};
>> > +#else
>> > +#define vendor_qdt_qdf2400_e44 vendor_sbsa
>> > +#endif
>> > +
>> >  static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
>> >  	[REG_DR] = UART01x_DR,
>> >  	[REG_ST_DMAWM] = ST_UART011_DMAWM,
>> > @@ -1518,7 +1538,7 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
>> >  {
>> >  	struct uart_amba_port *uap =
>> >  	    container_of(port, struct uart_amba_port, port);
>> > -	unsigned int status = pl011_read(uap, REG_FR);
>> > +	unsigned int status = pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr;
>> >  	return status & (uap->vendor->fr_busy | UART01x_FR_TXFF) ?
>> >  							0 : TIOCSER_TEMT;
>> >  }
>> > @@ -2218,7 +2238,8 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
>> >  	 *	Finally, wait for transmitter to become empty
>> >  	 *	and restore the TCR
>> >  	 */
>> > -	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
>> > +	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr)
>> > +						& uap->vendor->fr_busy)
>> >  		cpu_relax();
>> >  	if (!uap->vendor->always_enabled)
>> >  		pl011_write(old_cr, uap, REG_CR);
>> > @@ -2383,6 +2404,13 @@ static struct console amba_console = {
>> >
>> >  #define AMBA_CONSOLE	(&amba_console)
>> >
>> > +static bool qdf2400_e44(void) {
>> > +	u32 cpu_var_model = read_cpuid_id() & ~MIDR_REVISION_MASK;
>> > +
>> > +	return (cpu_var_model == MIDR_QCOM_KRYO_V1 ||
>> > +	    cpu_var_model == MIDR_QCOM_FALKOR_V1);

> Are we to take it that every SoC now and always with any Kryo or Falkor
> core which also has an SBSA UART will require this workaround?

No, only Kryo and Falkor V1 based SOCs have this problem.  Falkor V2 will have 
this fixed.  We intend to revert these fixes after Falkor V1 SOCs are no longer 
supported.

 > There's a
> guarantee that the UART itself will definitely never be fixed in some
> future revision? That it'll never be integrated into, say, some
> Kryo/Cortex-Axx big.LITTLE system where you do still need the
> workaround, but might be making this check on the wrong core?

We are sure that this erratum is restricted to those specific SOCs.

>
> If there's really no suitable ID register to identify this particular
> UART implementation, it probably needs to be described appropriately by
> the firmware - I can't claim knowledge of how that works under ACPI, but
> I do note that the only device ID currently being matched is "ARMH0011",
> which seems to me to be inappropriate to describe something which is not
> an ARM PL011, bugs or no bugs.

ACPI is not like device tree.  You can't just define a "qcom,needs-busy-bit-fix" 
property and call it a day.

If you're saying that we should create a new ACPI HID, like QCOM0011, that 
probably would have worked as well, except hindsight is 20/20, and we already 
have firmware in the field.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.

From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v3 5/7] ACPI: serial: implement earlycon on ACPI DBG2 port
Date: Tue, 1 Mar 2016 19:57:25 +0300
Message-ID: <56D5C9F5.5060301@linaro.org>
References: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
 <1456749726-30261-6-git-send-email-aleksey.makarov@linaro.org>
 <56D5BAFF.6080008@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <56D5BAFF.6080008@hurleysoftware.com>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Matthias Brugger <mbrugger@suse.com>, Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 03/01/2016 06:53 PM, Peter Hurley wrote:
> On 02/29/2016 04:42 AM, Aleksey Makarov wrote:
>> Add ACPI_DBG2_EARLYCON_DECLARE() macros that declares
>> an earlycon on the serial port specified in the DBG2 ACPI table.
>>
>> Pass the string "earlycon=acpi_dbg2" to the kernel to activate it.
>>
>> Callbacks for EARLYCON_DECLARE() and OF_EARLYCON_DECLARE()
>> can also be used for this macros.
>>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>> ---
>>  Documentation/kernel-parameters.txt |  3 ++
>>  drivers/tty/serial/earlycon.c       | 60 +++++++++++++++++++++++++++++++++++++
>>  include/linux/acpi_dbg2.h           | 20 +++++++++++++
>>  3 files changed, 83 insertions(+)
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index e0a21e4..19b947b 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -1072,6 +1072,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>  			A valid base address must be provided, and the serial
>>  			port must already be setup and configured.
>>  
>> +		acpi_dbg2
>> +			Use serial port specified by the DBG2 ACPI table.
>> +
>>  	earlyprintk=	[X86,SH,BLACKFIN,ARM,M68k]
>>  			earlyprintk=vga
>>  			earlyprintk=efi
>> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
>> index d217366..9ba3a04 100644
>> --- a/drivers/tty/serial/earlycon.c
>> +++ b/drivers/tty/serial/earlycon.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/sizes.h>
>>  #include <linux/of.h>
>>  #include <linux/of_fdt.h>
>> +#include <linux/acpi.h>
>>  
>>  #ifdef CONFIG_FIX_EARLYCON_MEM
>>  #include <asm/fixmap.h>
>> @@ -200,6 +201,8 @@ int __init setup_earlycon(char *buf)
>>  	return -ENOENT;
>>  }
>>  
>> +static bool setup_dbg2_earlycon;
>> +
>>  /* early_param wrapper for setup_earlycon() */
>>  static int __init param_setup_earlycon(char *buf)
>>  {
>> @@ -212,6 +215,11 @@ static int __init param_setup_earlycon(char *buf)
>>  	if (!buf || !buf[0])
>>  		return early_init_dt_scan_chosen_serial();
>>  
>> +	if (!strcmp(buf, "acpi_dbg2")) {
>> +		setup_dbg2_earlycon = true;
>> +		return 0;
>> +	}
> 
> So this series doesn't start an ACPI earlycon at early_param time?
> That doesn't seem very useful.
> 
> When does the ACPI earlycon actually start?
> And don't say "when the DBG2 table is probed"; that much is obvious.

ACPI earlycon starts as soon as ACPI tables become accessible (setup_arch()).
I think that is still quite early.

>> +
>>  	err = setup_earlycon(buf);
>>  	if (err == -ENOENT || err == -EALREADY)
>>  		return 0;
>> @@ -286,3 +294,55 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
>>  }
>>  
>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>> +
>> +#ifdef CONFIG_ACPI_DBG2_TABLE
>> +
>> +int __init acpi_setup_earlycon(struct acpi_dbg2_device *device, void *d)
>> +{
>> +	int err;
>> +	struct uart_port *port = &early_console_dev.port;
>> +	int (*setup)(struct earlycon_device *, const char *) = d;
>> +	struct acpi_generic_address *reg;
>> +
>> +	if (!setup_dbg2_earlycon)
>> +		return -ENODEV;
>> +
>> +	if (device->register_count < 1)
>> +		return -ENODEV;
>> +
>> +	if (device->base_address_offset >= device->length)
>> +		return -EINVAL;
>> +
>> +	reg = (void *)device + device->base_address_offset;
>> +
>> +	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY &&
>> +	    reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO)
>> +		return -EINVAL;
>> +
>> +	spin_lock_init(&port->lock);
>> +	port->uartclk = BASE_BAUD * 16;
>> +
>> +	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>> +		if (device->port_type == ACPI_DBG2_ARM_SBSA_32BIT)
>> +			port->iotype = UPIO_MEM32;
>> +		else
>> +			port->iotype = UPIO_MEM;
>> +		port->mapbase = reg->address;
>> +		port->membase = earlycon_map(reg->address, SZ_4K);
>> +	} else {
>> +		port->iotype = UPIO_PORT;
>> +		port->iobase = reg->address;
>> +	}
>> +
>> +	early_console_dev.con->data = &early_console_dev;
>> +	err = setup(&early_console_dev, NULL);
>> +	if (err < 0)
>> +		return err;
>> +	if (!early_console_dev.con->write)
>> +		return -ENODEV;
>> +
>> +	register_console(early_console_dev.con);
>> +	return 0;
>> +}
>> +
>> +#endif /* CONFIG_ACPI_DBG2_TABLE */
>> diff --git a/include/linux/acpi_dbg2.h b/include/linux/acpi_dbg2.h
>> index 125ae7e..b653752 100644
>> --- a/include/linux/acpi_dbg2.h
>> +++ b/include/linux/acpi_dbg2.h
>> @@ -37,12 +37,32 @@ int acpi_dbg2_setup(struct acpi_table_header *header, const void *data);
>>  	ACPI_DECLARE_PROBE_ENTRY(dbg2, name, ACPI_SIG_DBG2,		\
>>  				 acpi_dbg2_setup, &__acpi_dbg2_data_##name)
>>  
>> +int acpi_setup_earlycon(struct acpi_dbg2_device *device, void *d);
>> +
>> +/**
>> + * ACPI_DBG2_EARLYCON_DECLARE() - Define handler for ACPI GDB2 serial port
>> + * @name:		Identifier to compose name of table data
>> + * @subtype:		Subtype of the port
>> + * @console_setup:	Function to be called to setup the port
>> + *
>> + * Type of the console_setup() callback is
>> + * int (*setup)(struct earlycon_device *, const char *)
>> + * It's the type of callback of of_setup_earlycon().
>> + */
>> +#define ACPI_DBG2_EARLYCON_DECLARE(name, subtype, console_setup)	\
>> +	ACPI_DBG2_DECLARE(name, ACPI_DBG2_SERIAL_PORT, subtype,		\
>> +			  acpi_setup_earlycon, console_setup)
>> +
>>  #else
>>  
>>  #define ACPI_DBG2_DECLARE(name, type, subtype, setup_fn, data_ptr)	\
>>  	static const void *__acpi_dbg_data_##name[]			\
>>  		__used __initdata = { (void *)setup_fn,	(void *)data_ptr }
>>  
>> +#define ACPI_DBG2_EARLYCON_DECLARE(name, subtype, console_setup)	\
>> +	static const void *__acpi_dbg_data_serial_##name[]		\
>> +		__used __initdata = { (void *)console_setup }
>> +
>>  #endif
>>  
>>  #endif
>>
> 

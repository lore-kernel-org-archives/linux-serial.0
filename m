From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/4] serial: 8250_dw: Add support for big-endian MMIO
 accesses
Date: Wed, 22 Jul 2015 08:41:22 -0400
Message-ID: <55AF8F72.6070000@hurleysoftware.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com> <1437557699-25722-2-git-send-email-noamc@ezchip.com> <55AF8A34.2060900@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AF8A34.2060900@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alexey.Brodkin@synopsys.com, vgupta@synopsys.com, gregkh@linuxfoundation.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

On 07/22/2015 08:19 AM, Peter Hurley wrote:
> Hi Noam,
> 
> On 07/22/2015 05:34 AM, Noam Camus wrote:
>> From: Noam Camus <noamc@ezchip.com>
>>
>> Add support for UPIO_MEM32BE in addition to UPIO_MEM32.
> 
> This is not an adequate changelog.
> Please describe the refactoring.
> 
> Regards,
> Peter Hurley
> 
>> Signed-off-by: Noam Camus <noamc@ezchip.com>
>> ---
>>  drivers/tty/serial/8250/8250_dw.c |   42 ++++++++++++++++++++++++++++++------
>>  1 files changed, 35 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>> index d48b506..fe0b487 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -173,15 +173,13 @@ static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
>>  }
>>  #endif /* CONFIG_64BIT */
>>  
>> -static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
>> +static void dw8250_check_control(struct uart_port *p, int offset, int value)

Also, I think this fn name should be dw8250_check_LCR() to distinguish it
from modem control.

Regards,
Peter Hurley

>>  {
>>  	struct dw8250_data *d = p->private_data;
>>  
>>  	if (offset == UART_MCR)
>>  		d->last_mcr = value;
>>  
>> -	writel(value, p->membase + (offset << p->regshift));
>> -
>>  	/* Make sure LCR write wasn't ignored */
>>  	if (offset == UART_LCR) {
>>  		int tries = 1000;
>> @@ -190,7 +188,12 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
>>  			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
>>  				return;
>>  			dw8250_force_idle(p);
>> -			writel(value, p->membase + (UART_LCR << p->regshift));
>> +			if (p->iotype == UPIO_MEM32BE)
>> +				iowrite32be(value,
>> +					p->membase + (UART_LCR << p->regshift));
>> +			else
>> +				writel(value,
>> +					p->membase + (UART_LCR << p->regshift));
>>  		}
>>  		/*
>>  		 * FIXME: this deadlocks if port->lock is already held
>> @@ -199,6 +202,12 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
>>  	}
>>  }
>>  
>> +static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
>> +{
>> +	writel(value, p->membase + (offset << p->regshift));
>> +	dw8250_check_control(p, offset, value);
>> +}
>> +
>>  static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
>>  {
>>  	unsigned int value = readl(p->membase + (offset << p->regshift));
>> @@ -206,6 +215,19 @@ static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
>>  	return dw8250_modify_msr(p, offset, value);
>>  }
>>  
>> +static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
>> +{
>> +	iowrite32be(value, p->membase + (offset << p->regshift));
>> +	dw8250_check_control(p, offset, value);
>> +}
>> +
>> +static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
>> +{
>> +	unsigned int value = ioread32be(p->membase + (offset << p->regshift));
>> +
>> +	return dw8250_modify_msr(p, offset, value);
>> +}
>> +
>>  static int dw8250_handle_irq(struct uart_port *p)
>>  {
>>  	struct dw8250_data *d = p->private_data;
>> @@ -322,9 +344,15 @@ static int dw8250_probe_of(struct uart_port *p,
>>  		case 1:
>>  			break;
>>  		case 4:
>> -			p->iotype = UPIO_MEM32;
>> -			p->serial_in = dw8250_serial_in32;
>> -			p->serial_out = dw8250_serial_out32;
>> +			p->iotype = of_device_is_big_endian(np) ?
>> +				    UPIO_MEM32BE : UPIO_MEM32;
>> +			if (p->iotype == UPIO_MEM32) {
>> +				p->serial_in = dw8250_serial_in32;
>> +				p->serial_out = dw8250_serial_out32;
>> +			} else {
>> +				p->serial_in = dw8250_serial_in32be;
>> +				p->serial_out = dw8250_serial_out32be;
>> +			}
>>  			break;
>>  		default:
>>  			dev_err(p->dev, "unsupported reg-io-width (%u)\n", val);
>>
> 

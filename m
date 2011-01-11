From: Michael Williamson <michael.williamson@criticallink.com>
Subject: Re: [PATCH 1/2 v1] davinci: support disabling modem status interrupts
 on	SOC UARTS
Date: Tue, 11 Jan 2011 07:42:25 -0500
Message-ID: <4D2C5031.30507@criticallink.com>
References: <1294230392-29564-1-git-send-email-michael.williamson@criticallink.com> <B85A65D85D7EB246BE421B3FB0FBB593024829BCD4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63600 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab1AKMmg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Jan 2011 07:42:36 -0500
Received: by vws16 with SMTP id 16so8433034vws.19
        for <linux-serial@vger.kernel.org>; Tue, 11 Jan 2011 04:42:35 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024829BCD4@dbde02.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 1/11/2011 3:17 AM, Manjunathappa, Prakash wrote:

> Hi Michael,
> 
> On Wed, Jan 05, 2011 at 17:56:31, Michael Williamson wrote:
>> On the da850/omap-l138/am18x family of SoCs, up to three on chip UARTS may be
>> configured.  These peripherals support the standard Tx/Rx signals as well as
>> CTS/RTS hardware flow control signals.  The pins on these SOC's associated with
>> these signals are multiplexed; e.g., the pin providing UART0_TXD capability
>> also provides SPI0 chip select line 5 output capability.  The configuration of
>> the pin multiplexing occurs during platform initialization (or by earlier
>> bootloader operations).
>>
>> There is a problem with the multiplexing implementation on these SOCs.  Only
>> the output and output enable portions of the I/O section of the pin are
>> multiplexed.  All peripheral input functions remain connected to a given pin
>> regardless of configuration.
>>
>> In many configurations of these parts, providing a UART with Tx/Rx capability
>> is needed, but the HW flow control capability is not.  Furthermore, the pins
>> associated with the CTS inputs on these UARTS are often configured to support
>> a different peripheral, and they may be active/toggling during runtime.  This
>> can result in false modem status (CTS) interrupts being asserted to the 8250
>> driver controlling the associated Tx/Rx pins, and will impact system
>> performance.
>>
>> The 8250 serial driver platform data does not provide a direct mechanism to
>> tell the driver to disable modem status (i.e., CTS) interrupts for a given
>> port.  As a work-around, intercept register writes to the IER and disable
>> modem status interrupts.
>>
>> This patch was tested using a MityDSP-L138 SOM having UART1 enabled with the
>> associated CTS pin connected to a clock (configured for the AHCLKX function).
>>
>> Background / problem reports related to this issue are captured in the links
>> below:
>> http://e2e.ti.com/support/dsp/omap_applications_processors/f/42/t/36701.aspx
>> http://www.mail-archive.com/davinci-linux-open-source@linux.davincidsp.com/msg19524.html
>>
>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
>> Tested-by: Michael Williamson <michael.williamson@criticallink.com>
>> ---
>> This is against the linux-davinci tree.
>>
>> Changes from original proposed patch:
>> - instead of overriding set_termios, now override serial_out driver hook
>>   and intercept writes to the MSR.
>>
>> An alternate patch was proposed that modified the serial core driver and added a UPF_NO_MSR
>> flag.  There was resistance to this patch.  The reasoning is that the core 8250 driver code
>> should not continue to get muddied by platform hacks.
>>
>> I'm wondering, given this and the original proposed patch, if the set_termios
>> override might be better?  This patch incurs a test penalty every time the UART
>> is accessed; whereas the original patch only incurs a penalty on IOCTL calls.  The
>> set_termios would at least report the proper IOCTL information for CRTSCTS 
>> when probed, I think, instead of just quietly lying about it...
>>
>>  arch/arm/mach-davinci/include/mach/serial.h |    2 ++
>>  arch/arm/mach-davinci/serial.c              |   19 +++++++++++++++++++
>>  2 files changed, 21 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
>> index 8051110..8f7f5e5 100644
>> --- a/arch/arm/mach-davinci/include/mach/serial.h
>> +++ b/arch/arm/mach-davinci/include/mach/serial.h
>> @@ -49,6 +49,8 @@
>>  struct davinci_uart_config {
>>  	/* Bit field of UARTs present; bit 0 --> UART1 */
>>  	unsigned int enabled_uarts;
>> +	/* Bit field of modem status interrupt disables; bit 0 -> UART1 */
>> +	unsigned int disable_msi;
>>  };
>>  
>>  extern int davinci_serial_init(struct davinci_uart_config *);
>> diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
>> index 1875740..83d44c0 100644
>> --- a/arch/arm/mach-davinci/serial.c
>> +++ b/arch/arm/mach-davinci/serial.c
>> @@ -31,6 +31,22 @@
>>  #include <mach/serial.h>
>>  #include <mach/cputype.h>
>>  
>> +static void davinci_serial_out_nomsi(struct uart_port *p, int offset, int value)
>> +{
>> +	int lcr, lcr_off;
>> +
>> +	if (offset == UART_IER) {
>> +		lcr_off = UART_LCR << p->regshift;
>> +		lcr = readb(p->membase + lcr_off);
>> +		/* don't override DLM setting, or probing operations */
>> +		if (!(lcr & UART_LCR_DLAB) && p->type != PORT_UNKNOWN)
>> +			value &= ~UART_IER_MSI;
>> +	}
>> +
>> +	offset <<= p->regshift;
>> +	writeb(value, p->membase + offset);
>> +}
>> +
>>  static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
>>  					   int offset)
>>  {
>> @@ -109,6 +125,9 @@ int __init davinci_serial_init(struct davinci_uart_config *info)
>>  
>>  		if (p->membase && p->type != PORT_AR7)
>>  			davinci_serial_reset(p);
>> +
>> +		if (info->disable_msi & (1 << i))
>> +			p->serial_out = davinci_serial_out_nomsi;
>>  	}
>>  
>>  	return platform_device_register(soc_info->serial_dev);
>> -- 
>> 1.7.0.4
>>
>> _______________________________________________
>> Davinci-linux-open-source mailing list
>> Davinci-linux-open-source@linux.davincidsp.com
>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>>
> When status of CTS input is wrong, why can't we say flow control not
> supported on particular port and return an error to application trying to
> enable hardware flow control(i.e. set CRTSCTS). I am assuming you are seeing
> the spurious interrupts only on enabling hardware flow control(as modem
> status interrupt is enabled on setting the CRTSCTS).
> 



This was pretty much what the original patch I had proposed did.  There are
actually two termios flags that cause MS interrupts to be enabled by the
driver, CLOCAL (disabled) or CRTSCTS (enabled).  I observed that some
process after the kernel had completed booting (getty, I think)
was calling set_termios with CLOCAL disabled (not CRTSCTS enabled).  I could
probably alter the getty args to work around it, but it's a bit of a hole to
not have something in the kernel to preclude sending the OS to "interrupt 
hell".

Is there another way to accomplish what you are suggesting that is different
from the original patch?

Thanks for the comments.

-Mike

Background: The original patch (not accepted) is here
https://patchwork.kernel.org/patch/442671/

This kicked a second email thread:
http://marc.info/?l=linux-serial&m=129409970003827&w=4

>From that thread, it was suggested to add a port flag to the driver
flags structure for disabling MS interrupts.

Driver Tweak patch (not accepted):
https://patchwork.kernel.org/patch/450771/

>From that thread, it was suggested to override the I/O methods and hide
the problem back in the platform code (this patch).

All three proposed patches work for me.  I'd gladly submit a fourth if
suggested -- this problem pretty much kills a couple of platform
configurations we are working on...

> Thanks,
> Prakash
> 





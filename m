From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2 v1] davinci: support disabling modem status interrupts on SOC UARTS
Date: Tue, 01 Feb 2011 12:53:42 -0800
Message-ID: <871v3rwk6h.fsf@ti.com>
References: <1294230392-29564-1-git-send-email-michael.williamson@criticallink.com>
	<4D44803E.8000703@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:59609 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752084Ab1BAUxu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Feb 2011 15:53:50 -0500
Received: by mail-gy0-f182.google.com with SMTP id 3so2834033gyf.13
        for <linux-serial@vger.kernel.org>; Tue, 01 Feb 2011 12:53:47 -0800 (PST)
In-Reply-To: <4D44803E.8000703@criticallink.com> (Michael Williamson's message
	of "Sat, 29 Jan 2011 16:01:50 -0500")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Williamson <michael.williamson@criticallink.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, gregkh@suse.de, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Michael Williamson <michael.williamson@criticallink.com> writes:

> Hi Kevin...
>
> On 01/05/2011 07:26 AM, Michael Williamson wrote:
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
>
> I'd like to withdraw this patch.  It works, but it's inefficient and ugly, and 
> I also get the feeling it isn't going to make it in it's current form anyway.
>
> I have another patch that is limited to just the mityomapl138 platform that 
> I would like to submit in place of this.  No other board appears to have this
> problem, so it makes sense to constrain the fix to platform file that does.
>

OK

Kevin

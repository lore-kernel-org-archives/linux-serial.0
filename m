From: wanghui <Hui.Wang@windriver.com>
Subject: Re:Re:[PATCH RESEND 0/2] two serial_core suspend/resume fixes
Date: Tue, 24 Aug 2010 11:48:29 +0800
Message-ID: <4C73410D.4030407@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38798 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab0HXDpP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Aug 2010 23:45:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: sbrabec@suse.cz
Cc: gregkh@suse.de, alan@linux.intel.com, arnd@arndb.de, linux-serial@vger.kernel.org

>
> > Jason Wang wrote:
>   
>> > > Sorry for resending this thread. Last thread is forgot to CC
>> > > Greg Kroah-Hartman.
>>     
> >
> > Well, I experienced no_console_supend breakage on my PXA270 based Zaurus
> > SL-C3200 (terrier/spitz) as well.
> >
> > But your patches did not fix the behavior, serial port remains dead
> > after resume with no_console_supend.
> >
>   

Very strange, I have validated these patches on ti_omap3530evm, fsl_imx31pdk
and fsl_imx51pdk.
They work fine.

When we set no_console_suspend to bootargs,  the suspend process will skip
most sub-callings in the
serial_core.c->uart_suspend_port(), only call ops->tx_empty().  While in
resume process, if without my
first patch, it will call uart_change_pm(), ops->set_termios() and
console_start(), these callings will make
the console uart unusable, but if apply my first patch,  it will call
nothing in the resume process. So
apply my first patch will balance suspend and resume sub-callings.

So i guess, your issue is not here. Maybe other parts(like gpio/clock) of
suspend/resume affect your UART.

Thanks,
Jason.



> >
>   
>> > > The [1/2] fix this situation:
>> > > we set no_console_supend and console=ttyS0 to bootargs, then bootup
>> > > the kernel, the boot logs will print out from ttyS0. When we execute
>> > > echo mem > /sys/power/state, the system will suspend, we press a
>> > > key(or other wakeup trigger) to resume the system, but the ttyS0 can't
>> > > work anymore.
>> > >
>> > > The [2/2] fix this situation:
>> > > we set console=ttyS0 to bootargs, then bootup the kernel, the boot
>> > > logs will print out from ttyS0, this time we set ttyS1 as tty and
>> > > login for shell. When we execute echo mem > /sys/power/state, the
>> > > system will suspend, we press a key(or other wakeup trigger) to
>> > > resume the system, but the ttyS0 can't work anymore.
>>     
> >
> > --
> > Best Regards / S pozdravem,
> >
> > Stanislav Brabec
> > software developer
> > ---------------------------------------------------------------------
>   


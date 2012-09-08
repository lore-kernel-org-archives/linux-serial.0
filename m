From: peter.sheeren@axiris.be
Subject: Re: Bug in USB FTDI SIO driver
Date: Sat, 08 Sep 2012 19:20:37 +0200
Message-ID: <20120908192037.20412mlnvfniwkmd@webmail.axiris.be>
References: <20120908121439.15264wgwo05hva8f@webmail.axiris.be>
 <20120908181634.7c6e5c73@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay04-01.mx.hostbasket.com ([85.255.200.186]:56723 "EHLO
	mailrelay04-01.mx.hostbasket.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139Ab2IHRUm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Sep 2012 13:20:42 -0400
In-Reply-To: <20120908181634.7c6e5c73@pyramind.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org


Hello Alan

Thanks for the answer.

I'm seeing the issue on:
* Raspberry Pi with Debian6 (kernel 3.1.9+)
* Raspberry Pi with Raspbian (also kernel 3.1.9+)
* BeagleBoard xM rev. C with Ubuntu (kernel 3.1.4)

I did a much simpler test without test application, just plugging and  
looking. The results are the same on all three systems:
0. Reboot and log in
1. lsmod -> no usbserial, no ftdi_sio
2. plug in the USB device (first time)
3. lsmod -> usbserial loaded, ftdi_sio loaded
4. plug out the USB device
5. lsmod -> usbserial loaded, ftdi_sio loaded
6. plug in the USB device
7. lsmod -> usbserial loaded, ftdi_sio loaded

The existence of /dev/ttyUSB0 depends on the system:
* RPi with Raspbian: /dev/ttyUSB0 never goes away after step 4.
* RPi with Debian6, BBXM: /dev/ttyUSB0 goes away after step 4 and  
comes back after step 6.

The fact is that ftdi_sio and usbserial are never unloaded. That's  
probably the cause of the baudrate problem.

Are there any commands I can run to provide you with more information?

Best regards,

Peter

Quoting Alan Cox <alan@lxorguk.ukuu.org.uk>:

> On Sat, 08 Sep 2012 12:14:39 +0200
> peter.sheeren@axiris.be wrote:
>
>> 	if (((old_priv.flags & ASYNC_SPD_MASK) !=
>> 	     (priv->flags & ASYNC_SPD_MASK)) ||
>> 	    (((priv->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST) &&
>> 	     (old_priv.custom_divisor != priv->custom_divisor))) {
>> 		change_speed(tty, port);
>>
>> Function change_speed() is called only when the baudrate
>> (custom_divisor) has changed but after a USB replug this assumption is
>> wrong. Also note that /dev/ttyUSB0 remains in existence on the system
>> under test. If it were up to me, I'd always send the baudrate setting
>> over the USB bus nomatter whether the baudrate (supposedly) has
>> changed or not.
>
> We don't do that because if you gratuitously send speed changes that have
> no effect the hardware seems to reset its configuration and you lose
> characters, something a lot of software doesn't expect.
>
> If you think that if check is the problem can you replace it with an
> unconditional call to change_speed(tty, port) and the re-test. That will
> confirm if it is the cause.
>
> If it is then we can think about fixing it somehow.
>
> Alan
>



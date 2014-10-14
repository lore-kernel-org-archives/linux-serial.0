From: Johannes Thumshirn <johannes.thumshirn@men.de>
Subject: Re: Handling of automatic flow control in UART drivers
Date: Tue, 14 Oct 2014 11:22:46 +0200
Message-ID: <20141014092245.GA9412@jtlinux>
References: <20141013144831.GA8409@jtlinux>
 <543C0831.8000101@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.144]:48833 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754775AbaJNJXS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Oct 2014 05:23:18 -0400
Content-Disposition: inline
In-Reply-To: <543C0831.8000101@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>, linux-serial@vger.kernel.org, =?iso-8859-1?Q?Gei=DFler?= Andreas <Andreas.Geissler@men.de>

On Mon, Oct 13, 2014 at 01:13:21PM -0400, Peter Hurley wrote:
> On 10/13/2014 10:48 AM, Johannes Thumshirn wrote:
> > Hi,
> >
> > We have problem with automatic flow control (i.e. auto RTS/CTS handshaking) in
> > our uart driver (men_z135_uart.c). It's probably less a technical but a problem
> > with me understanding the API.
> >
> > I active the hardware auto flow control feature on the CRTSCTS flag in my
> > uart_ops->set_termios() function. But then the RTS flag is set on every call of
> > the uart_ops->set_mctrl() function, this seems to confuse the hardware. Is there
> > a way to tell the tty layer that flow control is handled solely by hardware?
> > I.e. is there a way of telling serial core to leave out the calls to
> > uart_set_mctrl()/uart_clear_mctrl() in uart_throttle()/uart_unthrottle(), or is
> > setting UPF_FLOW_HARD and then implementing a dummy port->ops->{un}throttle()
> > the correct way?
> >
> > Are there any drivers that use a hardware's automatic flow control feature I can
> > use as an example? A fast grep on AFE reveals some spots, but I can't really
> > find a difference to my implementation.
>
> uart_throttle()/uart_unthrottle() is essentially broken.
>
> If the RTS pin is driveable, then the UART driver must respond to TIOCM_RTS
> set and clear in the ->set_mctrl() handler, regardless of any mode selected
> in termios or other mode such as autoRTS.
>
> This requirement exists because both userspace and other kernel drivers may
> want to drive RTS for their own purposes.
>
> For example, a bluetooth UART HCI may allow the bluetooth module to sleep
> and wakes up the module by driving RTS low for a certain length of time;
> if autoRTS prevents MCR writes from driving RTS, then the wake up never
> happens. (see drivers/bluetooth/hci_ath.c : ath_wakeup_ar3k() for the
> equally broken workaround of turning off CRTSCTS via an internal
> tty core function which is going away soon).
>
> The reason why TI 16c750-based AFE doesn't have to bother with this is
> because, on that hardware, the MCR RTS bit overrides the autoRTS state;
> ie., RTS = MCR_RTS & autoRTS.
>
> If your hardware treats the two states orthogonally then you'll need
> to turn off autoRTS mode if TIOCM_RTS is being cleared.
> The amba-pl011.c driver does this; see drivers/tty/serial/amba-pl011.c:
> pl011_set_mctrl().

Thanks for the info.

We've actually found the problem. When using auto flow control we need to
disable the modem status IRQs, in order to work.

The only problem that arises here is, when the modem status IRQs are disabled
the uart_ops->start_tx() isn't called anymore. But there should be work arounds
available.

Thanks,
	Johannes

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ioctl for Edgeport/8s MEI
Date: Sun, 6 Mar 2011 23:16:24 +0000
Message-ID: <20110306231624.6f3c1c6a@lxorguk.ukuu.org.uk>
References: <201102171210.03474.frode@tennebo.com>
	<20110217132836.30963112@lxorguk.ukuu.org.uk>
	<op.vq2lpas52e9ulc@vader>
	<20110218003616.GB25386@kroah.com>
	<op.vq26eyht2e9ulc@vader>
	<20110218193210.GA6395@kroah.com>
	<op.vq4gv3op2e9ulc@vader>
	<20110219165611.4b0e11da@lxorguk.ukuu.org.uk>
	<op.vq6c8rpp2e9ulc@vader>
	<op.vrx1w5ch2e9ulc@vader>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53333 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754968Ab1CFXQ3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 6 Mar 2011 18:16:29 -0500
In-Reply-To: <op.vrx1w5ch2e9ulc@vader>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Frode =?ISO-8859-14?B?VGVubmVi+A==?= <frode@tennebo.com>
Cc: Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org, claudio@evidence.eu.com, linux-serial@vger.kernel.org

> > And how is/should the RS-422 and RS-232 mode switching [be] handled?  A  
> > different set of IOCTLs?

Probably the RS485 one, or we've got termiox. Might be worth looking how
other Unixen handle it.

[added linux-serial list - this is bigger than USB in its needs]

> 
> To allow for the complexity described above, I propose a rename of the  
> current IOCTLs and control struct, or a completely new set of IOCTLs and  
> structs to avoid incompatibilities if this is a concern (which I believe  
> it is, but I also understand that there is an aversion agains new  
> IOCTLs).  I think we need the following IOCTLs:
> 
> TIOCSSERIAL
> TIOCGSERIAL

These we cannot update or extend sanely, and a lot of drivers don't
support them. The locking would also not be ideal.

> 
> and either extend the serial_struct type or introduce a new one, e.g.  
> serial_ctrl, with the following components:

I'd actually stick these into the RS485 ioctl or termiox, one or the
other. Yes 422 isn't quite 485 but interface perfection is always fun
(and we can define a new ioctl of the same value if need be!)
> 
> 
> /*
>   * SER_AUTO_TOGGLE         Multidrop, i.e. TX driver is automatically  
> enabled
>   *                         before data is transmitted, then disabled  
> immediately
>   *                         after all data has been transmitted.
>   * SER_RTS_CONTROL         RTS (Request To Send) is used to control the TX
>   *                         driver.
>   * SER_DTR_CONTROL         DTR (Data Terminal Ready) is used to control  
> the TX
>   *                         driver.
>   *
>   * SER_NO_ECHO             Receiver only active when no TX.

This seems to have little to do with echo and more to do with full/half
duplex.

>   * SER_LOCAL_ECHO          Receiver will always be active.
>   *
>   * SER_NO_TERMINATION      Device has no termination ("middle unit" for  
> RS485.
>   * SER_LOCAL_TERMINATION   Device has termination ("end unit" for RS485.
>   *
>   * SER_SLAVE               The device is slave.
>   * SER_MASTER              Receiver will always be active.
>   *
>   * SER_NO_SIGNALING        RTS or DTR is enabled just before send.
>   * SER_SIGNAL_BEFORE_SEND  RTS or DTR is enabled just before send.

You have these two the same which I think is just a thinko in the
description ?

>   * SER_SIGNAL_AFTER_SEND   RTS or DTR is enabled just after send.

> There are some overlaps here, e.g. RS-422 could be seen as the same state  
> as RS-485 with full duplex as master (termination accordingly).

Right - which is where treating them as one probably helps.

> But I'm on thin ice here.  And since I have no previous knowledge of this  
> part of the kernel nor any of the devices which currently supports RS-485,  
> nor I'm not entirely sure how the Cris and Atmel devices maps to what I  
> have described above, I would like some consensus before proceeding.

Apart from where the bits go (I'd put them in the rs485 struct) it looks
like a good summary. Some of the chips we have now I seem to remember
support configurable delays on the rts/dtr behaviour ?


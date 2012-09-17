From: "Steven J. Ackerman" <steve@acscontrol.com>
Subject: RE: Linux USB Serial
Date: Mon, 17 Sep 2012 18:27:40 -0400
Message-ID: <00c501cd9523$a68524f0$f38f6ed0$@acscontrol.com>
References: <00a301cd950a$ae9081d0$0bb18570$@acscontrol.com> <87zk4o1kh4.fsf@nemi.mork.no> <00b801cd9518$715dd160$54197420$@acscontrol.com> <20120917214136.GA20773@kroah.com> <00c101cd951f$55626910$00273b30$@acscontrol.com> <20120917220813.GA7780@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gwa3.webcontrolcenter.com ([63.134.207.12]:33640 "EHLO
	gwa3.webcontrolcenter.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338Ab2IQW2a (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Sep 2012 18:28:30 -0400
In-Reply-To: <20120917220813.GA7780@kroah.com>
Content-language: en-us
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg KH' <gregkh@linuxfoundation.org>
Cc: =?iso-8859-1?Q?'Bj=F8rn_Mork'?= <bjorn@mork.no>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

> That's fine, the cdc-acm interface will work for that.
> 
> But is your device really a CDC ACM device?  Or is it something else?

The device is a 3.5" color LCD display with touchscreen that can act as a
serial 
terminal. It just needs to be able to send and receive characters over an
USB
serial port.

> You wouldn't, if you use the ftdi serial chip in your device.  Which
> begs me to ask, what type of usb to serial chip is in your device?  What
> protocol does it use to talk to the host?

The device is based upon a Renesas RX62N processor which has a USB interface

in it.  The protocol is supposedly based upon the CDC - a control endpoint
and 
two bulk endpoints. The software was derived from a demo supplied by the 
manufacturer - and it does work under Windows. The device enumerates as 
a COM port and you can interact with the display using a program or a
terminal 
emulator.  Unfortunately the chip vendor doesn't have any support for Linux.

> They shouldn't have to do that, once we get it working, they get the
> update automatically from their distro.  But if you can't test any
> changes we make to try to get this to work, there's not much we can do
> here, right?
> 

I guess that I'm operating under the assumption that there is something 
wrong on my end - an incorrectly configured descriptor for example. It
appears 
the other USB serial devices work OK under Linux - even without custom 
drivers. I'm hoping that I can find an error message somewhere that will 
tell me what I'm doing wrong - or that somebody who has been down that 
path before can't point to something obvious - like Bjrn did.

> Oh, and fix that descriptor up in your firmware, that might solve
> everything :)

Going through the USB CDC documentation between e-mails. Other than 
the incorrect bInterfaceSubClass value - which I have corrected - nothing 
else seems wrong.

> 
> Hope this helps,
> 
> greg k-h

Always appreciate your assistance - thank you!


Steven J. Ackerman, Consultant
ACS, Sarasota, FL
http://www.acscontrol.com
mailto:steve@acscontrol.com







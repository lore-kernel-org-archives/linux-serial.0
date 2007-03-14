From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 14 Mar 2007 14:45:35 +0100
Message-ID: <002001c7663f$0bc45ee0$2e01a8c0@acksys.local>
References: <m3slc8c7vo.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp23.msg.oleane.net ([62.161.4.23]:54039 "EHLO
	smtp23.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933914AbXCNNpl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Mar 2007 09:45:41 -0400
In-Reply-To: <m3slc8c7vo.fsf@maximus.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Krzysztof Halasa' <khc@pm.waw.pl>
Cc: linux-serial@vger.kernel.org

Krzysztof Halasa wrote:

> It's just reality. If your IC in question does this in hardware
> - fine, but you still have to support it in the driver, adding
> a #define XXX doesn't help.
<sigh>
The reality is: the need exists, it does not break the driver, other OSs
support it, Linux does not, I personally wrote support for it in the
existing 8250 driver, other people wrote similar code in similar Linux
drivers.

But for some reason maintainers did not want to hear about this work. So I
must reinsert it over and over again with each new version of the kernel.
</sigh>

> "Code talks".
Indeed, please listen to drivers/serial/crisv10.c function rs_ioctl() (not
my code)
I can show you my own code also, if you care.

> > But
> > obviously neither of you used half duplex devices before.
>
> This is your "not true". I was using them, though they weren't
> modems.
>
> > There is no need for handshake, since half duplex is used
> > in master/slave situations.
>
> Not necesarily, there are CSMA/CD-style designs as well as token-ring
> style.

We talk about RTS use don't we ? What I talk about, is a way to toggle RTS
around transmit data with acceptable delays. This can only reside in the
serial driver, not in a line discipline.

A line discipline would have a hard time to switch on the OXFORD behaviour
without serial driver support wouldn't it ?

>
> > And I can insure you, that Windows handles this very well, using
> > only the above-mentioned RTS_TOGGLE flag.
>
> That means the DCE does all the buffering and handshaking. I'd say
> it's not common, most devices are simpler.

Of course !
That simply means that buffer management is a link-level function.
I do not want to remove the existing behaviour for RTS, I want to add a
optional "new" one to handle the original standard, and I do believe that I
am not alone to need this.

Best regards


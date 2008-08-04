From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: Suggested patch for linux
Date: Mon, 4 Aug 2008 15:28:05 +0200
Message-ID: <014d01c8f635$ee178ec0$2e01a8c0@acksys.local>
References: <g557er$c32$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp01.msg.oleane.net ([62.161.4.1]:45011 "EHLO
	smtp01.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbYHDNzc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Aug 2008 09:55:32 -0400
In-Reply-To: <g557er$c32$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Grant Edwards' <grante@visi.com>, linux-serial@vger.kernel.org

> -----Original Message-----
> From: Grant Edwards
> Sent: Thursday, July 10, 2008 4:48 PM

...
>
> On 2008-07-10, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
...
> > Do we really benefit from having this in kernel ?
>
> People who do industrial communications sure would.  I maintain
> a couple serial drivers that support half-duplex mode exactly
> as described by the OP, and we have to control that feature via
> non-standard hacks.
...

I fully agree with Grant Edwards. I, as well, have been myself maintaining
two serial drivers that support half-duplex mode exactly as described, and I
have to control that feature via non-standard hacks !!!
I have been porting them over and over again with each Linux version and
subversion, since Linux 2.2, and there IS a demand for it.

About the benefit to have this in the kernel: well, we would be enabled to
implement it for any UART, not just the 16550 series !

Now, about Linux RT and response times: The TXD-to-RTS delay must be as
short as possible. To do this, several UARTS i.e. (Ox950) have a special
mode. How could you do this in a user land program for any baud rate ? I
speak about baud rates up to 2 Mbps, they are in use nowadays on
RS2422/RS485 lines.

Really, I would like AT LEAST some commonly defined way to activate this
behaviour. Russell King once suggested to create a line discipline to handle
the RTS, but even like this we need a way (an ioctl) to activate the
behaviour in the UART driver, to make it independent from the specific UART.

JP Tosoni
Acksys



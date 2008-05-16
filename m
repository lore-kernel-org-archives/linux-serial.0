From: ian <spyro@f2s.com>
Subject: serial on PXA2xx
Date: Fri, 16 May 2008 22:01:21 +0100
Message-ID: <1210971681.12142.38.camel@wirenth>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mk-outboundfilter-4.mail.uk.tiscali.com ([212.74.114.32]:62264
	"EHLO mk-outboundfilter-4.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608AbYEPVLb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 May 2008 17:11:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi guys

Im trying to get a SIR device working on a PDA, and having a lot of
trouble with it. Not under linux but I cant find a better place to ask
serial questions, and it is for a bootloader for linux :-)

I've managed to get the PXA2xx serial port up and running, and can see
the IrTX LED light up on my digital camera, so I know the transceiver
has power.

Further, I can receive data, however it is _all_ zeros, no matter what
the host transmitted.

I cant see how this is a problem with the transceiver as I would have
thought this would have resulted in me seeing no characters at all.

It would be helpful if I had some way to snoop the hosts serial port, as
I cant find a way to get the linux IrDA stack to show me the raw data as
it arrived at the serial port (its a SIR dongle, so I cant just read
ttyS0).

irdadump is great but only shows valid packets, not the raw data.


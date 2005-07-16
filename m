From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Subject: Re: development of serial driver
Date: Sat, 16 Jul 2005 13:06:38 +0200
Message-ID: <42D8EA3E.1050403@gmx.net>
References: <MFEBKNPNJBEAJEICJEJNAEAGCLAA.matts@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:7358 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261260AbVGPLFr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 16 Jul 2005 07:05:47 -0400
In-Reply-To: <MFEBKNPNJBEAJEICJEJNAEAGCLAA.matts@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: matts@commtech-fastcom.com
Cc: linux-serial@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Matt Schulte wrote:
> Wednesday, June 29, 2005 12:02 PM Matt Schulte wrote:
> 
>>I am a developer for a line of multiport PCI serial cards.  I
>>have received
>>enough requests that it is time to make the cards work with the 2.6.x
>>kernels.  I see that serial.c has been deprecated and I am wondering if
>>anyone can tell me exactly how the serial is supposed to work in the new
>>kernel?
>>
>>How can I modify the existing stock driver to include my card as well?  Is
>>there a CVS version somewhere that I could checkout?  Do I send patches
>>somewhere?
> 
> 
> I have been painfully digging through the linux kernel mailing list archive
> and I have a pretty good idea of how I can submit patches that I come up
> with to make my driver operate in the new serial driver.
> 
> In the past (2.4.x days) I have just hacked the serial.c code to do what I
> needed and then recompiled it as something else.
> 
> I would like for someone to explain to me exactly how a guy like me is
> "supposed" to use this new driver.  Let's say that I have submitted a patch
> to 8250_pci.c that inserts my cards' device and vendor ids and my cards'
> .initialize and .setup routines (if I need them).  Now they can be
> recognized by the driver and will initialize correctly as 16550A type ports.
> Now I need to be able to write a few routines that can configure my card's
> special features.  In my hijacked serial.c I just added these routines as
> IOCTL's and life was good.  How should I write these routines now?
> 
> Many Thanks,
> 
> Matt Schulte
> Commtech, Inc.
> http://www.commtech-fastcom.com

Russell King is the maintainer of the 2.6 serial layer. He is the one
to ask about integration.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

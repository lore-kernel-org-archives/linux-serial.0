From: "Matt Schulte" <matts@commtech-fastcom.com>
Subject: RE: development of serial driver
Date: Fri, 1 Jul 2005 17:06:34 -0500
Message-ID: <MFEBKNPNJBEAJEICJEJNAEAGCLAA.matts@commtech-fastcom.com>
References: <MFEBKNPNJBEAJEICJEJNMEPMCKAA.matts@commtech-fastcom.com>
Reply-To: <matts@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp003.bizmail.yahoo.com ([216.136.130.195]:53692 "HELO
	smtp003.bizmail.yahoo.com") by vger.kernel.org with SMTP
	id S262901AbVGAWGq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Jul 2005 18:06:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by backup.commtech-fastcom.com (Postfix) with ESMTP id 2F26D166345
	for <linux-serial@vger.kernel.org>; Fri,  1 Jul 2005 17:06:35 -0500 (CDT)
Received: from 66.136.244.89 ([127.0.0.1])
 by localhost (backup.commtech-fastcom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11519-01 for <linux-serial@vger.kernel.org>;
 Fri,  1 Jul 2005 17:06:34 -0500 (CDT)
Received: from matt2k (unknown [192.168.1.7])
	by backup.commtech-fastcom.com (Postfix) with SMTP id 75A27166344
	for <linux-serial@vger.kernel.org>; Fri,  1 Jul 2005 17:06:34 -0500 (CDT)
In-Reply-To: <MFEBKNPNJBEAJEICJEJNMEPMCKAA.matts@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Wednesday, June 29, 2005 12:02 PM Matt Schulte wrote:
> I am a developer for a line of multiport PCI serial cards.  I
> have received
> enough requests that it is time to make the cards work with the 2.6.x
> kernels.  I see that serial.c has been deprecated and I am wondering if
> anyone can tell me exactly how the serial is supposed to work in the new
> kernel?
>
> How can I modify the existing stock driver to include my card as well?  Is
> there a CVS version somewhere that I could checkout?  Do I send patches
> somewhere?

I have been painfully digging through the linux kernel mailing list archive
and I have a pretty good idea of how I can submit patches that I come up
with to make my driver operate in the new serial driver.

In the past (2.4.x days) I have just hacked the serial.c code to do what I
needed and then recompiled it as something else.

I would like for someone to explain to me exactly how a guy like me is
"supposed" to use this new driver.  Let's say that I have submitted a patch
to 8250_pci.c that inserts my cards' device and vendor ids and my cards'
.initialize and .setup routines (if I need them).  Now they can be
recognized by the driver and will initialize correctly as 16550A type ports.
Now I need to be able to write a few routines that can configure my card's
special features.  In my hijacked serial.c I just added these routines as
IOCTL's and life was good.  How should I write these routines now?

Many Thanks,

Matt Schulte
Commtech, Inc.
http://www.commtech-fastcom.com


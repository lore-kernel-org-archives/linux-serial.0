From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] uartlite: move from byte accesses to word accesses
Date: Wed, 20 Jan 2010 14:49:45 -0700
Message-ID: <2f45ae30-3c9f-4b92-90a1-fc6a2a91445b@SG2EHSMHS006.ehs.local>
References: <28287b91-411c-4ae6-82b8-ec02a9d8e75d@SG2EHSMHS006.ehs.local> <873a20mvgg.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sg2ehsobe002.messaging.microsoft.com ([207.46.51.76]:39082 "EHLO
	SG2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750976Ab0ATVux convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jan 2010 16:50:53 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <873a20mvgg.fsf@macbook.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-serial@vger.kernel.org, grant.likely@secretlab.ca, michal.simek@petalogix.com, john.williams@petalogix.com



> -----Original Message-----
> From: Peter Korsgaard [mailto:jacmet@gmail.com] On Behalf Of Peter
Korsgaard
> Sent: Wednesday, January 20, 2010 12:24 PM
> To: John Linn
> Cc: linux-serial@vger.kernel.org; grant.likely@secretlab.ca;
michal.simek@petalogix.com;
> john.williams@petalogix.com
> Subject: Re: [PATCH] uartlite: move from byte accesses to word
accesses
> 
> >>>>> "John" == John Linn <john.linn@xilinx.com> writes:
> 
>  John> From: XAQ IP Librarian <abq_iplib@xaqiptest40.(none)>
>  John> Byte accesses for I/O devices in Xilinx IP is going to be less
>  John> desired in the future such that the driver is being changed to
>  John> use 32 bit accesses.
> 
> Why is it less desired?

We are wanting to use our IP cores over a PCIe bus and it only allows 32
bit accesses.

> 
> Back when I wrote the driver, I used 8bit access on purpose to be
> independent of register widths / endianess.
> 
> We have used the driver on systems where (something looking like) a
> uartlite was behind a 16bit bus, so doing 32bit accesses would require
> double the bus accesses.

I understand.  Most of our customers are using a 32 bit bus so that this
wouldn't be a problem for most people.

We could do some kind of conditional compilation for the accesses, but
it's certainly less desired.  We could make 32 bit the default and then
allow a kernel config to change the access size.

> 
> Btw, the abq_iplib@xaqiptest40 address is (obviously) invalid.

Yes, I saw that after it went out, I'll have to find the source of that
weirdness.

Thanks, 
John

> 
> --
> Bye, Peter Korsgaard


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.



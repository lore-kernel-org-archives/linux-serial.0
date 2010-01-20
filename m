From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] uartlite: move from byte accesses to word accesses
Date: Wed, 20 Jan 2010 15:57:51 -0700
Message-ID: <6dff093c-1fce-40b1-a6d7-8305af178425@VA3EHSMHS015.ehs.local>
References: <28287b91-411c-4ae6-82b8-ec02a9d8e75d@SG2EHSMHS006.ehs.local><873a20mvgg.fsf@macbook.be.48ers.dk><2f45ae30-3c9f-4b92-90a1-fc6a2a91445b@SG2EHSMHS006.ehs.local> <87y6jsl76e.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:30928
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751938Ab0ATW6A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jan 2010 17:58:00 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <87y6jsl76e.fsf@macbook.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-serial@vger.kernel.org, grant.likely@secretlab.ca, michal.simek@petalogix.com, john.williams@petalogix.com

Hi,

> -----Original Message-----
> From: Peter Korsgaard [mailto:jacmet@gmail.com] On Behalf Of Peter
Korsgaard
> Sent: Wednesday, January 20, 2010 3:53 PM
> To: John Linn
> Cc: linux-serial@vger.kernel.org; grant.likely@secretlab.ca;
michal.simek@petalogix.com;
> john.williams@petalogix.com
> Subject: Re: [PATCH] uartlite: move from byte accesses to word
accesses
> 
> >>>>> "John" == John Linn <John.Linn@xilinx.com> writes:
> 
> Hi,
> 
>  >> Why is it less desired?
> 
>  John> We are wanting to use our IP cores over a PCIe bus and it only
>  John> allows 32 bit accesses.
> 
> Ok, that's valuable information for the commit messages.

Understood, should have given more details.

> 
>  John> I understand.  Most of our customers are using a 32 bit bus so
>  John> that this wouldn't be a problem for most people.
> 
>  John> We could do some kind of conditional compilation for the
>  John> accesses, but it's certainly less desired.  We could make 32
bit
>  John> the default and then allow a kernel config to change the access
>  John> size.
> 
> Naah, the project where we needed 16bit access is _OLD_, and the
> platform hasn't been ported from arch/ppc, so let's just move to 32bit
> access.
> 

Agreed.

> If you send an updated patch with a more detailed commit message then
> I'll ack it.
> 

Sounds great, I'll respin it and send it tomorrow.

Thanks for your help.

> --
> Bye, Peter Korsgaard


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.



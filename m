From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] [V4] uartlite: move from byte accesses to word accesses
Date: Wed, 7 Apr 2010 13:44:42 -0600
Message-ID: <eb425cb0-e380-4d2a-a43d-ef2996a01688@VA3EHSMHS024.ehs.local>
References: <0c9c4833-e369-4c21-9def-b53100f885fa@SG2EHSMHS007.ehs.local> <874ojnqc9p.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:6463 "EHLO
	VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750741Ab0DGTpm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Apr 2010 15:45:42 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <874ojnqc9p.fsf@macbook.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-serial@vger.kernel.org, grant.likely@secretlab.ca, michal.simek@petalogix.com, gregkh@suse.de, john.williams@petalogix.com

> -----Original Message-----
> From: Peter Korsgaard [mailto:jacmet@gmail.com] On Behalf Of Peter
Korsgaard
> Sent: Wednesday, April 07, 2010 1:44 PM
> To: John Linn
> Cc: linux-serial@vger.kernel.org; grant.likely@secretlab.ca;
michal.simek@petalogix.com;
> gregkh@suse.de; john.williams@petalogix.com
> Subject: Re: [PATCH] [V4] uartlite: move from byte accesses to word
accesses
> 
> >>>>> "John" == John Linn <john.linn@xilinx.com> writes:
> 
>  John> Byte accesses for I/O devices in Xilinx IP is going to be less
>  John> desired in the future such that the driver is being changed to
>  John> use 32 bit accesses.
> 
>  John> This change facilitates using the uartlite IP over a PCIe bus
>  John> which only allows 32 bit accesses.
> 
>  John> Signed-off-by: John Linn <john.linn@xilinx.com>
>  John> Tested-by: Michal Simek <monstr@monstr.eu>
>  John> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Looks good,
> 
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

Thanks Peter, appreciate the help.


> 
> --
> Bye, Peter Korsgaard


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.



From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] uartlite: move from byte accesses to word accesses
Date: Wed, 20 Jan 2010 23:53:29 +0100
Message-ID: <87y6jsl76e.fsf@macbook.be.48ers.dk>
References: <28287b91-411c-4ae6-82b8-ec02a9d8e75d@SG2EHSMHS006.ehs.local>
	<873a20mvgg.fsf@macbook.be.48ers.dk>
	<2f45ae30-3c9f-4b92-90a1-fc6a2a91445b@SG2EHSMHS006.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:50703 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab0ATWxd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jan 2010 17:53:33 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1390543eyd.19
        for <linux-serial@vger.kernel.org>; Wed, 20 Jan 2010 14:53:32 -0800 (PST)
In-Reply-To: <2f45ae30-3c9f-4b92-90a1-fc6a2a91445b@SG2EHSMHS006.ehs.local>
	(John Linn's message of "Wed, 20 Jan 2010 14:49:45 -0700")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <John.Linn@xilinx.com>
Cc: linux-serial@vger.kernel.org, grant.likely@secretlab.ca, michal.simek@petalogix.com, john.williams@petalogix.com

>>>>> "John" == John Linn <John.Linn@xilinx.com> writes:

Hi,

 >> Why is it less desired?

 John> We are wanting to use our IP cores over a PCIe bus and it only
 John> allows 32 bit accesses.

Ok, that's valuable information for the commit messages.

 John> I understand.  Most of our customers are using a 32 bit bus so
 John> that this wouldn't be a problem for most people.

 John> We could do some kind of conditional compilation for the
 John> accesses, but it's certainly less desired.  We could make 32 bit
 John> the default and then allow a kernel config to change the access
 John> size.

Naah, the project where we needed 16bit access is _OLD_, and the
platform hasn't been ported from arch/ppc, so let's just move to 32bit
access.

If you send an updated patch with a more detailed commit message then
I'll ack it.

-- 
Bye, Peter Korsgaard

From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Uartlite driver
Date: Mon, 12 May 2008 09:43:58 +0200
Message-ID: <87lk2garwh.fsf@macbook.be.48ers.dk>
References: <4826FC28.4090701@seznam.cz> <1210545557.5798.267.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:42179 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757828AbYELHoJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 May 2008 03:44:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1709790fgg.17
        for <linux-serial@vger.kernel.org>; Mon, 12 May 2008 00:44:03 -0700 (PDT)
In-Reply-To: <1210545557.5798.267.camel@localhost> (John Williams's message of "Mon\, 12 May 2008 08\:39\:17 +1000")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Williams <john.williams@petalogix.com>
Cc: monstr@seznam.cz, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

>>>>> "John" == John Williams <john.williams@petalogix.com> writes:

Hi,

 John> The uartlite register set is 32 bits wide - that's what the datasheet
 John> says, and that's how we should interact with it.  I really don't
 John> understand why this commit was reverted.

 John> Who uses the uartlite driver for anything other than the uartlite?

Me (the author of uartlite.c). We have designs where we needed more
uarts, but didn't have any more room/ I/O pins on the virtex, so we
have implemented an uartlite compatible interface in a S3E connected
through a 16bit bus.

Not exactly brilliant hw design, but it works and it keeps the sw
support to a minimum.

-- 
Bye, Peter Korsgaard

From: John Williams <john.williams@petalogix.com>
Subject: Re: Uartlite driver
Date: Mon, 12 May 2008 08:39:17 +1000
Message-ID: <1210545557.5798.267.camel@localhost>
References: <4826FC28.4090701@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from uki.us.mooball.net ([66.98.178.13]:37145 "EHLO
	uki.us.mooball.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755082AbYEKXFy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 May 2008 19:05:54 -0400
In-Reply-To: <4826FC28.4090701@seznam.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@seznam.cz
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, jacmet@sunsite.dk, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Hi Michal,

On Sun, 2008-05-11 at 16:01 +0200, Michal Simek wrote:

> I have started to use uartlite driver which is in Linus tree.
> I look at history and differences between my ancient version and new one.
> I found one "insensible" commit from Grant with ACK from Josh and John and one
> revert of this.
> 
> This commit a15da8eff3627b8368db7f5dd260e5643213d918 (description below) is
> trying to fix problem 32bit access to ulite registers. You change 8bit access to
> 32bit (and commit 077b50c29a7e8be5812d1156934ea837b712ca6) reverts changes back.
> 
> "Magic offset" is not magic it is normal - because there is normal big endian
> mess where readb and writeb read first byte from big endian but uartlite
> registers have are on the last byte -> this mean that magical offset +3.
> 
> goto next;
> 
> [POWERPC] Uartlite: Fix reg io to access documented register size
> The Uartlite data sheet defines the registers as 32 bit wide.  This
> patch changes the register access to use 32 bit transfers and eliminates
> the magic +3 offset which is currently required to make the device
> work.
> 
> [POWERPC] Uartlite: Revert register io access changes
> Reverts commit a15da8eff3627b8368db7f5dd260e5643213d918
> This driver is used by devices other than the xilinx opb-uartlite which
> depend on bytewise access to the registers.  The change to 32 bit access
> does not work on these devices.

The uartlite register set is 32 bits wide - that's what the datasheet
says, and that's how we should interact with it.  I really don't
understand why this commit was reverted.

Who uses the uartlite driver for anything other than the uartlite?

Magic +3 offsets anywhere are a bad idea - I agree having addresses like
0x40100003 in the kernel log for base addresses is stupid, but I don't
like a +3 offset in the platform code either.

Why can't we use the device as documented, with 32 bit wide accesses?

Regards,

John



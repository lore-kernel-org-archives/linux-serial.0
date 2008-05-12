From: Michal Simek <monstr@seznam.cz>
Subject: Re: Uartlite driver
Date: Mon, 12 May 2008 08:15:15 +0200
Message-ID: <4827E073.9020301@seznam.cz>
References: <4826FC28.4090701@seznam.cz> <1210545557.5798.267.camel@localhost> <fa686aa40805112131td11daa7n6ba24c85a413b243@mail.gmail.com>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from service1.sh.cvut.cz ([147.32.127.214]:52925 "EHLO
	service1.sh.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbYELHDJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 May 2008 03:03:09 -0400
In-Reply-To: <fa686aa40805112131td11daa7n6ba24c85a413b243@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: John Williams <john.williams@petalogix.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-serial@vger.kernel.org, jacmet@sunsite.dk, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Hi Grant,


> On Sun, May 11, 2008 at 4:39 PM, John Williams
> <john.williams@petalogix.com> wrote:
>> Hi Michal,
>>
>>  On Sun, 2008-05-11 at 16:01 +0200, Michal Simek wrote:
>>
>>  > This commit a15da8eff3627b8368db7f5dd260e5643213d918 (description below) is
>>  > trying to fix problem 32bit access to ulite registers. You change 8bit access to
>>  > 32bit (and commit 077b50c29a7e8be5812d1156934ea837b712ca6) reverts changes back.
>>  >
>>  > "Magic offset" is not magic it is normal - because there is normal big endian
>>  > mess where readb and writeb read first byte from big endian but uartlite
>>  > registers have are on the last byte -> this mean that magical offset +3.
> 
> I fully understand the reason for the +3.  What makes it 'magic' is
> the fact that it is an undocumented value added to the base address
> with no comment describing what it is for.

This is documented offset - look at uartlite manual - useful bits are 24-31.
On big endian systems with 32bit access is everything ok because the least
significant byte is the last in memory. But when you changed from 32bits to 8
bits access than you have to move your base address to +3 offset.

This is not undocumented value.


>>  The uartlite register set is 32 bits wide - that's what the datasheet
>>  says, and that's how we should interact with it.  I really don't
>>  understand why this commit was reverted.
>>
>>  Who uses the uartlite driver for anything other than the uartlite?
>>
>>  Magic +3 offsets anywhere are a bad idea - I agree having addresses like
>>  0x40100003 in the kernel log for base addresses is stupid, but I don't
>>  like a +3 offset in the platform code either.
>>
>>  Why can't we use the device as documented, with 32 bit wide accesses?
> 
> Peter (who wrote the driver in the first place) has another device
> which has almost the same register layout, but either does not support
> 32bit accesses, or is based at a different offset (I can't remember
> which).  Regardless, my change broke support for his device.
> 
> As for the platform code (in virtex_devices.c), I'm no longer
> concerned what ugliness lives there.  It will be gone in the next
> kernel version regardless.  Nor am I particularly concerned about the
> internal structure of the driver anymore as long as it works (it's
> Peter's responsibility as long as he is maintaining that driver).
> What I *do* care about is the device tree binding for the uartlite.
> As long as the device tree binding shows the real device base address
> and not any byte-addressable offset nonsense, then I'm happy.

:-)

Michal

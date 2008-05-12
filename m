From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Uartlite driver
Date: Sun, 11 May 2008 22:31:57 -0600
Message-ID: <fa686aa40805112131td11daa7n6ba24c85a413b243@mail.gmail.com>
References: <4826FC28.4090701@seznam.cz> <1210545557.5798.267.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:8416 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYELEb6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 May 2008 00:31:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so437098and.103
        for <linux-serial@vger.kernel.org>; Sun, 11 May 2008 21:31:57 -0700 (PDT)
In-Reply-To: <1210545557.5798.267.camel@localhost>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Williams <john.williams@petalogix.com>
Cc: monstr@seznam.cz, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-serial@vger.kernel.org, jacmet@sunsite.dk, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

On Sun, May 11, 2008 at 4:39 PM, John Williams
<john.williams@petalogix.com> wrote:
> Hi Michal,
>
>  On Sun, 2008-05-11 at 16:01 +0200, Michal Simek wrote:
>
>  > This commit a15da8eff3627b8368db7f5dd260e5643213d918 (description below) is
>  > trying to fix problem 32bit access to ulite registers. You change 8bit access to
>  > 32bit (and commit 077b50c29a7e8be5812d1156934ea837b712ca6) reverts changes back.
>  >
>  > "Magic offset" is not magic it is normal - because there is normal big endian
>  > mess where readb and writeb read first byte from big endian but uartlite
>  > registers have are on the last byte -> this mean that magical offset +3.

I fully understand the reason for the +3.  What makes it 'magic' is
the fact that it is an undocumented value added to the base address
with no comment describing what it is for.

>  The uartlite register set is 32 bits wide - that's what the datasheet
>  says, and that's how we should interact with it.  I really don't
>  understand why this commit was reverted.
>
>  Who uses the uartlite driver for anything other than the uartlite?
>
>  Magic +3 offsets anywhere are a bad idea - I agree having addresses like
>  0x40100003 in the kernel log for base addresses is stupid, but I don't
>  like a +3 offset in the platform code either.
>
>  Why can't we use the device as documented, with 32 bit wide accesses?

Peter (who wrote the driver in the first place) has another device
which has almost the same register layout, but either does not support
32bit accesses, or is based at a different offset (I can't remember
which).  Regardless, my change broke support for his device.

As for the platform code (in virtex_devices.c), I'm no longer
concerned what ugliness lives there.  It will be gone in the next
kernel version regardless.  Nor am I particularly concerned about the
internal structure of the driver anymore as long as it works (it's
Peter's responsibility as long as he is maintaining that driver).
What I *do* care about is the device tree binding for the uartlite.
As long as the device tree binding shows the real device base address
and not any byte-addressable offset nonsense, then I'm happy.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

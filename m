From: Dave Hansen <dave@sr71.net>
Subject: Re: post 3.14 serial regression
Date: Wed, 09 Apr 2014 09:02:00 -0700
Message-ID: <53456EF8.8060805@sr71.net>
References: <5343416F.8010201@sr71.net> <20140408122726.227f3da8@alan.etchedpixels.co.uk> <5344642A.2020703@sr71.net> <53446C57.5000504@intel.com> <20140409003648.GB32273@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140409003648.GB32273@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Hansen <dave.hansen@intel.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

On 04/08/2014 05:36 PM, Greg Kroah-Hartman wrote:
>> > Looks like this just changed the detection order so my device went from
>> > ttyS2 to ttyS4:
>> > 
>> > # cat /proc/tty/driver/serial
>> > serinfo:1.0 driver revision:
>> > 0: uart:16550A port:000003F8 irq:4 tx:0 rx:0 CTS|DSR|CD
>> > 1: uart:16550A port:000002F8 irq:3 tx:0 rx:0
>> > 2: uart:unknown port:000003E8 irq:4
>> > 3: uart:unknown port:000002E8 irq:3
>> > 4: uart:ST16650V2 port:00001008 irq:18 tx:0 rx:0
>> > 5: uart:ST16650V2 port:00001000 irq:19 tx:0 rx:0
> That's not good.
> 
> Geert, any idea how to fix this?  Or should I just revert your change to
> get back to the "working" behavior?

During some large bisects on previous kernels, I've noticed it make a
switch from ttyS2->ttyS4 before.  In other words, this might have
restored some *old* behavior inadvertently.

The annoying thing is that these assignments *do* keep swapping around.
 I don't really care whether or not we revert this, only that we pick
one order and stick with it.

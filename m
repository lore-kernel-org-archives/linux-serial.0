From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: Device to write to all (serial) consoles
Date: Sat, 3 Aug 2019 15:23:23 +0200
Message-ID: <20190803132323.GB6703@angband.pl>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
 <20190802160243.GA15484@kroah.com>
 <cab1fe06-0dc7-e7c1-50ac-cc01773c5ef5@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cab1fe06-0dc7-e7c1-50ac-cc01773c5ef5@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Donald Buczek <buczek@molgen.mpg.de>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 02, 2019 at 09:59:06PM +0200, Paul Menzel wrote:
> On 02.08.19 18:02, Greg Kroah-Hartman wrote:
> > On Fri, Aug 02, 2019 at 03:23:08PM +0200, Paul Menzel wrote:
> > > On a lot of devices, like servers, you have more than one serial console,
> > > and you do not always know, how they are numbered. Therefore, we start a
> > > console on ttyS0 and ttyS1.
> 
> Because the cable is always connected to the port on the back side, and
> sometimes the port in the front has ID 0, and the one in the back 1, and
> other times vice versa. We do not want to track that, and it would be
> convenient to just write to both ports.

Sounds like an XY problem then: what you want is not writing to all ports,
but to have the port assignments stable (see also: disk device reordering).


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ Latin:   meow 4 characters, 4 columns,  4 bytes
⣾⠁⢠⠒⠀⣿⡁ Greek:   μεου 4 characters, 4 columns,  8 bytes
⢿⡄⠘⠷⠚⠋  Runes:   ᛗᛖᛟᚹ 4 characters, 4 columns, 12 bytes
⠈⠳⣄⠀⠀⠀⠀ Chinese: 喵   1 character,  2 columns,  3 bytes <-- best!

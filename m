From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Date: Wed, 19 Jun 2013 12:52:59 +0200
Message-ID: <20130619105259.GC9448@linux-mips.org>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
 <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
 <2302882.NVjP8DdXWY@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2302882.NVjP8DdXWY@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 19, 2013 at 12:01:06PM +0200, Arnd Bergmann wrote:

> This breaks building on 32 bit architectures as I found on my daily ARM
> builds: __raw_writeq cannot be defined on architectures that don't have
> native 64 bit data access instructions. It's also wrong to use the
> __raw_* variant, which is not guaranteed to be atomic and is not
> endian-safe.

I've dequeued the series from the mips-next tree until David has a chance
to fix this.

  Ralf

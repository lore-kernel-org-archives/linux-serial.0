From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Date: Wed, 19 Jun 2013 20:52:09 +0200
Message-ID: <201306192052.09575.arnd@arndb.de>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com> <2302882.NVjP8DdXWY@wuerfel> <51C1E028.2040700@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51C1E028.2040700@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-serial@vger.kernel.org

On Wednesday 19 June 2013, David Daney wrote:
> On 06/19/2013 03:01 AM, Arnd Bergmann wrote:

> > It's also wrong to use the
> > __raw_* variant, which is not guaranteed to be atomic and is not
> > endian-safe.
> 
> We do runtime probing and only use this function on platforms where it 
> is appropriate, so atomicity is not an issue.  As for endianess, I used 
> the __raw_ variant precisely because it is correct for both big and 
> little endian kernels.

You don't know what the compiler turns a __raw_writeq into, it could
always to eight byte wise stores, that's why typically writeq is
an inline assembly while __raw_writeq is just a pointer dereference.

__raw_* never do endian swaps, so it will be wrong on either big-endian
CPUs or on little-endian CPUs, depending on what the MMIO register
needs.

	Arnd

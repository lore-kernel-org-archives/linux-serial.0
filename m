From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] fix early_serial_setup() regression
Date: Tue, 13 Jan 2009 16:55:26 -0500
Message-ID: <20090113215526.GG25103@bombadil.infradead.org>
References: <496D0CCB.1020706@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <496D0CCB.1020706@gmx.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: David Daney <ddaney@caviumnetworks.com>, Tomaso Paoletti <tpaoletti@caviumnetworks.com>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Kyle McMartin <kyle@mcmartin.ca>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, "Rafael J. Wysocky" <rjw@sisk.pl>, linux-parisc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 13, 2009 at 10:51:07PM +0100, Helge Deller wrote:
> commit b430428a188e8a434325e251d0704af4b88b4711,
> 	"8250: Don't clobber spinlocks."
> introduced a regression on the parisc architecture, which
> broke the handover to the serial port at boottime.
> 
> early_serial_setup() was changed to only copy a subset of the
> uart_port fields, and sadly the "type" and "line" fields
> were forgotten and thus the serial port was not initialized
> and could not be used for a handover.
> This patch fixes this by copying the missing fields.
> 
> As this change to early_serial_setup() doesn't need an 
> initialized spinlock in the uart_port struct any longer, we
> can drop the spinlock initialization in the superio driver.
> 
> CC: David Daney <ddaney@caviumnetworks.com>
> CC: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Kyle McMartin <kyle@mcmartin.ca>
> CC: linux-parisc@vger.kernel.org
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 

Acked-by: Kyle McMartin <kyle@mcmartin.ca>

Linus, please apply.

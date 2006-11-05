From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc <-> ThinkPads, summary
Date: Sun, 5 Nov 2006 07:23:30 +0100
Message-ID: <20061105062330.GT13381@stusta.de>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il> <20061101030126.GE27968@stusta.de> <20061104034906.GO13381@stusta.de> <20061104140440.GB19760@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061104140440.GB19760@flint.arm.linux.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Hugh Dickins <hugh@veritas.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org, Martin Lorenz <martin@lorenz.eu.org>, Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-serial@vger.kernel.org, linux-thinkpad@linux-thinkpad.org, Ernst Herzberg <earny@net4u.de>
List-Id: linux-serial@vger.kernel.org

On Sat, Nov 04, 2006 at 02:04:40PM +0000, Russell King wrote:
> On Sat, Nov 04, 2006 at 04:49:07AM +0100, Adrian Bunk wrote:
> > As far as I can see, the 2.6.19-rc ThinkPad situation is still 
> > confusing and we don't even know how many different bugs we are 
> > chasing...
> 
> Why am I copied on this?  Nothing jumps out as being in any area of my
> interest (which today is limited to ARM architecture only.)

Ernst bisected his problem to your
commit 1fbbac4bcb03033d325c71fc7273aa0b9c1d9a03 
("serial_cs: convert multi-port table to quirk table").

It might be a false positive of the bisecting, but if it turns out to 
actually cause problems it was your commit.

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


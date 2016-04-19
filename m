From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH, RESEND] serial-uartlite: un-constify
 uartlite_be/uartlite_le
Date: Tue, 19 Apr 2016 15:14:17 +0900
Message-ID: <20160419061417.GB11703@kroah.com>
References: <1460851985-1280235-1-git-send-email-arnd@arndb.de>
 <20160417003901.GA29002@kroah.com>
 <5713C107.5070009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5713C107.5070009@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Korsgaard <jacmet@sunsite.dk>, Jiri Slaby <jslaby@suse.com>, Maarten Brock <m.brock@vanmierlo.com>, Rich Felker <dalias@libc.org>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Apr 17, 2016 at 10:29:51PM +0530, Sudip Mukherjee wrote:
> On Sunday 17 April 2016 06:09 AM, Greg Kroah-Hartman wrote:
> > On Sun, Apr 17, 2016 at 02:12:47AM +0200, Arnd Bergmann wrote:
> > > The patch to make uartlite_be/uartlite_le const was well-intended but
> > > caused a new build warning:
> > > 
> > > tty/serial/uartlite.c: In function 'ulite_request_port':
> > > tty/serial/uartlite.c:348:21: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> > > tty/serial/uartlite.c:354:22: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> > > 
> > > It would be nice to allow passing const pointers through
> > > port->private_data, but that would be way more work, so this
> > > reverts part of the original commit for now.
> > > 
> > > A possible alternative might be to pass a structure in the private_data
> > > that contains a const pointer to the operations, which introduces a little
> > > extra overhead, or we could just add a cast to a non-const pointer, I'll
> > > leave that to the maintainer.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Fixes: 2905697a82ea ("serial-uartlite: Constify uartlite_be/uartlite_le")
> > > ---
> > >   drivers/tty/serial/uartlite.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > I sent this patch on March 10, but it never made it in.
> > > 
> > > Greg, could you apply the patch as a bugfix for 4.6? The warning is
> > > annoying as it shows up in several defconfig builds and allmodconfig.
> > 
> > Ugh, sorry about this, will get to it soon...
> > 
> 
> A revert patch with the same effect posted on 11th April is also in waiting.
> http://www.spinics.net/lists/linux-serial/msg22287.html

Sorry for the delay, will go queue that one up now...

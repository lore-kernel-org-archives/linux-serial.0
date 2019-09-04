From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_pci: Implement MSI(-X) support
Date: Wed, 4 Sep 2019 09:22:06 +0200
Message-ID: <20190904072206.GA30185@kroah.com>
References: <20190812112152.693622-1-ralf.ramsauer@oth-regensburg.de>
 <740fc1e7-fb3d-c0c7-c17b-2ea3a8864d89@oth-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <jailhouse-dev+bncBCUJ7YGL3QFBBIOMXXVQKGQEM32NPPQ@googlegroups.com>
Sender: jailhouse-dev@googlegroups.com
Content-Disposition: inline
In-Reply-To: <740fc1e7-fb3d-c0c7-c17b-2ea3a8864d89@oth-regensburg.de>
List-Post: <https://groups.google.com/group/jailhouse-dev/post>, <mailto:jailhouse-dev@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:jailhouse-dev+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/jailhouse-dev
List-Subscribe: <https://groups.google.com/group/jailhouse-dev/subscribe>, <mailto:jailhouse-dev+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+175645748590+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/jailhouse-dev/subscribe>
To: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, jailhouse-dev@googlegroups.com, Jay Dolan <jay.dolan@accesio.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 30, 2019 at 12:33:09AM +0200, Ralf Ramsauer wrote:
> *ping* :)
> 
> On 8/12/19 1:21 PM, Ralf Ramsauer wrote:
> > There may be setups, where legacy interrupts are not available. This is
> > the caese, e.g., when Linux runs as guest (aka. non-root cell) of the
> > partitioning hypervisor Jailhouse. There, only MSI(-X) interrupts are
> > available for guests.
> > 
> > But the 8250_pci driver currently only supports legacy ints. So let's
> > enable MSI(-X) interrupts.
> > 
> > Nevertheless, this needs to handled with care: while many 8250 devices
> > actually claim to support MSI(-X) interrupts it should not be enabled be
> > default. I had at least one device in my hands with broken MSI
> > implementation.
> > 
> > So better introduce a whitelist with devices that are known to support
> > MSI(-X) interrupts. I tested all devices mentioned in the patch.
> > 
> > Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>

Ok, will queue this up, let's see what breaks :)

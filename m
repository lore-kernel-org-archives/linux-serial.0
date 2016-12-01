From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 32/39] Annotate hardware config module parameters in
 drivers/tty/
Date: Thu, 1 Dec 2016 16:02:52 +0100
Message-ID: <20161201150252.GA10786@kroah.com>
References: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
 <148059563433.31612.11409694377610141671.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <148059563433.31612.11409694377610141671.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, minyard@acm.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 01, 2016 at 12:33:54PM +0000, David Howells wrote:
> When the kernel is running in secure boot mode, we lock down the kernel to
> prevent userspace from modifying the running kernel image.  Whilst this
> includes prohibiting access to things like /dev/mem, it must also prevent
> access by means of configuring driver modules in such a way as to cause a
> device to access or modify the kernel image.
> 
> To this end, annotate module_param* statements that refer to hardware
> configuration and indicate for future reference what type of parameter they
> specify.  The parameter parser in the core sees this information and can
> skip such parameters with an error message if the kernel is locked down.
> The module initialisation then runs as normal, but just sees whatever the
> default values for those parameters is.
> 
> Note that we do still need to do the module initialisation because some
> drivers have viable defaults set in case parameters aren't specified and
> some drivers support automatic configuration (e.g. PNP or PCI) in addition
> to manually coded parameters.
> 
> This patch annotates drivers in drivers/tty/.
> 
> Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> cc: Jiri Slaby <jslaby@suse.com>
> cc: linux-serial@vger.kernel.org
> ---
> 
>  drivers/tty/cyclades.c              |    4 ++--
>  drivers/tty/moxa.c                  |    2 +-
>  drivers/tty/mxser.c                 |    2 +-
>  drivers/tty/rocket.c                |   10 +++++-----
>  drivers/tty/serial/8250/8250_core.c |    4 ++--
>  drivers/tty/synclink.c              |    6 +++---
>  6 files changed, 14 insertions(+), 14 deletions(-)

NAK, see my response to patch 1 of this series.

thanks,

greg k-h

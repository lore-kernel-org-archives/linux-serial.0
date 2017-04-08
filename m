From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 31/38] Annotate hardware config module parameters in
 drivers/tty/
Date: Sat, 8 Apr 2017 17:19:16 +0200
Message-ID: <20170408151916.GA7879@kroah.com>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
 <149141168659.29162.541205367169653847.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-security-module-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <149141168659.29162.541205367169653847.stgit@warthog.procyon.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 05, 2017 at 06:01:26PM +0100, David Howells wrote:
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
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> cc: Jiri Slaby <jslaby@suse.com>
> cc: linux-serial@vger.kernel.org


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

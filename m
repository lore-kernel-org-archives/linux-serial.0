From: Bin Gao <bin.gao@linux.intel.com>
Subject: Re: serial_core: add pci uart early console support
Date: Thu, 14 May 2015 16:40:39 -0700
Message-ID: <20150514234015.GA90698@worksta>
References: <20150513192016.GA167188@worksta>
 <20150513230844.1d9a5d9a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150513230844.1d9a5d9a@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> On Wed, May 13, 2015 at 11:08:44PM +0100, One Thousand Gnomes wrote:
> 
> We've already got support for this
> 
> commit ea9e9d8029020d438b0717ffddf65140fda16051
> 
> 
> I actually think the fact you've put it into drivers/tty is better as PCI
> is generic and PCI serial boot likewise. However it ought to use the same
> command line interface (with extensions) to be compatible with the
> existing arch/x86 code, and to remove the arch/x86 version if you are
> doing so.
> 
> Alan

So now I'm sending two patches:
[PATCH 1/2] serial_core: add pci uart early console support
[PATCH 2/2] arch/x86: remove pci uart early console from early_prink.c

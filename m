From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Sun, 20 Dec 2015 22:58:41 +0530
Message-ID: <20151220172841.GB8471@sudip-laptop>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20151220164353.6ef29f77@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151220164353.6ef29f77@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 20, 2015 at 04:43:53PM +0000, One Thousand Gnomes wrote:
> > v3: Alan commented on v2, few things like NULL check, name of the gpio chip,
> > moving some more code into the gpio code. He also commented on it being
> > a separate module, but since this will not be needed by someone who is not
> > using Exar chip, and even those who are using, some of them may not need it.
> > This is optional for only those who wants to use the gpio capability of that
> > chip. So kept it as a separate module. Waiting for your comments on that.
> 
> That doesn't work because you reference the methods in it so it will
> always be dragged in. You would have to make the exar driver an MFD that
> provided a serial and a gpio binding to fix that up I think, or instead
> of having the serial driver call into your gpio driver (thus forcing the
> module into memory) you would have the serial driver create a platform
> device or similar that the GPIO device bound to.

So then should I rewrite it as MFD or should it be like the way you
suggested in the other mail to have it as bool in the Kconfig and combine
the file with 8250_pci.c when the symbol is selected?

regards
sudip

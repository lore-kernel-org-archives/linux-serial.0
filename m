From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] serial: sh-sci: HSCIF support
Date: Sun, 16 Jun 2013 20:00:23 -0700
Message-ID: <20130617030023.GD12522@kroah.com>
References: <1371436934-27744-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1371436934-27744-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Ulrich Hecht <ulrich.hecht@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 17, 2013 at 11:42:12AM +0900, Simon Horman wrote:
> Hi Greg, Hi All,
> 
> this short series adds HSCIF support to the sh-sci driver
> and enhances the r8a7790 SoC to not use external clocks for SCIF.
> 
> I have included these two patches in a single series as the second
> patch has a build-time dependency on the first.
> 
> Greg, would it be possible for you to review at least the first patch and
> if it is ok either:
> * Ack the first patch so I can merge it through the renesas tree or;

I've done this now, feel free to take this through the renesas tree.

thanks,

greg k-h

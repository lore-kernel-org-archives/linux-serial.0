From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial: sh-sci: HSCIF support
Date: Sun, 16 Jun 2013 20:00:05 -0700
Message-ID: <20130617030005.GC12522@kroah.com>
References: <1371436934-27744-1-git-send-email-horms+renesas@verge.net.au>
 <1371436934-27744-2-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1371436934-27744-2-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Ulrich Hecht <ulrich.hecht@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 17, 2013 at 11:42:13AM +0900, Simon Horman wrote:
> From: Ulrich Hecht <ulrich.hecht@gmail.com>
> 
> Adds support for "High Speed Serial Communications Interface with FIFO",
> essentially a SCIF with 128-byte FIFOs and more accurate baud rate
> generator.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

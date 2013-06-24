From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sh-sci: Initialise variables before access in
 sci_set_termios()
Date: Mon, 24 Jun 2013 16:34:55 -0700
Message-ID: <20130624233455.GA25628@kroah.com>
References: <1371731102-5125-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1371731102-5125-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-sh@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.cz>, Ulrich Hecht <ulrich.hecht@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 20, 2013 at 09:25:02PM +0900, Simon Horman wrote:
> This change addresses two warnings that are flagged by gcc relating to
> potential access to the ssr and cks variables while they are uninitialised.
> 
> I have addressed this by initialising the values to
> the defaults present in sci_baud_calc_hscif().
> 
> It is my analysis that cks is always initialised if used
> but that without this change ssr may be accessed while uninitialised.
> 
> The code altered by this patch was introduced by commit
> f303b364b41d3fc5bf879799128958400b7859aa ("serial: sh-sci: HSCIF support").
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

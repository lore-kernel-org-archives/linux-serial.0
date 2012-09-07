From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: omap: fix compile breakage
Date: Fri, 7 Sep 2012 08:31:36 -0700
Message-ID: <20120907153136.GA8634@kroah.com>
References: <1346995312-2872-1-git-send-email-balbi@ti.com>
 <1346995531-3197-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346995531-3197-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 07, 2012 at 08:25:31AM +0300, Felipe Balbi wrote:
> when rebasing patches on top of Greg's tty-next,
> it looks like automerge broke a few things which
> I didn't catch (for whatever reason I didn't
> have OMAP Serial enabled on .config) so I ended
> up breaking the build on Greg's tty-next branch.
> 
> Fix the breakage by re-adding the three missing
> members on struct uart_omap_port.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Changes since v1:
> 	. remove the fields from <plat/omap-serial.h>
> 
>  arch/arm/plat-omap/include/plat/omap-serial.h | 4 ----
>  drivers/tty/serial/omap-serial.c              | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)

This applies with fuzz, what tree did you make it against?

patching file arch/arm/plat-omap/include/plat/omap-serial.h
Hunk #1 succeeded at 105 with fuzz 1 (offset 26 lines).
patching file drivers/tty/serial/omap-serial.c
Hunk #1 succeeded at 100 (offset -23 lines).

Should I still apply it?

greg k-h

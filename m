From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/4] tty/serial: atmel: enforce tasklet init and
 termination sequences
Date: Sat, 25 Jun 2016 13:39:59 -0700
Message-ID: <20160625203959.GA22761@kroah.com>
References: <cover.1466157015.git.nicolas.ferre@atmel.com>
 <5a52e1fbd8ec126bebfcd00f35bfe5af605ee914.1466157015.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5a52e1fbd8ec126bebfcd00f35bfe5af605ee914.1466157015.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 17, 2016 at 12:05:49PM +0200, Nicolas Ferre wrote:
> As some race conditions are identified in the termination process of tasklets,
> enforce the atmel_shutdown() sequence. This way we make sure that no new
> tasklets or software timer are scheduled during shutdown process.
> 
> An atomic flag is positioned to give this information throughout the code.
> 
> We also remove tasklet_disable() calls that were leading to deadlocks while
> stopping the driver. A simpler init/kill sequence is used.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 61 ++++++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 23 deletions(-)

You obviously didn't even test build this patch, as it breaks the build :(

please be more careful...

greg k-h

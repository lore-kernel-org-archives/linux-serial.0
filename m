From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND tty/serial 1/1] tty: serial: fsl_lpuart: add
 imx8qxp support
Date: Thu, 4 Jul 2019 15:53:27 +0200
Message-ID: <20190704135327.GA27565@kroah.com>
References: <20190704134007.2316-1-fugang.duan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190704134007.2316-1-fugang.duan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: fugang.duan@nxp.com
Cc: linux-serial@vger.kernel.org, jslaby@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, u.kleine-koenig@pengutronix.de, daniel.baluta@nxp.com
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 04, 2019 at 09:40:07PM +0800, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> The lpuart of imx8ulp is basically the same as imx7ulp, but it
> has new feature support based on imx7ulp, like it can assert a
> DMA request on EOP(end-of-packet). imx8ulp lpuart use two clocks,
> one is ipg bus clock that is used to access registers, the other
> is baud clock that is used to transmit-receive data.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 106 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 86 insertions(+), 20 deletions(-)

You need to list what changed from the last version below the --- line.

Anyway, I'll take this as-is, next time :)

thanks,

greg k-h

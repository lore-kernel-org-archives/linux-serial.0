From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] tty/serial/imx.c: Rename URTX0 to UTXD0
Date: Fri, 22 Feb 2019 21:55:20 +0100
Message-ID: <20190222205520.fvqpttlzq5lycbvu@pengutronix.de>
References: <20190222163127.10172-1-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222163127.10172-1-cquast@hanoverdisplays.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christina Quast <cquast@hanoverdisplays.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 22, 2019 at 04:31:27PM +0000, Christina Quast wrote:
> Rename to be coherent with the datasheet.
> 
> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
> ---
>  drivers/tty/serial/imx.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index dff75dc94731..a405e0d21ec9 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -40,7 +40,7 @@
>  
>  /* Register definitions */
>  #define URXD0 0x0  /* Receiver Register */
> -#define URTX0 0x40 /* Transmitter Register */
> +#define UTXD0 0x40 /* Transmitter Register */

Oh wow, I never noticed this and it was wrong ever since the kernel is
tracked in git (back in 1da177e4c3f4 the definition was in
include/asm-arm/arch-imx/imx-regs.h)---I didn't check further.

Also I checked the i.MX1, i.MX25 and i.MX6 manuals and the transmit
register was never called RTX, in all three manuals it is named UTXD.

I suggest to also drop the 0 from both URXD0 and UTXD0.

If you send a v2 I recommend adding the imx people (from MAINTAINERS) to
Cc.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

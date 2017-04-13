From: Shanker Donthineni <shankerd@codeaurora.org>
Subject: Re: [PATCH] tty: pl011: use "qdf2400_e44" as the earlycon name for
 QDF2400 E44
Date: Thu, 13 Apr 2017 09:35:15 -0500
Message-ID: <f546e63c-06a6-3027-8483-eb76f8b76c15@codeaurora.org>
References: <1492091708-30593-1-git-send-email-timur@codeaurora.org>
Reply-To: shankerd@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1492091708-30593-1-git-send-email-timur@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Timur,


On 04/13/2017 08:55 AM, Timur Tabi wrote:
> Define a new early console name for Qualcomm Datacenter Technologies
> QDF2400 SOCs affected by erratum 44, instead of piggy-backing on "pl011".
> Previously, to enable traditional (non-SPCR) earlycon, the documentation
> said to specify "earlycon=pl011,<address>,qdf2400_e44", but the code was
> broken and this didn't actually work.
>
> So instead, the method for specifying the E44 work-around with traditional
> earlycon is "earlycon=qdf2400_e44,<address>".  Both methods of earlycon
> are now enabled with the same function.
>
> Fixes: e53e597fd4c4 ("tty: pl011: fix earlycon work-around for QDF2400 erratum 44")
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Tested-by: Shanker Donthineni <shankerd@codeaurora.org>


> ---
>  drivers/tty/serial/amba-pl011.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 2783539..0875f7d 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2470,19 +2470,34 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
>  	if (!device->port.membase)
>  		return -ENODEV;
>  
> -	/* On QDF2400 SOCs affected by Erratum 44, the "qdf2400_e44" must
> -	 * also be specified, e.g. "earlycon=pl011,<address>,qdf2400_e44".
> -	 */
> -	if (!strcmp(device->options, "qdf2400_e44"))
> -		device->con->write = qdf2400_e44_early_write;
> -	else
> -		device->con->write = pl011_early_write;
> +	device->con->write = pl011_early_write;
>  
>  	return 0;
>  }
>  OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
>  OF_EARLYCON_DECLARE(pl011, "arm,sbsa-uart", pl011_early_console_setup);
> -EARLYCON_DECLARE(qdf2400_e44, pl011_early_console_setup);
> +
> +/*
> + * On Qualcomm Datacenter Technologies QDF2400 SOCs affected by
> + * Erratum 44, traditional earlycon can be enabled by specifying
> + * "earlycon=qdf2400_e44,<address>".  Any options are ignored.
> + *
> + * Alternatively, you can just specify "earlycon", and the early console
> + * will be enabled with the information from the SPCR table.  In this
> + * case, the SPCR code will detect the need for the E44 work-around,
> + * and set the console name to "qdf2400_e44".
> + */
> +static int __init
> +qdf2400_e44_early_console_setup(struct earlycon_device *device,
> +				const char *opt)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	device->con->write = qdf2400_e44_early_write;
> +	return 0;
> +}
> +EARLYCON_DECLARE(qdf2400_e44, qdf2400_e44_early_console_setup);
>  
>  #else
>  #define AMBA_CONSOLE	NULL

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

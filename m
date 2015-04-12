From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH v3 01/10] drivers: PL011: avoid potential
 unregister_driver call
Date: Sun, 12 Apr 2015 11:15:54 +0200
Message-ID: <20150412111554.65edf83a@north>
References: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
 <1428578961-6896-2-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1428578961-6896-2-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: rob.herring@linaro.org, arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, rmk+kernel@arm.linux.org.uk, Jiri Slaby <jslaby@suse.cz>, Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu,  9 Apr 2015 12:29:12 +0100, Andre Przywara wrote:
> Although we care about not unregistering the driver if there are
> still ports connected during the .remove callback, we do miss this
> check in the pl011_probe function. So if the current port allocation
> fails, but there are other ports already registered, we will kill
> those.
> So factor out the port removal into a separate function and use that
> in the probe function, too.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/tty/serial/amba-pl011.c |   37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index f5bd842..d08951f 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2135,6 +2135,24 @@ static int pl011_probe_dt_alias(int index, struct device *dev)
>  	return ret;
>  }
>  
> +/* unregisters the driver also if no more ports are left */
> +static void pl011_unregister_port(struct uart_amba_port *uap)
> +{
> +	int i;
> +	bool busy = false;
> +
> +	for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
> +		if (amba_ports[i] == uap)
> +			amba_ports[i] = NULL;
> +		else if (amba_ports[i])
> +			busy = true;
> +	}
> +	pl011_dma_remove(uap);
> +	if (!busy)
> +		uart_unregister_driver(&amba_reg);
> +}
> +
> +

Double new line.

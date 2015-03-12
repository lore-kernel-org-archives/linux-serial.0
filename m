From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 01/10] drivers: PL011: avoid potential
 unregister_driver call
Date: Thu, 12 Mar 2015 10:42:59 +0000
Message-ID: <20150312104258.GI8656@n2100.arm.linux.org.uk>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
 <1425491994-23913-2-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1425491994-23913-2-git-send-email-andre.przywara@arm.com>
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
Cc: rob.herring@linaro.org, arnd@arndb.de, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz, Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 04, 2015 at 05:59:45PM +0000, Andre Przywara wrote:
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
>  drivers/tty/serial/amba-pl011.c |   38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 92783fc..961f9b0 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2235,6 +2235,24 @@ static int pl011_probe_dt_alias(int index, struct device *dev)
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

This is still racy, as I pointed out at the time this crap was dreamt
up.

There is _no_ locking between an individual driver's ->probe or ->remove
functions being called concurrently for different devices.  The only
locking which the driver model guarantees is that a single struct device
can only be probed by one driver at a time.

Multiple struct device's can be in-progress of ->probe or ->remove
simultaneously.

However, this isn't your bug to solve... it's those who were proponents
of this crap approach.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

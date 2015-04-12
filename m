From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH v3 05/10] drivers: PL011: refactor pl011_probe()
Date: Sun, 12 Apr 2015 12:16:22 +0200
Message-ID: <20150412121622.2ee92f59@north>
References: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
 <1428578961-6896-6-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1428578961-6896-6-git-send-email-andre.przywara@arm.com>
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

On Thu,  9 Apr 2015 12:29:16 +0100, Andre Przywara wrote:
> Currently the pl011_probe() function is relying on some AMBA IDs
> and a device tree node to initialize the driver and a port.
> Both features are not necessarily required for the driver:
> - we lack AMBA IDs in the ARM SBSA generic UART and
> - we lack a DT node in ACPI systems.
> So lets refactor the function to ease later reuse.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/tty/serial/amba-pl011.c |   89 ++++++++++++++++++++++++++-------------
>  1 file changed, 60 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index e1ac2cb..65df5c7 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2174,13 +2174,10 @@ static void pl011_unregister_port(struct uart_amba_port *uap)
>  		uart_unregister_driver(&amba_reg);
>  }
>  
> -
> -static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
> +static int pl011_allocate_port(struct device *dev, struct uart_amba_port **_uap)
>  {
>  	struct uart_amba_port *uap;
> -	struct vendor_data *vendor = id->data;
> -	void __iomem *base;
> -	int i, ret;
> +	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
>  		if (amba_ports[i] == NULL)
> @@ -2189,51 +2186,53 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  	if (i == ARRAY_SIZE(amba_ports))
>  		return -EBUSY;
>  
> -	uap = devm_kzalloc(&dev->dev, sizeof(struct uart_amba_port),
> -			   GFP_KERNEL);
> +	uap = devm_kzalloc(dev, sizeof(struct uart_amba_port), GFP_KERNEL);
>  	if (uap == NULL)
>  		return -ENOMEM;
>  
> -	i = pl011_probe_dt_alias(i, &dev->dev);
> +	if (_uap)
> +		*_uap = uap;
> +
> +	return i;
> +}

Could we please move the allocation out of this function and spare
ourselves the "out argument".  It's just a matter of personal
preference so the final decision is up to you.

Also you never pass _uap as NULL so the check is unnecessary.

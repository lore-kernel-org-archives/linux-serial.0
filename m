From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/4] serial: 8250: of: Load TX FIFO Load Size from DT
Date: Fri, 16 Sep 2016 14:20:39 -0500
Message-ID: <20160916192039.GB30710@rob-hp-laptop>
References: <1473351141-9239-1-git-send-email-tthayer@opensource.altera.com>
 <1473351141-9239-3-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473351141-9239-3-git-send-email-tthayer@opensource.altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tthayer@opensource.altera.com
Cc: gregkh@linuxfoundation.org, mark.rutland@arm.com, lftan@altera.com, jslaby@suse.com, arnd@arndb.de, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, yegorslists@googlemail.com, matwey@sai.msu.ru, mail@maciej.szmigiero.name, peter.ujfalusi@ti.com, jonathanh@nvidia.com, dongsheng.wang@nxp.com, luis@debethencourt.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, tthayer.linux@gmail.com, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 08, 2016 at 11:12:19AM -0500, tthayer@opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Initialize the tx_loadsz parameter if it is defined in the
> device tree.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  drivers/tty/serial/8250/8250_of.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 38963d7..3e4be2f 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -195,6 +195,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
>  	switch (port_type) {
>  	case PORT_8250 ... PORT_MAX_8250:
>  	{
> +		u32 prop;
>  		struct uart_8250_port port8250;
>  		memset(&port8250, 0, sizeof(port8250));
>  		port8250.port = port;
> @@ -202,6 +203,11 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
>  		if (port.fifosize)
>  			port8250.capabilities = UART_CAP_FIFO;
>  
> +		/* Check for TX fifo load size */
> +		if (of_property_read_u32(ofdev->dev.of_node,
> +					 "tx-loadsz", &prop) == 0)
> +			port8250.tx_loadsz = prop;

This can be simplified to:

of_property_read_u32(ofdev->dev.of_node, "tx-loadsz", &port8250.tx_loadsz);


> +
>  		if (of_property_read_bool(ofdev->dev.of_node,
>  					  "auto-flow-control"))
>  			port8250.capabilities |= UART_CAP_AFE;
> -- 
> 1.7.9.5
> 

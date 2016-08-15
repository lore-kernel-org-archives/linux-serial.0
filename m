From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v10 10/11] serial: 8250_lpss: enable MSI for Intel Quark
Date: Mon, 15 Aug 2016 10:04:42 +0100
Message-ID: <1471251882.5063.2.camel@nexus-software.ie>
References: <1471017716-44893-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1471017716-44893-11-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471017716-44893-11-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-08-12 at 19:01 +0300, Andy Shevchenko wrote:
> Intel Quark SoC supports MSI for LPSS, in particular for UART. Enable
> MSI for
> Intel Quark.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c
> b/drivers/tty/serial/8250/8250_lpss.c
> index cad96ee..5ac291c 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -151,6 +151,17 @@ static int byt_serial_setup(struct lpss8250
> *lpss, struct uart_port *port)
>  	return 0;
>  }
>  
> +static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port
> *port)
> +{
> +	struct pci_dev *pdev = to_pci_dev(port->dev);
> +
> +	pci_enable_msi(pdev);
> 

Andy,

ret = pci_enable_msi(dev);
if (ret)
    return ret;

once added please add

Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>

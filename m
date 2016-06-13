From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC] serial: 8250: fix regression in 8250 uart driver
Date: Mon, 13 Jun 2016 14:57:14 -0700
Message-ID: <575F2C3A.9040103@hurleysoftware.com>
References: <575F1404.1070802@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575F1404.1070802@opensource.altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dinh Nguyen <dinguyen@opensource.altera.com>
Cc: andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/13/2016 01:13 PM, Dinh Nguyen wrote:
> Hi Andy,
> 
> I saw that you have discovered that commit ec5a11a91eec ("serial: 8250:
> Validate dmaengine rx chan meets requirements") introduced a regression
> in the 8250 uart driver. For SoCFPGA platform, I am seeing this error:
> 
> [    5.541751] ttyS0 - failed to request DMA
> 
> Reverting the commit ec5a11a91eec removes the error.

The error is that your dmaengine driver doesn't support the functionality
required by the 8250 driver.

Regards,
Peter Hurley

> I saw that you started the discussion, but I didn't see that a patch was
> included[1].
> 
> The following patch seems to fix the error, but I'm not sure if it's the
> same fix that you had in mind.
> 
> Thanks,
> Dinh
> 
> [1] http://marc.info/?l=linux-serial&m=146254187602862&w=2
> 
> ---------------8<------------
> diff --git a/drivers/tty/serial/8250/8250_dma.c
> b/drivers/tty/serial/8250/8250_dma.c
> index 7f33d1c..847a203 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -176,7 +176,7 @@ int serial8250_request_dma(struct uart_8250_port *p)
>         ret = dma_get_slave_caps(dma->rxchan, &caps);
>         if (ret)
>                 goto release_rx;
> -       if (!caps.cmd_pause || !caps.cmd_terminate ||
> +       if ((!caps.cmd_pause || !caps.cmd_terminate) &&
>             caps.residue_granularity ==
> DMA_RESIDUE_GRANULARITY_DESCRIPTOR) {
>                 ret = -EINVAL;
>                 goto release_rx;
> 

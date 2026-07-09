Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEAD378833;
	Thu,  9 Jul 2026 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584431; cv=none; b=UKsncadLcOvVa7iGfgdcL/fgpccwf5+nBS5T25WF2gEucUeFq0DXsecCqi2hho5E0/8u4ZV0xqMt2k8Yk/5RMVDx8RzJC0IghYL2QAAZFFpGIsdAAUHUDq/q4fZs4jNcrpns2XcJNgaSl0ZZwuu7yiGYvlQe7NtXzjEjvtRU4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584431; c=relaxed/simple;
	bh=muDFtz9guPW/DzlAKMiWoLca0KgyS7mtGuYJtAibvqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rT39z1ZigWLSC7elOg5mqpiE9HnXl+5rNQw9nM9nQSQhO1HPVqHl1hI4bDtwSMvzY8VCjZz/LPNIlLv7X55FSAqyeAqsLi+qC/25xpC3sOynKeVWXgI2vABic8GSx90u4N86PqVTciCo+219CRjhgF7IU2VIALtFBHnVTjL/cfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIhY/YZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIhY/YZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A137B1F000E9;
	Thu,  9 Jul 2026 08:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783584430;
	bh=ei4LkbaQ+0ir0h2qdSE/3iuqnskkUzbdQTxsi/viklU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TIhY/YZEteDQJkxG83rsmWwFXxKY20FMPhMDClMEl0MpXaC5Hl6ah5945a2VNfVVg
	 avgZVt65z6VJFkpIoZ/w2R6+LKkxuOywbPy4Ywv0/t4Gt2wEXqU1t/nyyMqXR8vyr6
	 u7EbdeTLC9+iaktF84YE3PXjA7nLVirwbz/th+sXuadySfjSA2K9D9IrowN+T7UtOf
	 JgIEKZifaCOmk8w9Ozig32K8o2GI5/hFDIB9E1nSchNSB0Bbv0+Qq4+b/mxtlXz/zq
	 cBtdDhnuidCQbpawplccxqpfMymY5NMUBAHzYnspVy4f0vu13c8ooo8HUXLl7/wvla
	 pYiMKkZ/pTVaQ==
Message-ID: <009b213a-bc0a-41a0-8655-80cf262c2174@kernel.org>
Date: Thu, 9 Jul 2026 10:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] serial: 8250_mxpcie: defer uart_write_wakeup()
 to workqueue
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
 <20260709053314.435629-11-crescentcy.hsieh@moxa.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260709053314.435629-11-crescentcy.hsieh@moxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09. 07. 26, 7:33, Crescent Hsieh wrote:
> Avoid calling uart_write_wakeup() directly from the interrupt-driven TX
> path.
> 
> Defer the wakeup to a per-port work item and coalesce multiple TX events
> using a pending flag, so only one wakeup is scheduled while a previous
> one is still outstanding.

I am a bit worried of this added complexity. So what's the measured 
benefit of this actually?

What multiple TX events do you mean to coalesce? The work would run 
right after the ISR is completed, or what am I missing?

I am likely missing also the purpose of the MOXA_EVENT_TXLOW flag. The 
work won't be scheduled twice. And when it is scheduled once, the event 
is set, so no need to check it in the work. Or do you plan on more EVENTs?

> Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> ---
>   drivers/tty/serial/8250/8250_mxpcie.c | 34 +++++++++++++++++++++++----
>   1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
> index c7467fb94021..7b39ad19b331 100644
> --- a/drivers/tty/serial/8250/8250_mxpcie.c
> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
> @@ -15,6 +15,7 @@
>   #include <linux/pci.h>
>   #include <linux/tty_flip.h>
>   #include <linux/types.h>
> +#include <linux/workqueue.h>
>   
>   #include <linux/8250_pci.h>
>   #include <linux/serial_8250.h>
> @@ -104,7 +105,12 @@
>   #define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
>   #define MOXA_ODD_RS_MASK	GENMASK(7, 4)
>   
> +#define MOXA_EVENT_TXLOW	BIT(0)
> +
>   struct mxpcie8250_port {
> +	struct uart_port *port;
> +	struct work_struct work;
> +	unsigned long event_flags;
>   	int line;
>   };
>   
> @@ -328,6 +334,8 @@ static void mxpcie8250_tx_chars(struct uart_8250_port *up)
>   {
>   	struct uart_port *port = &up->port;
>   	struct tty_port *tport = &port->state->port;
> +	struct device *dev = port->dev;
> +	struct mxpcie8250 *priv = dev_get_drvdata(dev);
>   	unsigned int count, txsize;
>   	unsigned char c;
>   
> @@ -348,9 +356,10 @@ static void mxpcie8250_tx_chars(struct uart_8250_port *up)
>   
>   		serial_out(up, MOXA_PUART_TX_FIFO_MEM + i, c);
>   	}
> -	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> -		uart_write_wakeup(port);
> -
> +	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS) {
> +		if (!test_and_set_bit(MOXA_EVENT_TXLOW, &priv->port[port->port_id].event_flags))
> +			schedule_work(&priv->port[port->port_id].work);
> +	}
>   	if (kfifo_is_empty(&tport->xmit_fifo) && !(up->capabilities & UART_CAP_RPM))
>   		port->ops->stop_tx(port);
>   }
> @@ -377,6 +386,14 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
>   	return 1;
>   }
>   
> +static void mxpcie8250_work_handler(struct work_struct *work)
> +{
> +	struct mxpcie8250_port *priv_port = container_of(work, struct mxpcie8250_port, work);
> +
> +	if (test_and_clear_bit(MOXA_EVENT_TXLOW, &priv_port->event_flags))
> +		uart_write_wakeup(priv_port->port);
> +}
> +
>   static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
>   {
>   	void __iomem *bar2_base = priv->bar2_base;
> @@ -432,7 +449,7 @@ static void mxpcie8250_setup_port(struct pci_dev *pdev,
>   static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct uart_8250_port up = {};
> +	struct uart_8250_port up = {}, *new_port;
>   	struct mxpcie8250 *priv;
>   	unsigned short device = pdev->device;
>   	unsigned int num_ports;
> @@ -492,6 +509,11 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
>   				up.port.iotype, priv->port[i].line);
>   			break;
>   		}
> +		new_port = serial8250_get_port(priv->port[i].line);
> +
> +		priv->port[i].port = &new_port->port;
> +
> +		INIT_WORK(&priv->port[i].work, mxpcie8250_work_handler);
>   	}
>   	pci_set_drvdata(pdev, priv);
>   
> @@ -502,8 +524,10 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
>   {
>   	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
>   
> -	for (unsigned int i = 0; i < priv->num_ports; i++)
> +	for (unsigned int i = 0; i < priv->num_ports; i++) {
> +		cancel_work_sync(&priv->port[i].work);
>   		serial8250_unregister_port(priv->port[i].line);
> +	}
>   }
>   
>   static const struct pci_device_id mxpcie8250_pci_ids[] = {


-- 
js
suse labs

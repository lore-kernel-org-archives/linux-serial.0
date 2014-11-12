From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH/RFC 4/8] serial: pxa: Add fifo-size and {big,native}-endian
 properties
Date: Wed, 12 Nov 2014 10:03:58 +0100
Message-ID: <5463227E.9050304@suse.cz>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-5-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:59891 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbaKLJEE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 04:04:04 -0500
In-Reply-To: <1415781993-7755-5-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org, robh@kernel.org
Cc: tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On 11/12/2014, 09:46 AM, Kevin Cernekee wrote:
> With a few tweaks, the PXA serial driver can handle other 16550A clones.
> Add a fifo-size DT property to override the FIFO depth (BCM7xxx uses 32),
> and {native,big}-endian properties similar to regmap to support SoCs that
> have BE or "automagic endian" registers.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/tty/serial/pxa.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 21b7d8b..78ed7ee 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -60,13 +60,19 @@ struct uart_pxa_port {
>  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
>  {
>  	offset <<= 2;
> -	return readl(up->port.membase + offset);
> +	if (!up->port.big_endian)
> +		return readl(up->port.membase + offset);
> +	else
> +		return ioread32be(up->port.membase + offset);

This needn't fly IMO, unless you map the space using iomap (not ioremap).

-- 
js
suse labs

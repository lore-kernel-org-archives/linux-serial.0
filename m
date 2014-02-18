From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] serial: 8250_pci: unbreak last serial ports on NetMos
 9865 cards
Date: Tue, 18 Feb 2014 15:00:36 +0400
Message-ID: <CALT56yPj=0BTHxQ_2w+we8q4ETHjqX_VOUcbuYZBS5cU8GSooQ@mail.gmail.com>
References: <1392113893-8269-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:40377 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbaBRLAh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Feb 2014 06:00:37 -0500
In-Reply-To: <1392113893-8269-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hello,

On Tue, Feb 11, 2014 at 2:18 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Aparently 9865 uses standard BAR encoding scheme (unlike 99xx cards).
> Current pci_netmos_9900_setup() uses wrong BAR indices for the 9865 PCI
> device, function 2. Using standard BAR indices makes all 6 ports work
> for me. Thus disable the NetMos 9900 quirk for NetMos 9865 pci device.

Do you need any additional details for the patch?

[skipped lspci]

>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 4697a51..143a381 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -784,7 +784,8 @@ static int pci_netmos_9900_setup(struct serial_private *priv,
>  {
>         unsigned int bar;
>
> -       if ((priv->dev->subsystem_device & 0xff00) == 0x3000) {
> +       if ((priv->dev->device != PCI_DEVICE_ID_NETMOS_9865) &&
> +           (priv->dev->subsystem_device & 0xff00) == 0x3000) {
>                 /* netmos apparently orders BARs by datasheet layout, so serial
>                  * ports get BARs 0 and 3 (or 1 and 4 for memmapped)
>                  */
> --
> 1.8.5.2
>



-- 
With best wishes
Dmitry

From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH 1/2] Fix incorrect device ID for the Commtech 422/2-PCIe.
Date: Mon, 14 Jan 2013 09:25:33 -0600
Message-ID: <CAJp1Oe6TQTQoCdkivFDm0WpVsbRBhuLyij57pr33LMyG0QbQAw@mail.gmail.com>
References: <1357593435-3566-1-git-send-email-matts@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:42239 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297Ab3ANPbj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jan 2013 10:31:39 -0500
Received: by mail-vc0-f179.google.com with SMTP id p1so3584467vcq.38
        for <linux-serial@vger.kernel.org>; Mon, 14 Jan 2013 07:31:39 -0800 (PST)
In-Reply-To: <1357593435-3566-1-git-send-email-matts@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Matt Schulte <matts@commtech-fastcom.com>

Is there anything I need to do to get these commits accepted?

Thanks
Matt Schulte
Commtech, Inc.
Voice: 316-636-1131
Fax: 316-636-1163
http://www.commtech-fastcom.com


On Mon, Jan 7, 2013 at 3:17 PM, Matt Schulte <matts@commtech-fastcom.com> wrote:
>
> Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 26b9dc0..18f1d79 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1301,9 +1301,9 @@ pci_wch_ch353_setup(struct serial_private *priv,
>  #define PCI_VENDOR_ID_AGESTAR          0x5372
>  #define PCI_DEVICE_ID_AGESTAR_9375     0x6872
>  #define PCI_VENDOR_ID_ASIX             0x9710
> -#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0019
>  #define PCI_DEVICE_ID_COMMTECH_4224PCIE        0x0020
>  #define PCI_DEVICE_ID_COMMTECH_4228PCIE        0x0021
> +#define PCI_DEVICE_ID_COMMTECH_4222PCIE 0x0022
>
>
>  /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
> --
> 1.7.2.5
>

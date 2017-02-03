From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v13 1/2] serial: exar: split out the exar code from
 8250_pci
Date: Fri, 3 Feb 2017 15:02:15 +0100
Message-ID: <d77cf226-a1bc-0f55-9f2b-af6a97f2f74b@siemens.com>
References: <1485815302-5708-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485815302-5708-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2017-01-30 23:28, Sudip Mukherjee wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> 
> Add the serial driver for the Exar chips. And also register the
> platform device for the GPIO provided by the Exar chips.

"Also" means you are doing two things in one patch - was this already
discussed and accepted in previous review rounds? If so, ignore my
comment, but I would have asked for two patches, one that just
translates the existing code and another that adds this new feature.

> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
> 
> Andy,
> I have added the if (!board) check, but I am not sure how board can be
> NULL here. If probe executes that will mean there was a match of the
> device id and so in that case board can not be NULL.
> 
>  drivers/tty/serial/8250/8250_exar.c | 396 ++++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig     |   4 +
>  drivers/tty/serial/8250/Makefile    |   1 +
>  3 files changed, 401 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_exar.c
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> new file mode 100644
> index 0000000..ba1f359
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -0,0 +1,396 @@
> +/*
> + *  Probe module for 8250/16550-type Exar chips PCI serial ports.
> + *
> + *  Based on drivers/tty/serial/8250/8250_pci.c,
> + *
> + *  Copyright (C) 2017 Sudip Mukherjee, All Rights Reserved.

It's legally cleaner to carry over the copyright notice from the
original file, unless you rewrote everything (unlikely on first glance).
You may still add yours to the list for the significant contributions.

BTW, are you personally the copyright holder or your employer Codethink?
Depends on your contractual situation, but the former is less common.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

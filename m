From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1] tty: serial: 8250: 8250_gsc:- Handle return NULL error
 from ioremap_nocache
Date: Thu, 19 Jan 2017 20:48:07 +0200
Message-ID: <CAHp75VfNwkBK2E1bJxCP+-3iv4+GBztVi=Mum1LYe=VunqpxMA@mail.gmail.com>
References: <1484812844-10598-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1484812844-10598-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jejb@parisc-linux.org, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-parisc@vger.kernel.org, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 19, 2017 at 10:00 AM, Arvind Yadav
<arvind.yadav.cs@gmail.com> wrote:
> Here, If ioremap_nocache will fail. It will return NULL.
> Kernel can run into a NULL-pointer dereference.
> This error check will avoid NULL pointer dereference.

>         uart.port.mapbase       = address;
>         uart.port.membase       = ioremap_nocache(address, 16);
> +       if (!uart.port.membase) {
> +               dev_warn(&dev->dev, "Failed to map memory\n");
> +               return -ENOMEM;
> +       }

You also may do something like

void __iomem *base;
...

base = ioremap_nocache(...);
if (!base)
 return -ENOMEM;
// I doubt the message is useful, up to you

memset(&uart, 0, sizeof(uart));
...
uart.port.membase       = base;

-- 
With Best Regards,
Andy Shevchenko

From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 07/10] gpio-exar/8250-exar: Rearrange gpiochip parenthood
Date: Mon, 29 May 2017 14:34:02 +0200
Message-ID: <CACRpkdbrFgPe2DcjJdG=_cxc4UZOTsCsJfQcYf9tLQCeG=w=yw@mail.gmail.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com> <375d76dc3fe344f5168e8155211422de59f0efa0.1495814557.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <375d76dc3fe344f5168e8155211422de59f0efa0.1495814557.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 26, 2017 at 6:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> Set the parent of the exar gpiochip to its platform device, like other
> gpiochips are doing it. In order to keep the relationship discoverable
> for ACPI systems, set the platform device companion to the PCI device.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

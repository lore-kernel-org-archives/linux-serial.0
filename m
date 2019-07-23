From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] uio: remove netx driver
Date: Tue, 23 Jul 2019 10:14:16 +0200
Message-ID: <CAK8P3a2juz8UEc9b87JdhxYtvog89ap3REhpC8tMkyLzWo-nqw@mail.gmail.com>
References: <20190722191552.252805-1-arnd@arndb.de> <20190722191552.252805-3-arnd@arndb.de>
 <415f511480774ca58e068d6c005c917b@hilscher.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <415f511480774ca58e068d6c005c917b@hilscher.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Trensch <MTrensch@hilscher.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "davem@davemloft.net" <davem@davemloft.net>, Sascha Hauer <s.hauer@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Robert Schwebel <r.schwebel@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 23, 2019 at 7:45 AM Michael Trensch <MTrensch@hilscher.com> wrote:
>
> The "uio_netx" driver is not used in conjunction with the removed netX SoC support.
> It is used to handle netX-Based PCI(e) cards (https://www.hilscher.com/products/product-groups/pc-cards/) plugged into a PC or any kind of embedded hardware.
>
> So a removal of this driver would render those extension cards unusable in future.

Ok, thanks for the quick reply, let's pretend I never sent that patch then.

      Arnd

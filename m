From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] serial: remove netx serial driver
Date: Tue, 23 Jul 2019 10:26:15 +0200
Message-ID: <CACRpkdbm5MpcNdm8EGTR=U8MpK2VPzEg=Us0-AxZzOZ=vVJSmQ@mail.gmail.com>
References: <20190722191552.252805-1-arnd@arndb.de> <20190722191552.252805-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722191552.252805-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Sascha Hauer <s.hauer@pengutronix.de>, Michael Trensch <MTrensch@hilscher.com>, Robert Schwebel <r.schwebel@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 22, 2019 at 9:16 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The netx platform got removed, so this driver is now
> useless.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

We seem so overlap :)
https://marc.info/?l=linux-serial&m=156377843325488&w=2

Anyways, the patches are identical except here:

> -/* Hilscher netx */
> +/* Hilscher netx (removed) */
>  #define PORT_NETX      71

Is there some reason for keeping the magical number around?
When I looked over the file there seemed to be more "holes"
in the list.

Yours,
Linus Walleij

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] serial: remove netx serial driver
Date: Tue, 23 Jul 2019 10:43:05 +0200
Message-ID: <CAK8P3a1=Bnsxg-3RztGEL-c6muQjam-egyrsZfqc7_yjBzcGXA@mail.gmail.com>
References: <20190722191552.252805-1-arnd@arndb.de> <20190722191552.252805-2-arnd@arndb.de>
 <CACRpkdbm5MpcNdm8EGTR=U8MpK2VPzEg=Us0-AxZzOZ=vVJSmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbm5MpcNdm8EGTR=U8MpK2VPzEg=Us0-AxZzOZ=vVJSmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Sascha Hauer <s.hauer@pengutronix.de>, Michael Trensch <MTrensch@hilscher.com>, Robert Schwebel <r.schwebel@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 23, 2019 at 10:26 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jul 22, 2019 at 9:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > The netx platform got removed, so this driver is now
> > useless.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> We seem so overlap :)
> https://marc.info/?l=linux-serial&m=156377843325488&w=2
>
> Anyways, the patches are identical except here:
>
> > -/* Hilscher netx */
> > +/* Hilscher netx (removed) */
> >  #define PORT_NETX      71
>
> Is there some reason for keeping the magical number around?
> When I looked over the file there seemed to be more "holes"
> in the list.

I looked at the same list and though I saw more obsolete entries
than holes. The last ones that I saw getting removed were
PORT_MFD in 2017 and PORT_V850E_UART in 2008.

It probably doesn't matter as we have precedence for both.

       Arnd

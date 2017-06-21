From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: disable DMA for RS-485 on i.MX6 SMP
Date: Wed, 21 Jun 2017 11:12:23 -0300
Message-ID: <CAOMZO5DXxaJ6PveJb9912rog8xvfqgsg3O3u3a-ffWUj9ZnpCg@mail.gmail.com>
References: <20170620153701.12626-1-clemens.gruber@pqgruber.com>
 <CAOMZO5Djf8OsqF=jUBo1Dkm2mw7pObxmkC=qq0U0RLZsYonXgQ@mail.gmail.com> <20170621140556.GA766@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170621140556.GA766@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Fugang Duan <fugang.duan@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hi Clemens,

On Wed, Jun 21, 2017 at 11:05 AM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> I'd also prefer fixing the underlying problem.

Yes, that would be much better.

> If you take a look at the DMA parts in drivers/tty/serial/imx.c, can you
> spot anything SMP-unsafe?

Not really.

> By the way, can you get your hands on an i.MX6Q board with RS-485 to
> reproduce it?

Unfortunately I don't have such hardware. Even the mx6solo board that
I used to have access in the past I do not have it anymore.

> We could try for a few more weeks to find the bug and if we don't find
> it, adding this rs485-enabled-at-boot-time property sounds good!

Sounds like a good plan, thanks.

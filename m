From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 5/6] serial: 8250/mediatek: fix building with SERIAL_8250=m
Date: Thu, 11 Feb 2016 17:31:56 +0100
Message-ID: <4817391.g2eX6rsJJ6@wuerfel>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de> <1455205297-1021302-6-git-send-email-arnd@arndb.de> <20160211160438.GH28452@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160211160438.GH28452@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thursday 11 February 2016 11:04:38 you wrote:
> > diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> > index 6ecc6e3e82dc..55be90c1d85e 100644
> > --- a/drivers/tty/serial/8250/8250_mtk.c
> > +++ b/drivers/tty/serial/8250/8250_mtk.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/module.h>
> 
> Something isn't right here ; I can see module.h three lines up in the
> context.  Guessing your addition of the revert makes this addition no
> longer required...
> 

Ok, thanks for noticing this. Also, I really should know my alphabet
at this point. I saw that the headers were sorted alphabetically and
thought I had added it in the right place, which would have worked fine
after the revert. Oh well.

	Arnd

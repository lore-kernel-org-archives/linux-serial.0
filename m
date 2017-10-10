From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] serial: sh-sci: Remove __init attribute from static
 struct 'port_cfg'
Date: Mon, 9 Oct 2017 17:35:59 -0700
Message-ID: <20171010003559.GS173745@google.com>
References: <20171010000411.140016-1-mka@chromium.org>
 <CABXOdTdEH-=n8nf6a=0sC1iBeXLDKSxTXxoj1wUYmLUX_U=BUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABXOdTdEH-=n8nf6a=0sC1iBeXLDKSxTXxoj1wUYmLUX_U=BUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <groeck@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <groeck@chromium.org>
List-Id: linux-serial@vger.kernel.org

El Mon, Oct 09, 2017 at 05:18:32PM -0700 Guenter Roeck ha dit:

> On Mon, Oct 9, 2017 at 5:04 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > This fixes the following error when building with clang:
> >
> > drivers/tty/serial/sh-sci.c:3247:15: error: '__section__' attribute only
> >   applies to functions, methods, properties, and global variables
> >     static struct __init plat_sci_port port_cfg;
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/tty/serial/sh-sci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index 784dd42002ea..0d1df1df9e89 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -3244,7 +3244,7 @@ early_platform_init_buffer("earlyprintk", &sci_driver,
> >                            early_serial_buf, ARRAY_SIZE(early_serial_buf));
> >  #endif
> >  #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
> > -static struct __init plat_sci_port port_cfg;
> > +static struct plat_sci_port port_cfg;
> 
> __initdata ?

Good point, thanks!

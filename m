From: "Maarten Brock" <m.brock@vanmierlo.com>
Subject: Re: [PATCH] serial-uartlite: un-constify uartlite_be/uartlite_le
Date: Thu, 10 Mar 2016 10:08:01 +0100
Message-ID: <20160310100801.37d49aba@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Korsgaard <jacmet@sunsite.dk>, Jiri Slaby <jslaby@suse.com>, Rich Felker <dalias@libc.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

I've created a version 2 of this patch immediately which fixes the warning,
but somehow this stays ignored.

Please apply my second patch!
Maarten

> The patch to make uartlite_be/uartlite_le const was well-intended but
> caused a new build warning:
> 
> tty/serial/uartlite.c: In function 'ulite_request_port':
> tty/serial/uartlite.c:348:21: error: assignment discards 'const' qualifier
> from pointer target type [-Werror=discarded-qualifiers]
> tty/serial/uartlite.c:354:22: error: assignment discards 'const' qualifier
> from pointer target type [-Werror=discarded-qualifiers]
> 
> It would be nice to allow passing const pointers through
> port->private_data, but that would be way more work, so this
> reverts part of the original commit for now.
> 
> A possible alternative might be to pass a structure in the private_data
> that contains a const pointer to the operations, which introduces a little
> extra overhead, or we could just add a cast to a non-const pointer, I'll
> leave that to the maintainer.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 2905697a82ea ("serial-uartlite: Constify uartlite_be/uartlite_le")
> ---
>  drivers/tty/serial/uartlite.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index c9fdfc8bf47f..1474c5755140 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -72,7 +72,7 @@ static void uartlite_outbe32(u32 val, void __iomem *addr)
>  	iowrite32be(val, addr);
>  }
>  
> -static const struct uartlite_reg_ops uartlite_be = {
> +static struct uartlite_reg_ops uartlite_be = {
>  	.in = uartlite_inbe32,
>  	.out = uartlite_outbe32,
>  };
> @@ -87,7 +87,7 @@ static void uartlite_outle32(u32 val, void __iomem *addr)
>  	iowrite32(val, addr);
>  }
>  
> -static const struct uartlite_reg_ops uartlite_le = {
> +static struct uartlite_reg_ops uartlite_le = {
>  	.in = uartlite_inle32,
>  	.out = uartlite_outle32,
>  };
> -- 
> 2.7.0
> 
> 

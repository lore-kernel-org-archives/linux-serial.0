From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/4] serial: 8250_mtk: drop !defined(MODULE) conditional
Date: Mon, 6 Jun 2016 12:27:50 +0200
Message-ID: <57555026.8030400@gmail.com>
References: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
 <1465206063-1018-4-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465206063-1018-4-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-serial@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Paul Burton <paul.burton@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On 06/06/16 11:41, Masahiro Yamada wrote:
> The !defined(MODULE) conditional has been added to the
> OF_EARLYCON_DECLARE() define.
>
> This commit partially reverts commit 3f5921a60f74 ("serial:
> 8250/mediatek: fix building with SERIAL_8250=m").
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

>
>   drivers/tty/serial/8250/8250_mtk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 3489fbc..3611ec9 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -301,7 +301,7 @@ static struct platform_driver mtk8250_platform_driver = {
>   };
>   module_platform_driver(mtk8250_platform_driver);
>
> -#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
>   static int __init early_mtk8250_setup(struct earlycon_device *device,
>   					const char *options)
>   {
>

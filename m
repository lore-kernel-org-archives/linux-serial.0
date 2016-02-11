From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 5/6] serial: 8250/mediatek: fix building with
 SERIAL_8250=m
Date: Fri, 12 Feb 2016 00:14:14 +0100
Message-ID: <56BD15C6.6040006@gmail.com>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
 <1455205297-1021302-6-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455205297-1021302-6-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <s.hauer@pengutronix.de>, Eddie Huang <eddie.huang@mediatek.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mediatek@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On 11/02/16 16:41, Arnd Bergmann wrote:
> The Mediatek 8250 driver has a 'bool' Kconfig symbol, but that
> breaks when SERIAL_8250 is a loadable module:
>
> drivers/tty/built-in.o: In function `mtk8250_set_termios':
> :(.text+0x1bee8): undefined reference to `serial8250_do_set_termios'
> :(.text+0x1bf10): undefined reference to `uart_get_baud_rate'
> :(.text+0x1c09c): undefined reference to `uart_get_divisor'
> drivers/tty/built-in.o: In function `mtk8250_do_pm':
> :(.text+0x1c0d0): undefined reference to `serial8250_do_pm'
> drivers/tty/built-in.o: In function `mtk8250_probe':
> :(.text+0x1c2e4): undefined reference to `serial8250_register_8250_port'
> serial/8250/8250_mtk.c:287:242: error: data definition has no type or storage class [-Werror]
> serial/8250/8250_mtk.c:287:122: error: 'mtk8250_platform_driver_init' defined but not used [-Werror=unused-function]
>
> This changes the symbol to a 'tristate', so the dependency on
> SERIAL_8250 also works when that is set to 'm'.
> To actually build the driver, we also need to include <linux/module.h>.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

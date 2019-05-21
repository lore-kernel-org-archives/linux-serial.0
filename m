From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tracing: fix typos in code and comments
Date: Tue, 21 May 2019 16:54:32 +0200
Message-ID: <20190521145432.GB3491@kroah.com>
References: <20190521144740.22490-1-houweitao@xiaomi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190521144740.22490-1-houweitao@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: houweitao <houweitaoo@gmail.com>
Cc: linus.walleij@linaro.org, yamada.masahiro@socionext.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, baohua@kernel.org, jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net, rostedt@goodmis.org, mingo@redhat.com, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, houweitao <houweitao@xiaomi.com>
List-Id: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 10:47:40PM +0800, houweitao wrote:
> fix ingore to ignore in kernel; since there are other
> mistakes can be found with "git grep ",fix all
> 
> Signed-off-by: houweitao <houweitao@xiaomi.com>
> ---
>  drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 2 +-
>  drivers/rtc/rtc-sirfsoc.c                        | 2 +-
>  drivers/tty/serial/mxs-auart.c                   | 2 +-
>  drivers/tty/serial/serial_txx9.c                 | 2 +-
>  drivers/tty/serial/sunsab.c                      | 2 +-
>  kernel/trace/trace.c                             | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

You have to split this up into patches for different subsystems, and use
your real name.

thanks,

greg k-h

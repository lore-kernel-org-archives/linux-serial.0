From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 05/11] of: earlycon: Initialize port fields from DT properties
Date: Tue, 12 Jan 2016 17:49:32 -0600
Message-ID: <CAL_JsqJiKfT5nu6vatU4U3kv7dfs5vx8QEW6mS0=Qj4iX4CE8w@mail.gmail.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
 <1452627672-9482-1-git-send-email-peter@hurleysoftware.com> <1452627672-9482-6-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452627672-9482-6-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grant Likely <grant.likely@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Sebastian Frias <sf84@laposte.net>, Paul Burton <paul.burton@imgtec.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 12, 2016 at 1:41 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Read the optional "reg-offset", "reg-shift", "reg-io-width" and endianness
> properties and initialize the respective struct uart_port field if found.
>
> NB: These bindings are common to several drivers and the values merely
> indicate the default value; the registering earlycon setup() method can
> simply override the values if required.
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---

> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 7509ee34d..03eac4a 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -20,6 +20,10 @@
>  #include <linux/serial_core.h>
>  #include <linux/sizes.h>
>
> +#ifdef CONFIG_OF_EARLY_FLATTREE
> +#include <linux/of_fdt.h>
> +#endif

I think you don't need the ifdef around this.

> +
>  #ifdef CONFIG_FIX_EARLYCON_MEM
>  #include <asm/fixmap.h>
>  #endif

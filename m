From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC v2 1/6] mux: include compiler.h from mux/consumer.h
Date: Mon, 31 Jul 2017 11:02:07 +0200
Message-ID: <1a1233da-2f39-7777-1149-7a0f32a4b1d5@axentia.se>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1500305076-15570-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1500305076-15570-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, robh@kernel.org, geert@linux-m68k.org, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

This patch looks good to me. Let me know if I should feed this
through the mux subsystem or if it will take some other route.

In case someone else ends up taking it:
Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

On 2017-07-17 17:24, Ulrich Hecht wrote:
> Required for __must_check.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  include/linux/mux/consumer.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
> index 5577e1b..ea96d4c 100644
> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h
> @@ -13,6 +13,8 @@
>  #ifndef _LINUX_MUX_CONSUMER_H
>  #define _LINUX_MUX_CONSUMER_H
>  
> +#include <linux/compiler.h>
> +
>  struct device;
>  struct mux_control;
>  
> 

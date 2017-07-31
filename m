From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC v2 1/6] mux: include compiler.h from mux/consumer.h
Date: Mon, 31 Jul 2017 14:22:04 +0300
Message-ID: <3087511.3ZL0pLHBmR@avalon>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1500305076-15570-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1500305076-15570-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Monday 17 Jul 2017 17:24:31 Ulrich Hecht wrote:
> Required for __must_check.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

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

-- 
Regards,

Laurent Pinchart

From: Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 00/20] Update STM32 usart driver
Date: Thu, 29 Jun 2017 17:09:21 +0200
Message-ID: <3eaff22e-4a7b-d491-4d84-aeccbd444d0d@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon-qxv4g6HH51o@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Greg, Rob

On 06/26/2017 02:49 PM, Bich HEMON wrote:
> From: Bich Hemon <bich.hemon-qxv4g6HH51o@public.gmane.org>
> 
> This patchset updates the stm32 usart driver. It mainly adds
> support for fifo, dma, debugfs anf fixes various bugs.
> 
> Bich Hemon (20):
>    serial: stm32: adding fifo support
>    dt-bindings: serial: each stm32 usart needs an alias
>    serial: stm32: fix multi ports management
>    serial: stm32: make fifoen as property for each port
>    serial: stm32: add debugfs
>    serial: stm32: fix pio transmit timeout
>    serial: stm32: less messages on dma alloc error
>    serial: stm32: timeout interrupt using with dma
>    serial: stm32: fix end of transfer
>    serial: stm32: fix dma receive
>    serial: stm32: add RTS support
>    serial: stm32: fix last_res value
>    serial: stm32: fix error handling in probe
>    dt-bindings: serial: document option wake-up interrupt for STM32 USART
>    serial: stm32: Add wakeup mechanism
>    serial: stm32: fix fifo usage
>    dt-bindings: serial: stm32: add dma using note
>    serial: stm32: update dma buffers length
>    serial: stm32: add dma rx callback
>    serial: stm32: fix rx interrupt handling in startup
> 
>   .../devicetree/bindings/serial/st,stm32-usart.txt  |  55 +++-
>   drivers/tty/serial/stm32-usart.c                   | 310 ++++++++++++++++++---
>   drivers/tty/serial/stm32-usart.h                   |  51 +++-
>   3 files changed, 375 insertions(+), 41 deletions(-)
> 

This series have been abandoned (maybe not in correct way). Don't waste 
your time with that. New patches will be sent in several series and 
patches will be reworked.

Thanks
Alex


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

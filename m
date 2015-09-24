From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/7] tty: serial: msm: Add DMA support and fix bit definitions
Date: Fri, 25 Sep 2015 00:27:19 +0100
Message-ID: <560486D7.3090003@linaro.org>
References: <1442062934-13449-1-git-send-email-ivan.ivanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442062934-13449-1-git-send-email-ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ivan T. Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Frank Rowand <frank.rowand-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


Hi Ivan,
On 12/09/15 14:02, Ivan T. Ivanov wrote:
> Hi,
>
> Following patches add DMA support for UARTDM type of hardware.
>
> Changes have been tested on UARTDM v1.3(APQ8064) and v1.4(APQ8016).
>
> Patches from Gurav were published long ago here[1], I just addressed
> remaining comments and coding style issues.
>
> Any comments are welcome.
Looks like Magic Sysrq is broken with this patches.

--srini
>
> Regards,
> Ivan
>
> Ivan T. Ivanov (5):
>    tty: serial: msm: Fix command Stale Event Enable definition
>    tty: serial: msm: Add msm prefix to all driver functions
>    tty: serial: msm: Add TX DMA support
>    tty: serial: msm: Add RX DMA support
>    tty: serial: msm: Remove 115.2 Kbps maximum baud rate limitation
>
> Pramod Gurav (2):
>    tty: serial: msm: Add mask value for UART_DM registers
>    tty: serial: msm: replaces (1 << x) with BIT(x) macro
>
> [1] http://www.spinics.net/lists/linux-serial/msg16874.html
>
>
>   .../devicetree/bindings/serial/qcom,msm-uartdm.txt |   6 +
>   drivers/tty/serial/msm_serial.c                    | 616 +++++++++++++++++++--
>   drivers/tty/serial/msm_serial.h                    |  55 +-
>   3 files changed, 604 insertions(+), 73 deletions(-)
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 3/3] tty: serial: msm: replaces (1 << x) with BIT(x) macro
Date: Fri, 10 Apr 2015 09:33:16 -0300
Message-ID: <CAOMZO5Css1at4beoJZzwcSnWMPNhUMEc8Qtn=usQQfYVdzvvug@mail.gmail.com>
References: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org>
	<1428668396-6955-3-git-send-email-gpramod@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1428668396-6955-3-git-send-email-gpramod@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <gpramod@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, bryanh@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 10, 2015 at 9:19 AM, Pramod Gurav <gpramod@codeaurora.org> wrote:

> -#define UART_TF                0x000C
> -#define UARTDM_TF      0x0070
> +#define UART_TF                                0x000C
> +#define UARTDM_TF                      0x0070

This is a different change, so it should be part of a different patch.

> -#define UART_IPR       0x0018
> -#define UART_TFWR      0x001C
> -#define UART_RFWR      0x0020
> -#define UART_HCR       0x0024
> +#define UART_IPR               0x0018
> +#define UART_TFWR              0x001C
> +#define UART_RFWR              0x0020
> +#define UART_HCR               0x0024

Same here.

Regards,

Fabio Estevam

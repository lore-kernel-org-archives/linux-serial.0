From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] serial/8250: delete WR SBC850 UART quirk handling
Date: Wed, 27 Jun 2012 12:52:42 +0100
Message-ID: <20120627125242.08a3114e@pyramind.ukuu.org.uk>
References: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
	<1340740469-31445-4-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46181 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756292Ab2F0LtK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Jun 2012 07:49:10 -0400
In-Reply-To: <1340740469-31445-4-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Tue, 26 Jun 2012 15:54:29 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> We've are dropping the support for the EOL SBC8560, so we can
> also delete this variant of the Alpha quirk support.
> 
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/tty/serial/8250/8250.h |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index f9719d1..ffd1e6e 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -119,13 +119,6 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
>   * is cleared, the machine locks up with endless interrupts.
>   */
>  #define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1)
> -#elif defined(CONFIG_SBC8560)
> -/*
> - * WindRiver did something similarly broken on their SBC8560 board. The
> - * UART tristates its IRQ output while OUT2 is clear, but they pulled
> - * the interrupt line _up_ instead of down, so if we register the IRQ
> - * while the UART is in that state, we die in an IRQ storm. */
> -#define ALPHA_KLUDGE_MCR (UART_MCR_OUT2)
>  #else
>  #define ALPHA_KLUDGE_MCR 0
>  #endif

Would you mind removing all of the crap from this if its going (eg
8250.c) not just the header so it gets missed ? Kill the symbol entirely ?

Alan

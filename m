From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Fix get_mctrl behaviour
Date: Mon, 9 Mar 2015 11:40:11 -0700
Message-ID: <CAE_wzQ-43+oGAmyJ_cgso1XfnCYFGVczPvePG++x=povcAPOdA@mail.gmail.com>
References: <jonathar@broadcom.com>
	<1424997357-31487-1-git-send-email-jonathar@broadcom.com>
	<1424997357-31487-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424997357-31487-2-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Anatol Pomazau <anatol@google.com>, Scott Branden <sbranden@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Desmond Liu <desmondl@broadcom.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 26, 2015 at 4:35 PM, Jonathan Richardson
<jonathar@broadcom.com> wrote:
> @@ -334,6 +342,30 @@ static int dw8250_probe_of(struct uart_port *p,
>         if (id >= 0)
>                 p->line = id;
>
> +       if (of_property_read_bool(np, "dcd-override")) {
> +               /* Always report DCD as active */
> +               data->msr_mask_on |= UART_MSR_DCD;
> +               data->msr_mask_off |= UART_MSR_DDCD;
> +       }
> +
> +       if (of_property_read_bool(np, "dsr-override")) {
> +               /* Always report DSR as active */
> +               data->msr_mask_on |= UART_MSR_DSR;
> +               data->msr_mask_off |= UART_MSR_DDSR;
> +       }
> +
> +       if (of_property_read_bool(np, "cts-override")) {
> +               /* Always report DSR as active */
> +               data->msr_mask_on |= UART_MSR_DSR;
> +               data->msr_mask_off |= UART_MSR_DDSR;
> +       }
> +
> +       if (of_property_read_bool(np, "ri-override")) {
> +               /* Always report Ring indicator as inactive */
> +               data->msr_mask_off |= UART_MSR_RI;
> +               data->msr_mask_off |= UART_MSR_TERI;

This looks like a typo. Should the 1st line be data->msr_mask_on by any chance?

Thanks,
Dmitry

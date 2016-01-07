From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] tty: amba-pl011: use iotype instead of access_32b to
 track 32-bit I/O
Date: Thu, 7 Jan 2016 09:09:00 +0100
Message-ID: <CAMuHMdX5cPFU45bvnUkxhPf3qvw6fsoL_UBzt_qb_aHkMCtqVw@mail.gmail.com>
References: <1451943462-27818-1-git-send-email-timur@codeaurora.org>
	<1451943462-27818-2-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1451943462-27818-2-git-send-email-timur@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.com>, jun.nie@linaro.org, shijie.huang@arm.com, Peter Hurley <peter@hurleysoftware.com>, andrew.jackson@arm.com, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 4, 2016 at 10:37 PM, Timur Tabi <timur@codeaurora.org> wrote:
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -995,10 +995,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>                         unspecified, the h/w is not initialized.
>
>                 pl011,<addr>
> +               pl011,mmio32,<addr>
>                         Start an early, polled-mode console on a pl011 serial
>                         port at the specified address. The pl011 serial port
>                         must already be setup and configured. Options are not
> -                       yet supported.
> +                       yet supported.  If 'mmio32' is specified, then only

Bogus "only"

> +                       the driver will use only 32-bit accessors to read/write
> +                       the device registers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

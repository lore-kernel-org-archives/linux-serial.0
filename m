From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial/core: Initialize the console pm state
Date: Fri, 3 Oct 2014 14:22:47 +0200
Message-ID: <CAMuHMdWwEoK__-qTdUmzx6vJJSQ1+XdvL3nZukUX_RjM1tDVGA@mail.gmail.com>
References: <1411367422-2095-1-git-send-email-ssreedharan@mvista.com>
	<CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Sudhir Sreedharan <ssreedharan@mvista.com>, linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, lkml <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 1, 2014 at 7:27 PM, Kevin Hilman <khilman@kernel.org> wrote:
> On Sun, Sep 21, 2014 at 11:30 PM, Sudhir Sreedharan
> <ssreedharan@mvista.com> wrote:
>> For console devices having UART_CAP_SLEEP capability, the uart_pm_state has
>> to be initialized to UART_PM_STATE_ON. Otherwise the LCR regiser values
>> are reinitialized when uart_change_pm is called from uart_configure_port.
>>
>> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
>
> Multiple boot failures on ARM[1] were bisected down to this patch.
>
> How was this patch tested, and on which platforms?
>
> Also, the changelog states that this should be done only for
> UART_CAP_SLEEP, but the patch does it for every UART.
>
> Greg, I suggest this patch be dropped from tty-next until it has been
> better described and tested.
>
> Kevin
>
> [1] http://lists.linaro.org/pipermail/kernel-build-reports/2014-October/005550.html

Perhaps it should call "uart_change_pm(state, UART_PM_STATE_ON)"
instead, so the driver's .pm() method is called?

UART_CAP_SLEEP seems to be an 8250-only flag.

BTW, this was the first commit I reverted when I had an issue with a serial
console yesterday, but it didn't seem to have any influence (for me).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

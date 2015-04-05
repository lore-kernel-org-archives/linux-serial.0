From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v5] earlycon: 8250: Fix command line regression
Date: Sun, 5 Apr 2015 13:02:12 -0700
Message-ID: <CAE9FiQWbha9tYpDNRW-KHUc8YPYjXVZLz9RQ+QvkcO4Y5ftMHQ@mail.gmail.com>
References: <1428167961-26841-1-git-send-email-peter@hurleysoftware.com>
	<1428245532-1523-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428245532-1523-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Sun, Apr 5, 2015 at 7:52 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Restore undocumented behavior of kernel command line parameters of
> the forms:
>     console=uart[8250],io|mmio|mmio32,<addr>[,options]
>     console=uart[8250],<addr>[,options]
> where 'options' have not been specified; in this case, the hardware
> is assumed to be initialized.
>
> Document the required behavior of the original implementation.
>
> Fixes: c7cef0a84912cab3c9df8 ("console: Add extensible console matching")
> Reported-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
> v5: Refactored serial8250_console_setup() & univ8250_console_setup()
>     to eliminate open-coding; net +1 LOC (excludes documentation)
>
> v4: Removed FIXME comment
>
> v3: Fixed automatic console to port line settings initialization;
>     open-coded serial8250_console_setup() so the baud can be probed;
>     added sha reference in commit log
>
> v2: Fixed regression which allowed "console=uart1337,..." to start a
>     console (but not an earlycon)
>   + fixed earlycon= documentation related required behavior fixed by
>     this patch
>
>  Documentation/kernel-parameters.txt  | 18 ++++++++++++---
>  drivers/tty/serial/8250/8250_core.c  | 45 ++++++++++++++++++++++++++++--------
>  drivers/tty/serial/8250/8250_early.c | 19 ---------------
>  3 files changed, 50 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index bfcb1a6..1facf0b 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -713,10 +713,18 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>
>                 uart[8250],io,<addr>[,options]
>                 uart[8250],mmio,<addr>[,options]
> +               uart[8250],mmio32,<addr>[,options]
> +               uart[8250],0x<addr>[,options]

You just don't listen.

I wasted too much time on this.

Greg,

Please just drop c7cef0a84912cab3c9df8 ("console: Add extensible
console matching").

Thanks

Yinghai

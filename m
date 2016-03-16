From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/9] serial: doc: Document .throttle()
Date: Wed, 16 Mar 2016 17:19:46 +0100
Message-ID: <CAMuHMdUhC1rFW+QvWengK61p-CPbHrqafG+PiBg1ORQ2cUTHsg@mail.gmail.com>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
	<1457968577-22379-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-4-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 14, 2016 at 4:16 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/serial/driver | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/serial/driver b/Documentation/serial/driver
> index 61d520dea4c6e13a..50f3d94ed50b341e 100644
> --- a/Documentation/serial/driver
> +++ b/Documentation/serial/driver
> @@ -126,6 +126,13 @@ hardware.
>         Interrupts: locally disabled.
>         This call must not sleep
>
> +  throttle(port)
> +       Notify the serial driver that input buffers for the line discipline are
> +       close to full, and it should somehow signal that no more characters
> +       should be sent to the serial port.
> +
> +       Locking: none.
> +

In the mean time I discovered this (and .unthrottle()) is used with hardware
assisted flow control only, and when it was introduced.
Will update the documentation accordingly.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

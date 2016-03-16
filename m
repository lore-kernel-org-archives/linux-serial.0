From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/9] serial: doc: Un-document non-existing uart_write_console()
Date: Wed, 16 Mar 2016 17:17:55 +0100
Message-ID: <CAMuHMdWR2GweYOO53ywEv-nZpP=rc8C_MQqW2NADQ0OEmdO-VQ@mail.gmail.com>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
	<1457968577-22379-2-git-send-email-geert+renesas@glider.be>
	<56E9835F.1020604@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <56E9835F.1020604@hurleysoftware.com>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 16, 2016 at 5:01 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 03/14/2016 08:16 AM, Geert Uytterhoeven wrote:
>> uart_write_console() never existed, not even when the "new
>> uart_write_console function" was documented.
>
> Right. Should be uart_console_write()

Thx, I checked a few other possibilities, but couldn't find them.
Will update.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

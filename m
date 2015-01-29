From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: sh-sci: Use dev_dbg() to log an error message
Date: Thu, 29 Jan 2015 17:14:28 +0100
Message-ID: <CAMuHMdXQN4=sRZBA4NY0dg8m_eqF56q8SSOQdvNxU5uQ46tcEQ@mail.gmail.com>
References: <1422273209-3473-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1422273209-3473-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 26, 2015 at 12:53 PM, Yoshihiro Kaneko
<ykaneko0929@gmail.com> wrote:
> Since the driver cannot return from overrun error if characters
> are output during overrun process, use dev_dbg() instead of
> dev_notice() to log the error message of overrun in syslog.
>
> Based on a patch by Hisashi Nakamura.
>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/68] TTY buffer in tty_port -- prep no. 1
Date: Sun, 18 Mar 2012 09:56:23 +0100
Message-ID: <CAMuHMdWwqPSarZi5kDMaM8KOjm9m+KFyv_OG=dVfP5FxEgEoZA@mail.gmail.com>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-serial@vger.kernel.org

Hi Jiri,

On Mon, Mar 5, 2012 at 14:51, Jiri Slaby <jslaby@suse.cz> wrote:
> this is the first series of patches which allow tty buffers to be
> moved from tty_struct (present from open to close/hangup) to tty_port
> (present as long as the device). This will allow us to get rid of the
> tty refcounting in the interrupt service routines and other hot paths
> after we are done. This is because we won't need to handle races amon=
g
> ISRs, timers, hangups and others, because tty_port lives as long as a=
n
> interrupt/timer tick may occur. Unlike tty_struct.
>
> In this series, only first few drivers are converted to use
> tty_port. The rest is to come later.
>
> The first few patches are simple fixes/cleanups which emerged during
> the code investigation here and there. Further serialP header removal
> happens there. Finally, some drivers are forced to use tty_port, whic=
h
> will become a necessity in the future.
>
> Simserial (ia64) and standard x86 stuff were runtime-tested. The rest
> is only checked to be compilation-errors free.

I had a look at all 19 patches touching amiserial, and they look fine. =
So
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks for the cleanup!

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds

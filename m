From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix earlycon on Renesas ARM platforms
Date: Fri, 31 Aug 2018 00:30:30 +0200
Message-ID: <CAMuHMdVgRQsOiQ-M3CGZZK1wdx3smY6MgkkokdSuw3iBm8zPrQ@mail.gmail.com>
References: <20180830125404.21192-1-geert+renesas@glider.be> <TY1PR01MB1562E58C07A892AC7CF7438B8A080@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TY1PR01MB1562E58C07A892AC7CF7438B8A080@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, uli+renesas@fpond.eu, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Chris,

On Thu, Aug 30, 2018 at 8:52 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Thursday, August 30, 2018, Geert Uytterhoeven wrote:
> > Earlycon for RZ/A2 (which is a new platform) will be fixed later in a
> > separate patch.
>
> I assume something like this:

Exactly!

> (which works for me)

Thanks for checking!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

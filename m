From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 12/19] serial: sh-sci: Remove initialization of zero
 fields in sci_port_params
Date: Fri, 6 Jan 2017 11:29:33 +0100
Message-ID: <CAMuHMdWhKhr0Xy4BcU6sNiaTyMDSqXLRWqYavd6R8zChdstmHg@mail.gmail.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-13-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-13-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The compiler zeros uninitialized fields, don't zero them manually.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

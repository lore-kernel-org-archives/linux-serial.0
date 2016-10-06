From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] sh-sci: add R8A7743/5 support
Date: Thu, 6 Oct 2016 22:55:59 +0200
Message-ID: <CAMuHMdUVj485ok3UoTSixGU_dYaRr8QJrAnOO56_TDPWT=seCA@mail.gmail.com>
References: <2017044.9fZNuWa2OZ@wasted.cogentembedded.com> <2254757.qf3e5qBuAz@avalon>
 <CAL_Jsq+p35REB_Lwm2vhGEKiTQHCawAXqYeJ1Yq5o3WEad9K8Q@mail.gmail.com> <7496008.sErWcihIz4@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <7496008.sErWcihIz4@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <robh+dt@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 5, 2016 at 3:37 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 05 Oct 2016 08:28:05 Rob Herring wrote:
>> Is it really 4 distinct UARTs on a chip? DT can't fix that insanity.
>
> It's really 4 different UART types on a chip, yes. We have actually 5
> different UART types, named SCI, SCIF, SCIFA, SCIFB and HSCIF. Only the last 4
> are used on R-Car SoCs.

And even that is a simplification ;-)

AFAIU, evolution seems to have been

    SCI --> SCIF ---> SCIF + BRG ---> HSCIF
              |
              +---> SCIFA ---> SCIFB

Now, that's a simplication, too ;-) There are many intermediate variants
with slightly different features and register bits,esp. on SuperH.
They're all handled by the same sh-sci.c driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

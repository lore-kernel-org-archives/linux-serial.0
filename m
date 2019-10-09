From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for the sifive serial driver
Date: Wed, 9 Oct 2019 08:56:29 +0200
Message-ID: <CAMuHMdVdPFSU_3VEtO=P73kqLezV5Dmki=N3nxsKibzy-U5pBg@mail.gmail.com>
References: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Andreas Schwab <schwab@suse.de>, Christoph Hellwig <hch@lst.de>
List-Id: linux-serial@vger.kernel.org

Hi Paul,

On Wed, Oct 9, 2019 at 1:09 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> Document earlycon usage for the SiFive serial port driver in the same
> fashion as for the other serial port IP blocks, since the SiFive
> serial port driver supports it.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Reported-by: Andreas Schwab <schwab@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

Why do you need this?
I believe risc-v is DT-only, so if chosen/stdout-path is set up, just
passing "earlycon" (without any options) should work.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c7ac2f3ac99f..90becb00221b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1106,6 +1106,12 @@
>                         address must be provided, and the serial port must
>                         already be setup and configured.
>
> +               sifive,<addr>
> +                       Start an early, polled-mode console on a SiFive
> +                       serial port at the specified address.  The port must
> +                       already be setup and configured.  Options are not
> +                       yet supported.
> +
>         earlyprintk=    [X86,SH,ARM,M68k,S390]
>                         earlyprintk=vga
>                         earlyprintk=sclp

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

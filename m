From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for the sifive serial driver
Date: Wed, 9 Oct 2019 12:55:37 +0200
Message-ID: <CAMuHMdVh=CUXKwnXee067cRccVBDVuwWpo1wP7crAaCFA=y2Tw@mail.gmail.com>
References: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com>
 <CAMuHMdVdPFSU_3VEtO=P73kqLezV5Dmki=N3nxsKibzy-U5pBg@mail.gmail.com> <mvmv9syz10h.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mvmv9syz10h.fsf@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: linux-serial@vger.kernel.org

Hi Andreas,

On Wed, Oct 9, 2019 at 12:06 PM Andreas Schwab <schwab@suse.de> wrote:
> On Okt 09 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I believe risc-v is DT-only, so if chosen/stdout-path is set up
>
> If.  Currently, it isn't.

IC. So isn't it better to fix that, instead of pointing people to more obscure
legacy solutions?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

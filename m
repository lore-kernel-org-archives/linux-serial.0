From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for the sifive serial driver
Date: Wed, 9 Oct 2019 07:31:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1910090720290.11044@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com> <CAMuHMdVdPFSU_3VEtO=P73kqLezV5Dmki=N3nxsKibzy-U5pBg@mail.gmail.com> <mvmv9syz10h.fsf@suse.de> <CAMuHMdVh=CUXKwnXee067cRccVBDVuwWpo1wP7crAaCFA=y2Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVh=CUXKwnXee067cRccVBDVuwWpo1wP7crAaCFA=y2Tw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Schwab <schwab@suse.de>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On Wed, 9 Oct 2019, Geert Uytterhoeven wrote:

> On Wed, Oct 9, 2019 at 12:06 PM Andreas Schwab <schwab@suse.de> wrote:
> > On Okt 09 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > I believe risc-v is DT-only, so if chosen/stdout-path is set up
> >
> > If.  Currently, it isn't.
> 
> IC. So isn't it better to fix that, instead of pointing people to more obscure
> legacy solutions?

There's nothing that's RISC-V specific about the SiFive serial IP or 
its driver.  So the issue of whether RISC-V is DT-only or not probably 
shouldn't impact whether we document that the SiFive serial driver 
supports earlycon.

best regards,

- Paul

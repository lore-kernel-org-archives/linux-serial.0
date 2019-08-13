From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] serial: 8250_pci: Add support for Sunix serial boards
Date: Tue, 13 Aug 2019 11:23:35 +0300
Message-ID: <CAHp75VedrnJDOoJGuYJiFAx3ODGAMFx7nTKuoErNn3NWYSn_gA@mail.gmail.com>
References: <20190809190130.30773-1-kai.heng.feng@canonical.com>
 <CAHp75VeGs8K+da+4CaqNjm_ci86KoLcmhY8GaJO7jm__J0TcSQ@mail.gmail.com>
 <93860D98-9CB7-4D3D-8917-E15591BD1EC4@canonical.com> <20190813061228.GH6670@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813061228.GH6670@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Morris Ku <morris_ku@sunix.com>, Debbie Liu <debbie_liu@sunix.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 13, 2019 at 9:12 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Aug 13, 2019 at 12:36:40PM +0800, Kai-Heng Feng wrote:
> > at 21:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Aug 9, 2019 at 10:05 PM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:

> > > Can you, please, split out the Sunix quirk driver to a separate module
> > > (see examples like: 8250_exar, 8250_lpss, 8250_mid)?
> > > And then with a fewer LOCs add a new boards.
> >
> > Greg asked Sunix to use existing 8250_pci.c instead of its own module.
> > It only needs a special setup function, other parts are just 8250_pci.
>
> Agreed.  And this patch is already in my tree :)
>
> If people really worry about size issues, start carving this up by
> different configuration options, or yes, split it up into tiny modules
> (but note the overhead there when things get too tiny, it's a
> diminishing return).

It's always a trade off and associative pros and cons. If Sunix is a
simple one, I tend to agree that 8250_pci is a good place. For rather
big quirk modules, like Exar one, the separate sounds better (and as
we can see from retrospective of maintenance).

>
> > Why does split them a better idea? I even think of squashing 8250_moxa into
> > 8250_pci.
>
> I would agree with you, I bet you save space if you do that.



-- 
With Best Regards,
Andy Shevchenko

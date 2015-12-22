From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Tue, 22 Dec 2015 16:07:28 +0530
Message-ID: <20151222103728.GA30453@sudip-pc>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20151220164353.6ef29f77@lxorguk.ukuu.org.uk>
 <20151220172841.GB8471@sudip-laptop>
 <20151220174208.1447d2f3@lxorguk.ukuu.org.uk>
 <20151221151904.GA23780@sudip-pc>
 <CAHp75VfF_f=4MFmk9D1eLYanVyQyr+Fr8RBY81Pw+dyGZ7e0xw@mail.gmail.com>
 <20151222042707.GA3250@sudip-pc>
 <CAHp75VfU74zvwBef682bVqL-aSYVRYeEyPjyarE_KRyLr+8NQw@mail.gmail.com>
 <20151222100859.GA24622@sudip-pc>
 <CAHp75Ve_Hsj9YbV3bQ16qRQrVRo+HE2RJukuH=Mpq5AVLzhaDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Ve_Hsj9YbV3bQ16qRQrVRo+HE2RJukuH=Mpq5AVLzhaDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 22, 2015 at 12:15:18PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 22, 2015 at 12:08 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > On Tue, Dec 22, 2015 at 11:58:17AM +0200, Andy Shevchenko wrote:
> 
> >> > The only downside is
> >> > that the module gets loaded even if the device is not there.
> >>
> >> How is that?
> >
> > Alan explained that in https://lkml.org/lkml/2015/12/20/103
> >
> > Quoting from his mail "you reference the methods in it so it will
> > always be dragged in".
> >
> > And I wanted to verify that so I tested today morning after removing the
> > card from my local system and after booting I saw having 8250_gpi loaded.
> 
> Ah, it is in case "exar as a library".
> 
> In case "exar as a separate driver" other way around: it will drag
> methods from 8250_pci if any.

Yes. Now we have many different options:

1) the way i submited v1, 8250_gpio is a separate module, init() and
exit() are referenced from 8250_pci(). Downside - module will be loaded
even if hardware is not there.

2) Separate 8250_exar driver which uses 8250_pci as library. Reason to
avoid - Greg was initially against this idea of having it as a separate
driver.

3) Like Alan suggested, having something like a platform driver and
8250_gpio will bind to that.

I am waiting for Greg's signal on these three and I wont be surprised if
he comes out with another fourth idea which will solve it in a most simple
way. :)

regards
sudip

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Tue, 22 Dec 2015 15:38:59 +0530
Message-ID: <20151222100859.GA24622@sudip-pc>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20151220164353.6ef29f77@lxorguk.ukuu.org.uk>
 <20151220172841.GB8471@sudip-laptop>
 <20151220174208.1447d2f3@lxorguk.ukuu.org.uk>
 <20151221151904.GA23780@sudip-pc>
 <CAHp75VfF_f=4MFmk9D1eLYanVyQyr+Fr8RBY81Pw+dyGZ7e0xw@mail.gmail.com>
 <20151222042707.GA3250@sudip-pc>
 <CAHp75VfU74zvwBef682bVqL-aSYVRYeEyPjyarE_KRyLr+8NQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfU74zvwBef682bVqL-aSYVRYeEyPjyarE_KRyLr+8NQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 22, 2015 at 11:58:17AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 22, 2015 at 6:27 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > On Mon, Dec 21, 2015 at 08:28:51PM +0200, Andy Shevchenko wrote:
> >> On Mon, Dec 21, 2015 at 5:19 PM, Sudip Mukherjee
> >> <sudipm.mukherjee@gmail.com> wrote:
> >>
> 
> >> There are at least two approaches:
> >>  - use 8250_pci, etc as a library (see example: 8250_mid.c)
> >>  - force 8250_pci to use external libraries in some cases (seems your approach)
> 
> Third one btw is to blow up the 8250_pci. (This actually was the main
> reason why we chose separate driver approach in our case).
> 
> >> Of course better to gather maintainer's opinion first.
> >
> > Greg, can you please give some idea here about the best way to approach...
> > I personally think, having it as a module with the minor changes that
> > Alan and Andy has suggested is the best approach.
> 
> > The only downside is
> > that the module gets loaded even if the device is not there.
> 
> How is that?

Alan explained that in https://lkml.org/lkml/2015/12/20/103

Quoting from his mail "you reference the methods in it so it will
always be dragged in".

And I wanted to verify that so I tested today morning after removing the
card from my local system and after booting I saw having 8250_gpi loaded.

regards
sudip

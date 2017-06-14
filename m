From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] tty/serial: remove AVR32 specific access wrappers
Date: Wed, 14 Jun 2017 16:26:22 +0200
Message-ID: <20170614142622.vqqanjg7ucpt2ovi@piout.net>
References: <20170613202517.26558-1-alexandre.belloni@free-electrons.com>
 <CAHp75VcMrhG0K-=dtkF1T5siAAmmLYdmCxcLdo_vvH8dLjLh=A@mail.gmail.com>
 <20170614132723.2duxhpjq4odchcw2@piout.net>
 <CAHp75Vd8osYbgxhOe3vxLFsCuDk0p+MWz+UQQWz+uX9+bvkZmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vd8osYbgxhOe3vxLFsCuDk0p+MWz+UQQWz+uX9+bvkZmw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 14/06/2017 at 17:15:32 +0300, Andy Shevchenko wrote:
> On Wed, Jun 14, 2017 at 4:27 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > On 14/06/2017 at 12:43:40 +0300, Andy Shevchenko wrote:
> >> On Tue, Jun 13, 2017 at 11:25 PM, Alexandre Belloni
> >> <alexandre.belloni@free-electrons.com> wrote:
> >> > Now that AVR32 is gone, the specific wrappers for that architecture are
> >> > unnecessary and will not be compiled anymore.
> >> >
> >>
> >> Can you rebase this on top of tty-next?
> >>
> >> I'm pretty sure this patch will gone.
> >>
> >
> > So you avoided most of the bikeshedding by not copying any of the
> > maintainers, nice...
> 
> Wait, what? I used get_maintainer.pl script and I took its output + Greg.
> 

Yeah, get_maintainer is not ideal but that's fine. Probably the lakml
should be added.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

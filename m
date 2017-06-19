From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 09/28] tty: serial: Add Actions Semi Owl UART earlycon
Date: Mon, 19 Jun 2017 10:12:12 +0800
Message-ID: <20170619021212.GA3195@kroah.com>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-10-afaerber@suse.de>
 <55059fdd-5c54-ee6c-3e63-b5a9035c1745@suse.de>
 <20170619011627.GB11287@kroah.com>
 <7fff8813-cea4-0530-bf7b-3d0ad50d6e93@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7fff8813-cea4-0530-bf7b-3d0ad50d6e93@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linux-arm-kernel@lists.infradead.org, support@lemaker.org, =?utf-8?B?5byg5aSp55uK?= <tyzhang@actions-semi.com>, 96boards@ucrobotics.com, linux-kernel@vger.kernel.org, Thomas Liau <thomas.liau@actions-semi.com>, mp-cs@actions-semi.com, linux-serial@vger.kernel.org, =?utf-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, Jiri Slaby <jslaby@suse.com>, =?utf-8?B?5byg5Lic6aOO?= <zhangdf@actions-semi.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 19, 2017 at 03:24:44AM +0200, Andreas Färber wrote:
> Am 19.06.2017 um 03:16 schrieb Greg Kroah-Hartman:
> > On Sun, Jun 18, 2017 at 11:45:28PM +0200, Andreas Färber wrote:
> >> Greg,
> >>
> >> Am 06.06.2017 um 02:54 schrieb Andreas Färber:
> >>> This implements an earlycon for Actions Semi S500/S900 SoCs.
> >>>
> >>> Based on LeMaker linux-actions tree.
> >>>
> >>> Signed-off-by: Andreas Färber <afaerber@suse.de>
> >>
> >> The DT vendor prefix is applied to my linux-actions.git tree now, and
> >> the serial binding has been ack'ed by Rob.
> >>
> >> Is there anything keeping you from adding this patch, the preceding DT
> >> binding (08/28) and the following documentation patch (10/28) to your
> >> tree for 4.13?
> > 
> > Yeah, I don't have it in my queue anymore :)
> > 
> > Can you resend it just as a single patch?
> 
> Do you mean squash the documentation into this tty patch? As you wish.
> But the DT binding is supposed to be a separate patch - I can queue it
> in my tree if you prefer.

No, just send me what ever you want me to apply to my tree.  If you want
me to pick some random patch out of the middle of a series, um, that's a
bit hard for me to know what to do, right?

Make it very very obvious please :)

thanks,

greg k-h

From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: imx serial driver commit breaks system boot on i.MX6 boards
Date: Wed, 7 Oct 2015 17:03:24 +0200
Message-ID: <20151007150323.GB11573@pqgruber.com>
References: <20151007143904.GA11573@pqgruber.com>
 <CAOMZO5CDC8swE6HwjiA97=mZaXnGsHCwrj9MjP7SAd3EJKv-Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5CDC8swE6HwjiA97=mZaXnGsHCwrj9MjP7SAd3EJKv-Jw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@freescale.com>, Eduardo Valentin <edubezval@gmail.com>, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 07, 2015 at 11:42:07AM -0300, Fabio Estevam wrote:
> On Wed, Oct 7, 2015 at 11:39 AM, Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> 
> > A revert patch from Fabio Estevam was sent on Aug 18th of 2015.
> >
> > Is there a reason why that revert patch has not been merged yet?
> > Hopefully this will be fixed before the 4.3 release.
> 
> Already reverted in Greg's tree:
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/commit/?h=tty-linus&id=0c727a42043f79db210cdde0366f9137b9c6bf5a
> 
> Should be available in 4.3-rc5.

Awesome, thanks!

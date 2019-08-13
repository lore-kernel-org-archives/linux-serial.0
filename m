From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] serial: 8250_pci: Add support for Sunix serial
 boards
Date: Tue, 13 Aug 2019 08:12:28 +0200
Message-ID: <20190813061228.GH6670@kroah.com>
References: <20190809190130.30773-1-kai.heng.feng@canonical.com>
 <CAHp75VeGs8K+da+4CaqNjm_ci86KoLcmhY8GaJO7jm__J0TcSQ@mail.gmail.com>
 <93860D98-9CB7-4D3D-8917-E15591BD1EC4@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <93860D98-9CB7-4D3D-8917-E15591BD1EC4@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Morris Ku <morris_ku@sunix.com>, Debbie Liu <debbie_liu@sunix.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 13, 2019 at 12:36:40PM +0800, Kai-Heng Feng wrote:
> Hi Andy,
> 
> at 21:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Fri, Aug 9, 2019 at 10:05 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > > Add support to Sunix serial boards with up to 16 ports.
> > > 
> > > Sunix board need its own setup callback instead of using Timedia's, to
> > > properly support more than 4 ports.
> > 
> > Can you, please, split out the Sunix quirk driver to a separate module
> > (see examples like: 8250_exar, 8250_lpss, 8250_mid)?
> > And then with a fewer LOCs add a new boards.
> 
> Greg asked Sunix to use existing 8250_pci.c instead of its own module.
> It only needs a special setup function, other parts are just 8250_pci.

Agreed.  And this patch is already in my tree :)

If people really worry about size issues, start carving this up by
different configuration options, or yes, split it up into tiny modules
(but note the overhead there when things get too tiny, it's a
diminishing return).

> Why does split them a better idea? I even think of squashing 8250_moxa into
> 8250_pci.

I would agree with you, I bet you save space if you do that.

thanks,

greg k-h

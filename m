From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC, PATCH] imx: serial: Take tty->files_lock opportunistically
Date: Mon, 12 Jun 2017 08:46:56 +0200
Message-ID: <20170612064656.GA15926@kroah.com>
References: <20170530123726.18598-1-andrew.smirnov@gmail.com>
 <CAL_JsqJUF8NhEhGY2FPPX5GUF3oP9XONQJy9sj42uPYATskz9A@mail.gmail.com>
 <20170530144213.48df2a1c@alans-desktop>
 <20170530134427.GD6786@collabora.com>
 <20170603093048.GA9120@kroah.com>
 <CAOMZO5A_hLkuQkmfQFmCmLtCFimf0i70WbtYMr0o811vpreKbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5A_hLkuQkmfQFmCmLtCFimf0i70WbtYMr0o811vpreKbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Peter Senna Tschudin <peter.senna@collabora.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rob Herring <robherring2@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Chris Healy <cphealy@gmail.com>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Jun 11, 2017 at 09:33:13PM -0300, Fabio Estevam wrote:
> Hi Greg,
> 
> On Sat, Jun 3, 2017 at 6:30 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, May 30, 2017 at 03:44:27PM +0200, Peter Senna Tschudin wrote:
> >> On Tue, May 30, 2017 at 02:42:13PM +0100, Alan Cox wrote:
> >>
> >> I sent a second patch recently:
> >>
> >> https://patchwork.kernel.org/patch/9725625/
> >
> > And it's already in linux-next so all should be good here.
> 
> linux-next is good, but mainline is not.
> 
> Actually we need 4dec2f119e86f9c9 ("imx-serial: RX DMA startup
> latency") to be applied to 4.12-rc as well.

Why?  Can't it wait until 4.13-rc1?

thanks,

greg k-h

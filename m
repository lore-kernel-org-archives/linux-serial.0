From: Peter Senna Tschudin <peter.senna@collabora.com>
Subject: Re: [RFC, PATCH] imx: serial: Take tty->files_lock opportunistically
Date: Tue, 30 May 2017 15:44:27 +0200
Message-ID: <20170530134427.GD6786@collabora.com>
References: <20170530123726.18598-1-andrew.smirnov@gmail.com>
 <CAL_JsqJUF8NhEhGY2FPPX5GUF3oP9XONQJy9sj42uPYATskz9A@mail.gmail.com>
 <20170530144213.48df2a1c@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530144213.48df2a1c@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Rob Herring <robherring2@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Chris Healy <cphealy@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 30, 2017 at 02:42:13PM +0100, Alan Cox wrote:

I sent a second patch recently:

https://patchwork.kernel.org/patch/9725625/

> > > Fixes: 18a4208826dd0a13eb06de724c86bba2c225f943 ("imx-serial: Reduce
> > > RX DMA startup latency when opening for reading")
> > >
> > > Cc: cphealy@gmail.com
> > > Cc: Peter Senna Tschudin <peter.senna@collabora.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jiri Slaby <jslaby@suse.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > ---
> > >
> > > Not sure if this is the best way to solve the problem (hence the RFC
> > > tag). If anyone has a better idea, or if there's a better fix for this
> > > already, please let me know.  
> > 
> > IMO, the low level serial drivers shouldn't be accessing
> > tty->tty_files in the first place. Is being opened for write-only that
> > common and is skipping the DMA setup really necessary?
> 
> Seconded - the Reduce RX DMA startup latency patch should just be
> reverted (and shouldn't ever IMHO have gotten in).
> 
> Not all readers and writers to a tty have a file handle any more anyway,
> so it's not only icky and layer violating it's fundamentally broken
> beyond the locking.
> 
> Alan

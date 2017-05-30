From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC, PATCH] imx: serial: Take tty->files_lock
 opportunistically
Date: Tue, 30 May 2017 14:42:13 +0100
Message-ID: <20170530144213.48df2a1c@alans-desktop>
References: <20170530123726.18598-1-andrew.smirnov@gmail.com>
        <CAL_JsqJUF8NhEhGY2FPPX5GUF3oP9XONQJy9sj42uPYATskz9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJUF8NhEhGY2FPPX5GUF3oP9XONQJy9sj42uPYATskz9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Chris Healy <cphealy@gmail.com>, Peter Senna Tschudin <peter.senna@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> > Fixes: 18a4208826dd0a13eb06de724c86bba2c225f943 ("imx-serial: Reduce
> > RX DMA startup latency when opening for reading")
> >
> > Cc: cphealy@gmail.com
> > Cc: Peter Senna Tschudin <peter.senna@collabora.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >
> > Not sure if this is the best way to solve the problem (hence the RFC
> > tag). If anyone has a better idea, or if there's a better fix for this
> > already, please let me know.  
> 
> IMO, the low level serial drivers shouldn't be accessing
> tty->tty_files in the first place. Is being opened for write-only that
> common and is skipping the DMA setup really necessary?

Seconded - the Reduce RX DMA startup latency patch should just be
reverted (and shouldn't ever IMHO have gotten in).

Not all readers and writers to a tty have a file handle any more anyway,
so it's not only icky and layer violating it's fundamentally broken
beyond the locking.

Alan

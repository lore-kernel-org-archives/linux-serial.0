From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: relocate remaining serial drivers from tty/ to
 tty/serial/
Date: Wed, 4 Jan 2012 22:01:58 +0000
Message-ID: <20120104220158.3300d65b@pyramind.ukuu.org.uk>
References: <1325707287-31038-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1325707287-31038-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: alan@linux.intel.com, gregkh@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed,  4 Jan 2012 15:01:27 -0500
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> The commit ab4382d27412e7e3e7c936e8d50d8888dfac3df8,
> 
>    "tty: move drivers/serial/ to drivers/tty/serial/"
> 
> put most of the serial drivers together in one place, but the ones
> that were hiding in drivers/char didn't get picked up in that change.
> 
> They did get moved in commit a6afd9f3e819de4795fcd356e5bfad446e4323f2
> 
>    "tty: move a number of tty drivers from drivers/char/ to drivers/tty/"
> 
> but there was no distinction of serial vs. non-serial in the above.
> 
> Here we take the remaining serial drivers (mostly legacy multiport
> drivers) and put them alongside all the others in tty/serial/ dir.
> 
> We can drop SERIAL_NONSTANDARD's dependency on HAS_IOMEM, since the
> encompassing menu block already has that dependency called out.

NAK

The tty/serial directory is the stuff using serial_core. I'm not averse
to moving the others down a layer into more appropriate places but its
already too crowded and in need of re-ordering (eg tty/serial/8250/...
might be an improvement)

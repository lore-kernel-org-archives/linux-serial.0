From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 5/5] drivers/tty: make serial 8250_lpc18xx.c explicitly
 non-modular
Date: Tue, 11 Aug 2015 02:05:44 -0400
Message-ID: <20150811060544.GJ9751@windriver.com>
References: <1439081497-14986-1-git-send-email-paul.gortmaker@windriver.com>
 <1439081497-14986-6-git-send-email-paul.gortmaker@windriver.com>
 <CAGhQ9Vxjymt4z32s3x2B8b6ypgn3Bzh1ncbqxqidfPyM2k87jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGhQ9Vxjymt4z32s3x2B8b6ypgn3Bzh1ncbqxqidfPyM2k87jw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

[Re: [PATCH 5/5] drivers/tty: make serial 8250_lpc18xx.c explicitly non-modular] On 10/08/2015 (Mon 20:42) Joachim Eastwood wrote:

> Hi Paul,
> 
> On 9 August 2015 at 02:51, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> > The Kconfig currently controlling compilation of this code is:
> >
> > 8250/Kconfig:config SERIAL_8250_LPC18XX
> > 8250/Kconfig:        bool "NXP LPC18xx/43xx serial port support"
> >
> > ...meaning that it currently is not being built as a module by anyone.
> >
> > Lets remove the modular code that is essentially orphaned, so that
> > when reading the driver there is no doubt it is builtin-only.
> 
> The bool in KConfig is more or less a copy-paste mistake on my side. I
> really meant for this driver to be buildable as module and it builds
> just fine with 'm'.
> 
> Want me send a patch changing it to tristate or will you handle it?

I will do a v2 in the next day or so with collected ACKs and this patch
replaced, unless Greg jumps in and indicates he'd like something
different.

Paul.
--

> 
> 
> regards, Joachim Eastwood

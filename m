From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] tty: fix up a few remaining files without SPDX
 identifiers
Date: Thu, 4 Apr 2019 12:24:05 +0200
Message-ID: <20190404102405.GA15592@kroah.com>
References: <20190402140708.519-1-gregkh@linuxfoundation.org>
 <20190402140708.519-2-gregkh@linuxfoundation.org>
 <988b3a14-f5f6-44cb-3bda-eb7489bd2431@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <988b3a14-f5f6-44cb-3bda-eb7489bd2431@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukesh Ojha <mojha@codeaurora.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 04, 2019 at 02:16:06PM +0530, Mukesh Ojha wrote:
> 
> On 4/2/2019 7:37 PM, Greg Kroah-Hartman wrote:
> > There were a few straggling files under drivers/tty/ that did not have
> > any SPDX identifier either because they entered the tree recently, or
> > they somehow missed the mass-tagging of commit b24413180f56 ("License
> > cleanup: add SPDX GPL-2.0 license identifier to files with no license")
> > 
> > This commit follows the same rule as b24413180f56 ("License cleanup: add
> > SPDX GPL-2.0 license identifier to files with no license") where files
> > without any specified license in them fall under GPL-2.0 as the correct
> > license for the individual file.  Add that identifier to these remaining
> > files so that we don't have to guess at the license of them in the
> > future.
> > 
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/tty/serial/8250/8250_men_mcb.c | 1 +
> >   drivers/tty/serial/sn_console.c        | 1 +
> >   drivers/tty/vcc.c                      | 1 +
> >   drivers/tty/vt/.gitignore              | 1 +
> >   drivers/tty/vt/cp437.uni               | 1 +
> >   drivers/tty/vt/defkeymap.c_shipped     | 1 +
> >   drivers/tty/vt/defkeymap.map           | 1 +
> >   7 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
> > index 127017cc41d9..02c5aff58a74 100644
> > --- a/drivers/tty/serial/8250/8250_men_mcb.c
> > +++ b/drivers/tty/serial/8250/8250_men_mcb.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >   #include <linux/device.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> > diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
> > index fe9170731c16..283493358a62 100644
> > --- a/drivers/tty/serial/sn_console.c
> > +++ b/drivers/tty/serial/sn_console.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >   /*
> >    * C-Brick Serial Port (and console) driver for SGI Altix machines.
> >    *
> > diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> > index 58b454c34560..d2a1e1228c82 100644
> > --- a/drivers/tty/vcc.c
> > +++ b/drivers/tty/vcc.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >   /* vcc.c: sun4v virtual channel concentrator
> >    *
> >    * Copyright (C) 2017 Oracle. All rights reserved.
> > diff --git a/drivers/tty/vt/.gitignore b/drivers/tty/vt/.gitignore
> > index 83683a2d8e6a..9b38b85f9d9a 100644
> > --- a/drivers/tty/vt/.gitignore
> > +++ b/drivers/tty/vt/.gitignore
> 
> .gitignore ?

Yes, all files need them :)

> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Thanks for the review.

greg k-h

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 06/12] 8250: use the 8250 register interface not the
 legacy one
Date: Wed, 27 Jun 2012 23:50:49 +0100
Message-ID: <20120627235049.36aeb659@pyramind.ukuu.org.uk>
References: <20120627112102.5678.4141.stgit@localhost.localdomain>
	<20120627112205.5678.80154.stgit@localhost.localdomain>
	<CAP=VYLopNPeYCi4uQoHuqU0vWFF5hc4J9x3uzSOXJVv=DGLLWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:47127 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583Ab2F0WrC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Jun 2012 18:47:02 -0400
In-Reply-To: <CAP=VYLopNPeYCi4uQoHuqU0vWFF5hc4J9x3uzSOXJVv=DGLLWw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: greg@kroah.com, linux-serial@vger.kernel.org

On Wed, 27 Jun 2012 18:39:53 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> On Wed, Jun 27, 2012 at 7:22 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > From: Alan Cox <alan@linux.intel.com>
> >
> > The old interface just copies bits over and calls the newer one.
> > In addition we can now pass more information.
> >
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > ---
> 
> [...]
> 
> > - * serial8250_register_port and serial8250_unregister_port allows for
> > + * serial8250_register_8250_port and serial8250_unregister_port allows
> 
> This seems a bit lopsided.  Can we convert the unregister too, and
> then just keep the old names, and avoid the doubling up on the
> presence of 8250 in the name?  (I confess to having not looked
> at the code to seeing if there is an obvious barrier to doing this),

That wouldn't be a bad idea for a follow up. I didn't pick the names -
they were changed earlier so that we could have both APIs. Now the old
API is gone we could at some point rename it back - but that ought to
wait a while so any out of tree stuff continues to break for a bit to
avoid accidents.

Alan

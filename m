From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] jsm_tty: Fix a possible null pointer dereference in two
 functions
Date: Wed, 29 Nov 2017 18:05:28 +0000
Message-ID: <20171129180528.GA24705@kroah.com>
References: <5c78db97-88f5-8655-9a47-eeee0a043fba@users.sourceforge.net>
 <1511976187.19952.65.camel@perches.com>
 <20171129173504.GA20581@kroah.com>
 <1511977896.19952.69.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511977896.19952.69.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, linux-serial@vger.kernel.org, "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 29, 2017 at 09:51:36AM -0800, Joe Perches wrote:
> On Wed, 2017-11-29 at 17:35 +0000, Greg Kroah-Hartman wrote:
> > On Wed, Nov 29, 2017 at 09:23:07AM -0800, Joe Perches wrote:
> > > On Wed, 2017-11-29 at 17:40 +0100, SF Markus Elfring wrote:
> > > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > > Date: Wed, 29 Nov 2017 17:30:36 +0100
> > > > 
> > > > Move two debug messages so that a null pointer access can not happen
> > > > for the variable "ch" in these functions.
> > > 
> > > An actual defect fix!
> > 
> > Nope, not at all, this does not "fix" anything.
> 
> Well, I believe it does in unusual cases like a
> CONFIG_DYNAMIC_DEBUG when this is enabled by an
> odd +p in the dynamic debug control file.
> 
> > > Here you could probably cc stable too.
> > 
> > Nope, not worth it.
> 
> <shrug>
> 
> It's pretty unlikely, but it is an actual defect.

No it is not, those variables will never be set to NULL, so this can
never be triggered.  Walk up the call chain.

greg k-h

From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] jsm_tty: Fix a possible null pointer dereference in two
 functions
Date: Wed, 29 Nov 2017 22:16:13 +0300
Message-ID: <20171129191613.arwn3tko42zwszxq@mwanda>
References: <5c78db97-88f5-8655-9a47-eeee0a043fba@users.sourceforge.net>
 <1511976187.19952.65.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511976187.19952.65.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Jiri Slaby <jslaby@suse.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 29, 2017 at 09:23:07AM -0800, Joe Perches wrote:
> On Wed, 2017-11-29 at 17:40 +0100, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 29 Nov 2017 17:30:36 +0100
> > 
> > Move two debug messages so that a null pointer access can not happen
> > for the variable "ch" in these functions.
> 
> An actual defect fix!
> 
> Here you could probably cc stable too.
> 

These aren't real bugs because "ch" is never NULL.

regards,
dan carpenter

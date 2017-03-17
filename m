From: Petr Mladek <pmladek@suse.com>
Subject: Re: Does braille console work?
Date: Fri, 17 Mar 2017 10:35:44 +0100
Message-ID: <20170317093544.GN3977@pathway.suse.cz>
References: <1bb67bee-b8f9-2835-725a-f36fda085216@linaro.org>
 <20170317005355.xwym3zpamym3rwp6@var.youpi.perso.aquilenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317005355.xwym3zpamym3rwp6@var.youpi.perso.aquilenet.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Fri 2017-03-17 01:53:55, Samuel Thibault wrote:
> Aleksey Makarov, on jeu. 16 mars 2017 17:02:53 +0300, wrote:
> > 
> > So braille console registration should not work.  What do I miss?
> 
> Nothing, the code transformation was broken :/

> > So it looks like braille console has not been used for more than 3 years.
> > Should we remote it?
> 
> Please, no :)
> 
> It is indeed not often useful, since one would usually use a userland
> daemon to access the system, but when one's system does not boot
> properly or something similar, it's useful to have the braille
> console. That's just very not often useful.

I see the points. I would personally prefer to keep it even though
it is not much used and it complicates some code paths. Well, I do
not feel in the position to decide about it.

Anyway, the feature is not usable at the moment. Samuel, would
you be able to fix and test it, please?

Best Regards,
Petr

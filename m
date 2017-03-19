From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Does braille console work?
Date: Sun, 19 Mar 2017 15:41:33 +0100
Message-ID: <20170319144133.ep2em6uebaew4iwa@var.youpi.perso.aquilenet.fr>
References: <1bb67bee-b8f9-2835-725a-f36fda085216@linaro.org>
 <20170317005355.xwym3zpamym3rwp6@var.youpi.perso.aquilenet.fr>
 <20170317093544.GN3977@pathway.suse.cz>
 <20170317094051.lpdu4pjloboaikgr@var.youpi.perso.aquilenet.fr>
 <20170317090208.437d4e10@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317090208.437d4e10@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

Steven Rostedt, on ven. 17 mars 2017 09:02:08 -0400, wrote:
> Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> > Petr Mladek, on ven. 17 mars 2017 10:35:44 +0100, wrote:
> > > Anyway, the feature is not usable at the moment. Samuel, would
> > > you be able to fix and test it, please?  
> > 
> > Sure, it's already on my TODO list, I will do when I get the time.
> 
> Yes please.

Done so.

> There's no reason to keep that code if it's been broken for
> 3 years and nobody noticed.

It's rather that nobody complained. That's what usually happens with
accessibility: when something breaks, the concerned users do notice, but
end up just thinking "ok, yet another regression..."

> In fact, keeping it may actually make it
> more difficult to add accessibility in the future. Methodologies may
> change and the old broken code (that we've been complicating all other
> code with), may actually become a hindrance to a new methodology.

Why so?  I would say the contrary: the existing code shows the actual
needs and how they can be implemented.  That's the usual "show me actual
code" question answered.

> Getting rid of the complications it adds to the core code, and let the
> core code become more simplified may actually end up being easier to
> add accessibility in the future, than keeping the old cruft around.

No, because it means it'll get hard to get something implemented again,
because actual implementation will have been dropped.

Samuel

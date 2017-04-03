From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 3 Apr 2017 16:09:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704031603160.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <87pogur0y9.fsf@firstfloor.org> <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr> <CAHp75VdgEcyXPxENS87nHLtCEHqB5Z-1_T_W1opSiKqqNpeU2A@mail.gmail.com> <20170403153103.GB22592@two.firstfloor.org>
 <20170403195756.xitzpei2knmwt3sx@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170403195756.xitzpei2knmwt3sx@angband.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
Cc: Andi Kleen <andi@firstfloor.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 3 Apr 2017, Adam Borowski wrote:

> On Mon, Apr 03, 2017 at 08:31:03AM -0700, Andi Kleen wrote:
> > Except for that (and possibly VT) it is unlikely that people really
> > rely on the obsolete terminal features from the 70ies. So it's a kind
> > of cleanup.
> 
> But... but... but what shall we do without OLCUC?!?
> 
> I guess sending these features to the pasture would be nice even in
> mainstream TTY.  Probably even without a Kconfig option to restore them.

Thing is... those arcane features don't take much code at all:

		if (O_OLCUC(tty))
			c = toupper(c);

That's it. I didn't make the minitty code 5x smaller just by omitting 
those.  ;-)


Nicolas

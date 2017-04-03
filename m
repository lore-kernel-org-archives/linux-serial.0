From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 3 Apr 2017 13:27:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704031304230.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <87pogur0y9.fsf@firstfloor.org> <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr> <CAHp75VdgEcyXPxENS87nHLtCEHqB5Z-1_T_W1opSiKqqNpeU2A@mail.gmail.com> <20170403153103.GB22592@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170403153103.GB22592@two.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 3 Apr 2017, Andi Kleen wrote:

> I like the idea of mintty (if it supported ptys).

In fact PTYs could probably be implemented like another UART driver for 
the master side.

But that may come later.

> Except for that (and possibly VT) it is unlikely that people really
> rely on the obsolete terminal features from the 70ies. So it's a kind
> of cleanup.

I wouldn't push for replacing the existing code though. It is stable and 
full featured. The mini version may well never be fully standard 
compliant to keep the code small.


Nicolas

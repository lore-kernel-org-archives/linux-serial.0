From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/3] serial: sh-sci: Add OF support
Date: Wed, 6 Mar 2013 10:28:22 +0000
Message-ID: <201303061028.23084.arnd@arndb.de>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com> <20130306005009.GF14275@linux-sh.org> <CABYn4szirgE7jy=49qCR3BuYd9jsWXJ=DrXeCqyuyGP0S2quiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CABYn4szirgE7jy=49qCR3BuYd9jsWXJ=DrXeCqyuyGP0S2quiQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wednesday 06 March 2013, Bastian Hecht wrote:
> 2013/3/6 Paul Mundt <lethal@linux-sh.org>:
> > No, we still need to figure out how to generate that baud rate, whether
> > it needs an internal or external clock for driving the rate, etc. The
> > frequency in and of itself doesn't provide this information, and various
> > parts use different algorithms for factoring the baud rate generator,
> > even varying across otherwise identical ports. It's unfortunately not
> > possible to infer anything about the SCBRR algorithm from port type or
> > specified baud rate.
> >
> > The algorithm IDs here are wholly arbitrary anyways, but are the
> > variations I came up with from roughly 60-70 different CPUs.

Ok, I see.

> So if we stick with the notion of the algrithm ID everything is settled now.
> 
> I will prepare a v6 that I will post as the whole patchset and an
> additional incremental patch 1/3 from v3 to v6 for Paul's repo. Then
> we can see if the SCBRR thing needs further discussion and if the rest
> of the patchset is final.

I can't think of anything better either, so let's stick to putting the
algorithm ID into the DT binding.

	Arnd

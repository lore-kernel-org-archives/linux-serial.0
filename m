From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial devices using DT
Date: Tue, 5 Mar 2013 19:22:02 +0000
Message-ID: <201303051922.02455.arnd@arndb.de>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com> <2835497.S76YK1KMLM@wuerfel> <CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tuesday 05 March 2013, Bastian Hecht wrote:
> 2013/3/4 Arnd Bergmann <arnd@arndb.de>:
> > On Monday 04 March 2013 17:20:54 Bastian Hecht wrote:
> >>
> >> +       sci@e6c40000 {
> >> +               compatible = "renesas,sci-SCIFA-uart";
> >> +               interrupt-parent = <&intca>;
> >> +               reg = <0xe6c40000 0x100>;
> >> +               interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
> >> +               cell-index = <0>;
> >> +               renesas,scscr = <0x30>;
> >> +               renesas,scbrr-algo-id = <4>;
> >> +               renesas,autoconf;
> >> +       };
> >
> > The default name for a uart is "serial", I would recommend sticking to
> > that by convention. You may also want to add an "aliases" node
> > somewhere, to define which port should get which logical device number
> > on a given board.
> 
> Switched to "...-serial".

I actually meant the name, not the "compatible" value. For compatible, either
version is fine with me. What I think you should change though is renaming
"sci@e6c40000" to "serial@e6c40000".

> About the aliases: Would I need to add that now, or can we postpone that?
> 

No hurry for that. It's just a feature that comes in very handy, but not
all platforms implement it.

	Arnd

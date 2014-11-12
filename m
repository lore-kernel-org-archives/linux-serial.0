From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 1/2] of: Fix crash if an earlycon driver is not found
Date: Wed, 12 Nov 2014 17:12:09 +0000
Message-ID: <20141112171209.672A3C41CF4@trevor.secretlab.ca>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
	<CAL_Jsq+iVfFGYEF575spQ5MaYPzo1QSfLUZP1M=TpH0+HdGS6A@mail.gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+iVfFGYEF575spQ5MaYPzo1QSfLUZP1M=TpH0+HdGS6A@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux-MIPS <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 10 Nov 2014 08:14:01 -0600
, Rob Herring <robh@kernel.org>
 wrote:
> On Sun, Nov 9, 2014 at 2:55 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> > __earlycon_of_table_sentinel.compatible is a char[128], not a pointer, so
> > it will never be NULL.  Checking it against NULL causes the match loop to
> > run past the end of the array, and eventually match a bogus entry, under
> > the following conditions:
> >
> >  - Kernel command line specifies "earlycon" with no parameters
> >  - DT has a stdout-path pointing to a UART node
> >  - The UART driver doesn't use OF_EARLYCON_DECLARE (or maybe the console
> >    driver is compiled out)
> >
> > Fix this by checking to see if match->compatible is a non-empty string.
> >
> > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> > Cc: <stable@vger.kernel.org> # 3.16+
> 
> Thanks. I'll queue this up.
> 
> BTW, you should not add stable CC when submitting for review, but
> rather add a note for the maintainer to apply to stable. Only if a
> commit is in mainline already and not flagged for stable, then you
> send the patch with the stable tag to get the commit added to stable.
> It's a bit confusing...


Oops, since you've picked it up I'll drop it from my tree. I'll let you
send the pull req to Linus.

g.

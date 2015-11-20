From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/25] serial: sh-sci: Add external clock and BRG Support
Date: Fri, 20 Nov 2015 16:50:06 +0200
Message-ID: <3985193.nXz0F4qod7@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <11872773.MUvOKIUXMO@avalon> <CAMuHMdVA60R_Cz=tLQzkBuM4yqZj=xRmnga807EV2CumqUhpyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVA60R_Cz=tLQzkBuM4yqZj=xRmnga807EV2CumqUhpyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On Friday 20 November 2015 10:07:31 Geert Uytterhoeven wrote:
> On Fri, Nov 20, 2015 at 9:58 AM, Laurent Pinchart wrote:
> > On Friday 20 November 2015 09:22:16 Geert Uytterhoeven wrote:
> >> On Thu, Nov 19, 2015 at 10:08 PM, Laurent Pinchart wrote:
> >>> Could you briefly explain (and even better in a source code comment)
> >>> how you handle baud rate calculation with the chained BRGs ?
> >> 
> >> I'll do that. Note that there's no chaining of BRGs, only muxing (so yes,
> >> it needs more clarification ;-).
> > 
> > Really ? I thought the BRG-EC was one possible input for the internal BRG
> > ? Does it bypass the internal BRG ? Or do you configure the internal BRG
> > to not divide the clock when using the BRG-EC ?
> 
> Yes, it's bypassed.
> 
> Cfr. SCSCR.CKE[1:0].
> '00' means internal BRG (although the docs state P divided by 1/4/16/64),
> '10' means SCK or SC_CLK (SCIF_CLK/INT_CLK).

That's indeed simpler. Could you capture the behaviour in a source code 
comment ?

-- 
Regards,

Laurent Pinchart

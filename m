From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 4/4] arm64: dts: r8a7796: salvator-x: add SCIF1
 (DEBUG1)
Date: Mon, 13 Feb 2017 14:05:32 +0100
Message-ID: <20170213130531.GE29718@verge.net.au>
References: <1486118300-12633-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1486118300-12633-5-git-send-email-ulrich.hecht+renesas@gmail.com>
 <20170208105426.GE26982@verge.net.au>
 <CAO3366ykrZnVCPGra6+Ba70+KA=ZrbBhuei0R7yULsQXMkdj+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO3366ykrZnVCPGra6+Ba70+KA=ZrbBhuei0R7yULsQXMkdj+Q@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, linux-serial@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 08, 2017 at 12:19:55PM +0100, Ulrich Hecht wrote:
> On Wed, Feb 8, 2017 at 11:54 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Feb 03, 2017 at 11:38:20AM +0100, Ulrich Hecht wrote:
> >> Enables the SCIF hooked up to the DEBUG1 connector.
> >>
> >> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Hi Ulrich,
> >
> > could you clarify the dependency of this patch on earlier ones in the
> > series. Is it safe to queue this up independently of the other patches?
> 
> It does not actually depend on the other patches. I think I included
> it here because I used that port for testing. Should be safe.

Thanks but I dont' seem to have scif1 in r8a7796.dtsi.
Should this patch be updated to use hscif1 which is (now) present in
r8a7796.dtsi?

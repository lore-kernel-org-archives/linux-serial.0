From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] sh-sci: add R8A7743/5 support
Date: Wed, 05 Oct 2016 17:10:16 +0300
Message-ID: <3079600.pjxVqDtBI9@avalon>
References: <2017044.9fZNuWa2OZ@wasted.cogentembedded.com> <7496008.sErWcihIz4@avalon> <SG2PR06MB1165204F1566A4B3B920F05B8AC40@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB1165204F1566A4B3B920F05B8AC40@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Chris,

On Wednesday 05 Oct 2016 13:50:18 Chris Brandt wrote:
> > There are 34 compatible strings defined, one per UART + SoC combination,
> > plus a set of more generic ones. So far, the driver handles the r7s72100
> > compatible string separately as the UART on that chip is quite peculiar,
> > but for all other SoCs we only need to match against
> 
> Just FYI...
> There are 2 different types of UARTS (SCI) on r7s72100: SCIF and SCI
> 
> Getting  the "SCI" ones to work takes some 'tweaking' of some registers in
> the interrupt controller that are outside of the scope of the SCI driver.
> Basically, the power on reset values for some IRQ signaling is wrong but
> can be adjusted with a register. At the moment, I've been fixing that in
> u-boot.
> 
> So in reality, a "renesas,sci-r7s72100" is probably needed too if you want
> to throw that one on the pile....

I'm totally fine adding compatible strings when it makes sense, what bothers 
me is a pile of compat strings to describe IP cores that are identical :-)

-- 
Regards,

Laurent Pinchart

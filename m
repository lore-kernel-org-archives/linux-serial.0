From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 01/25] serial: sh-sci: Update DT binding documentation for external clock input
Date: Thu, 19 Nov 2015 22:27:55 +0200
Message-ID: <2241755.f72hngpPkv@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <1447958344-836-2-git-send-email-geert+renesas@glider.be> <1756365.Ijac5ApxcA@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1756365.Ijac5ApxcA@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On Thursday 19 November 2015 22:19:14 Laurent Pinchart wrote:
> On Thursday 19 November 2015 19:38:40 Geert Uytterhoeven wrote:
> > Amend the DT bindings to include the optional external clock on
> > (H)SCI(F) and some SCIFA, where this pin can serve as a clock input,
> > depending on board wiring.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: devicetree@vger.kernel.org
> > ---
> > 
> >  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt index
> > 2c9e6b8477e92792..8efc9b6f35637fbb 100644
> > --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > 
> > @@ -43,6 +43,9 @@ Required properties:
> >    - clocks: Must contain a phandle and clock-specifier pair for each
> >    entry
> >    
> >      in clock-names.
> >    
> >    - clock-names: Must contain "fck" for the SCIx UART functional clock.
> > 
> > +    On (H)SCI(F) and some SCIFA, an additional clock may be specified:
> Could you list the SCIFA variants that support external clocks ?
> 
> > +      - "hsck" for the optional external clock input (on HSCIF),
> > +      - "sck" for the optional external clock input (on other variants).

Additionally, those clocks are used as inputs to the baud rate generator for 
external clocks, as the ones listed in patch 02/25 in this series. I'd merge 
the two patches and clarify the wording.

> >  Note: Each enabled SCIx UART should have an alias correctly numbered in
> >  the "aliases" node.

-- 
Regards,

Laurent Pinchart


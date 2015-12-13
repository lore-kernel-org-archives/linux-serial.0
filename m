From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 01/16] serial: sh-sci: Drop the interface clock
Date: Sat, 12 Dec 2015 22:42:37 -0800
Message-ID: <20151213064237.GA16326@kroah.com>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
 <1447958173-543-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447958173-543-2-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 19, 2015 at 07:35:58PM +0100, Geert Uytterhoeven wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> As no platform defines an interface clock the SCI driver always falls
> back to a clock named "peripheral_clk".
>   - On SH platforms that clock is the base clock for the SCI functional
>     clock and has the same frequency,
>   - On ARM platforms that clock doesn't exist, and clk_get() will return
>     the default clock for the device.
> We can thus make the functional clock mandatory and drop the interface
> clock.
> 
> EPROBE_DEFER is handled for clocks that may be referenced from DT (i.e.
> "fck" and deprecated "sci_ick").
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> [geert: Handle EPROBE_DEFER, reformat description, break long comment line]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

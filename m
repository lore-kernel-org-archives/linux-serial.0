From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] sh-sci: document R8A7743/5 support
Date: Sun, 30 Oct 2016 15:41:29 -0500
Message-ID: <20161030204129.3aimogcpr6p352uv@rob-hp-laptop>
References: <4258682.UW6HhKP1CC@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4258682.UW6HhKP1CC-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 21, 2016 at 11:00:43PM +0300, Sergei Shtylyov wrote:
> Renesas RZ/G SoC also have the SCIF, SCIFA, SCIFB, and HSCIF ports and
> they  seem compatible with the R-Car gen2 SoC  in this respect...
> Document RZ/G1[ME] (also known as R8A774[35]) SoC bindings.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
> Acked-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> 
> ---
> This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.
> 
> Changes in version 2:
> - removed the RZ/G  family specific bindings, renamed the patch;
> - added Simon's and Geert's ACKs.
> 
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt |    8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

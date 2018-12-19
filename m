From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] dt-bindings: serial: sh-sci: Document r8a774c0
 bindings
Date: Wed, 19 Dec 2018 08:25:35 +0100
Message-ID: <20181219072535.GA28473@kroah.com>
References: <1545134590-22510-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545134590-22510-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 18, 2018 at 12:03:10PM +0000, Fabrizio Castro wrote:
> RZ/G2E (R8A774C0) SoC also has the R-Car Gen3 compatible SCIF and
> HSCIF ports, so document the SoC specific bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v1->v2:
> * Fixed title according to Geert's comment
> 
> This patch depends on:
> https://patchwork.kernel.org/patch/10565543/

I don't have that patch in my tree, so can you please resend all of the
pending patches that you need applied so that I can?  Including this one
too.

thanks,

greg k-h

From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] serial: sh-sci: Document r8a774a1 bindings
Date: Wed, 15 Aug 2018 14:22:02 -0600
Message-ID: <20180815202202.GA12472@rob-hp-laptop>
References: <1534250042-15815-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534250042-15815-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 14 Aug 2018 13:34:02 +0100, Fabrizio Castro wrote:
> RZ/G2M (R8A774A1) SoC also has the R-Car Gen3 compatible SCIF and
> HSCIF ports, so document the SoC specific bindings. While at it,
> update the RZ/G1 and RZ/G2 family specific strings description as
> outdated.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  .../devicetree/bindings/serial/renesas,sci-serial.txt      | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

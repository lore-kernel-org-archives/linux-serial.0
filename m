From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH repost v2] serial: sh-sci: document R8A77970 bindings
Date: Mon, 4 Sep 2017 16:47:45 +0200
Message-ID: <20170904144742.GA4356@verge.net.au>
References: <20170901221519.704978317@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170901221519.704978317@cogentembedded.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Sep 02, 2017 at 01:15:13AM +0300, Sergei Shtylyov wrote:
> R-Car V3M (R8A77970) SoC also has the R-Car gen3 compatible SCIF and HSCIF
> ports, so document the SoC specific bindings.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.
> 
> Changes in version 2:
> - changed R8A7797 to R8A77970 everywhere;
> - rebased against the current branch.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

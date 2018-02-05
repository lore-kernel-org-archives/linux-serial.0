From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] DT: serial: renesas,sci-serial: document R8A77980
 bindings
Date: Mon, 5 Feb 2018 00:09:27 -0600
Message-ID: <20180205041307.n3wo7kfshc6swd3x@rob-hp-laptop>
References: <2182bb59-d16f-54f0-d992-65b49815ce1d@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2182bb59-d16f-54f0-d992-65b49815ce1d@cogentembedded.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 01, 2018 at 10:36:20PM +0300, Sergei Shtylyov wrote:
> R-Car V3H (R8A77980) SoC has the R-Car gen3 compatible SCIF and HSCIF ports,
> so document the SoC specific bindings.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt |    2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

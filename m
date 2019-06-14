From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: serial: 8250_omap: Add compatible for
 J721E UART controller
Date: Fri, 14 Jun 2019 10:45:55 -0600
Message-ID: <20190614164555.GA18636@bogus>
References: <20190522161921.20750-1-nm@ti.com>
 <20190522161921.20750-3-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190522161921.20750-3-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 22 May 2019 11:19:17 -0500, Nishanth Menon wrote:
> J721e uses a UART controller that is compatible with AM654 UART.
> Introduce a specific compatible to help handle the differences if
> necessary.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> NOTE:
>  - If Greg is ok, we can pick up the uart compatibility via the k3 tree,
>    else, I can spawn it off the series into it's own patch, but it
>    seemed better in a logical order.
> 
>  Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250_omap: Add compatible for
 AM654 UART controller
Date: Tue, 26 Jun 2018 15:12:53 -0600
Message-ID: <20180626211253.GA21853@rob-hp-laptop>
References: <20180619194450.6353-1-nm@ti.com>
 <20180619194450.6353-2-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619194450.6353-2-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Vignesh R <vigneshr@ti.com>, Jiri Slaby <jslaby@suse.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 19, 2018 at 02:44:49PM -0500, Nishanth Menon wrote:
> AM654 uses a UART controller that is only partially compatible with
> existing 8250 UART. UART DMA integration is substantially different
> and even a match against standard 8250 or omap4 would result in
> non-working UART once DMA is enabled by default.
> 
> Introduce a specific compatible to help build up the differences in
> follow on patches.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Acked-by: Rob Herring <robh@kernel.org>

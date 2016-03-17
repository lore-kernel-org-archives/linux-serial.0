From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/4] ARM: dts: r8a777[89]: HSCIF support
Date: Thu, 17 Mar 2016 14:54:08 +0900
Message-ID: <20160317055408.GA5345@verge.net.au>
References: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458148210-21800-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

thanks for posting this. It (and several other items you have posted
recently) have been on my todo list for a while.

I have looked over the patches and I agree that they appear to
match the documentation for the SoCs in question which in turn
appears to match the documentation for HSCIF on RCar Gen2.

I was also unable to find any obvious errors when I looked
at the node properties, mstp, irq and base address settings.

>From my point of view it would be best if the driver change (the last patch
in the series) could progress (via Greg) before the DT updates are merged
(most likely by me).

On Wed, Mar 16, 2016 at 06:10:06PM +0100, Ulrich Hecht wrote:
> Hi!
> 
> This adds HSCIF nodes to the r8a7778 and r8a7779 device trees.
> (And the relevant clocks on r8a7778, which are already there on r8a7779.)
> 
> CU
> Uli
> 
> 
> Ulrich Hecht (4):
>   ARM: dts: r8a7778: Add HSCIF0/1 clocks
>   ARM: dts: r8a7778: Add HSCIF0/1 device nodes
>   ARM: dts: r8a7779: Add HSCIF0/1 device nodes
>   serial: sh-sci: add r8a7778/9 HSCIF DT bindings
> 
>  .../bindings/serial/renesas,sci-serial.txt         |  2 ++
>  arch/arm/boot/dts/r8a7778.dtsi                     | 30 ++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7779.dtsi                     | 26 +++++++++++++++++++
>  include/dt-bindings/clock/r8a7778-clock.h          |  2 ++
>  4 files changed, 60 insertions(+)
> 
> -- 
> 2.6.4
> 

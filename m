From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 00/16] serial: sh-sci: Clock Cleanups
Date: Tue, 24 Nov 2015 11:44:05 +0900
Message-ID: <20151124024405.GE21853@verge.net.au>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 19, 2015 at 07:35:57PM +0100, Geert Uytterhoeven wrote:
> 	Hi,
> 
> The SCI driver currently handles two clocks, an interface clock named
> sci_ick and a functional clock named sci_fck. Studying the datasheets of
> the SH and ARM SoCs that incorportate (H)SCI(F)([AB]) instances showed
> (un)surprisingly that the hardware doesn't have a separate controllable
> interface clock.
> 
> All the platforms that declare an interface clock for the SCI set it to
> the clock used as the SCI functional clock. The two clocks can thus be
> merged on the driver side, which is what this patch series does. The
> resulting clock is called "fck", and all H8/300, SH and ARM users (both
> DT and non-DT) are fixed to name their SCI clocks appropriately.
> 
> Support for the "sci_ick" name is kept in the sh-sci driver to ensure DT
> backward compatibility, and support for the "peripheral_clk" clock to
> not break SH platforms that don't declare device-specific SCI clocks.
> The latter can be removed when all SH platforms will declare their SCI
> clocks properly.
> 
> This series serves as a preparatory clock cleanup for the SCI baud rate
> generator clock support series. I decided to keep it separate as this
> series has more stringent internal dependencies:
>   - The SH patches 2-3 depend on patch 1,
>   - The DT patches 4-15 depend on patch 1,
>   - Cleanup patch 16 depends on SH patch 2.
> 
> Thanks for your comments!
> 
> Changes compared to v1:
>   - Take over the patches from Laurent,
>   - Add Acked-by,
>   - Handle EPROBE_DEFER,
>   - Add missing patches to convert r8a7795 and h8300.
> 
> Geert Uytterhoeven (2):
>   arm64: renesas: r8a7795 dtsi: Rename the serial port clock to fck
>   h8300: dts: Rename the serial port clock to fck
> 
> Laurent Pinchart (14):
>   serial: sh-sci: Drop the interface clock
>   sh: Rename sci_ick and sci_fck clock to fck
>   sh: Remove sci_ick clock alias
>   ARM: shmobile: sh73a0 dtsi: Rename the serial port clock to fck
>   ARM: shmobile: r7s72100 dtsi: Rename the serial port clock to fck
>   ARM: shmobile: r8a73a4 dtsi: Rename the serial port clock to fck
>   ARM: shmobile: r8a7740 dtsi: Rename the serial port clock to fck
>   ARM: shmobile: r8a7778 dtsi: Rename the serial port clock to fck
>   ARM: shmobile: r8a7779 dtsi: Rename the serial port clock to fck
>   ARM: shmobile: r8a7790 dtsi: Rename the serial port clock to fck
>   ARM: shmobile: r8a7791 dtsi: Rename the serial port clock to fck
>   ARM: shmobile: r8a7793 dtsi: Rename the serial port clock to fck
>   ARM: shmobile: r8a7794 dtsi: Rename the serial port clock to fck
>   serial: sh-sci: Drop the sci_fck clock fallback

I have marked the above shmobile patches as deferred pending
the binding changes being accepted.

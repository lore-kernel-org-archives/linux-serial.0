From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/4] serial: sh-sci: Add DMA support to the DT binding
Date: Mon, 25 May 2015 10:04:39 +0900
Message-ID: <20150525010438.GC24690@verge.net.au>
References: <1432143987-10308-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432143987-10308-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On Wed, May 20, 2015 at 07:46:23PM +0200, Geert Uytterhoeven wrote:
> 	Hi Greg, Simon, Magnus,
> 
> This patch series adds DMA support to the DT binding documentation for
> the various Renesas (H)SCI(F{,A,B}) serial ports, and adds the
> corresponding properties to the Renesas R-Car Gen2 DT source files.
> 
>   - Patch 1 updates the DT binding documentation.
>   - Patches 2-4 update the dtsi files.
> 
> Although the sh-sci driver itself doesn't support DT DMA properties
> yet, it's safe to apply patches 2-4, as DT describes the hardware, not
> the (current) features of the Linux driver implementation.

I would prefer for the new binding (documentation) to be accepted before
updating the DT files.

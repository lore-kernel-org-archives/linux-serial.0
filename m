From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 04/27] serial: sh-sci: Update DT binding documentation
 for BRG support
Date: Sat, 19 Dec 2015 21:39:38 -0600
Message-ID: <20151220033938.GN9883@rob-hp-laptop>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
 <1450119456-964-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450119456-964-5-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 14, 2015 at 07:57:13PM +0100, Geert Uytterhoeven wrote:
> Amend the DT bindings to include the optional clock sources for the Baud
> Rate Generator for External Clock (BRG), as found on some SCIF variants
> and on HSCIF.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: devicetree@vger.kernel.org
> ---
> v3:
>   - Add Acked-by,
>   - Rename "int_clk" to "brg_int".
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

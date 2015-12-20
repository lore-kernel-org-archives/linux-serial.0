From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 03/27] serial: sh-sci: Update DT binding documentation
 for external clock input
Date: Sat, 19 Dec 2015 21:39:29 -0600
Message-ID: <20151220033929.GL9883@rob-hp-laptop>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
 <1450119456-964-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450119456-964-4-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 14, 2015 at 07:57:12PM +0100, Geert Uytterhoeven wrote:
> Amend the DT bindings to include the optional external clock on
> (H)SCI(F) and some SCIFA, where this pin can serve as a clock input,
> depending on board wiring.
> 
> Clarify the use of the divided functional clock as a source for the
> sampling clock.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: devicetree@vger.kernel.org
> ---
> v3:
>   - Add Acked-by,
>   - Clarify the use of the divided functional clock.
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

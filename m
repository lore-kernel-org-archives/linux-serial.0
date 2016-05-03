From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 02/11] serial: sh-sci: Update DT binding documentation
 for dedicated RTS/CTS
Date: Tue, 3 May 2016 13:01:57 -0500
Message-ID: <20160503180156.GA3536@rob-hp-laptop>
References: <1461934714-18681-1-git-send-email-geert+renesas@glider.be>
 <1461934714-18681-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461934714-18681-3-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 29, 2016 at 02:58:25PM +0200, Geert Uytterhoeven wrote:
> Some Renesas SCIF UARTs have dedicated lines for RTS/CTS hardware flow
> control.  Whether these lines exist depends on SoC and UART instance
> inside the SoC.  Whether these lines can be used for hardware flow
> control depends on board wiring.
> 
> Amend the DT bindings with an optional property to indicate that RTS/CTS
> hardware flow control lines exist, and can be used as such, according to
> the Generic Serial DT Bindings.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> ---
> v2:
>   - Drop RFC status,
>   - Use "uart-has-rtscts" instead of "renesas,uart-has-rtscts",
>   - Refer to the Generic Serial DT Bindings.
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

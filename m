From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] Documentation: dt: serial: Add TX FIFO load size
Date: Fri, 16 Sep 2016 14:19:08 -0500
Message-ID: <20160916191908.GA30710@rob-hp-laptop>
References: <1473351141-9239-1-git-send-email-tthayer@opensource.altera.com>
 <1473351141-9239-2-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473351141-9239-2-git-send-email-tthayer@opensource.altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tthayer@opensource.altera.com
Cc: gregkh@linuxfoundation.org, mark.rutland@arm.com, lftan@altera.com, jslaby@suse.com, arnd@arndb.de, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, yegorslists@googlemail.com, matwey@sai.msu.ru, mail@maciej.szmigiero.name, peter.ujfalusi@ti.com, jonathanh@nvidia.com, dongsheng.wang@nxp.com, luis@debethencourt.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, tthayer.linux@gmail.com, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 08, 2016 at 11:12:18AM -0500, tthayer@opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree bindings needed to support the TX FIFO
> load size.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
> index f5561ac..93de5ef 100644
> --- a/Documentation/devicetree/bindings/serial/8250.txt
> +++ b/Documentation/devicetree/bindings/serial/8250.txt
> @@ -45,6 +45,7 @@ Optional properties:
>  - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
>    line respectively. It will use specified GPIO instead of the peripheral
>    function pin for the UART feature. If unsure, don't specify this property.
> +- tx-loadsz: the number of bytes that can be loaded into the TX FIFO.

It seems you don't really need to know the loadsz, but just need the 
threshold trigger level. So just use that directly. And please check if 
any other UARTs have threshold properties. i.MX has programmable 
thresholds.

Rob

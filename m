From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 08/11] dt-bindings: serial: Document RDA Micro UART
Date: Tue, 18 Dec 2018 08:54:43 -0600
Message-ID: <20181218145443.GA5150@bogus>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
 <20181218080527.10801-9-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218080527.10801-9-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: olof@lixom.net, arnd@arndb.de, gregkh@linuxfoundation.org, jslaby@suse.com, linux-unisoc@lists.infradead.org, afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 18, 2018 at 01:35:24PM +0530, Manivannan Sadhasivam wrote:
> From: Andreas Färber <afaerber@suse.de>
> 
> Add an initial binding for the UART in RDA Micro RDA8810PL SoC.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt

Please add acks/reviewed-bys when posting new versions.

Rob

From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/6] tty: serial: msm: Add TX DMA support
Date: Wed, 30 Sep 2015 18:32:01 +0100
Message-ID: <20150930173201.GB745@leverpostej>
References: <1443614906-2196-1-git-send-email-ivan.ivanov@linaro.org>
 <1443614906-2196-5-git-send-email-ivan.ivanov@linaro.org>
 <20150930132919.GI10997@leverpostej>
 <1443621086.2412.11.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443621086.2412.11.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frank.rowand@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Sep 30, 2015 at 02:51:26PM +0100, Ivan T. Ivanov wrote:
> 
> On Wed, 2015-09-30 at 14:29 +0100, Mark Rutland wrote:
> > On Wed, Sep 30, 2015 at 01:08:24PM +0100, Ivan T. Ivanov wrote:
> > > Add transmit DMA support for UARTDM type of controllers.
> > > 
> > > Tested on APQ8064, which have UARTDM v1.3 and ADM DMA engine
> > > and APQ8016, which have UARTDM v1.4 and BAM DMA engine.
> > > 
> > > Signed-off-by: Ivan T. Ivanov ivanov@linaro.org>
> > > ---
> > >  .../devicetree/bindings/serial/qcom,msm-uartdm.txt |   3 +
> > >  drivers/tty/serial/msm_serial.c                    | 312 +++++++++++++++++++--
> > >  drivers/tty/serial/msm_serial.h                    |   3 +
> > >  3 files changed, 294 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> > > index a2114c217376..a600023d9ec1 100644
> > > --- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> > > +++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> > > @@ -26,6 +26,9 @@ Required properties:
> > >  Optional properties:
> > >  - dmas: Should contain dma specifiers for transmit and receive channels
> > >  - dma-names: Should contain "tx" for transmit and "rx" for receive channels
> > > +- qcom,tx-crci: Identificator <u32> for Client Rate Control Interface to be
> > > +           used with TX DMA channel. Required when using DMA for transmission
> > > +           with UARTDM v1.3 and bellow.
> > 
> > This sounds like it belongs in the dma-specifier, and dealt with by the
> > DMA controller driver.
> > 
> > Why does the UART driver need to know about this?
> 
> CRCI information was part of the first version of ADM DMA engine driver
> bindings, but Andy remove it because some client devices are requiring
> more that one CRCI number. See here[1] and here [2].
> 
> Regards,
> Ivan
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314190.html
> [2] https://lkml.org/lkml/2015/8/19/19

This leaves me more confused. If different writes from the same agent
are being distinguished then it sounds like you actually have two
logical DMA channels.

Could you elaborate on the qcom,ebi2-nand binding? From a brief read I'd
expect you to have "txrx" and "cmd" dmas, rather than describing the
CRCI information on the side.

Mark.

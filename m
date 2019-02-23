From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
Date: Fri, 22 Feb 2019 18:26:55 -0600
Message-ID: <20190223002655.GA6631@bogus>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
 <20190123170758.GB512@tuxbook-pro>
 <5ca1ce61-c458-5550-f89d-ab361f1ec456@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5ca1ce61-c458-5550-f89d-ab361f1ec456@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Alok Chauhan <alokc@codeaurora.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>, dianders@chromium.org, swboyd@chromium.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 23, 2019 at 08:41:20PM +0200, Georgi Djakov wrote:
> Hi,
> 
> On 1/23/19 19:07, Bjorn Andersson wrote:
> > On Mon 21 Jan 22:33 PST 2019, Alok Chauhan wrote:
> > 
> >> Add documentation for the interconnect and interconnect-names bindings
> >> for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.
> >>
> >> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> >> ---
> >>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> >> index dab7ca9..44d7e02 100644
> >> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> >> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> >> @@ -17,6 +17,12 @@ Required properties if child node exists:
> >>  - #address-cells: 	Must be <1> for Serial Engine Address
> >>  - #size-cells: 		Must be <1> for Serial Engine Address Size
> >>  - ranges: 		Must be present
> >> +- interconnects:	phandle to a interconnect provider. Please refer
> >> +			../interconnect/interconnect.txt for details.
> >> +			Must be 2 paths corresponding to 2 AXI ports.
> >> +- interconnect-names:	Port names to differentiate between the
> > 
> > s/Port names/Path names/
> > 
> >> +			2 interconnect paths defined with interconnect
> >> +			specifier.
> > 
> > These two names are significant in that they must match what the driver
> > expects, hence you must actually specify them here.
> > 
> > And as the scope of these strings are local to the QUP node you can omit
> > "qup" from them, so make them "memory" and "config" (or perhaps iface,
> > to match the clock naming?).
> 
> Actually there was a discussion in the past where we decided include
> both the src and dst endpoint names in this property so that there is
> some symmetry with the "interconnects" property. It would be nice to be
> consistent across different drivers at least for now.
> If we want to denote the master and slave ports here, my two cents would
> be for "qup-mem" and "cpu-qup" or something similar?

Well, there's a proposal from Maxime to add 'dma-memory' or something. 
You all need to sort this out.

I assume config or cpu-qup is for register access? Why is this needed? 
That should get described thru the DT tree. The interconnect stuff was 
supposed to be for the non-cpu centric view (i.e. DMA masters). Maybe 
it's fine, but that's not my initial reaction.

Rob

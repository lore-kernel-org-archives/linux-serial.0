From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
Date: Mon, 25 Feb 2019 19:39:34 +0200
Message-ID: <9318130e-0c2c-c1c1-6ad1-b8bc8ec0c223@linaro.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
 <20190123170758.GB512@tuxbook-pro>
 <5ca1ce61-c458-5550-f89d-ab361f1ec456@linaro.org>
 <20190223002655.GA6631@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190223002655.GA6631@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Alok Chauhan <alokc@codeaurora.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>, dianders@chromium.org, swboyd@chromium.org
List-Id: linux-serial@vger.kernel.org

On 2/23/19 02:26, Rob Herring wrote:
> On Wed, Jan 23, 2019 at 08:41:20PM +0200, Georgi Djakov wrote:
>> Hi,
>>
>> On 1/23/19 19:07, Bjorn Andersson wrote:
>>> On Mon 21 Jan 22:33 PST 2019, Alok Chauhan wrote:
>>>
>>>> Add documentation for the interconnect and interconnect-names bindings
>>>> for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.
>>>>
>>>> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>>> index dab7ca9..44d7e02 100644
>>>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>>> @@ -17,6 +17,12 @@ Required properties if child node exists:
>>>>  - #address-cells: 	Must be <1> for Serial Engine Address
>>>>  - #size-cells: 		Must be <1> for Serial Engine Address Size
>>>>  - ranges: 		Must be present
>>>> +- interconnects:	phandle to a interconnect provider. Please refer
>>>> +			../interconnect/interconnect.txt for details.
>>>> +			Must be 2 paths corresponding to 2 AXI ports.
>>>> +- interconnect-names:	Port names to differentiate between the
>>>
>>> s/Port names/Path names/
>>>
>>>> +			2 interconnect paths defined with interconnect
>>>> +			specifier.
>>>
>>> These two names are significant in that they must match what the driver
>>> expects, hence you must actually specify them here.
>>>
>>> And as the scope of these strings are local to the QUP node you can omit
>>> "qup" from them, so make them "memory" and "config" (or perhaps iface,
>>> to match the clock naming?).
>>
>> Actually there was a discussion in the past where we decided include
>> both the src and dst endpoint names in this property so that there is
>> some symmetry with the "interconnects" property. It would be nice to be
>> consistent across different drivers at least for now.
>> If we want to denote the master and slave ports here, my two cents would
>> be for "qup-mem" and "cpu-qup" or something similar?
> 
> Well, there's a proposal from Maxime to add 'dma-memory' or something. 
> You all need to sort this out.

Agree. I haven't commented on the latest MBUS patches yet. Meanwhile i
am trying to get a better understanding of the hardware. In general if
there are no better suggestions, i am fine with adding a specific name
to handle this kind of dma transfers.

> I assume config or cpu-qup is for register access? Why is this needed? 
> That should get described thru the DT tree. The interconnect stuff was 
> supposed to be for the non-cpu centric view (i.e. DMA masters). Maybe 
> it's fine, but that's not my initial reaction.

Yes, cpu-qup should be for register access. Alok, please correct me if i
am wrong, but I believe this is a separate bus used only for
configuration access to some HW blocks. This bus might be disabled by
default and we may need to request some bandwidth in order to enable it.
It's described as a separate path in DT and we are trying to give it a
meaningful name.

Thanks,
Georgi

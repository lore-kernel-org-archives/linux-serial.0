From: Karthik Ramasubramanian <kramasub@codeaurora.org>
Subject: Re: [PATCH RFC 4/7] i2c: Add device tree bindings for GENI I2C
 Controller
Date: Fri, 12 Jan 2018 14:35:37 -0700
Message-ID: <b34e59e5-9961-99fd-e2b7-0208f6daf017@codeaurora.org>
References: <1514392046-30602-1-git-send-email-kramasub@codeaurora.org>
 <1514392046-30602-5-git-send-email-kramasub@codeaurora.org>
 <20180102155149.f2wzjvdhoi6cne4x@rob-hp-laptop>
 <1d741169-e6e6-1896-d8d4-4f580f5d497d@codeaurora.org>
 <CAL_Jsq+2w280okNbUxVqzm2oXWRc81RnMwBaM6utXqg_+fvMkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+2w280okNbUxVqzm2oXWRc81RnMwBaM6utXqg_+fvMkg@mail.gmail.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sagar Dharia <sdharia@codeaurora.org>
List-Id: linux-serial@vger.kernel.org



On 1/11/2018 8:19 AM, Rob Herring wrote:
> On Mon, Jan 8, 2018 at 6:33 PM, Karthik Ramasubramanian
> <kramasub@codeaurora.org> wrote:
>>
>>
>> On 1/2/2018 8:51 AM, Rob Herring wrote:
>>>
>>> On Wed, Dec 27, 2017 at 09:27:23AM -0700, Karthikeyan Ramasubramanian
>>> wrote:
>>>>
>>>> Add device tree binding support for I2C Controller in GENI based
>>>> QUP Wrapper.
>>>>
>>>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>>>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
>>>> ---
>>>>    .../devicetree/bindings/i2c/i2c-qcom-geni.txt      | 39
>>>> ++++++++++++++++++++++
>>>>    1 file changed, 39 insertions(+)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
>>>> b/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
>>>> new file mode 100644
>>>> index 0000000..d2fa9ce
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-qcom-geni.txt
>>>> @@ -0,0 +1,39 @@
>>>> +Qualcomm Technologies Inc. GENI based I2C Controller driver
>>>> +
>>>> +Required properties:
>>>> + - compatible: Should be:
>>>> +   * "qcom,i2c-geni.
>>>
>>>
>>> Only 1 version?
>>
>> The Serial Engine used by I2C protocol has the same version as the QUP h/w
>> version. The QUP Wrapper driver exposes an interface function to get the h/w
>> version so that I2C controller driver can support version-specific
>> operations, if any.
>>>
>>>
>>>> + - reg: Should contain QUP register address and length.
>>>> + - interrupts: Should contain I2C interrupt.
>>>> + - clocks: Serial engine core clock, and AHB clocks needed by the
>>>> device.
>>>
>>>
>>> Are there really clocks for a firmware based device or these are just
>>> clocks in the parent serial engine?
>>
>> The clocks are required to derive the protocol clock. The clocks are also
>> required by the Serial Engine to access the System Memory during DMA mode of
>> operation.
> 
> You can get the QUP core (or Serial engine?) node and then get its
> clocks if you need to know the frequency. Put the clocks in DT in the
> h/w block they belong to. If you don't really have an I2C clock in the
> h/w, don't put one in the DT.
> 
The clocks that are used to access the System Memory are common to all 
the Serial Engines in the QUP Wrapper. I will move those clock 
definitions to the QUP core node. The clock that is used to derive the 
protocol clock is Serial Engine specific. Since the serial engine DT 
node is synonymous with the protocol with which it is programmed, I am 
defining that clock in the child node i.e. protocol controller block.
> Rob
> 
Regards,
Karthik.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

From: Karthik Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH RFC 6/7] serial: Add device tree bindings for GENI based
 UART Controller
Date: Fri, 12 Jan 2018 14:24:31 -0700
Message-ID: <51610a55-7198-a0ff-4dae-4b4b2922e865@codeaurora.org>
References: <1514392046-30602-1-git-send-email-kramasub@codeaurora.org>
 <1514392046-30602-7-git-send-email-kramasub@codeaurora.org>
 <20180102155517.j4sqhdtamybtgta4@rob-hp-laptop>
 <068baf4d-963e-f177-311d-d2c76d27a6f9@codeaurora.org>
 <CAL_JsqL1=NAn1T_HaetO5hT+fdgxmkcNwtOr1+XaxGzSh-n6Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqL1=NAn1T_HaetO5hT+fdgxmkcNwtOr1+XaxGzSh-n6Sg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org



On 1/11/2018 8:12 AM, Rob Herring wrote:
> On Tue, Jan 9, 2018 at 12:36 PM, Karthik Ramasubramanian
> <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>
>>
>> On 1/2/2018 8:55 AM, Rob Herring wrote:
>>>
>>> On Wed, Dec 27, 2017 at 09:27:25AM -0700, Karthikeyan Ramasubramanian
>>> wrote:
>>>>
>>>> Add device tree binding support for GENI based UART Controller in the
>>>> QUP Wrapper.
>>>>
>>>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>> Signed-off-by: Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>> ---
>>>>    .../devicetree/bindings/serial/qcom,geni-uart.txt  | 31
>>>> ++++++++++++++++++++++
>>>>    1 file changed, 31 insertions(+)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
>>>> b/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
>>>> new file mode 100644
>>>> index 0000000..e60ec6a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/serial/qcom,geni-uart.txt
>>>> @@ -0,0 +1,31 @@
>>>> +Qualcomm Technologies Inc. GENI based Serial UART Controller driver
>>>> +
>>>> +This serial UART driver supports console use-cases. This driver is meant
>>>> +only for Generic Interface (GENI) based Qualcomm Universal Peripheral
>>>> (QUP)
>>>> +cores and isn't backwards compatible.
>>>> +
>>>> +Required properties:
>>>> +- compatible: should contain "qcom,geni-uart, qcom,geni-console"
>>>
>>>
>>> Is console different programming model or just how you are using the
>>> h/w? for the latter, drop it as we have stdout-path to select a console.
>>
>> The console programming model is different from a regular UART port and
>> hence the compatible field contains console in it.
> 
> And "console" is what the h/w reference manual calls it? If so, then
> it is fine. If not, sounds like a Linuxism.
>The hardware reference manual calls it Debug UART. I can change the 
compatible string to contain "qcom,geni-debug-uart".
> Rob
Regards,
Karthik.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

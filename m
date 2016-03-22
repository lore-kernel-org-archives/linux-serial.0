From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 2/2] serial: amba-pl011: complete support to ZTE uart
Date: Mon, 21 Mar 2016 20:55:52 -0500
Message-ID: <56F0A628.2080607@codeaurora.org>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
 <1457920282-14823-2-git-send-email-jun.nie@linaro.org>
 <56F05C16.1030805@codeaurora.org>
 <CABymUCNKOgdLBLr2fZ4KhwmG+R4Zm-LHnfDppV-yiwUjRH4Nyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABymUCNKOgdLBLr2fZ4KhwmG+R4Zm-LHnfDppV-yiwUjRH4Nyg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Nie <jun.nie@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, G Gregory <graeme.gregory@linaro.org>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Jun Nie wrote:
> 2016-03-22 4:39 GMT+08:00 Timur Tabi <timur@codeaurora.org>:
>> Jun Nie wrote:
>>>
>>> @@ -2570,9 +2608,17 @@ static int pl011_uart_plat_probe(struct
>>> platform_device *pdev)
>>>          if (!uap)
>>>                  return -ENOMEM;
>>>
>>> +       uap->clk = devm_clk_get(&pdev->dev, NULL);
>>> +       if (IS_ERR(uap->clk))
>>> +               return PTR_ERR(uap->clk);
>>> +
>>
>>
>> I don't this is supposed to be part of your patch, and it breaks my ACPI
>> platform anyway.  Where did it come from?
>>
> Is it OK to move to device tree part, I mean if (pdev->dev.of_node)
> clause? It is part of my patch, I am not aware ACPI requirement on
> this.

But this is not restricted to the ZTE platform.  Your patch says, 
"compete support to ZTE uart" (maybe you should reword that to "add 
support for ZTE UARTs").  However, this change affects ALL platforms. 
If you move it to the device tree part, it will affect ALL device tree 
platforms.  That's not "adding ZTE support".

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.

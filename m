From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH 2/2] serial: amba-pl011: complete support to ZTE uart
Date: Tue, 22 Mar 2016 09:16:13 +0800
Message-ID: <CABymUCNKOgdLBLr2fZ4KhwmG+R4Zm-LHnfDppV-yiwUjRH4Nyg@mail.gmail.com>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
 <1457920282-14823-2-git-send-email-jun.nie@linaro.org>
 <56F05C16.1030805@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56F05C16.1030805@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, G Gregory <graeme.gregory@linaro.org>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

2016-03-22 4:39 GMT+08:00 Timur Tabi <timur@codeaurora.org>:
> Jun Nie wrote:
>>
>> @@ -2570,9 +2608,17 @@ static int pl011_uart_plat_probe(struct
>> platform_device *pdev)
>>         if (!uap)
>>                 return -ENOMEM;
>>
>> +       uap->clk = devm_clk_get(&pdev->dev, NULL);
>> +       if (IS_ERR(uap->clk))
>> +               return PTR_ERR(uap->clk);
>> +
>
>
> I don't this is supposed to be part of your patch, and it breaks my ACPI
> platform anyway.  Where did it come from?
>
Is it OK to move to device tree part, I mean if (pdev->dev.of_node)
clause? It is part of my patch, I am not aware ACPI requirement on
this.

Jun
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum, a Linux Foundation collaborative project.

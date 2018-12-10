From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 08/15] irqchip: Add RDA8810PL interrupt driver
Date: Mon, 10 Dec 2018 10:10:07 +0000
Message-ID: <c8540623-aa98-3850-8dfc-df244fa7630d@arm.com>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-9-manivannan.sadhasivam@linaro.org>
 <9debdd34-0c4a-a0a3-a284-b6372c2f7fd5@arm.com>
 <20181210095650.GA12397@Mani-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210095650.GA12397@Mani-XPS-13-9360>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, overseas.sales@unisoc.com
List-Id: linux-serial@vger.kernel.org

On 10/12/2018 09:56, Manivannan Sadhasivam wrote:
> Hi Marc,
> 
> On Mon, Dec 10, 2018 at 09:39:13AM +0000, Marc Zyngier wrote:
>> On 28/11/2018 13:50, Manivannan Sadhasivam wrote:
>>> Add interrupt driver for RDA Micro RDA8810PL SoC.
>>>
>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Given the dependency on the platform Kconfig entry, how do you want this
>> to be merged?
>>
> 
> Hmmm, I think I can just move the platform Kconfig change to SoC changes
> in next revision so that you can apply the driver independently.
That would work for me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

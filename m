From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v6 1/6] irqchip/mtk-sysirq: support 4 interrupt parameters
 for sysirq
Date: Thu, 7 Feb 2019 15:52:27 +0000
Message-ID: <c0187acf-bd8c-2d41-d84d-d35fc63b2beb@arm.com>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-2-git-send-email-erin.lo@mediatek.com>
 <898ca3d9-002b-e28e-fc97-86bc2538e9de@gmail.com>
 <626b5b46-aac7-1532-386e-2fed85bf4ad9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <626b5b46-aac7-1532-386e-2fed85bf4ad9@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Erin Lo <erin.lo@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, Seiya Wang <seiya.wang@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On 07/02/2019 15:47, Marc Zyngier wrote:
> On 07/02/2019 15:20, Matthias Brugger wrote:
>>
>>
>> On 24/01/2019 09:07, Erin Lo wrote:
>>> From: Seiya Wang <seiya.wang@mediatek.com>
>>>
>>> To support partitioned PPIs, 4 interrupt parameters should be valid
>>> for sysirq.
>>>
>>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
>>> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
>>> ---
>>>  drivers/irqchip/irq-mtk-sysirq.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
>>> index 90aaf19..282736a 100644
>>> --- a/drivers/irqchip/irq-mtk-sysirq.c
>>> +++ b/drivers/irqchip/irq-mtk-sysirq.c
>>> @@ -81,7 +81,7 @@ static int mtk_sysirq_domain_translate(struct irq_domain *d,
>>>  				       unsigned int *type)
>>>  {
>>>  	if (is_of_node(fwspec->fwnode)) {
>>> -		if (fwspec->param_count != 3)
>>> +		if (fwspec->param_count != 3 && fwspec->param_count != 4)
>>
>> Where is this 4th parameter used?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt#n14
Sorry, I fired Send way too early.

What I wanted to add is that it is not clear to me why this change would
be required here, as this driver only supports SPIs. It could be fixed
by just relaxing the binding itself.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

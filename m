From: Seiya Wang <seiya.wang@mediatek.com>
Subject: Re: [PATCH v6 1/6] irqchip/mtk-sysirq: support 4 interrupt
 parameters for sysirq
Date: Mon, 11 Feb 2019 14:35:29 +0800
Message-ID: <1549866929.22817.20.camel@mtksdccf07>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-2-git-send-email-erin.lo@mediatek.com>
 <898ca3d9-002b-e28e-fc97-86bc2538e9de@gmail.com>
 <626b5b46-aac7-1532-386e-2fed85bf4ad9@arm.com>
 <c0187acf-bd8c-2d41-d84d-d35fc63b2beb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c0187acf-bd8c-2d41-d84d-d35fc63b2beb@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, srv_heupstream <srv_heupstream@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Erin Lo <erin.lo@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, mars.cheng@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Thomas Gleixner <tglx@linutronix.de>, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2019-02-07 at 15:52 +0000, Marc Zyngier wrote:
> On 07/02/2019 15:47, Marc Zyngier wrote:
> > On 07/02/2019 15:20, Matthias Brugger wrote:
> >>
> >>
> >> On 24/01/2019 09:07, Erin Lo wrote:
> >>> From: Seiya Wang <seiya.wang@mediatek.com>
> >>>
> >>> To support partitioned PPIs, 4 interrupt parameters should be valid
> >>> for sysirq.
> >>>
> >>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> >>> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> >>> ---
> >>>  drivers/irqchip/irq-mtk-sysirq.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> >>> index 90aaf19..282736a 100644
> >>> --- a/drivers/irqchip/irq-mtk-sysirq.c
> >>> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> >>> @@ -81,7 +81,7 @@ static int mtk_sysirq_domain_translate(struct irq_domain *d,
> >>>  				       unsigned int *type)
> >>>  {
> >>>  	if (is_of_node(fwspec->fwnode)) {
> >>> -		if (fwspec->param_count != 3)
> >>> +		if (fwspec->param_count != 3 && fwspec->param_count != 4)
> >>
> >> Where is this 4th parameter used?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt#n14
> Sorry, I fired Send way too early.
> 
> What I wanted to add is that it is not clear to me why this change would
> be required here, as this driver only supports SPIs. It could be fixed
> by just relaxing the binding itself.
> 
> Thanks,
> 
> 	M.

Do you mean that we should change #interrupt-cells back to 3 for sysirq
and remove the 4th parameters of every spi interrupts in mt8183.dtsi
(i.e. 3 parameters for spi, 4 for ppi) such that we can discard this
patch?

If yes, we may need some time to verify the change before resending the
patch.

Thanks.

From: Mars Cheng <mars.cheng@mediatek.com>
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add mt6765 support
Date: Thu, 12 Jul 2018 08:06:17 +0800
Message-ID: <1531353977.25499.9.camel@mtkswgap22>
References: <1531116302-29921-1-git-send-email-mars.cheng@mediatek.com>
 <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
 <7fb13f45-4e33-6efc-467b-c7256a40cbc9@gmail.com>
 <d439eb7d-6365-7a0a-2969-1ddecc51defc@arm.com>
 <1531177443.7777.18.camel@mtkswgap22>
 <7a3becb3-510b-5763-5b66-5e14ebf7c974@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7a3becb3-510b-5763-5b66-5e14ebf7c974@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, CC Hwang <cc.hwang@mediatek.com>, wsd_upstream@mediatek.com, Marc Zyngier <marc.zyngier@arm.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Matthias

On Tue, 2018-07-10 at 12:52 +0200, Matthias Brugger wrote:
> 
> On 10/07/18 01:04, Mars Cheng wrote:
[...]

> > pmic/pwrap/i2c/rtc/kpd/spi/wdt/cqdma/auxadc/pwm/cmdq/disp. We have
> > dedicated owners to handle them and will cowork tightly with members to
> > make sure things happen in the following weeks.
> > 
> 
> Ok, so let's wait until pinctrl driver is submitted. I'd prefer if you could add
> the clk driver to this series. This way we can get rid of the dummy clocks in
> the device tree.
> 

Got it, I will submit this series with clk support in v5. and pinctrl
after that.

> > For previous chips, we did have no enough support after shell. It is due
> > to fast pace of smartphone SoC and other resource issues. We also know
> > that is no excuse so that we already confirmed owners and their
> > schedules for mt6765.
> > 
> > If there is any suggestion, please let us know.
> > 
> 
> I know that smartphone SoC is a fast paced business. Never the less I'm
> convinced that the basic building blocks won't change much from one version to
> another. And that mainline support for the previous version of your SoC will
> help you to get your new drivers faster upstream.
> 
> For me the best example is the mt7622 which got to a reasonable upstream support
> quite fast, thanks to a good foundation of mt7623 in mainline. I'd love to see
> that happen on the smartphone SoCs as well.
> 
> Not to mention that upstream support will help you internally when you have to
> rebase your BSP code-base to a new kernel version.
> 
> That said I think it is good news that you have already defined owner for the
> different devices and hope to see submissions for them in the near future :)
> As a suggestion I would say that upstream submission takes time and effort and
> it will help your engineers if they can allocate some time to do so. But that's
> most probably a management decision and all engineers know that management bases
> it's decision on some hard-to-understandable abbreviations like EBITDA etc. ;)
> 
> Best regards,
> Matthias

Thanks for your suggestions. We will try to catch up on this mission :-)

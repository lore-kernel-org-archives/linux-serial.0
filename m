From: Mars Cheng <mars.cheng@mediatek.com>
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add mt6765 support
Date: Tue, 10 Jul 2018 07:04:03 +0800
Message-ID: <1531177443.7777.18.camel@mtkswgap22>
References: <1531116302-29921-1-git-send-email-mars.cheng@mediatek.com>
         <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
         <7fb13f45-4e33-6efc-467b-c7256a40cbc9@gmail.com>
         <d439eb7d-6365-7a0a-2969-1ddecc51defc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d439eb7d-6365-7a0a-2969-1ddecc51defc@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Matthias/Marc

On Mon, 2018-07-09 at 17:43 +0100, Marc Zyngier wrote:
> On 09/07/18 11:20, Matthias Brugger wrote:
> > 
> > 
> > On 09/07/18 08:05, Mars Cheng wrote:
> >> This adds basic chip support for MT6765 SoC.
> >>
> >> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> >> ---
> >>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
> >>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
> >>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  156 +++++++++++++++++++++++++++
> >>  3 files changed, 190 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> >>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> >> index ac17f60..7506b0d 100644
> >> --- a/arch/arm64/boot/dts/mediatek/Makefile
> >> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> >> @@ -1,6 +1,7 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
> >> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6765-evb.dtb
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> > 
> > As you can see, we have a long list of SoCs which are poorly supported.
> > I'm not very keen to just add another SoC which supports booting into a ramdisk
> > using the serial console. Do you have a roadmap adding mainline support for this
> > SoC?
> 
> Yes, that's a valid concern.
> 
> mt6755 and mt6795 are in a similar state, the latter after three years.
> I'm all for supporting new SoCs, but this feels looks a box-ticking
> exercise ("hey, look, our SoC is supported in mainline") which doesn't
> help anyone.
> 
> My Ack still stands, but I'd definitely like to see some more complete
> support before this patch goes in.
> 
> Thanks,
> 
> 	M.

Yes, we do arrange more resources to do upstream task for mt6765,
clk/pinctrl drivers are almost ready to submit. systimer is under
reviewing (v9).
http://lists.infradead.org/pipermail/linux-mediatek/2018-July/013989.html

other drivers including
pmic/pwrap/i2c/rtc/kpd/spi/wdt/cqdma/auxadc/pwm/cmdq/disp. We have
dedicated owners to handle them and will cowork tightly with members to
make sure things happen in the following weeks.

For previous chips, we did have no enough support after shell. It is due
to fast pace of smartphone SoC and other resource issues. We also know
that is no excuse so that we already confirmed owners and their
schedules for mt6765.

If there is any suggestion, please let us know.

Thanks. 

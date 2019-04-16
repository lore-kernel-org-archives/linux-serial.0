From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v9] arm64: dts: Add Mediatek SoC MT8183 and evaluation
 board dts and Makefile
Date: Tue, 16 Apr 2019 10:29:42 +0200
Message-ID: <135d7e3a-d5a3-0f13-05c9-4a8ec0524256@gmail.com>
References: <1552898552-13045-2-git-send-email-erin.lo@mediatek.com>
 <201903190247.QZDwfpLQ%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201903190247.QZDwfpLQ%lkp@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Erin Lo <erin.lo@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, mars.cheng@mediatek.com, eddie.huang@mediatek.com, Ben Ho <Ben.Ho@mediatek.com>, Seiya Wang <seiya.wang@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-serial@vger.kernel.org



On 18/03/2019 19:42, kbuild test robot wrote:
> Hi Erin,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v5.1-rc1 next-20190318]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Erin-Lo/arm64-dts-Add-Mediatek-SoC-MT8183-and-evaluation-board-dts-and-Makefile/20190318-170422
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/arm64/boot/dts/mediatek/mt8183-evb.dts:9:0:
>>> arch/arm64/boot/dts/mediatek/mt8183.dtsi:8:10: fatal error: dt-bindings/clock/mt8183-clk.h: No such file or directory
>     #include <dt-bindings/clock/mt8183-clk.h>
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.
> 
> vim +8 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> 
>    > 8	#include <dt-bindings/clock/mt8183-clk.h>
>      9	#include <dt-bindings/interrupt-controller/arm-gic.h>
>     10	#include <dt-bindings/interrupt-controller/irq.h>
>     11	
> 

Stephen queued the corresponding patch for v5.2.
I propose we wait for v5.2-rc1 and then apply the basic support and the others
based on this one.

Erin: There are may mt8183 dts patches floating around that depend on this or
more patches. Can you coordinate with your colleagues to resend them as a
series? Then it will be easier for me to take them for v5.3, as some have
dependencies on other series etc.

Thanks a lot.
Matthias

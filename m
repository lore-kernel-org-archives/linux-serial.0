From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 03/18] dt-bindings: clk: Add documentation of grx500
 clock controller
Date: Wed, 8 Aug 2018 08:54:12 -0600
Message-ID: <CAL_JsqL5=a9nhvaZOsuDZ7YFhvZs23QT-jbDd4m7wPFviGU1CQ@mail.gmail.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-4-songjun.wu@linux.intel.com> <CAL_JsqKLa1e3X+ddAoVdEwBQFd6tsL=RjOLcTLdfoc6mpKuefQ@mail.gmail.com>
 <9c0cbdfa-8109-be0d-8e14-7d303c764f5c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9c0cbdfa-8109-be0d-8e14-7d303c764f5c@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yixin zhu <yixin.zhu@linux.intel.com>
Cc: Songjun Wu <songjun.wu@linux.intel.com>, hua.ma@linux.intel.com, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com, Linux-MIPS <linux-mips@linux-mips.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 7, 2018 at 9:08 PM yixin zhu <yixin.zhu@linux.intel.com> wrote:
>
>
>
> On 8/6/2018 11:18 PM, Rob Herring wrote:
> > On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
> >> From: Yixin Zhu <yixin.zhu@linux.intel.com>
> >>
> >> This patch adds binding documentation for grx500 clock controller.
> >>
> >> Signed-off-by: YiXin Zhu <yixin.zhu@linux.intel.com>
> >> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> >> ---
> >>
> >> Changes in v2:
> >> - Rewrite clock driver's dt-binding document according to Rob Herring's
> >>    comments.
> >> - Simplify device tree docoment, remove some clock description.
> >>
> >>   .../devicetree/bindings/clock/intel,grx500-clk.txt | 39 ++++++++++++++++++++++
> > Please match the compatible string: intel,grx500-cgu.txt
> Will update to use same name.
>
> >
> >>   1 file changed, 39 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> >> new file mode 100644
> >> index 000000000000..e54e1dad9196
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
> >> @@ -0,0 +1,39 @@
> >> +Device Tree Clock bindings for grx500 PLL controller.
> >> +
> >> +This binding uses the common clock binding:
> >> +       Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> +
> >> +The grx500 clock controller supplies clock to various controllers within the
> >> +SoC.
> >> +
> >> +Required properties for clock node
> >> +- compatible: Should be "intel,grx500-cgu".
> >> +- reg: physical base address of the controller and length of memory range.
> >> +- #clock-cells: should be 1.
> >> +
> >> +Optional Propteries:
> >> +- intel,osc-frequency: frequency of the osc clock.
> >> +if missing, driver will use clock rate defined in the driver.
> > This should use a fixed-clock node instead.
> Yes, This is a fixed clock node registered in driver code.
> The frequency of the fixed clock is designed to be overwritten by device
> tree in case some one verify
> clock driver in the emulation platform or in some cases frequency other
> than driver defined one is preferred.

Emulation platforms often need several hacks that shouldn't be upstream...

> These kinds of cases are very rare. But I feel it would be better to
> have a way to use customized frequency.
> The frequency defined in device tree will overwritten driver defined
> frequency before registering fixed-clock node.

I don't think you understand what I meant. Add a DT node with
"fixed-clock" compatible and have this node refer to it with "clocks"
property. The frequency is still in DT, but uses the clock binding.

Rob

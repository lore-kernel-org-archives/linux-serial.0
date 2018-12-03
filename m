From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline description
Date: Mon, 3 Dec 2018 09:49:29 -0600
Message-ID: <CAL_Jsq+dnKht3TwCh1qB1H4pYFhQJmSN0nAayU+=PJLAvq0bbQ@mail.gmail.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
 <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com> <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
 <f5917f71-f15b-a92d-649c-e3f5f5f10698@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f5917f71-f15b-a92d-649c-e3f5f5f10698@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sugaya.taichi@socionext.com
Cc: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 3, 2018 at 1:42 AM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi,
>
> On 2018/11/30 17:16, Stephen Boyd wrote:
> > Quoting Sugaya, Taichi (2018-11-29 04:24:51)
> >> On 2018/11/28 11:01, Stephen Boyd wrote:
> >>> Quoting Sugaya Taichi (2018-11-18 17:01:07)
> >>>>    create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>> new file mode 100644
> >>>> index 0000000..f5d906c
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>> @@ -0,0 +1,12 @@
> >>>> +Socionext M10V SMP trampoline driver binding
> >>>> +
> >>>> +This is a driver to wait for sub-cores while boot process.
> >>>> +
> >>>> +- compatible: should be "socionext,smp-trampoline"
> >>>> +- reg: should be <0x4C000100 0x100>
> >>>> +
> >>>> +EXAMPLE
> >>>> +       trampoline: trampoline@0x4C000100 {
> >>> Drop the 0x part of unit addresses.
> >>
> >> Okay.
> >>
> >>
> >>>> +               compatible = "socionext,smp-trampoline";
> >>>> +               reg = <0x4C000100 0x100>;
> >>> Looks like a software construct, which we wouldn't want to put into DT
> >>> this way. DT doesn't describe drivers.
> >> We would like to use this node only getting the address of the
> >> trampoline area
> >> in which sub-cores wait.  (They have finished to go to this area in previous
> >> bootloader process.)
> >
> > Is this area part of memory, or a special SRAM? If it's part of memory,
> > I would expect this node to be under the reserved-memory node and
> > pointed to by some other node that uses this region. Could even be the
> > CPU nodes.
>
> Yes, 0x4C000100 is a part of memory under the reserved-memory node. So
> we would like to use the SRAM ( allocated 0x00000000 ) area instead.
> BTW, sorry, the trampoline address of this example is simply wrong.  We
> were going to use a part of the SRAM from the beginning.
>
> >
> >>
> >> So should we embed the constant value in source codes instead of getting
> >> from
> >> DT because the address is constant at the moment? Or is there other
> >> approach?
> >>
> >
> > If it's constant then that also works. Why does it need to come from DT
> > at all then?
>
> We think it is not good to embed constant value in driver codes and do
> not have another way...
> Are there better ways?

If this is just memory, can you use the standard spin-table binding in
the DT spec? There are some requirements like 64-bit values even on
32-bit machines (though this gets violated).

Rob

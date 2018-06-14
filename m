From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/7] clk: intel: Add clock driver for GRX500 SoC
Date: Thu, 14 Jun 2018 08:09:14 -0600
Message-ID: <CAL_JsqJVcKPexrVrnGnr-zga1n6n00nYdUmKZWOz2VQJ7BV-oA@mail.gmail.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-3-songjun.wu@linux.intel.com> <20180612223725.GC2197@rob-hp-laptop>
 <41163f48-ce5c-efae-2b6d-b93d75e422e5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41163f48-ce5c-efae-2b6d-b93d75e422e5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yixin zhu <yixin.zhu@linux.intel.com>
Cc: Songjun Wu <songjun.wu@linux.intel.com>, hua.ma@linux.intel.com, chuanhua.lei@linux.intel.com, Linux-MIPS <linux-mips@linux-mips.org>, qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 14, 2018 at 2:40 AM, yixin zhu <yixin.zhu@linux.intel.com> wrote:
>
>
> On 6/13/2018 6:37 AM, Rob Herring wrote:
>>
>> On Tue, Jun 12, 2018 at 01:40:29PM +0800, Songjun Wu wrote:
>>>
>>> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>>>
>>> PLL of GRX500 provide clock to DDR, CPU, and peripherals as show below

[...]

>>> +Example:
>>> +       clkgate0: clkgate0 {
>>> +               #clock-cells = <1>;
>>> +               compatible = "intel,grx500-gate0-clk";
>>> +               reg = <0x114>;
>>> +               clock-output-names = "gate_xbar0", "gate_xbar1",
>>> "gate_xbar2",
>>> +               "gate_xbar3", "gate_xbar6", "gate_xbar7";
>>> +       };
>>
>>
>> We generally don't do a clock node per clock or few clocks but rather 1
>> clock node per clock controller block. See any recent clock bindings.
>>
>> Rob
>
> Do you mean only one example is needed per clock controller block?
> cpuclk is not needed in the document?

No, I mean generally we have 1 DT node for the h/w block with all the
clock control registers rather than nodes with a single register and 1
or a couple of clocks. Sometimes the clock registers are mixed with
other functions which complicates things a bit. But I can't tell that
here because you haven't documented what's in the rest of the register
space.

Rob

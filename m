From: yixin zhu <yixin.zhu@linux.intel.com>
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
Date: Wed, 8 Aug 2018 10:51:50 +0800
Message-ID: <57bea045-628b-2dad-2492-dadd9947cbe9@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-3-songjun.wu@linux.intel.com>
 <CAL_JsqK5pFNKyAhTTmNpaSnKa_beY3kS8FGtYim8oTgw6oO9Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqK5pFNKyAhTTmNpaSnKa_beY3kS8FGtYim8oTgw6oO9Rw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Songjun Wu <songjun.wu@linux.intel.com>
Cc: hua.ma@linux.intel.com, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com, Linux-MIPS <linux-mips@linux-mips.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org



On 8/6/2018 11:19 PM, Rob Herring wrote:
> On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>> From: Yixin Zhu <yixin.zhu@linux.intel.com>
>>
>> This driver provides PLL clock registration as well as various clock
>> branches, e.g. MUX clock, gate clock, divider clock and so on.
>>
>> PLLs that provide clock to DDR, CPU and peripherals are shown below:
>>
>>                   +---------+
>>              |--->| LCPLL3 0|--PCIe clk-->
>>     XO       |    +---------+
>> +-----------|
>>              |    +---------+
>>              |    |        3|--PAE clk-->
>>              |--->| PLL0B  2|--GSWIP clk-->
>>              |    |        1|--DDR clk-->DDR PHY clk-->
>>              |    |        0|--CPU1 clk--+   +-----+
>>              |    +---------+            |--->0    |
>>              |                               | MUX |--CPU clk-->
>>              |    +---------+            |--->1    |
>>              |    |        0|--CPU0 clk--+   +-----+
>>              |--->| PLLOA  1|--SSX4 clk-->
>>                   |        2|--NGI clk-->
>>                   |        3|--CBM clk-->
>>                   +---------+
>>
>> Signed-off-by: Yixin Zhu <yixin.zhu@linux.intel.com>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>> Changes in v2:
>> - Rewrite clock driver, add platform clock description details in
>>    clock driver.
>>
>>   drivers/clk/Kconfig                          |   1 +
>>   drivers/clk/Makefile                         |   3 +
>>   drivers/clk/intel/Kconfig                    |  20 ++
>>   drivers/clk/intel/Makefile                   |   7 +
>>   drivers/clk/intel/clk-cgu-pll.c              | 166 ++++++++++
>>   drivers/clk/intel/clk-cgu-pll.h              |  34 ++
>>   drivers/clk/intel/clk-cgu.c                  | 470 +++++++++++++++++++++++++++
>>   drivers/clk/intel/clk-cgu.h                  | 259 +++++++++++++++
>>   drivers/clk/intel/clk-grx500.c               | 168 ++++++++++
>>   include/dt-bindings/clock/intel,grx500-clk.h |  69 ++++
> This belongs with the clk binding patch.
>
> Rob
Thanks for review.
Will move it to clock binding patch.

>

From: Hua Ma <hua.ma@linux.intel.com>
Subject: Re: [PATCH 3/7] MIPS: intel: Add initial support for Intel MIPS SoCs
Date: Thu, 14 Jun 2018 16:01:31 +0800
Message-ID: <821a2d72-da13-4dbe-4413-edc25f01e9fb@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-4-songjun.wu@linux.intel.com>
 <20180612223153.GB2197@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612223153.GB2197@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Songjun Wu <songjun.wu@linux.intel.com>
Cc: yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, linux-mips@linux-mips.org, qi-ming.wu@intel.com, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org


On 6/13/2018 6:31 AM, Rob Herring wrote:
> On Tue, Jun 12, 2018 at 01:40:30PM +0800, Songjun Wu wrote:
>> From: Hua Ma <hua.ma@linux.intel.com>
>>
>> Add initial support for Intel MIPS interAptiv SoCs made by Intel.
>> This series will add support for the GRX500 family.
>>
>> The series allows booting a minimal system using a initramfs.
>>
>> Signed-off-by: Hua ma <hua.ma@linux.intel.com>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
>>
>>   arch/mips/Kbuild.platforms                         |   1 +
>>   arch/mips/Kconfig                                  |  36 ++++
>>   arch/mips/boot/dts/Makefile                        |   1 +
>>   arch/mips/boot/dts/intel-mips/Makefile             |   3 +
>>   arch/mips/boot/dts/intel-mips/easy350_anywan.dts   |  20 +++
>>   arch/mips/boot/dts/intel-mips/xrx500.dtsi          | 196 +++++++++++++++++++++
> Please split dts files to separate patch.
Thanks,
it will be split into separate patches: one for dts, one for mips codes 
and one for the document.
>> diff --git a/arch/mips/boot/dts/intel-mips/easy350_anywan.dts b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
>> new file mode 100644
>> index 000000000000..40177f6cee1e
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/interrupt-controller/mips-gic.h>
>> +#include <dt-bindings/clock/intel,grx500-clk.h>
>> +
>> +#include "xrx500.dtsi"
>> +
>> +/ {
>> +	model = "EASY350 ANYWAN (GRX350) Main model";
> A board should have a board specific compatible, too.
The board compatible will be added.
>
>> +	chosen {
>> +		bootargs = "earlycon=lantiq,0x16600000 clk_ignore_unused";
>> +		stdout-path = "serial0";
>> +	};
>> +
>> +	memory@0 {
> memory@20000000
The memory address will be changed to @20000000.
>
>> +		device_type = "memory";
>> +		reg = <0x20000000 0x0e000000>;
>> +	};
>> +};
>> diff --git a/arch/mips/boot/dts/intel-mips/xrx500.dtsi b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
>> new file mode 100644
>> index 000000000000..04a068d6d96b
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
>> @@ -0,0 +1,196 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/ {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	compatible = "intel,xrx500";
> This needs to be documented.
The compatible will be updated in the document.

From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
Date: Fri, 15 Jun 2018 19:08:14 +0530
Message-ID: <a69fcb7a-f7a1-481b-8a02-1da7d1e20671@ti.com>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
 <20180607233853.p7iw7nlxxuyi66og@kahuna>
 <20180614123805.GF112168@atomide.com>
 <20180614130435.j2bmzam6corrjylx@kahuna>
 <20180615050108.GG112168@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615050108.GG112168@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Vignesh R <vigneshr@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Tony,

On Friday 15 June 2018 10:31 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [180614 13:07]:
>> On 12:38-20180614, Tony Lindgren wrote:

>> From A53 view, a more accurate view might be  - from an interconnect
>> view of the world (still simplified - i have ignored the sub bus
>> segments in the representations below):
>>
>> msmc {
>> 	navss_main {
>> 		cbass_main{
>> 			cbass_mcu {
>> 				navss_mcu {
>> 				};
>> 				cbass_wkup{
>> 				};
>> 			};
>> 		};
>> 	};
>> };
>>
>> From R5 view, the view will be very different ofcourse:
>> view of the world (still simplified):
>>
>> cbass_mcu {
>> 	navss_mcu {
>> 	};
>> 	cbass_wkup{
>> 	};
>> 	cbass_main{
>> 		navss_main {
>> 			msmc {
>> 			};
>> 		};
>> 	};
>> };
> 
> Well if we follow the hardware representation of the interconnects,
> it should not matter from which processor view you're looking at things.
> There are just different ranges provided.

AFAIK, the root node needs to have the CPU which is using the DT. So,
the hierarchy will change based on CPU view (if we describe it fully).

How well we can reuse individual interconnect segments is something I
have to think about / experiment. Will have to be wary of any "short
paths" or "cross connections".

Thanks,
Sekhar

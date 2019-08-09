From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Date: Fri, 9 Aug 2019 09:45:40 +0000
Message-ID: <VI1PR0402MB2863B3E3E2F93CBA8ADB96E5DFD60@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190808080832.nleult5bknmzr3ze@willie-the-truck>
 <VI1PR0402MB28635661A4A294EC6F01095EDFD70@VI1PR0402MB2863.eurprd04.prod.outlook.com>
 <20190808171711.nk7ljqkugtketu4q@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Larisa Ileana Grigore <larisa.grigore@nxp.com>
List-Id: linux-serial@vger.kernel.org

On 8/8/2019 8:17 PM, Will Deacon wrote:
> On Thu, Aug 08, 2019 at 12:47:00PM +0000, Stefan-gabriel Mirea wrote:
>> On 8/8/2019 11:08 AM, Will Deacon wrote:
>>> On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:
>>>> +             linflex,<addr>
>>>> +                     Use early console provided by Freescale LinFlex UART
>>>> +                     serial driver for NXP S32V234 SoCs. A valid base
>>>> +                     address must be provided, and the serial port must
>>>> +                     already be setup and configured.
>>>
>>> Why isn't earlycon= sufficient for this?
>>
>> "earlycon=" is not actually supported. I will fix this in the next
>> version by adding a /chosen/stdout-path to the dts. The compatible
>> string provided to OF_EARLYCON_DECLARE will also be changed from
>> "fsl,s32v234-linflexuart" to "fsl,s32-linflexuart" to match the one in
>> the device tree nodes. I missed this after importing a rename from our
>> codebase.
>>
>> Should I remove this addition from kernel-parameters.txt after that?
> 
> Yes, if you can use earlycon instead, then you can drop your custom option
> entirely and therefore there's no need to document it either.

Can you please clarify what you mean by "drop your custom option"? The
"linflex" option documented in the paragraph is the name of the
earlycon_id declared via "OF_EARLYCON_DECLARE(linflex, ...)". We have
not done anything particular to accept it in the parameter value.

We do use earlycon (e.g. "earlycon=linflex,0x40053000"), we just do not
support an empty value after "=", which needs to be fixed as I
understand, because it does not respect the comment[1] about ARM64.

Regards,
Stefan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt?h=v5.3-rc3#n980

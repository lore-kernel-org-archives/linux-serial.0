From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Date: Thu, 8 Aug 2019 18:17:11 +0100
Message-ID: <20190808171711.nk7ljqkugtketu4q@willie-the-truck>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190808080832.nleult5bknmzr3ze@willie-the-truck>
 <VI1PR0402MB28635661A4A294EC6F01095EDFD70@VI1PR0402MB2863.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB28635661A4A294EC6F01095EDFD70@VI1PR0402MB2863.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, Larisa Ileana Grigore <larisa.grigore@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hi,

On Thu, Aug 08, 2019 at 12:47:00PM +0000, Stefan-gabriel Mirea wrote:
> On 8/8/2019 11:08 AM, Will Deacon wrote:
> > On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:
> >> +             linflex,<addr>
> >> +                     Use early console provided by Freescale LinFlex UART
> >> +                     serial driver for NXP S32V234 SoCs. A valid base
> >> +                     address must be provided, and the serial port must
> >> +                     already be setup and configured.
> > 
> > Why isn't earlycon= sufficient for this?
> 
> "earlycon=" is not actually supported. I will fix this in the next
> version by adding a /chosen/stdout-path to the dts. The compatible
> string provided to OF_EARLYCON_DECLARE will also be changed from
> "fsl,s32v234-linflexuart" to "fsl,s32-linflexuart" to match the one in
> the device tree nodes. I missed this after importing a rename from our
> codebase.
> 
> Should I remove this addition from kernel-parameters.txt after that?

Yes, if you can use earlycon instead, then you can drop your custom option
entirely and therefore there's no need to document it either.

Will

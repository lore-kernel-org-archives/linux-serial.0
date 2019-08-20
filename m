From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH v2 2/6] arm64: Introduce config for S32
Date: Tue, 20 Aug 2019 16:38:30 +0000
Message-ID: <VI1PR0402MB2863F70B8497B8901087B7A4DFAB0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
 <20190809112853.15846-3-stefan-gabriel.mirea@nxp.com>
 <20190819081457.GH5999@X250>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hello Shawn,=0A=
=0A=
On 8/19/2019 11:15 AM, Shawn Guo wrote:=0A=
> On Fri, Aug 09, 2019 at 11:29:10AM +0000, Stefan-gabriel Mirea wrote:=0A=
>> +config ARCH_S32=0A=
>> +     bool "Freescale S32 SoC Family"=0A=
> =0A=
> So you still want to use 'Freescale' than 'NXP' here?=0A=
> =0A=
>> +     help=0A=
>> +       This enables support for the Freescale S32 family of processors.=
=0A=
=0A=
Thanks; I will replace Freescale with NXP wherever possible in the next=0A=
version.=0A=
=0A=
Regards,=0A=
Stefan=0A=

From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH v3 4/7] serial: fsl_linflexuart: Be consistent with the
 name
Date: Thu, 5 Sep 2019 11:32:06 +0000
Message-ID: <VI1PR0402MB2863B0A0D1D12FA9CC2515E2DFBB0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
 <20190823191115.18490-5-stefan-gabriel.mirea@nxp.com>
 <20190904075259.GA10983@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello Greg,=0A=
=0A=
On 9/4/2019 10:53 AM, gregkh@linuxfoundation.org wrote:=0A=
> On Fri, Aug 23, 2019 at 07:11:37PM +0000, Stefan-gabriel Mirea wrote:=0A=
>> For consistency reasons, spell the controller name as "LINFlexD" in=0A=
>> comments and documentation.=0A=
>>=0A=
>> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>=0A=
>> ---=0A=
>>  Documentation/admin-guide/kernel-parameters.txt | 2 +-=0A=
>>  drivers/tty/serial/Kconfig                      | 8 ++++----=0A=
>>  drivers/tty/serial/fsl_linflexuart.c            | 4 ++--=0A=
>>  include/uapi/linux/serial_core.h                | 4 ++--=0A=
>>  4 files changed, 9 insertions(+), 9 deletions(-)=0A=
> =0A=
> Doesn't apply to my tty-next tree :(=0A=
=0A=
Thanks for letting me know; I will fix this in v4.=0A=
=0A=
Regards,=0A=
Stefan=0A=

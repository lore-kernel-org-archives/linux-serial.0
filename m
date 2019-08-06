From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Date: Tue, 6 Aug 2019 17:11:17 +0000
Message-ID: <HE1PR0402MB28579034C09EB49A76A4F8E7DFD50@HE1PR0402MB2857.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190805153114.GA16836@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, Larisa Ileana Grigore <larisa.grigore@nxp.com>
List-Id: linux-serial@vger.kernel.org

On 8/5/2019 6:31 PM, gregkh@linuxfoundation.org wrote:=0A=
> On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:=0A=
>>=0A=
>> +/* Freescale Linflex UART */=0A=
>> +#define PORT_LINFLEXUART     121=0A=
> =0A=
> Do you really need this modified?=0A=
=0A=
Hello Greg,=0A=
=0A=
This macro is meant to be assigned to port->type in the config_port=0A=
method from uart_ops, in order for verify_port to know if the received=0A=
serial_struct structure was really targeted for a LINFlex port. It=0A=
needs to be defined outside, to avoid "collisions" with other drivers.=0A=
=0A=
As far as I see, uart_set_info() will actually fail at the=0A=
"baud_base < 9600" check[1], right after calling verify_port(), when=0A=
performing an ioctl() on "/dev/console" with TIOCSSERIAL using a=0A=
serial_struct obtained with TIOCGSERIAL. This happens because this=0A=
reduced version of the LINFlex UART driver will not touch the uartclk=0A=
field of the uart_port (as there is currently no clock support).=0A=
Therefore, the linflex_config/verify_port() functions, along with the=0A=
PORT_LINFLEXUART macro, may be indeed unnecessary at this point (and=0A=
should be added later). Is this what you mean?=0A=
=0A=
Other than that, I do not see anything wrong with the addition of a=0A=
define in serial_core.h for this purpose (which is also what most of the=0A=
serial drivers do, including amba-pl011.c, mentioned in=0A=
Documentation/driver-api/serial/driver.rst as providing the reference=0A=
implementation), so please be more specific.=0A=
=0A=
Regards,=0A=
Stefan=0A=
=0A=
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/tty/serial/serial_core.c?h=3Dv5.3-rc1#n872=0A=

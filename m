From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH] serial: Do not treat the IIR register as a bitfield
Date: Thu, 30 Mar 2017 17:39:39 +0200
Message-ID: <97434C93-32EF-4742-838D-4C783E5ECC45@schinagl.nl>
References: <20170329184431.6226-1-oliver@schinagl.nl> <6be65e8b-eea4-08ed-0b30-5c0608764a83@ti.com> <D694FA74-1F31-4B57-8858-2DBE8DE57D45@schinagl.nl> <2faa7420-0a54-e77f-0da2-80f6dfcf9710@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2faa7420-0a54-e77f-0da2-80f6dfcf9710@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laxman Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "David S . Miller" <davem@davemloft.net>
Cc: "dev@linux-sunxi.org" <dev@linux-sunxi.org>, Ed Blake <ed.blake@imgtec.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Yegor Yefremov <yegorslists@googlemail.com>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>, Jason Uy <jason.uy@broadcom.com>, Douglas Anderson <dianders@chromium.org>, Peter Hurley <peter@hurleysoftware.com>, Tony Lindgren <tony@atomide.com>, Thor Thayer <tthayer@opensource.altera.com>, David Lechner <david@lechnology.com>, Jan Kiszka <jan.kiszka@siemens.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel@
List-Id: linux-serial@vger.kernel.org

Hey Vignesh,

On March 30, 2017 9:57:19 AM CEST, Vignesh R <vigneshr@ti=2Ecom> wrote:
>
>
>On Thursday 30 March 2017 12:13 PM, Olliver Schinagl wrote:
>>=20
>>=20
>> On March 30, 2017 8:15:29 AM CEST, Vignesh R <vigneshr@ti=2Ecom> wrote:
>>> Hi,
>>>
>>> On Thursday 30 March 2017 12:14 AM, Olliver Schinagl wrote:
>>>> diff --git a/include/uapi/linux/serial_reg=2Eh
>>> b/include/uapi/linux/serial_reg=2Eh
>>>> index 5db76880b4ad=2E=2E489522389a10 100644
>>>> --- a/include/uapi/linux/serial_reg=2Eh
>>>> +++ b/include/uapi/linux/serial_reg=2Eh
>>>> @@ -31,18 +31,18 @@
>>>>  #define UART_IERX_SLEEP		0x10 /* Enable sleep mode */
>>>> =20
>>>>  #define UART_IIR	2	/* In:  Interrupt ID Register */
>>>> -#define UART_IIR_NO_INT		0x01 /* No interrupts pending */
>>>> -#define UART_IIR_ID		0x0e /* Mask for the interrupt ID */
>>>>  #define UART_IIR_MSI		0x00 /* Modem status interrupt */
>>>> +#define UART_IIR_NO_INT		0x01 /* No interrupts pending */
>>>>  #define UART_IIR_THRI		0x02 /* Transmitter holding register empty
>*/
>>>>  #define UART_IIR_RDI		0x04 /* Receiver data interrupt */
>>>>  #define UART_IIR_RLSI		0x06 /* Receiver line status interrupt */
>>>> -
>>>>  #define UART_IIR_BUSY		0x07 /* DesignWare APB Busy Detect */
>>>> +#define UART_IIR_RX_TIMEOUT	0x0c /* DesignWare RX Timeout
>interrupt
>>> */
>> It was moved due to sorting=2E The comment could be changed maybe? I
>renamed it from omap to dw as i believe the omap also uses the dw ip=2E
>But i think it is a defacto standard mapping of the irr register?
>
>AFAIK, OMAP UART does not use DW core, please make these IDs generic to
>avoid confusion=2E
The ids are genetic, the comments are not=2E Ill update the comments to be=
 generic, with the exception of the omap specific extended ones?

Olliver
>
>>=20
>>>> +#define UART_IIR_MASK		0x0f /* DesignWare IIR mask */
>>>> =20
>>>> -#define UART_IIR_RX_TIMEOUT	0x0c /* OMAP RX Timeout interrupt */
>>>
>>> You are removing UART_IIR_RX_TIMEOUT? Is this intended?
>>>
>>>>  #define UART_IIR_XOFF		0x10 /* OMAP XOFF/Special Character */
>>>>  #define UART_IIR_CTS_RTS_DSR	0x20 /* OMAP CTS/RTS/DSR Change */
>>>> +#define UART_IIR_EXT_MASK	0x30 /* OMAP extended IIR mask */
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

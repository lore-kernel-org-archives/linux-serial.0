From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 2/2] serial: atmel: add support for new UART version
Date: Tue, 26 Jan 2016 11:25:32 +0100
Message-ID: <56A7499C.8090109@atmel.com>
References: <201601260224.Djb6afTp%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201601260224.Djb6afTp%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kbuild-all@01.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, davidm@egauge.net
List-Id: linux-serial@vger.kernel.org

Le 25/01/2016 19:34, kbuild test robot a =E9crit :
> Hi Nicolas,
>=20
> [auto build test ERROR on usb/usb-testing]
> [also build test ERROR on v4.5-rc1 next-20160125]
> [if your patch is applied to the wrong git tree, please drop us a not=
e to help improving the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Nicolas-Ferre/serial=
-atmel-trivial-clean-the-IP-version-decoding-code/20160126-014116
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.gi=
t usb-testing
> config: i386-allmodconfig (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/tty/serial/atmel_serial.c: In function 'atmel_get_ip_name'=
:
>>> drivers/tty/serial/atmel_serial.c:1717:2: error: 'new_uart' undecla=
red (first use in this function)

Sorry for this dumb error and the associated noise!

I send a v2 immediately.

>      new_uart =3D 0x55415254; /* UART */
>      ^
>    drivers/tty/serial/atmel_serial.c:1717:2: note: each undeclared id=
entifier is reported only once for each function it appears in
>=20
> vim +/new_uart +1717 drivers/tty/serial/atmel_serial.c
>=20
>   1711		int name =3D atmel_uart_readl(port, ATMEL_US_NAME);
>   1712		u32 version;
>   1713		u32 usart, dbgu_uart;
>   1714		/* ASCII decoding for IP version */
>   1715		usart =3D 0x55534152;	/* USAR(T) */
>   1716		dbgu_uart =3D 0x44424755;	/* DBGU */
>> 1717		new_uart =3D 0x55415254;	/* UART */
>   1718=09
>   1719		atmel_port->has_hw_timer =3D false;
>   1720=09
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technolog=
y Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Cor=
poration
>=20


--=20
Nicolas Ferre

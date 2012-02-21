From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH] pch_uart: Change default UART clock setting 192MHz
Date: Tue, 21 Feb 2012 14:07:04 -0800
Message-ID: <4F441588.8010101@linux.intel.com>
References: <1329800140-4279-1-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2337 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773Ab2BUWHk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Feb 2012 17:07:40 -0500
In-Reply-To: <1329800140-4279-1-git-send-email-tomoya.rohm@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, feng.tang@intel.com



On 02/20/2012 08:55 PM, Tomoya MORINAGA wrote:
> Currently, PCH_UART uses 1843200Hz as default clock.
> However, in case of using high baud rate, users need to modify
> clock setting.
>=20
> This patch uses 192MHz setting as default UART clock setting.
> Using this clock, users can use almost high baud rate without modifyi=
ng
> clock settings.
>=20
> This setting is the same as quirk for CM-iTC board.
> So, delete the quirk.

With this change, the serial console will work, but only after the
device is initialized. We get garbage out of the early serial console
(as it still uses the 115200 as the BASE_BAUD and the firmware in my
case has set this to 64000000/16):

x=C4=80x=EF=BF=BDx=EF=BF=BD=EF=BF=BDx=EF=BF=BDx=EF=BF=BD=EF=BF=BDxx=EF=BF=
=BDx=EF=BF=BD=EF=BF=BDxxx=EF=BF=BDxxx=EF=BF=BDx=EF=BF=BD=EF=BF=BDx=EF=BF=
=BDx=EF=BF=BDxxxx=EF=BF=BD=EF=BF=BD=EF=BF=BDxxx=EF=BF=BDx=EF=BF=BDx=EF=BF=
=BD=EF=BF=BDx=EF=BF=BDx=EF=BF=BDx=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDx=EF=BF=BD=EF=BF=BDxx=EF=BF=BD=EF=BF=BD=EF=BF=BDx=EF=BF=BDx=EF=BF=
=BDx=EF=BF=BDxx=EF=BF=BDx=EF=BF=BD=EF=BF=BDx=EF=BF=BDx6
ahci 0000:03:06.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA=
 mode
ahci 0000:03:06.0: flags: ncq sntf pm led clo only pmp pio slum part cc=
c
scsi0 : ahci
scsi1 : ahci
=2E..

Perhaps a reasonable solution would be to add a KCONFIG option for the
early_console BASE_BAUD. I prefer the fixed 192MHz solution here to
special casing every EG20T PCH board.

I'll prepare and test a patch for early_serial_console BASE_BAUD.

Please resend these patches with my clock_param changes removed as they
shouldn't be necessary now that we set all boards to 192MHz.

--
Darren

>=20
> Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>
> ---
> Related patch is=20
> http://marc.info/?l=3Dlinux-kernel&m=3D132979974907774&w=3D2
> ---
>  drivers/tty/serial/pch_uart.c |   15 ++++++---------
>  1 files changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_u=
art.c
> index 17ae657..d068c34 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -203,7 +203,7 @@ enum {
> =20
>  #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
> =20
> -#define DEFAULT_BAUD_RATE 1843200 /* 1.8432MHz */
> +#define DEFAULT_UART_CLOCK 192000000 /* 192.0MHz */
> =20
>  struct pch_uart_buffer {
>  	unsigned char *buf;
> @@ -287,6 +287,7 @@ static struct pch_uart_driver_data drv_dat[] =3D =
{
>  static struct eg20t_port *pch_uart_ports[PCH_UART_NR];
>  #endif
>  static unsigned int default_baud =3D 9600;
> +static unsigned int clock_param;
>  static const int trigger_level_256[4] =3D { 1, 64, 128, 224 };
>  static const int trigger_level_64[4] =3D { 1, 16, 32, 56 };
>  static const int trigger_level_16[4] =3D { 1, 4, 8, 14 };
> @@ -1507,7 +1508,7 @@ static int __init pch_console_setup(struct cons=
ole *co, char *options)
>  		return -ENODEV;
> =20
>  	/* setup uartclock */
> -	port->uartclk =3D DEFAULT_BAUD_RATE;
> +	port->uartclk =3D clock_param ? clock_param : DEFAULT_UART_CLOCK;
> =20
>  	if (options)
>  		uart_parse_options(options, &baud, &parity, &bits, &flow);
> @@ -1553,7 +1554,6 @@ static struct eg20t_port *pch_uart_init_port(st=
ruct pci_dev *pdev,
>  	int fifosize, base_baud;
>  	int port_type;
>  	struct pch_uart_driver_data *board;
> -	const char *board_name;
> =20
>  	board =3D &drv_dat[id->driver_data];
>  	port_type =3D board->port_type;
> @@ -1566,12 +1566,8 @@ static struct eg20t_port *pch_uart_init_port(s=
truct pci_dev *pdev,
>  	if (!rxbuf)
>  		goto init_port_free_txbuf;
> =20
> -	base_baud =3D DEFAULT_BAUD_RATE;
> -
> -	/* quirk for CM-iTC board */
> -	board_name =3D dmi_get_system_info(DMI_BOARD_NAME);
> -	if (board_name && strstr(board_name, "CM-iTC"))
> -		base_baud =3D 192000000; /* 192.0MHz */
> +	/* The module parameter overrides default. */
> +	base_baud =3D clock_param ? clock_param : DEFAULT_UART_CLOCK;
> =20
>  	switch (port_type) {
>  	case PORT_UNKNOWN:
> @@ -1785,3 +1781,4 @@ module_exit(pch_uart_module_exit);
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Intel EG20T PCH UART PCI Driver");
>  module_param(default_baud, uint, S_IRUGO);
> +module_param(clock_param, uint, (S_IRUSR | S_IWUSR));

--=20
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

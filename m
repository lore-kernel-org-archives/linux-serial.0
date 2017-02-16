From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/11] tty: serial: Add Actions Semi Owl UART earlycon
Date: Thu, 16 Feb 2017 14:41:51 +0100
Message-ID: <3685307.zVcugmQnxp@wuerfel>
References: <20170215165528.10052-1-afaerber@suse.de>
 <20170215165528.10052-7-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170215165528.10052-7-afaerber@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: support@lemaker.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, info@ucrobotics.com, linux-kernel@vger.kernel.org, mp-cs@actions-semi.com, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, contact@linux-xapple.org
List-Id: linux-serial@vger.kernel.org

On Wednesday, February 15, 2017 5:55:23 PM CET Andreas F=E4rber wrote:
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 6117ac8..9d4213c 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1677,6 +1677,25 @@ config SERIAL_MVEBU_CONSOLE
>           and warnings and which allows logins in single user mode)
>           Otherwise, say 'N'.
>  =

> +config SERIAL_OWL
> +       bool "Actions Semi Owl serial port support"
> +       depends on ARCH_OWL || COMPILE_TEST
> +       select SERIAL_CORE
> +       help
> +         This driver is for Actions Semi S500/S900 SoC's UART.
> +         Say 'Y' here if you wish to use the on-board serial port.
> +         Otherwise, say 'N'.
> +
> =


This could maybe use a word of information about how there isn't
actually a uart driver in this series, only an earlycon driver.

Do you plan to add the actual tty driver soon? If not, maybe
only add one Kconfig symbol for the earlycon support.

	Arnd

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] serial: 8250_dw: Add ACPI support for uart on
 Hisilicon Hip05 soc
Date: Wed, 29 Jun 2016 15:52:44 +0300
Message-ID: <1467204764.30123.327.camel@linux.intel.com>
References: <1467083835-37750-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467083835-37750-1-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, z.liuxinliang@hisilicon.com, guohanjun@huawei.com
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-06-28 at 11:17 +0800, Kefeng Wang wrote:
> Make dw8250_set_termios() as the default set_termios callback for 825=
0
> dw uart, correct me
> if I am wrong.
>=20
> Then add ACPI support for uart on Hisilicon Hip05 soc, be careful tha=
t
> it is not 16500
> compatible.

You mean it has Busy Functionality implemented?
Is there any public specification to look at?

>  Note, the build(no ACPI) depends on
> https://patchwork.kernel.org/patch/9141207/,
> which was already accepted in net-next.
>=20
> Meanwhile, set dw8250_serial_out32 to keep consistent between
> serial_out
> and serial_in in ACPI.
>=20
> Kefeng Wang (2):
> =C2=A0 serial: 8250_dw: make dw8250_set_termios as default set_termio=
s
> =C2=A0=C2=A0=C2=A0=C2=A0callback
> =C2=A0 serial: 8250_dw: add ACPI support for uart on Hisilicon Hip05 =
soc
>=20
> =C2=A0drivers/tty/serial/8250/8250_dw.c | 11 +++++++----
> =C2=A01 file changed, 7 insertions(+), 4 deletions(-)
>=20

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

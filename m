From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: Re: [PATCH] serial: 8250: fix a sparse warning
Date: Mon, 9 Mar 2015 16:41:00 +0800
Message-ID: <54FD5C9C.4080609@huawei.com>
References: <1425886615-78601-1-git-send-email-zhenzhang.zhang@huawei.com> <54FD4EE6.7000408@huawei.com> <20150309082253.GA14349@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150309082253.GA14349@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, tim.kryger@linaro.org, jamie@jamieiles.com, alan@linux.intel.com, arnd@arndb.de
List-Id: linux-serial@vger.kernel.org

On 2015/3/9 16:22, Greg KH wrote:
> On Mon, Mar 09, 2015 at 03:42:30PM +0800, Zhang Zhen wrote:
>> drivers/tty/serial/8250/8250_core.c: In function =E2=80=98serial8250=
_console_write=E2=80=99:
>> drivers/tty/serial/8250/8250_core.c:3244: warning: =E2=80=98flags=E2=
=80=99 may be used u
>> unitialized in this function
>>
>> Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
>> ---
>>  drivers/tty/serial/8250/8250_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/seria=
l/8250/8250_core.c
>> index deae122..50702e2 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -3241,7 +3241,7 @@ serial8250_console_write(struct console *co, c=
onst char *s, unsigned int count)
>>  {
>>  	struct uart_8250_port *up =3D &serial8250_ports[co->index];
>>  	struct uart_port *port =3D &up->port;
>> -	unsigned long flags;
>> +	unsigned long flags =3D 0;
>>  	unsigned int ier;
>>  	int locked =3D 1;
>>
>=20
> Sparse generated this?  Or did a broken / old version of gcc?
>=20
Sorry, it's a gcc warning.

My gcc version is:
gcc (SUSE Linux) 4.3.4 [gcc-4_3-branch revision 152973]

> This patch fixes nothing, sorry, so I can't accept it.
>=20
> greg k-h
>=20
> .
>=20

From: Wolfgang Schnitker <wolfgang.schnitker@gmx.de>
Subject: Bug#854231: Fwd: Re: Fwd: Kernel 4.9 traces
Date: Sat, 18 Feb 2017 11:51:18 +0100
Message-ID: <606cd75b-63d4-d88e-c7c5-a7314a361c74@gmx.de>
References: <198ddfc5-4d9d-bb70-a54b-ff38603099c6@gmx.de>
Reply-To: Wolfgang Schnitker <wolfgang.schnitker@gmx.de>, 854231@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.854231.B854231.148741508922881@bugs.debian.org>
In-Reply-To: <198ddfc5-4d9d-bb70-a54b-ff38603099c6@gmx.de>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: linux-serial@vger.kernel.org, 854231@bugs.debian.org
Cc: Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Additional information:

Just checked this:

setserial -g /dev/ttyS*

/dev/ttyS0, UART: unknown, Port: 0x03f8, IRQ: 4
/dev/ttyS1, UART: 16550A, Port: 0xcc00, IRQ: 17
/dev/ttyS2, UART: 16550A, Port: 0xc880, IRQ: 17
/dev/ttyS3, UART: 16550A, Port: 0x02e8, IRQ: 3

Are we opening a non exsisting port?

Did an update-initrd for all kernels, reboot, errors while booting are go=
ne.

But still have 4 ttyS with only 3 physical ports.

sudo dmesg| grep tty
[    0.000000] console [tty0] enabled
[    0.832371] 00:00: ttyS3 at I/O 0x2e8 (irq =3D 3, base_baud =3D 115200=
) is a 16550A
[    9.908812] 0000:03:00.0: ttyS0 at I/O 0xcc00 (irq =3D 17, base_baud =3D=
 115200) is a 16550A
[    9.929450] 0000:03:00.0: ttyS1 at I/O 0xc880 (irq =3D 17, base_baud =3D=
 115200) is a 16550A

ls /dev/ttyS*
/dev/ttyS0  /dev/ttyS1  /dev/ttyS2  /dev/ttyS3

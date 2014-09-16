From: Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH 3.4.x-stable] 8250_pci: fix warnings in backport of Broadcom
 TruManage support
Date: Tue, 16 Sep 2014 18:06:26 +0800
Message-ID: <54180BA2.9030605@huawei.com>
References: <1408988000-32987-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1408988000-32987-1-git-send-email-paul.gortmaker@windriver.com>
Sender: stable-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: stable@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Hurd <shurd@broadcom.com>, Michael Chan <mchan@broadcom.com>, Ben Hutchings <ben@decadent.org.uk>, Rui Xiang <rui.xiang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On 2014/8/26 1:33, Paul Gortmaker wrote:
> commit 7400ce7ee9595432b2a1402b6ffcac9faf38d9ae (v3.4.92-76-g7400ce7e=
e959)
> was a backport of commit ebebd49a8eab5e9aa1b1f8f1614ccc3c2120f886 ups=
tream
> ("8250/16?50: Add support for Broadcom TruManage redirected serial po=
rt")
>=20
> However, in the context of 3.4.x kernels, the pci setup code was
> expecting a struct uart_port and not a struct uart_8250_port, leading=
 to
> the following concerning warnings:
>=20
> drivers/tty/serial/8250/8250_pci.c: In function =E2=80=98pci_brcm_tru=
manage_setup=E2=80=99:
> drivers/tty/serial/8250/8250_pci.c:1086:2: warning: passing argument =
3 of =E2=80=98pci_default_setup=E2=80=99 from incompatible pointer type=
 [enabled by default]
>   int ret =3D pci_default_setup(priv, board, port, idx);
>   ^
> drivers/tty/serial/8250/8250_pci.c:1036:1: note: expected =E2=80=98st=
ruct uart_port *=E2=80=99 but argument is of type =E2=80=98struct uart_=
8250_port *=E2=80=99
>  pci_default_setup(struct serial_private *priv,
>  ^
> drivers/tty/serial/8250/8250_pci.c: At top level:
> drivers/tty/serial/8250/8250_pci.c:1746:3: warning: initialization fr=
om incompatible pointer type [enabled by default]
>    .setup  =3D pci_brcm_trumanage_setup,
>    ^
> drivers/tty/serial/8250/8250_pci.c:1746:3: warning: (near initializat=
ion for =E2=80=98pci_serial_quirks[56].setup=E2=80=99) [enabled by defa=
ult]
>=20
> I'd also expect the initialization to not function correctly, and
> perhaps dereference random garbage due to this.  Since the uart_port
> is a field within the uart_8250_port, the adaptation to fix these
> warnings is a straightforward removal of a layer of indirection.
>=20
> Cc: Stephen Hurd <shurd@broadcom.com>
> Cc: Michael Chan <mchan@broadcom.com>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Cc: Rui Xiang <rui.xiang@huawei.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied to 3.4. Thanks.

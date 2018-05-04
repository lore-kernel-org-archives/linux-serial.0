From: Muni Sekhar <munisekharrms@gmail.com>
Subject: serial: uart_port->type
Date: Fri, 4 May 2018 23:08:21 +0530
Message-ID: <CAHhAz+iOotCJCnBhUUpw1v+3mB5BvU1sd8BnRzVv09J9y9bTjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi All,

For the uart_port structure=E2=80=99s =E2=80=9Ctype=E2=80=9D, I see the per=
mitted types are
none, 8250, 16450, 16550, 16550A, 16650, 16650V2, 16654, 16750, 16850,
16950, and 16954 etc.

For FPGA based UART hardware(it has 512 bytes FIFO and supports up to
4Mbps speed) what should be the =E2=80=98type=E2=80=99 value?


--=20
Thanks,
Sekhar

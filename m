From: Muni Sekhar <munisekharrms@gmail.com>
Subject: uart throughput
Date: Thu, 5 Apr 2018 22:08:14 +0530
Message-ID: <CAHhAz+io6_dS=+YO=Zd9rYuPomOOFtd2GsweKyvN1A4zKQZOVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

Hi All,


I=E2=80=99ve an uart hardware implemented on Xilinx FPGA image and it conne=
cts
to host CPU(Intel based chip) on PCIe bus in Linux platform.


The following parameters were fixed or varied when measuring the UART
throughput in internal loopback mode(UART_RX and UART_TX pins were
internally connected):



=E2=80=A2             Uart baud rate

=E2=80=A2             Parity Bit

=E2=80=A2             Stop Bit(s)



The primary factor affecting UART throughput is the baud rate, apart
from this any other factors affect the UART throughput?



For 4000000 bps uart baud rate, what should be the theoretical peak
data throughput?





--=20
Thanks,
Sekhar

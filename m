From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v3 00/10] tty: xuartps: Fix lock ups
Date: Sat, 21 Nov 2015 18:59:22 -0800
Message-ID: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Hi,

here is v3 of this series. It's largely the same as before, but I
adjusted 'tty: xuartps: Don't consider circular buffer when enabling
transmitter' according to Peter's suggestions.

I also spent some time trying to get Peter's test for flow control and
xchar running. The xchar thing fails and will need some more work, but =
I
think in general it should be possible to get it to work.
The flow control test passes:

root@Xilinx-ZC1751-DC1:~# ./flow /dev/ttyPS0
Test flow control on /dev/ttyPS0
begin test1
patterns sent: 223  recvd: 208
read distribution: 1   =3D 0
                   2+  =3D 0
                   4+  =3D 0
                   8+  =3D 0
                  16+  =3D 0
                  32+  =3D 643
                  64+  =3D 0
                 128+  =3D 0
                 256+  =3D 0
                 512+  =3D 0
PASSED

root@Xilinx-ZC1751-DC1:~# ./flow /dev/ttyPS1
Test flow control on /dev/ttyPS1
begin test1
patterns sent: 223  recvd: 208
read distribution: 1   =3D 0
                   2+  =3D 0
                   4+  =3D 0
                   8+  =3D 0
                  16+  =3D 0
                  32+  =3D 643
                  64+  =3D 0
                 128+  =3D 0
                 256+  =3D 0
                 512+  =3D 0
PASSED

	S=C3=B6ren

S=C3=B6ren Brinkmann (10):
  tty: xuartps: Beautify read-modify writes
  tty: xuartps: Use spinlock to serialize HW access
  tty: xuartps: Don't consider circular buffer when enabling transmitte=
r
  tty: xuartps: Clear interrupt status register in shutdown
  tty: xuartps: Improve startup function
  tty: xuartps: Keep lock for whole ISR
  tty: xuartps: Acquire port lock for shutdown
  tty: xuartps: Move RX path into helper function
  tty: xuartps: Only handle RX IRQs when RX is enabled
  tty: xuartps: Cleanup: Reformat if-else

 drivers/tty/serial/xilinx_uartps.c | 246 +++++++++++++++++++++--------=
--------
 1 file changed, 137 insertions(+), 109 deletions(-)

--=20
2.6.3.3.g9bb996a

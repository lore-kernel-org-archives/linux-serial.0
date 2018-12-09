From: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Subject: [PATCH v3 1/2] dt-bindings: serial: 8250: Add rate limit for serial port input overruns
Date: Mon, 10 Dec 2018 11:27:39 +1300
Message-ID: <20181209222739.15866-1-darwin.dingel@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc: chris.packham@alliedtelesis.co.nz, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
List-Id: linux-serial@vger.kernel.org

When a serial port continuously experiences input overrun from
(1) continuous receive characters from remote and or (2) hardware
issues, its interrupt handler can preempt other tasks especially
when the system is busy (ie. boot up period). This can cause other
tasks to get starved of processing time from the CPU.

When this dts binding is enabled and input overrun on the serial port
is detected, serial port receive will be throttled to give some breathing=

room for processing other tasks. Value provided will be in milliseconds.

&serial0{
=09overrun-throttle-ms =3D <500>;
};

Signed-off-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
---

Notes:
=20   Changelog
=20   v1->v2:
=20   - Separated dts binding to another patch
=20  =20
=20   v2->v3:
=20   - Fixed commit message and reviewed-by fields

=20Documentation/devicetree/bindings/serial/8250.txt | 1 +
=201 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Document=
ation/devicetree/bindings/serial/8250.txt
index aeb6db4e35c3..da50321da34d 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -51,6 +51,7 @@ Optional properties:
=20- tx-threshold: Specify the TX FIFO low water indication for parts wit=
h
=20  programmable TX FIFO thresholds.
=20- resets : phandle + reset specifier pairs
+- overrun-throttle-ms : how long to pause uart rx when input overrun is =
encountered.
=20
=20Note:
=20* fsl,ns16550:
--=20
2.19.2

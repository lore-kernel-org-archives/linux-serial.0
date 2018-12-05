From: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] serial: 8250: Add dts binding to rate limit serial port during overruns
Date: Wed,  5 Dec 2018 13:50:57 +1300
Message-ID: <20181205005058.14095-1-darwin.dingel@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
List-Id: linux-serial@vger.kernel.org

When this dts binding is enabled and input overrun on the serial port is
detected, serial port receive will be throttled to give some breathing ro=
om
for processing other tasks. This is particularly useful to avoid situatio=
ns
where serial port HW malfunctions triggering input overruns and then othe=
r
processes get starved of processing time. Value provided will be in
milliseconds.

&serial0{
=09overrun-throttle-ms =3D <500>;
};

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
---
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

changes in v2:
- separated dts binding to another patch

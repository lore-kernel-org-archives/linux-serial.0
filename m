From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: [RFC] serdev binding for QCA7000 UART driver
Date: Mon, 13 Mar 2017 17:10:20 +0100
Message-ID: <5177ec94-9ed5-a096-9877-05a69cc5b5f0@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

|Hi Rob, since serdev has been merged, i'm currently working on a
suitable ethernet driver for the QCA7000 [1]. In order to provide a plug
and play solution for the network interface i suggest the following
binding, which uses common properties for UART configuration: * Qualcomm
QCA7000 (Ethernet over UART protocol) Note: The QCA7000 is also useable
as a UART slave device. Required properties: - compatible : Should be
"qca,qca7000-uart" Optional properties: - local-mac-address : 6 bytes,
specifies MAC address - current-speed : Specifies current serial device
speed in bits per second (default = 115200) - data-bits : Specifies
number of data bits (default = 8) - use-parity : If present, this
enables the parity error detection (default = off) - odd-parity : If
present, this specifies that the parity of each character must be odd
(default = even) Example: /* Freescale i.MX28 UART */ auart0:
serial@8006a000 { compatible = "fsl,imx28-auart", "fsl,imx23-auart"; reg
= <0x8006a000 0x2000>; pinctrl-names = "default"; pinctrl-0 =
<&auart0_2pins_a>; status = "okay"; qca7000: ethernet { compatible =
"qca,qca7000-uart"; local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
current-speed = <38400>; data-bits = <8>; use-parity; odd-parity; }; };
Is it okay for you or do you want a different kind of configuration? Are
there any plans for parity handling? Thanks Stefan |

[1] - https://lwn.net/Articles/701225/

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

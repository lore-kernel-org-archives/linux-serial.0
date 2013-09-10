From: Christian Jann <christian.jann@ymail.com>
Subject: Need some help with auart on imx23
Date: Tue, 10 Sep 2013 12:26:32 +0200
Message-ID: <3205717.NO7EKVN077@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm11.bullet.mail.ird.yahoo.com ([77.238.189.64]:23681 "HELO
	nm11.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751011Ab3IJKd0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Sep 2013 06:33:26 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi, I could really need some help to get the second application uart working 
on my imx23 based board.

I've seen this message: http://article.gmane.org/gmane.linux.serial/9184/: 
"But in mx23, the DMA has a bug(see errata:2836). We can not add the DMA 
support in mx23"

Hopefully there is only something wrong with my devicetree.

In arm/boot/dts/imx23-olinuxino.dts I've added:

auart1: serial@8006e000 {
  pinctrl-names = "default";
  pinctrl-0 = <&auart1_2pins_a>;
  status = "okay";
};

And in arch/arm/boot/dts/imx23.dtsi I've added:

auart1_2pins_a: auart1-2pins@0 {
  reg = <0>;
  fsl,pinmux-ids = <
    0x00e0 /* MX23_PAD_GPMI_D14__GPMI_D14 */
    0x00f0 /* MX23_PAD_GPMI_D15__GPMI_D15 */
  >;
  fsl,drive-strength = <0>;
  fsl,voltage = <1>;
  fsl,pull-up = <0>;
};

I've adapted both from auart0 that was working on my OLinuXino.

The device /dev/ttyAPP1 is available and the serial getty should be configured 
correctly because I can use /dev/ttyAPP0 on my OLinuXino and I've configured 
it here in the same way. I can also eliminate a hardware problem because I 
have a working minimal example without OS where I can receive something on 
auart1.

Here is my current devicetree:

- http://www.jann.cc/_downloads/next-20130910_imx23.dtsi,
- http://www.jann.cc/_downloads/next-20130910_imx23-olinuxino.dts,
- http://www.jann.cc/_downloads/next-20130910.diff

It wasn't working in 3.9.4 and 3.10.11 too.

And my odyssey is documented here:

- http://www.jann.cc/2013/08/31/porting_linux_to_a_new_board.html#step-4-the-application-uart

I can use GDB to debug the kernel but I don't really know where to start, 
maybe something is broken in drivers/tty/serial/mxs-auart.c. Hopefully 
somebody could give me a hint what to do.

--
chris



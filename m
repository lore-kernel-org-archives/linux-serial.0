From: Christian Jann <christian.jann@ymail.com>
Subject: Re: Need some help with auart on imx23
Date: Fri, 13 Sep 2013 21:28:58 +0200
Message-ID: <1523739.AE3jKYTuqA@thinkpad>
References: <3205717.NO7EKVN077@thinkpad> <1485573.VUJ6COcddm@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm10-vm1.bullet.mail.ird.yahoo.com ([77.238.189.93]:23878 "HELO
	nm10-vm1.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754421Ab3IMT3B (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Sep 2013 15:29:01 -0400
In-Reply-To: <1485573.VUJ6COcddm@thinkpad>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Tuesday 10 September 2013 19:58:01 you wrote:
> On Tuesday 10 September 2013 12:26:32 you wrote:
> > Hi, I could really need some help to get the second application uart
> > working on my imx23 based board.
> > 

So I've finally solved the issue after reading 
Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt again, the 
pinmux-ids were wrong.

Required subnode-properties:
- fsl,pinmux-ids: An integer array.  Each integer in the array specify a pin
  with given mux function, with bank, pin and mux packed as below.

    [15..12] : bank number
    [11..4]  : pin number
    [3..0]   : mux selection

0000000000000000
[  ][      ][  ]
bank  pin    mux

0000000011100000 0x00e0 /* MX23_PAD_GPMI_D14__GPMI_D14 */
0000000011110000 0x00f0 /* MX23_PAD_GPMI_D15__GPMI_D15 */
  0b00001110 = 14
  0b00001111 = 15

Looking at the datasheet, mux for auart should be 01:

0000000011100001 0x00e1 /* MX23_PAD_GPMI_D14__AUART2_TX */
0000000011110001 0x00f1 /* MX23_PAD_GPMI_D15__AUART2_RX */


Before I haven't understood the exact functioning of fsl,pinmux-ids but now 
I've corrected arch/arm/boot/dts/imx23.dtsi:

auart1_2pins_a: auart1-2pins@0 {
  reg = <0>;
  fsl,pinmux-ids = <
    0x00e1 /* MX23_PAD_GPMI_D14__AUART2_TX */
    0x00f1 /* MX23_PAD_GPMI_D15__AUART2_RX */
  >;
  fsl,drive-strength = <0>;
  fsl,voltage = <1>;
  fsl,pull-up = <0>;
};

--
chris



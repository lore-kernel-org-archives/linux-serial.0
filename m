From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 5/7] ARM: meson: dts: add basic
 Meson/Meson6/Meson6-atv1200 DTSI/DTS
Date: Mon, 18 Aug 2014 17:15:07 +0100
Message-ID: <20140818161507.GC3302@leverpostej>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-6-git-send-email-carlo@caione.org>
 <20140817144201.GB29963@gmail.com>
 <CAOQ7t2Ye2FjB-+YYQJg6xnFyfj4VNpdm9NFqjE2A+inTZ1=BkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49388 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751091AbaHRQQh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 12:16:37 -0400
Content-Disposition: inline
In-Reply-To: <CAOQ7t2Ye2FjB-+YYQJg6xnFyfj4VNpdm9NFqjE2A+inTZ1=BkQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: Beniamino Galvani <b.galvani@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "grant.likely@linaro.org" <grant.likely@linaro.org>

On Sun, Aug 17, 2014 at 04:21:23PM +0100, Carlo Caione wrote:
> On Sun, Aug 17, 2014 at 4:42 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:
> > Hi,
> 
> >> +/include/ "meson.dtsi"
> >> +
> >> +/ {
> >> +     model = "Amlogic Meson6 SoC";
> >> +     compatible = "amlogic,meson6", "amlogic,8726_mx";
> >> +
> >> +     interrupt-parent = <&gic>;
> >> +
> >> +     cpus {
> >> +             #address-cells = <1>;
> >> +             #size-cells = <0>;
> >> +
> >> +             cpu@0 {
> >
> > The address after the @ should match the value of the 'reg' property.

Just remember to strip the leading "0x" (this should be "cpu@200").

Cheers,
Mark.

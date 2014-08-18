From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH 7/7] ARM: meson: update documentation (uart, timer and
 vendors)
Date: Mon, 18 Aug 2014 15:33:25 +0200
Message-ID: <20140818133325.GC28819@carlo-MacBookPro>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-8-git-send-email-carlo@caione.org>
 <53F1D73F.8010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50333 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaHRNda (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 09:33:30 -0400
Content-Disposition: inline
In-Reply-To: <53F1D73F.8010204@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com

On Mon, Aug 18, 2014 at 12:36:47PM +0200, Matthias Brugger wrote:
> 
> 
> On 17/08/14 12:49, Carlo Caione wrote:
> >New UART and timer bindings are documented. A new vendor is added to the
> >vendors list.
> >
> >Signed-off-by: Carlo Caione <carlo@caione.org>
> >---
> >  .../devicetree/bindings/serial/amlogic,meson-uart.txt   | 17 +++++++++++++++++
> >  .../devicetree/bindings/timer/amlogic,meson6-timer.txt  | 16 ++++++++++++++++
> >  Documentation/devicetree/bindings/vendor-prefixes.txt   |  1 +
> >  3 files changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
> >  create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
> 
> This should be three patches for the different files. It might
> happen, that for example your timer driver get merged through a
> different tree then arm-soc. For the merge, the driver and the
> documentation should go togehter.

Right. Thank you for pointing this out.

Best,

-- 
Carlo Caione

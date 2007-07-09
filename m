From: Luca <kronos.it@gmail.com>
Subject: Re: [PATCH] Enable legacy support for serial ports when SERIAL_8250_PNP is disabled
Date: Mon, 9 Jul 2007 19:30:59 +0200
Message-ID: <68676e00707091030xe7a299je9f4e053ef2a2e98@mail.gmail.com>
References: <20070707233300.GA3267@dreamland.darkstar.lan>
	 <200707090946.33101.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:45891 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbXGIRbB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Jul 2007 13:31:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1491064wah
        for <linux-serial@vger.kernel.org>; Mon, 09 Jul 2007 10:31:00 -0700 (PDT)
In-Reply-To: <200707090946.33101.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 7/9/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Saturday 07 July 2007 05:33:00 pm Luca Tettamanti wrote:
> > your patch:
> >
> > commit 7e92b4fc345f5b6f57585fbe5ffdb0f24d7c9b26
> > Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > Date:   Tue May 8 00:36:07 2007 -0700
> >
> >     x86, serial: convert legacy COM ports to platform devices
> >
> > disables probing using legacy code in favour of ACPI/PNP to avoid double
> > discovery.
> >
> > However if SERIAL_8250_PNP is not enabled the user is left without
> > serial ports (been there, done that - my kernel config suddenly wasn't
> > working anymore). So:
>
> Yes, that's true.  Kconfig should automatically turn on SERIAL_8250_PNP
> if PNP and SERIAL_8250 are selected, but it does give you a choice if
> you have EMBEDDED set.  So I guess you must have this:
>
>   CONFIG_EMBEDDED=y
>   CONFIG_PNP=y
>   CONFIG_SERIAL_8250=y
>   CONFIG_SERIAL_8250_PNP=n
>
> Why do you want PNP support, but not 8250_PNP support?

That's a good question :-) IIRC the serial PNP code used to mess up
the mode of the port on my laptop, making it useless for debugging the
boot. Bug was fixed long ago, but I didn't re-enabled that option.

> If you turn off
> PNP completely, you will have "pnp_platform_devices == 0", and the
> existing code will do what you need.

Well for me it's a non-issue, I'm able to "work-around" it in many
ways. My point is that a configuration that used to work and is still
valid suddenly doesn't work anymore. I missed the dependacy on
CONFIG_EMBEDDED though, so feel free to ignore the patch ;-)

Luca

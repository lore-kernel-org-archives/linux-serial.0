From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/4] tty: serial: bcm63xx_uart: add support for DT
 probing
Date: Thu, 20 Feb 2014 12:21:31 +0000
Message-ID: <20140220122131.GA32745@e106331-lin.cambridge.arm.com>
References: <1392852167-26243-1-git-send-email-f.fainelli@gmail.com>
 <1392852167-26243-4-git-send-email-f.fainelli@gmail.com>
 <CAOiHx==rYbsy66zRUc-QXTS7ZjaX8v9kiomp+m33+tcEtKC-dA@mail.gmail.com>
 <CAGVrzcYEWJ6nKncSx3jjWFp9TXf8PFJnd-joPwSe0mDh-CeMiw@mail.gmail.com>
 <CAOiHx=mDYsGjtEXEK+8YUo4WZRQeXYvDJdfk2OQtqheeaD7icw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42291 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752214AbaBTMVm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Feb 2014 07:21:42 -0500
Content-Disposition: inline
In-Reply-To: <CAOiHx=mDYsGjtEXEK+8YUo4WZRQeXYvDJdfk2OQtqheeaD7icw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jonas Gorski <jogo@openwrt.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Maxime Bizon <mbizon@freebox.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thu, Feb 20, 2014 at 10:59:04AM +0000, Jonas Gorski wrote:
> On Thu, Feb 20, 2014 at 2:29 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > 2014-02-19 16:00 GMT-08:00 Jonas Gorski <jogo@openwrt.org>:
> >> On Thu, Feb 20, 2014 at 12:22 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>> @@ -857,6 +861,12 @@ static int bcm_uart_remove(struct platform_device *pdev)
> >>>         return 0;
> >>>  }
> >>>
> >>> +static const struct of_device_id bcm63xx_of_match[] = {
> >>> +       { .compatible = "brcm,bcm63xx-uart" },
> >>
> >> From my understanding, this should be "brcm,bcm6345-uart", because
> >> this kind of uart appeared first on bcm6345 (well, maybe bcm6335, no
> >> idea which one of these two was first, but the latter was never
> >> supported in mainline anyway).
> >
> > That's right, in fact, I think it might be desirable to handle both
> > compatible string, just as a hint that it is compatible with the
> > entire bcm63xx family. Would that work for you?
> 
> I think using a "generic" compatible string is rather frowned upon
> (what do you do if there is eventually a bcm63xx chip with an
> incompatible uart?), but I'm no device tree expert.

As long as each compatible string entry describes something that has a
compatible programming model, there's no problem. The new UART wouldn't
be described with a string it's not compatible with.

I think "brcm,bcm6345-uart," is a nicer name to use for the moment than
"brcm,bcm63xx-uart" as it clearly describes a specific UART and is less
likely to be problematic in future if an incompatible UART appears.
Additionally, each compatible UART can have a more specific compatible
string entry that allows them to be more uniquely identified in case
they need to be handled specially in future. e.g:

  compatible = "brcm,bcm634x-uart", "brcm,bcm6345-uart";

Then if a bcm634y comes out with a UART that's not compatible with the
bcm6345 UART, it just needs:

  compatible = "brcm,bcm634y-uart";

Thanks,
Mark.

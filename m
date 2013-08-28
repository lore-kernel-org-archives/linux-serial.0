From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Wed, 28 Aug 2013 11:37:21 +0530
Message-ID: <CAKohpo=jyyiqVLzGY-70_iAOrE94xdF5JGmzgLTNAoVrpSEhjw@mail.gmail.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
	<52123A44.9090608@hurleysoftware.com>
	<CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com>
	<5212D602.2000005@hurleysoftware.com>
	<CAKohpomE+6fxwF4JsDUDCzf+LsWZ_deBsRzF_XYjQHZTPvp_jw@mail.gmail.com>
	<5213C5CA.7060206@hurleysoftware.com>
	<CAKohpo=rZn-0FwcK5gzyYXufpVvfFHXSz_bK0=EqJbTDNcxqMQ@mail.gmail.com>
	<CAKohpokL4_RZ7s=yyn8S5jKh5zpW_DaUK4ni5_x_qN2+0Bv-Uw@mail.gmail.com>
	<20130827231946.GA18233@kroah.com>
	<CAKohpomP6Cj0Jp6ZqKTqw6Tb3sc8UQo3D46JJ6+LB9ahUex1SQ@mail.gmail.com>
	<20130828060536.GA19160@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:52323 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577Ab3H1GHW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Aug 2013 02:07:22 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so7270982oah.9
        for <linux-serial@vger.kernel.org>; Tue, 27 Aug 2013 23:07:21 -0700 (PDT)
In-Reply-To: <20130828060536.GA19160@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>, Linaro Networking <linaro-networking@linaro.org>, Peter Hurley <peter@hurleysoftware.com>

On 28 August 2013 11:35, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> Why, as it doesn't cause problems unless you are running rt kernels at
> the moment, right?  Is there some other way to trigger the problem that
> you know of?

No, its only coming for RT kernels...

> Remember, stable is for "real" problems :)

I faced this issue while working on 3.10 rt kernel and so asked :)

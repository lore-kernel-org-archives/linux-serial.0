From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/4] serial: imx: Fix the reporting of interrupts
Date: Tue, 28 Oct 2014 23:58:10 -0200
Message-ID: <CAOMZO5B=C0LVKoGuA8=xzNTpp8X8p5PdZy0h_1nCOq-Wt-C7Ww@mail.gmail.com>
References: <1414428580-29534-1-git-send-email-fabio.estevam@freescale.com>
	<8e4a991e46474daa8bc40b96e8042ef2@BLUPR03MB373.namprd03.prod.outlook.com>
	<CAOMZO5CvM6V9LCUEuDshVzRQoELcQPQVC40dm0Pzw7DQYiJbFQ@mail.gmail.com>
	<77b6c2f96de043f79840fed8fcfe254d@BLUPR03MB373.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:40252 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaJ2B6M (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Oct 2014 21:58:12 -0400
Received: by mail-lb0-f172.google.com with SMTP id n15so1686639lbi.17
        for <linux-serial@vger.kernel.org>; Tue, 28 Oct 2014 18:58:10 -0700 (PDT)
In-Reply-To: <77b6c2f96de043f79840fed8fcfe254d@BLUPR03MB373.namprd03.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Oct 28, 2014 at 11:33 PM, fugang.duan@freescale.com
<fugang.duan@freescale.com> wrote:

> Ok, if wake up function still work, the patch is fine for me.
> But I suggest you do one test like this:
> 1. echo enabled > /sys/class/tty/ttymxc0/power/wakeup
> 2. echo mem > /sys/power/state
> 3. ..quickly click console key in continuously.
> (Make sure the delay between step2 and step3 is little)

Tested this and it worked fine on a mx6qsabresd.

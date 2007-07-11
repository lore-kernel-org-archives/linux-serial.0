From: Luca <kronos.it@gmail.com>
Subject: Re: [PATCH] Enable legacy support for serial ports when SERIAL_8250_PNP is disabled
Date: Wed, 11 Jul 2007 21:40:07 +0200
Message-ID: <68676e00707111240v28263cc7i13c033c8be1339b9@mail.gmail.com>
References: <20070707233300.GA3267@dreamland.darkstar.lan>
	 <200707090946.33101.bjorn.helgaas@hp.com>
	 <68676e00707091030xe7a299je9f4e053ef2a2e98@mail.gmail.com>
	 <200707091230.01556.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:40818 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757775AbXGKTkJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Jul 2007 15:40:09 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1456411nze
        for <linux-serial@vger.kernel.org>; Wed, 11 Jul 2007 12:40:07 -0700 (PDT)
In-Reply-To: <200707091230.01556.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 7/9/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Monday 09 July 2007 11:30:59 am Luca wrote:
> > On 7/9/07, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > > If you turn off
> > > PNP completely, you will have "pnp_platform_devices == 0", and the
> > > existing code will do what you need.
> >
> > Well for me it's a non-issue, I'm able to "work-around" it in many
> > ways. My point is that a configuration that used to work and is still
> > valid suddenly doesn't work anymore.
>
> You're right about that, and it is a legitimate issue.  But given the
> fact that (PNP && !SERIAL_8250_PNP) should be relatively unusual, my
> opinion is that it's not worth extra ifdefs in legacy_serial.c.
>
> If you have to use any workarounds like "legacy_serial.force", I think
> that's a bug, and I'll fix it.

Ok, I double-checked: the serial port is usable during boot with PNP
enabled, so no problem with dropping my patch.

Luca

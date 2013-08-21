From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Wed, 21 Aug 2013 10:05:35 +0530
Message-ID: <CAKohpo=rZn-0FwcK5gzyYXufpVvfFHXSz_bK0=EqJbTDNcxqMQ@mail.gmail.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
	<52123A44.9090608@hurleysoftware.com>
	<CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com>
	<5212D602.2000005@hurleysoftware.com>
	<CAKohpomE+6fxwF4JsDUDCzf+LsWZ_deBsRzF_XYjQHZTPvp_jw@mail.gmail.com>
	<5213C5CA.7060206@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:59938 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab3HUEfg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Aug 2013 00:35:36 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so2233605obc.40
        for <linux-serial@vger.kernel.org>; Tue, 20 Aug 2013 21:35:36 -0700 (PDT)
In-Reply-To: <5213C5CA.7060206@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>, Linaro Networking <linaro-networking@linaro.org>

On 21 August 2013 01:08, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 08/20/2013 06:52 AM, Viresh Kumar wrote:

> That's really Greg's call whether he wants to take up RT-specific patches
> into the regular tree.

Yeah.. Lets wait for Greg..

>> One more thing: We are calling tty_flip_buffer_push() with (from interrupt
>> context) and without (from process context) port->lock held.  Shouldn't we
>>
>> make this flat, like don't acquire port->lock while calling
>> tty_flip_buffer_push() as that may cause recursive locking?
>
> When you note that tty_flip_buffer_push() is called from 'process context',
> I assume you mean kworker threads handling rx DMA. Besides the pty driver
> and the fwserial staging driver that has loopback mode, I'm not aware of
> any other drivers that do rx from process context.

Okay.. And so most of the people call it from interrupt context (25+ of them,
I am trying to fix for RT and others are already doing the right thing) and all
of these must have set port->low_latency to false.

Now my questions is, what exactly we want to protect in this function while
calling it from interrupt or process context? For which we need a port->lock
to be held by caller?

There are drivers which are sustaining without a lock being held by caller and
others shouldn't have any problem doing that... That might be a clean solution
for Mainline and that will fix the RT issues we are facing :)

--
viresh

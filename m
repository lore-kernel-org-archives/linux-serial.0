From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/25] tty: serial: drop uart_port->lock before calling
Date: Fri, 16 Aug 2013 23:14:52 +0530
Message-ID: <CAKohpomFJprUfTOXrPpkp0LYgy_9WJBSHuRC49dJ7_X1=untUg@mail.gmail.com>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
	<20130816122753.GA24550@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57756 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab3HPRow (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 13:44:52 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so2358738obb.19
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 10:44:52 -0700 (PDT)
In-Reply-To: <20130816122753.GA24550@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>

On 16 August 2013 17:57, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Aug 16, 2013 at 05:13:01PM +0530, Viresh Kumar wrote:
>> The -rt patch triggers a lockdep warning for serial drivers if
>> tty_flip_buffer_push() is called with uart_port->lock locked. This never shows
>> up on UP kernels.
>
> What about SMP kernels?  linux-next?

As per Thomas Gleixner initial patch, it must break for SMP too. But we
have tested it only for 3.10 stable merged with RT Kernel patchset..

Haven't tried it on linux-next..

>> This is neither tested nor compiled.
>
> So I'm guessing you don't want it to be applied, if you can't take the
> time to at least test-build it, why should we?
>
> {sigh}

:( ..

Actually I build tested it for few ARM platforms but not for others.. Now
its build tested for all platforms that are modified here..

> Lots of tty and serial changes have happened since -rc5 in linux-next,
> can you please rebase, and test, these against that tree and resend them
> if they are still needed?

I have rebased them over latest linux-next and they applied cleanly..
Haven't tested it though.. Will try that next week.

Sorry for the noise :(

--
viresh

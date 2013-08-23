From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Fri, 23 Aug 2013 13:56:08 +0530
Message-ID: <CAKohpokL4_RZ7s=yyn8S5jKh5zpW_DaUK4ni5_x_qN2+0Bv-Uw@mail.gmail.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
	<52123A44.9090608@hurleysoftware.com>
	<CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com>
	<5212D602.2000005@hurleysoftware.com>
	<CAKohpomE+6fxwF4JsDUDCzf+LsWZ_deBsRzF_XYjQHZTPvp_jw@mail.gmail.com>
	<5213C5CA.7060206@hurleysoftware.com>
	<CAKohpo=rZn-0FwcK5gzyYXufpVvfFHXSz_bK0=EqJbTDNcxqMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:50934 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab3HWI0I (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Aug 2013 04:26:08 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so412352oag.41
        for <linux-serial@vger.kernel.org>; Fri, 23 Aug 2013 01:26:08 -0700 (PDT)
In-Reply-To: <CAKohpo=rZn-0FwcK5gzyYXufpVvfFHXSz_bK0=EqJbTDNcxqMQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>, Linaro Networking <linaro-networking@linaro.org>, Peter Hurley <peter@hurleysoftware.com>

On 21 August 2013 10:05, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21 August 2013 01:08, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 08/20/2013 06:52 AM, Viresh Kumar wrote:
>
>> That's really Greg's call whether he wants to take up RT-specific patches
>> into the regular tree.
>
> Yeah.. Lets wait for Greg..

Hi Greg,

Should I resend my patches with better commit logs if you are going to
take these patches?

--
viresh

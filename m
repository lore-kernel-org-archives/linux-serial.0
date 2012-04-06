From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/6] tegra, serial8250: add ->handle_break() uart_port op
Date: Fri, 6 Apr 2012 15:25:11 -0700
Message-ID: <CABE8wwvfqEgCqfMKTpLVfsYqJ5KaxAKkUd67uoEfFLMes1SrFg@mail.gmail.com>
References: <20120406184346.21744.18004.stgit@dwillia2-linux.jf.intel.com>
	<20120406184956.22088.85217.stgit@dwillia2-linux.jf.intel.com>
	<4F7F59B2.4090400@wwwdotorg.org>
	<CABE8wws23LSLBxz34LYuyYtXMCG+-YTShhojXdeVkfiOvHWseQ@mail.gmail.com>
	<4F7F66A4.8070701@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:2487 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758235Ab2DFWZO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Apr 2012 18:25:14 -0400
Received: by bkcjm19 with SMTP id jm19so2275184bkc.25
        for <linux-serial@vger.kernel.org>; Fri, 06 Apr 2012 15:25:11 -0700 (PDT)
In-Reply-To: <4F7F66A4.8070701@wwwdotorg.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: gregkh@linuxfoundation.org, Sudhakar Mamillapalli <sudhakar@fb.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Nhan H Mai <nhan.h.mai@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, alan@linux.intel.com

On Fri, Apr 6, 2012 at 2:56 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/06/2012 03:28 PM, Williams, Dan J wrote:
>> On Fri, Apr 6, 2012 at 2:01 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 04/06/2012 12:49 PM, Dan Williams wrote:
>>>> The "KT" serial port has another use case for a "received break" quirk,
>>>> so before adding another special case to the 8250 core take this
>>>> opportunity to push such quirks out of the core and into a uart_port op.
>>>
>>> This doesn't seem quite right. Why do the board files have to set up
>>> this .handle_break function; they're already setting .type=PORT_TEGRA,
>>> which should be enough to drive the setup of any required quirks.
>>
>> Because struct serial8250_config does not convey any uart_port ops.
>
> But couldn't it be enhanced to do so, just like this patch added a field
> to struct uart_port for this? If you went this route, then the change
> would be entirely isolated within 8250.c, so you could drop all the
> arch/arm/mach-tegra changes, and also not need to update of_serial.c.

That's kind of the point, it seems the goal of serial port hardware
design is to find new and interesting ways to make them fail.  Putting
everyone's fail in 8250.c is messy so when we tried to add another
"handle_break" quirk we were rightly asked to make the core interface
generic and push the logic out of the core.

I don't see how moving quirk routines into serial8250_config makes
this any cleaner, we'd either be left with two methods for specifying
quirks, or requiring custom serial8250_configs for drivers that only
want to set one of the ops.

Hmm, is there any precendent for an openfirmware serial port that
needs one of these custom ops?

        unsigned int            (*serial_in)(struct uart_port *, int);
        void                    (*serial_out)(struct uart_port *, int, int);
        void                    (*set_termios)(struct uart_port *,
                                               struct ktermios *new,
                                               struct ktermios *old);
        int                     (*handle_irq)(struct uart_port *);
        void                    (*pm)(struct uart_port *, unsigned int state,
                                      unsigned int old);
        void                    (*handle_break)(struct uart_port *);

...I would be surprised if this is the first time this has come up
given the prevalence of broken uarts.

--
Dan

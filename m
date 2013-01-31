From: Joe Millenbach <jmillenbach@gmail.com>
Subject: Re: [PATCHv5] tty: Added a CONFIG_TTY option to allow removal of TTY
Date: Thu, 31 Jan 2013 09:35:49 -0800
Message-ID: <CADwDc1D5hCZdmsZvMx9NaQ_6BVioM7UtAFvniNBBRbo0OuEuUw@mail.gmail.com>
References: <1359594919-2819-1-git-send-email-jmillenbach@gmail.com>
	<20130131051728.GA2961@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58933 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab3AaRfw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Jan 2013 12:35:52 -0500
In-Reply-To: <20130131051728.GA2961@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jirislaby@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, Jamey Sharp <jamey@minilop.net>

On Wed, Jan 30, 2013 at 9:17 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This isn't going to work because I've already applied this to my tree.
> Can you just make a tiny patch against the tty-next git tree to fix up
> the differences here for the Input drivers and I can apply that?
>
> thanks,
>
> greg k-h

Oh, I misunderstood and thought you were backing out the whole commit.
 I'll get started tonight after work.

- Joe

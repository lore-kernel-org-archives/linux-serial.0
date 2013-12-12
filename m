From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH] serial: 8250_dw: Fix LCR workaround regression
Date: Wed, 11 Dec 2013 17:00:15 -0800
Message-ID: <CAAYSxhonv=zvhVJwM2s8ANFZp24=KjmB=C5zm7gcN9yg+wVzhQ@mail.gmail.com>
References: <1386714484-30251-1-git-send-email-james@albanarts.com>
	<20131211140014.GF28456@xps8300>
	<CAAYSxhr10XqQdQrvGf3Ez6e4LSbvmc0J-=yRgUePVEcd93e5wQ@mail.gmail.com>
	<2515351.7napg2VnCT@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40295 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab3LLBAQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Dec 2013 20:00:16 -0500
Received: by mail-ob0-f174.google.com with SMTP id wn1so7881285obc.33
        for <linux-serial@vger.kernel.org>; Wed, 11 Dec 2013 17:00:15 -0800 (PST)
In-Reply-To: <2515351.7napg2VnCT@radagast>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Jiri Slaby <jslaby@suse.cz>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matt Porter <matt.porter@linaro.org>, Markus Mayer <markus.mayer@linaro.org>

On Wed, Dec 11, 2013 at 1:05 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On Wednesday 11 December 2013 13:00:33 Tim Kryger wrote:

>> DT declared DW UARTs don't run autoconfig and don't see this issue as
>> far as I know.

> Thanks for the extra description. FYI, I was instantiating DW UART from DT
> when I saw the problem.

You are right.  It is a little more nuanced.

The regression will also appear for DT declared UARTs if they were
configured without FIFOs or with UART_ADD_ENCODED_PARAMS = 0.

-Tim

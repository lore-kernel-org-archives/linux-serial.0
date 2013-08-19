From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/25] tty: serial: drop uart_port->lock before calling
Date: Mon, 19 Aug 2013 20:07:15 +0530
Message-ID: <CAKohponfEnujiMJHAKw_rTUByuw6v6ahuqdqK-mHWHhKh8Ek-w@mail.gmail.com>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
	<20130816122753.GA24550@kroah.com>
	<CAKohpomFJprUfTOXrPpkp0LYgy_9WJBSHuRC49dJ7_X1=untUg@mail.gmail.com>
	<CAKohponE-FY132W8zcLn-yAP+wLQjJ4xH9_HPeyV5K1VRdjksw@mail.gmail.com>
	<52121A8F.8050600@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:65523 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab3HSOhQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Aug 2013 10:37:16 -0400
Received: by mail-qc0-f170.google.com with SMTP id i8so2541206qcq.1
        for <linux-serial@vger.kernel.org>; Mon, 19 Aug 2013 07:37:16 -0700 (PDT)
In-Reply-To: <52121A8F.8050600@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>

On 19 August 2013 18:45, Peter Hurley <peter@hurleysoftware.com> wrote:
> Umm. How did a worker thread schedule while an IRQ handler was holding a
> irq-disabling spin lock?

Not sure.. I was just trying to fix a random issue that came to me. Don't really
have much knowledge of serial backend :(

> PS - please paste your stack backtraces with line-wrap disabled

I copied it correctly but its gmail which corrupted it.. If I see the
text in your
reply its fixed automatically :)

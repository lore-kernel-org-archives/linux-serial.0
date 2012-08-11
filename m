From: Tomas Hlavacek <tmshlvck@gmail.com>
Subject: Re: RFC: exposing uartclk value to sysfs
Date: Sat, 11 Aug 2012 10:18:09 +0200
Message-ID: <CAEB7QLCddnn3Te0q81YytkvKyWfkwcRSL5ppQFkY0viXLHOxSQ@mail.gmail.com>
References: <CAEB7QLAJXkK6NDPVDi36n_U_X_DGh5niHJhH6FpqBUZFmXQ2Xg@mail.gmail.com>
	<20120810234858.4a5decd4@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57329 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab2HKISK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 11 Aug 2012 04:18:10 -0400
Received: by yhmm54 with SMTP id m54so2315099yhm.19
        for <linux-serial@vger.kernel.org>; Sat, 11 Aug 2012 01:18:09 -0700 (PDT)
In-Reply-To: <20120810234858.4a5decd4@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>

On Sat, Aug 11, 2012 at 12:48 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Although there is a way to set baud_base via setserial(8) I was
>> wandering whether it would be possible to expose uartclk in sysfs for
>> read/write. I have created a following proof-of-concept experimental
>> patch:
>
> That would probably be a *lot* more civilised. As a conceptual idea I
> think its a good one.

OK, I will dig into it and I will come up with more elaborate patch next time.

Tomas

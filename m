From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Deterministic behavior for TTY serial
Date: Tue, 1 May 2012 16:04:56 +0100
Message-ID: <20120501160456.3b0b5e34@pyramind.ukuu.org.uk>
References: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
	<20120419001407.GA24710@kroah.com>
	<CAMSQXEEkssPGWYgC4dkpKEhfrB4s8yOoxiNNVdRRX7r+b91EMQ@mail.gmail.com>
	<20120419154609.GA9263@kroah.com>
	<CAMSQXEEN=6M59CR3riNA5-kFFv7QAsn_g3PHi3A8P9mh3SfdeQ@mail.gmail.com>
	<CAMSQXEGb9moJbCQwwXgEq7H-HvaSiuS5JBL55jr0ZhEEeAmqzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54765 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291Ab2EAPCM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 May 2012 11:02:12 -0400
In-Reply-To: <CAMSQXEGb9moJbCQwwXgEq7H-HvaSiuS5JBL55jr0ZhEEeAmqzw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ivo Sieben <meltedpianoman@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, RT <linux-rt-users@vger.kernel.org>

> This Spin Lock is defined globally, This causes that my high priority
> process to get blocked because of a lower priority process that holds
> this spin lock. Of course you get priority inheritance, but this adds
> quite a lot of extra execution time to the read function (because of
> additional spin lock behavior, and scheduling to the lower priority
> process)

It's a spin lock and its only held across very small numbers of
instructions in any normal path so this rather surprises me - in your
actual capture data can you see what is holding the lock for long times
causing this ?

> Since the "user" and "refcount" reference counters have combined
> behavior (refcount is decremented when users reaches zero), I don't
> see a way to remove this global lock. Any ideas how this can be
> improved?

I've never really thought about it because it should never be contended
in any meaningful way.

Alan

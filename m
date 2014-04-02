From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] serial: 8250, disable "too much work" messages
Date: Wed, 2 Apr 2014 17:43:42 +0100
Message-ID: <20140402174342.1f78a39e@alan.etchedpixels.co.uk>
References: <1396352220-5031-1-git-send-email-jslaby@suse.cz>
	<20140401144057.63b3ceb5@alan.etchedpixels.co.uk>
	<533BDC4F.3060903@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <533BDC4F.3060903@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> So, according to Takashi's measurements, we would need over 15000 loops
> on a single port. Of course, this value is highly dependent on a system.
> On my system, it is like 7 times lower (2100). And it lasts ~300ms here.
> 
> I suppose a limit like 32k loops is way too much and I just should go
> and implement the polling. Or what about adding inter-character sleeps
> to qemu to correspond to the speed? I can do that too, but I am not sure
> if limiting the throughput will be accepted by them.

The other option would be to detect qemu as a buggy uart, log a warning
and ignore the test on it. I think polling might be better, and that
would probably fix hang cases on real buggy uarts where right now we
sometimes keel over.

From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH 0/7] 3.8-rc regression with pps-ldisc due to 70ece7a731
Date: 8 Feb 2013 19:22:58 -0500
Message-ID: <20130209002258.15821.qmail@science.horizon.com>
References: <20130208233656.GA7700@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:21083 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760395Ab3BIAXA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Feb 2013 19:23:00 -0500
In-Reply-To: <20130208233656.GA7700@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux@horizon.com
Cc: giometti@linux.it, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter@hurleysoftware.com

> As this is a breakage in 3.8-rc1, is there any way to pull out patches 5
> and 6 in a format that I can apply them now, or in a way that I can get
> I can't apply all of these to 3.8-final now, as it's way too late.

I'll reorder them for you.  But Philipp will be bitterly disappointed. :-)

The other cleanups are far smaller and lower risk than the infrastructure
added in #5; I was just being OCD about committing the "least patchable
unit".

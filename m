From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question:  How to power-manage UART-attached devices.
Date: Mon, 30 Apr 2012 23:33:22 +0100
Message-ID: <20120430223322.GA3951@sirena.org.uk>
References: <20120501082209.0b560708@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120501082209.0b560708@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 01, 2012 at 08:22:09AM +1000, NeilBrown wrote:

>  The question is how can user-space tell the kernel that these devices are
>  'inactive'?

>  I would like to integrate this into Linux in the most  "natural" way that I
>  can but am having trouble.  My current approach involves using "rfkill" but
>  that doesn't work very well for reasons that are probably not very relevant
>  here.  It probably does make sense for powering the GPS antenna, but not
>  much else.

The userspace consumer was added for users like this that live entirely
in userspace.

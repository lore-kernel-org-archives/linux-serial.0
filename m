From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH 2/6] Blackfin Serial Driver: Add a debug function to serial driver.
Date: Wed, 15 Oct 2008 04:38:11 -0400
Message-ID: <20081015083811.GA21237@shell.devel.redhat.com>
References: <1223891185-13924-1-git-send-email-cooloney@kernel.org> <1223891185-13924-3-git-send-email-cooloney@kernel.org> <20081014142701.72090868@lxorguk.ukuu.org.uk> <1224037421.6284.40.camel@dyang>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58488 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbYJOIie (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Oct 2008 04:38:34 -0400
Content-Disposition: inline
In-Reply-To: <1224037421.6284.40.camel@dyang>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gyang <graf.yang@analog.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bryan Wu <cooloney@kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Oct 15, 2008 at 10:23:41AM +0800, gyang wrote:
> We are making a SMP like patch to blackfin, cpu_relax() is replaced by a
> data cache flush function which will count it to a per-cpu counter.
> If this serial function is called too early, the per-cpu data area have
> not been initialized, this call will cause crash.
> So we'd like to use barrier() instead of cpu_relax().

Can you split that out as a separate change and include the explanation in
the patch then.

Thanks
Alan

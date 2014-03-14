From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH V3] serial/uart/8250: Add tunable RX interrupt trigger
 I/F of FIFO buffers
Date: Fri, 14 Mar 2014 16:38:31 +0200
Message-ID: <20140314143831.GB11603@xps8300>
References: <20140314022154.4345.23024.stgit@yunodevel>
 <20140314120400.4e17c47a@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16102 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640AbaCNOih (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Mar 2014 10:38:37 -0400
Content-Disposition: inline
In-Reply-To: <20140314120400.4e17c47a@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Warren <swarren@nvidia.com>, Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, linux-serial@vger.kernel.org, yrl.pp-manager.tt@hitachi.com, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Aaron Sierra <asierra@xes-inc.com>, Jiri Slaby <jslaby@suse.cz>

On Fri, Mar 14, 2014 at 12:04:00PM +0000, One Thousand Gnomes wrote:
> Otherwise this looks good to me. The interface is sensible, it can be
> expanded easily to other devices and device types, and the logic looks
> right.

I have one concern..

I think this may be problematic when used with DMA. The burst size is
usually expected to be aligned with the trigger level.

Though I don't know how big risk that actually is.


Thanks,

-- 
heikki

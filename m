From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Tue, 29 Jan 2013 23:46:03 -0500
Message-ID: <20130130044603.GC30002@kroah.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <cover.1359022955.git.lv.zheng@intel.com>
 <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
 <20130125214121.GA30924@kroah.com>
 <1AE640813FDE7649BE1B193DEA596E88BF41C7@SHSMSX101.ccr.corp.intel.com>
 <20130126034232.GB5066@kroah.com>
 <1AE640813FDE7649BE1B193DEA596E88BF46D2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44502 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab3A3IJL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2013 03:09:11 -0500
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BF46D2@SHSMSX101.ccr.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Jiri Slaby (jslaby@suse.cz)" <jslaby@suse.cz>, "Heikki Krogerus (heikki.krogerus@linux.intel.com)" <heikki.krogerus@linux.intel.com>

On Mon, Jan 28, 2013 at 02:58:00AM +0000, Zheng, Lv wrote:
> Which one do you think is better? V2 or V5 (I have completed the test
> and now I have the V6 ones, I can send them out if you think the
> tty_enum bus is better than the serial_bus).

I don't know, if you have a patch set you want to have reviewed, please
send it, I don't have the time to dig through the links you sent me to
old patch versions, nor should you ever expect someone to do that.

But whatever you send, it better not contain a duplicate of the existing
tty class code, like your last patchset did, that's not going to be
acceptable at all for the reasons I said.

Again, take advantage of your Intel internal Linux kernel developers for
the proper review of your code, and test it!   Your last patch set
showed that this obviously did not happen, and I'm not going to look at
anything further from you until you get a signed-off-by by at least one
of them first (preferably more than one.)

greg k-h

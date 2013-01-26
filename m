From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Sat, 26 Jan 2013 03:12:07 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BF41DF@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <cover.1359022955.git.lv.zheng@intel.com>
 <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
 <20130125214544.GB30924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50379 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754963Ab3AZDML convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 22:12:11 -0500
In-Reply-To: <20130125214544.GB30924@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Jiri Slaby (jslaby@suse.cz)" <jslaby@suse.cz>, "Heikki Krogerus (heikki.krogerus@linux.intel.com)" <heikki.krogerus@linux.intel.com>

> > +static void tty_slave_release(struct device *dev) {
> > +	struct tty_slave *tts = to_tty_slave(dev);
> > +
> > +	kfree(tts);
> > +	/* Test code to see if slave device get released */
> > +	BUG();
> > +}
> 
> You send me a patch like this and expect me to apply it when it's obvious you
> didn't even test it out?  That's the most _basic_ test for any dynamic type of
> device (add it and remove it and make sure the kernel still works.)  And
> obviously you didn't do it.
> 
> I need a really good reason why to take you seriously now.

It's actually my fault.
I'm lack of release testability then.
Now I can do this exactly.
According to internal reviewers' comments, it should be RFC patch to see if any objections there in the community.
I'll complete the test and refresh the patches if you think the functionality is interesting and useful.
Please be noted the device tree guys can also get benefit from such tty target enumeration mechanism.

Thanks
-Lv


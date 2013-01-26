From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Fri, 25 Jan 2013 19:44:18 -0800
Message-ID: <20130126034418.GC5066@kroah.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <cover.1359022955.git.lv.zheng@intel.com>
 <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
 <20130125214544.GB30924@kroah.com>
 <1AE640813FDE7649BE1B193DEA596E88BF41DF@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88BF41DF@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Jiri Slaby (jslaby@suse.cz)" <jslaby@suse.cz>, "Heikki Krogerus (heikki.krogerus@linux.intel.com)" <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 26, 2013 at 03:12:07AM +0000, Zheng, Lv wrote:
> > > +static void tty_slave_release(struct device *dev) {
> > > +	struct tty_slave *tts = to_tty_slave(dev);
> > > +
> > > +	kfree(tts);
> > > +	/* Test code to see if slave device get released */
> > > +	BUG();
> > > +}
> > 
> > You send me a patch like this and expect me to apply it when it's obvious you
> > didn't even test it out?  That's the most _basic_ test for any dynamic type of
> > device (add it and remove it and make sure the kernel still works.)  And
> > obviously you didn't do it.
> > 
> > I need a really good reason why to take you seriously now.
> 
> It's actually my fault.
> I'm lack of release testability then.
> Now I can do this exactly.
> According to internal reviewers' comments, it should be RFC patch to
> see if any objections there in the community.

Don't put code like this in RFC code either, that shows you didn't even
test it out, and want to waste other people's time.

And note, I almost _never_ read RFC patches, so you aren't going to get
a review from me for it, sorry, I have too many other things to do.

> I'll complete the test and refresh the patches if you think the
> functionality is interesting and useful.  Please be noted the device
> tree guys can also get benefit from such tty target enumeration
> mechanism.

No, they can use what we have today, don't reinvent the wheel.

greg k-h

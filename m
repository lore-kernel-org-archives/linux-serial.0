From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Mon, 28 Jan 2013 03:02:42 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BF46ED@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <cover.1359022955.git.lv.zheng@intel.com>
 <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
 <20130125214544.GB30924@kroah.com>
 <1AE640813FDE7649BE1B193DEA596E88BF41DF@SHSMSX101.ccr.corp.intel.com>
 <20130126034418.GC5066@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20130126034418.GC5066@kroah.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Jiri Slaby (jslaby@suse.cz)" <jslaby@suse.cz>, "Heikki Krogerus (heikki.krogerus@linux.intel.com)" <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Hi,

> > It's actually my fault.
> > I'm lack of release testability then.
> > Now I can do this exactly.
> > According to internal reviewers' comments, it should be RFC patch to
> > see if any objections there in the community.
> 
> Don't put code like this in RFC code either, that shows you didn't even test it
> out, and want to waste other people's time.
> 
> And note, I almost _never_ read RFC patches, so you aren't going to get a
> review from me for it, sorry, I have too many other things to do.

It's my great pleasure to have you taking a look at my patches.

> > I'll complete the test and refresh the patches if you think the
> > functionality is interesting and useful.  Please be noted the device
> > tree guys can also get benefit from such tty target enumeration
> > mechanism.
> 
> No, they can use what we have today, don't reinvent the wheel.

According to my previous reply, I'm not trying to reinvent the wheel but trying to fix some gaps in UART slave device enumeration which is introduced in the recent ACPI 5.0 spec updates.

Thanks and best regards
-Lv

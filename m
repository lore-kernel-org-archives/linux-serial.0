From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: CH340/341: cannot open twice
Date: Sun, 20 Sep 2015 13:56:02 -0700
Message-ID: <20150920205602.GA22637@localhost>
References: <trinity-deaddc67-9f42-4260-9032-d3eb30b7e8f1-1442696993994@3capp-mailcom-lxa06>
 <20150919221032.GF2360@localhost>
 <trinity-efc5f19e-b3a1-4cc7-b944-04deb6368aca-1442710334176@3capp-mailcom-lxa02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <trinity-efc5f19e-b3a1-4cc7-b944-04deb6368aca-1442710334176@3capp-mailcom-lxa02>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "C. SB" <fenugrec-f9SIN1PjVWVBDgjK7y7TUQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Karl Palsson <karlp-PhA6lrgffZtPR4JQBCEnsQ@public.gmane.org>, Peter Stuge <peter-Y+HMSxxDrH8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

[ Please keep everyone on CC including the usb list when responding. ]

On Sun, Sep 20, 2015 at 02:52:14AM +0200, C. SB wrote:

> > device. The reported problems have looked like hardware issues,
> Probably not my case - the device works OK on a winXP box

That's good to know.

> > Could you try the vendor driver and see if that makes the device work so
> > that we'd know for sure?
> Well, it was quite a job to get the driver to compile on linux 4.1.6, and
> I had to kludge a replacement for the deprecated interruptible_sleep_on()
> mechanism. I still can't believe it works (I have no kernel/module experience)
> but apart from an inexplicable 1-2 second delay when close()-ing
> the port, it works in my application (write+read with timeout; TXD-RXD
> connected together in a loopback)
> 
> The mfg driver I used was downloaded from WCH at some point. A copy is visible
> on https://github.com/karlp/ch341-linux/blob/master/drivers/CH341SER_LINUX/ch34x.c
> And my patch to get it to compile is quite simple:
> http://pastebin.ca/3167353
> (not sure what the diff/patch guidelines are on this list, I preferred to link)
> 
> Note : I probably violate many rules of kernel coding with my use of
> wait_event_interruptible(). Consider this a highly unstable, incompetent patch.

Thanks for verifying that. I've added Karl on CC that I think has some
preliminary code for adding support for newer ch341 devices, and Peter
who has also run into some similar issues.

Hopefully someone with access to these devices can figure out what is
missing in the mainline driver so that they get proper support.

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

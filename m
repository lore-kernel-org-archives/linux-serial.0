From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: cdc_acm bug? read buffer bytes shifted
Date: Tue, 20 Sep 2016 10:45:34 +0200
Message-ID: <1474361134.4358.7.camel@suse.com>
References: <2c59e268-9fd6-172b-1803-074aa4e11f27@farjump.io>
         <1471692758.29854.0.camel@suse.com>
         <4bffb2dd-de01-8819-cf44-c4fb1357ecd4@farjump.io>
         <1471874667.17783.19.camel@suse.com>
         <f97a97ee-4d22-145c-5f73-472ee4f03968@farjump.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f97a97ee-4d22-145c-5f73-472ee4f03968-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julio Guerra <julio-wf23HAOg02MWenYVfaLwtA@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-09-16 at 18:24 +0200, Julio Guerra wrote:
> > On Sat, 2016-08-20 at 14:14 +0200, Julio Guerra wrote:
> >>>> Another example:
> >>>>> 00 00 00 00 00 00 00 01
> >>>> ...
> >>>>> 01 00 00 00 00 00 00 00
> >>>> ...
> >>>>> 00 01 00 00 00 00 00 00
> >>>> ...
> >>>>> 00 00 01 00 00 00 00 00
> >>>> after a random number of times, while usbmon shows the usb payload
> >>>> "00 00 00 00 00 00 00 01".
> >>>
> >>> Hi, how many bytes does read() return?
> >>>
> >>
> >> Exactly 8 bytes, always. I set the tty in raw non-canonical mode with
> >> vmin = 8 and vtime = 0. I also tried with vmin = 1 and did the copy of
> >> exactly 8 bytes by looping in userspace, without any improvement.
> >>
> >> I wrote a small workaround for now that detects this problem (because I
> >> exactly know what the buffer is supposed to look like) to close() and
> >> re-open() the device. The next read buffer is then correct.
> >>
> > 
> > Please activate dynamic debugging for the tty and cdc_acm driver.
> > We need to know where the corruption happens.
> > 
> 
> I didn't find anything helpful in /sys/kernel/debug/dynamic_debug
> regarging the tty module (I enabled tty_io debugs and it doesn't appear
> in the logs), but I enabled cdc_acm debugs. Nothing is observable in the
> logs when the bug appears. I logged everything as a comment of the gist:
> https://gist.github.com/Julio-Guerra/b6529994f814771c825649bdb8d927c2#gistcomment-1875985
> 
> Note that re-running the script restarts the underlying kernel buffer
> correctly, it does not restart from its previous bugged state.
> 
> Let me know if you want other debug traces enabled.
> 

Can you modify the tty layer to print out the buffer?
It is unclear from the logs where the shift happens.

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

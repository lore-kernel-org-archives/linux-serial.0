From: Clemens Eisserer <linuxhippy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 13906] New: Huawei E169 GPRS connection causes
	Ooops
Date: Tue, 4 Aug 2009 17:55:46 +0200
Message-ID: <194f62550908040855x11ed8aaewcbe486a2edaa8f84@mail.gmail.com>
References: <20090804021637.ce7e62ad.akpm@linux-foundation.org>
	 <Pine.LNX.4.44L0.0908041024050.2948-100000@iolanthe.rowland.org>
	 <20090804151221.GB20276@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090804151221.GB20276-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

I'll try to get that done soon, however its not easy sitting behind a
~56K GPRS connection which decides to break every 5min ;)

- Clemens

2009/8/4, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>:
> On Tue, Aug 04, 2009 at 10:25:20AM -0400, Alan Stern wrote:
>> On Tue, 4 Aug 2009, Andrew Morton wrote:
>>
>> > > http://bugzilla.kernel.org/show_bug.cgi?id=13906
>> > >
>> > >            Summary: Huawei E169 GPRS connection causes Ooops
>>
>> There are a lot of serial fixes in Greg KH's queue.  Try applying:
>>
>> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-all-2.6.31-rc5.patch
>>
>> to your 2.6.31-rc5 kernel.  In particular, this one patch:
>>
>> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-tty/tty-usb-shutdown
>>
>> might solve your problem.
>
> If it does, I need to know soon, as that isn't queued up for a .31 release.
>
> thanks,
>
> greg k-h
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

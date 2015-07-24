From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] Avoid usb reset crashes by making tty_io cdevs truly
 dynamic
Date: Fri, 24 Jul 2015 09:12:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507240859070.24450-100000@netrider.rowland.org>
References: <55B16EA9.3020609@kynesim.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B16EA9.3020609@kynesim.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Watts <rrw@kynesim.co.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 23 Jul 2015, Richard Watts wrote:

>   When the USB reset happens, we get a bunch of complaints from the
> kernel.
> 
>   Some of these are to do with races on the kobjects associated with the
> sysfs entries for the ttyACM0 device. They turn out not to be fatal,
> and have their own patch series ('Attempt to cope with device changes
> and delayed kobject deallocation' on linux-kernel).
> 
>   The fatal one turns out to be an execution path that goes like this:
> 
>   1 USB device declares itself to be CDC
>   2 tty driver fires up and allocates a cdev for the relevant tty.

Does this happen in the same thread as 1?

>   3 driver->cdevs[0].kobj gets initialised as part of the cdev_alloc()
>   4 USB reset happens, queueing driver->cdevs[0].kobj for release.

1 and 4 should be mutually exclusive.  Probing and reset both acquire
the USB device's mutex.

>   5 The tty driver calls cdev_init(&driver->cdevs[0]), which
>       reinitialises driver->cdevs[0].kobj with a refcount of 1.

Presumably this happens in the same thread as 1, 2, and 3?  Which means 
it should be mutually exclusive with 4 -- it should happen _before_ 4, 
not after.

By the way, kobjects should _never_ be reinitialized.  They are 
initialized just once, when they are created.  If something initializes 
them again afterward, that's a bug.

>   6 tty driver starts using that new cdev, queueing an operation on it.
>      This causes a timer entry to be added including the kobj.
>   7 At this point, the release we scheduled in (4) happens and the
>      members of kobj are deallocated.
>   8 Someone allocates the newly released memory for one of the members of
>       cdriver->cdevs[0].kobj somewhere else and overwrites it.
>   9 The timer goes off.
> 10 Boom
> 
>   My patch (ham-fistedly) fixes this by ensuring that because we
> never reuse the cdev pointer, we are never fooled into reinitialising
> a kobject queued for deletion.
> 
>   I'm not all that familiar with how the locking should go here, and
> there is a definite argument that under non CONFIG_DEBUG_KOBJECT_RELEASE
> conditions, the kobject_release() would have happened by 5, and
> therefore this situation should never exist "for real".

I can tell you a little about locking in the USB subsystem (don't know
about the TTY subsystem).  In particular, USB probing and reset are
mutually exclusive.

>   .. but (a) that makes it rather hard to test kernels with
> CONFIG_DEBUG_KOBJECT_RELEASE, and (b) my customer's crashes have
> (allegedly) now gone away even without CONFIG_DEBUG_KOBJECT_RELEASE
> set.

In general, delaying an object's release should make no difference at
all (except for the fact that the memory is temporarily unavailable for
other purposes).  Objects don't get released until their refcounts are
0, meaning that they are not in use anywhere.  If an object is still in
use (being initialized, or on a list, etc.) then its refcount should 
not be 0.  If it is, that's a bug.

Alan Stern

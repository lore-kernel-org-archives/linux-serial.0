From: Richard Watts <rrw@kynesim.co.uk>
Subject: Re: [PATCH 1/1] Avoid usb reset crashes by making tty_io cdevs truly
 dynamic
Date: Thu, 23 Jul 2015 23:46:01 +0100
Message-ID: <55B16EA9.3020609@kynesim.co.uk>
References: <555B518D.2010102@kynesim.co.uk> <20150723220854.GA24492@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060900040608040805050000"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150723220854.GA24492@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------060900040608040805050000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

  Sure - sorry, my description was a little .. basic.

  So, I have a client who was having problems with machines hanging in
the field. Very rare, associated with a h/w change that introduced
more cores. Kernel dumps implied that the timer list was getting
corrupted.

  This configuration of machine is an SBC on a board which communicates
with the SBC (partly) via a USB CDC device, which pops up as
/dev/ttyACM0.

  So one of the things we turned on was CONFIG_DEBUG_KOBJECT_RELEASE.
One of the side-effects of this is to delay kobject destruction.

  When we did that, we could reproduce the crash by performing a
USB reset on the CDC device -  and logs suggest that this was
happening in the field too.

  When the USB reset happens, we get a bunch of complaints from the
kernel.

  Some of these are to do with races on the kobjects associated with the
sysfs entries for the ttyACM0 device. They turn out not to be fatal,
and have their own patch series ('Attempt to cope with device changes
and delayed kobject deallocation' on linux-kernel).

  The fatal one turns out to be an execution path that goes like this:

  1 USB device declares itself to be CDC
  2 tty driver fires up and allocates a cdev for the relevant tty.
  3 driver->cdevs[0].kobj gets initialised as part of the cdev_alloc()
  4 USB reset happens, queueing driver->cdevs[0].kobj for release.
  5 The tty driver calls cdev_init(&driver->cdevs[0]), which
      reinitialises driver->cdevs[0].kobj with a refcount of 1.
  6 tty driver starts using that new cdev, queueing an operation on it.
     This causes a timer entry to be added including the kobj.
  7 At this point, the release we scheduled in (4) happens and the
     members of kobj are deallocated.
  8 Someone allocates the newly released memory for one of the members of
      cdriver->cdevs[0].kobj somewhere else and overwrites it.
  9 The timer goes off.
10 Boom

  My patch (ham-fistedly) fixes this by ensuring that because we
never reuse the cdev pointer, we are never fooled into reinitialising
a kobject queued for deletion.

  I'm not all that familiar with how the locking should go here, and
there is a definite argument that under non CONFIG_DEBUG_KOBJECT_RELEASE
conditions, the kobject_release() would have happened by 5, and
therefore this situation should never exist "for real".

  .. but (a) that makes it rather hard to test kernels with
CONFIG_DEBUG_KOBJECT_RELEASE, and (b) my customer's crashes have
(allegedly) now gone away even without CONFIG_DEBUG_KOBJECT_RELEASE
set.

  Does that help at all? I've attached my 0/1, just in case that
got lost somewhere.


Richard.




--------------060900040608040805050000
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Attached Message"

Message-ID: <555B5100.8010708@kynesim.co.uk>
Date: Tue, 19 May 2015 16:04:32 +0100
From: Richard Watts <rrw@kynesim.co.uk>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 0/1] Avoid usb reset crashes by making tty_io cdevs truly
 dynamic
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Sometimes, usb buses on which CDC ACM devices sit encounter a usb reset.

When this happens, particularly when CONFIG_DEBUG_KOBJECT_RELEASE is on,
we attempt to destroy the cdev for the associated tty and then
rapidly re-initialise it. Since kobject destruction is not immediate,
this potentially leaves us with cdev_init() calling kobject_init() on a
kobject that is about to be destroyed.

This turns out not to be such a good thing and this patch solves the
problem by making the cdevs tty_operations->cdevs dynamically
allocated.

This may not be a problem in the wild (though I have some circumstantial
evidence that it is), but I submit that we might want to think about
fixing it anyway, since it makes debugging on systems with
CONFIG_DEBUG_KOBJECT_RELEASE=y and USB resets rather difficult
(guess what I have been doing lately .. ).

Patch is against e26081808edadfd257c6c9d81014e3b25e9a6118 (head of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git ).

  (in fact, you will still get an oops - which is the subject of
another, more controversial, patchset ..)



Richard.

--------------060900040608040805050000--

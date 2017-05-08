From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] serdev: Restore serdev_device_write_buf for atomic
 context
Date: Mon, 8 May 2017 17:18:58 +0200
Message-ID: <20170508151858.GB30445@localhost>
References: <1493380041-14710-1-git-send-email-stefan.wahren@i2se.com>
 <20170502090638.GB2973@localhost>
 <CAL_Jsq+QOv6G2EFX8RpE1gk2S9M5VrndwQNNCjM0GqZ+2PXz3A@mail.gmail.com>
 <20170502131854.GA17710@localhost>
 <b62674e7-5c50-585b-eade-7cef0a400d02@i2se.com>
 <CAL_JsqLCiyU8kU2NaLQRz9aS-k7TNr3Tf45Wt3H3DuSyMAuvDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLCiyU8kU2NaLQRz9aS-k7TNr3Tf45Wt3H3DuSyMAuvDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, May 04, 2017 at 03:32:53PM -0500, Rob Herring wrote:
> On Thu, May 4, 2017 at 11:22 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > Am 02.05.2017 um 15:18 schrieb Johan Hovold:
> >> On Tue, May 02, 2017 at 07:41:34AM -0500, Rob Herring wrote:
> >>> On Tue, May 2, 2017 at 4:06 AM, Johan Hovold <johan@kernel.org> wrote:
> >>>> On Fri, Apr 28, 2017 at 01:47:21PM +0200, Stefan Wahren wrote:
> >>>>> Starting with commit 6fe729c4bdae ("serdev: Add serdev_device_write
> >>>>> subroutine") the function serdev_device_write_buf cannot be used in
> >>>>> atomic context anymore (mutex_lock is sleeping). So restore the old
> >>>>> behavior.
> >>>> Yeah, preventing use in atomic context seems unnecessary, although any
> >>>> clients writing must now deal with serialisation themselves (as before,
> >>>> and as they should).
> >>> We could just remove the mutex for serdev_device_write and always make
> >>> the client responsible for serialization.
> >> That sounds reasonable.
> >
> > So it's unwanted to have 2 write functions (non-atomic, atomic)?
> 
> No, it's unwanted to have more than we need.
> 
> Looking closer, we'd also have to ensure the wait for completion is
> not called also. So probably better to just leave it as you have done
> it.

Indeed. Sorry if my reply above was unclear on that point (i.e. that
Stefan's patch is still needed regardless of whether we keep the mutex
or not).

Thanks,
Johan

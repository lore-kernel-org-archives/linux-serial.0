From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] serdev: Restore serdev_device_write_buf for atomic context
Date: Tue, 2 May 2017 07:41:34 -0500
Message-ID: <CAL_Jsq+QOv6G2EFX8RpE1gk2S9M5VrndwQNNCjM0GqZ+2PXz3A@mail.gmail.com>
References: <1493380041-14710-1-git-send-email-stefan.wahren@i2se.com> <20170502090638.GB2973@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170502090638.GB2973@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 2, 2017 at 4:06 AM, Johan Hovold <johan@kernel.org> wrote:
> On Fri, Apr 28, 2017 at 01:47:21PM +0200, Stefan Wahren wrote:
>> Starting with commit 6fe729c4bdae ("serdev: Add serdev_device_write
>> subroutine") the function serdev_device_write_buf cannot be used in
>> atomic context anymore (mutex_lock is sleeping). So restore the old
>> behavior.
>
> Yeah, preventing use in atomic context seems unnecessary, although any
> clients writing must now deal with serialisation themselves (as before,
> and as they should).

We could just remove the mutex for serdev_device_write and always make
the client responsible for serialization.

> Calling wait_for_completion in the non-blocking case was also needlessly
> inefficient.

It won't be called because count should be 0.

Rob

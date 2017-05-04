From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] serdev: Restore serdev_device_write_buf for atomic
 context
Date: Thu, 4 May 2017 18:22:31 +0200
Message-ID: <b62674e7-5c50-585b-eade-7cef0a400d02@i2se.com>
References: <1493380041-14710-1-git-send-email-stefan.wahren@i2se.com>
 <20170502090638.GB2973@localhost>
 <CAL_Jsq+QOv6G2EFX8RpE1gk2S9M5VrndwQNNCjM0GqZ+2PXz3A@mail.gmail.com>
 <20170502131854.GA17710@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170502131854.GA17710@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Am 02.05.2017 um 15:18 schrieb Johan Hovold:
> On Tue, May 02, 2017 at 07:41:34AM -0500, Rob Herring wrote:
>> On Tue, May 2, 2017 at 4:06 AM, Johan Hovold <johan@kernel.org> wrote:
>>> On Fri, Apr 28, 2017 at 01:47:21PM +0200, Stefan Wahren wrote:
>>>> Starting with commit 6fe729c4bdae ("serdev: Add serdev_device_write
>>>> subroutine") the function serdev_device_write_buf cannot be used in
>>>> atomic context anymore (mutex_lock is sleeping). So restore the old
>>>> behavior.
>>> Yeah, preventing use in atomic context seems unnecessary, although any
>>> clients writing must now deal with serialisation themselves (as before,
>>> and as they should).
>> We could just remove the mutex for serdev_device_write and always make
>> the client responsible for serialization.
> That sounds reasonable.

So it's unwanted to have 2 write functions (non-atomic, atomic)?

Stefan

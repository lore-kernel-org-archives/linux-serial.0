From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] serdev: Restore serdev_device_write_buf for atomic
 context
Date: Tue, 2 May 2017 11:06:38 +0200
Message-ID: <20170502090638.GB2973@localhost>
References: <1493380041-14710-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493380041-14710-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 28, 2017 at 01:47:21PM +0200, Stefan Wahren wrote:
> Starting with commit 6fe729c4bdae ("serdev: Add serdev_device_write
> subroutine") the function serdev_device_write_buf cannot be used in
> atomic context anymore (mutex_lock is sleeping). So restore the old
> behavior.

Yeah, preventing use in atomic context seems unnecessary, although any
clients writing must now deal with serialisation themselves (as before,
and as they should).

Calling wait_for_completion in the non-blocking case was also needlessly
inefficient.

> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 6fe729c4bdae ("serdev: Add serdev_device_write subroutine")

Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks,
Johan

From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: RFC: out-of-tree tty driver breakage (changing ASYNC_ bits)
Date: Mon, 11 Jan 2016 15:53:20 +0000 (UTC)
Message-ID: <n70j5g$sem$1@ger.gmane.org>
References: <5692D054.7050203@hurleysoftware.com>
 <20160111044204.GB12741@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2016-01-11, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sun, Jan 10, 2016 at 01:42:44PM -0800, Peter Hurley wrote:
>
>> This will break out-of-tree drivers but I don't really see a
>> realistic alternative. Also, I think the new symbol prefix ASY_ isn't
>> great and I'd like to get some suggestions.
>
> Don't worry about breaking out-of-tree drivers, that's fine.

One request from this maintainer of several out-of-tree drivers: if
you break something, break it such that it won't compile.  It would be
nice to avoid changes that break functionality but still compile
without warning.

-- 
Grant Edwards               grant.b.edwards        Yow! Where do your SOCKS
                                  at               go when you lose them in
                              gmail.com            th' WASHER?

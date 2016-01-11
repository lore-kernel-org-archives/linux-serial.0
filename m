From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: RFC: out-of-tree tty driver breakage (changing ASYNC_ bits)
Date: Mon, 11 Jan 2016 08:24:13 -0800
Message-ID: <5693D72D.6050501@hurleysoftware.com>
References: <5692D054.7050203@hurleysoftware.com>
 <20160111044204.GB12741@kroah.com> <n70j5g$sem$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <n70j5g$sem$1@ger.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On 01/11/2016 07:53 AM, Grant Edwards wrote:
> On 2016-01-11, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Sun, Jan 10, 2016 at 01:42:44PM -0800, Peter Hurley wrote:
>>
>>> This will break out-of-tree drivers but I don't really see a
>>> realistic alternative. Also, I think the new symbol prefix ASY_ isn't
>>> great and I'd like to get some suggestions.
>>
>> Don't worry about breaking out-of-tree drivers, that's fine.
> 
> One request from this maintainer of several out-of-tree drivers: if
> you break something, break it such that it won't compile.  It would be
> nice to avoid changes that break functionality but still compile
> without warning.

I was in the process of writing how I can't remove ASYNC_INITIALIZED, et.al
from the uapi header, when I realized that I can just guard them with
#ifndef _KERNEL_ which will trigger the requisite out-of-tree build
break.

Regards,
Peter Hurley

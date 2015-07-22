From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Wed, 22 Jul 2015 10:30:24 -0400
Message-ID: <55AFA900.6040605@hurleysoftware.com>
References: <55AC1883.4050605@svenbrauch.de>	 <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de>	 <20150721091838.GG20628@localhost> <55AE7714.80306@hurleysoftware.com> <1437554428.5445.0.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437554428.5445.0.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Sven Brauch <mail@svenbrauch.de>, Johan Hovold <johan@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Toby Gray <toby.gray@realvnc.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07/22/2015 04:40 AM, Oliver Neukum wrote:
> On Tue, 2015-07-21 at 12:45 -0400, Peter Hurley wrote:
>> Let me know if you need help instrumenting the tty buffers/throttling
>> to help figure out what the actual problem is.
>>
>> Regarding the patch itself, I have no opinion on the suitability of
>> simply not resubmitting urbs. However, that is exactly how the
>> throttle
>> mechanism works, and the tty buffer API is specifically designed to
>> allow drivers to manage flow via that interface as well (especially
>> for high-throughput drivers).
> 
> Could you please expand on how this is supposed to work?
> For once how does one learn that room is available again?

There are basically 3 mechanisms for managing rx data:
1. Allocate space when the data arrives; drop data if no space is avail
   and indicate buf_overrun. This is what most drivers do.
2. Allocate space when the data arrives; try to buffer uncopied data
   and resubmit the data later. Some high-throughput drivers (in the wild)
   do this (but less so now that the tty buffer space is configurable).
3. Pre-allocate space _before_ the data arrives (with tty_buffer_request_room());
   this is applicable to subsystems which know how much data can be in-flight
   at any one time. This guarantees that when rx data arrives buffer space is
   available (since it has already been allocated).

Drivers that use method 2 typically attempt to recopy the buffered data
when either new data arrives or @ unthrottle. I've seen others use deferred
work as well.

AFAIK no driver/subsystem is using method 3 for guaranteed delivery
of in-flight data, but it seems ideally suited to usb serial.

Regards,
Peter Hurley

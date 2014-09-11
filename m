From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC] tty: Always allow tcflow(TCOON) to unwedge terminal
Date: Thu, 11 Sep 2014 11:40:20 -0400
Message-ID: <5411C264.8000105@hurleysoftware.com>
References: <1410384499-4982-1-git-send-email-peter@hurleysoftware.com> <20140911000343.GA5328@kroah.com> <5410E8A2.5030802@hurleysoftware.com> <20140911002410.GA11732@kroah.com> <5410F08D.10707@hurleysoftware.com> <20140911135610.GD15632@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:49738 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751146AbaIKPkZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 11:40:25 -0400
In-Reply-To: <20140911135610.GD15632@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/11/2014 09:56 AM, Theodore Ts'o wrote:
> On Wed, Sep 10, 2014 at 08:45:01PM -0400, Peter Hurley wrote:
>>> I'm all for working around broken hardware in the kernel, but this seems
>>> like a very old issue, if it's even one at all, that we would be
>>> changing for no one who has reported it (that I know of...)
>>
>> How to unwedge a terminal comes up from time to time.
> 
> Are you trying to unwedge a terminal using hardware flow control, or
> software flow control?

For unwedging software flow control.

Like you point out, unwedging hardware flow control would be more complicated
and less predictable.

> For software flow control, this is a guarantee that we can make wrt to
> the behavior of tcflow().  For hardware flow control, we can't make
> any guarantees, whether it's with tcflow(TCOON) or tcflow(TCOOF);
> tcflow(TCOON). 
> 
>> It's possible that this may cause userspace breakage. Some app
>> may call tcflow(TCOON) thus accidently overriding the flow control
>> state when it would have had no effect before.
> 
> It's very likely that an application that would be using tcflow() at
> all would first be sending a TCOOFF, and then sending a TCOON.  So
> this doesn't worry me that much.
> 
> Indeed, given that the definition of how TCION and TCIOFF is worded
> (send a START or STOP command), it's completely reasonable to
> interpret TCOON and TCOOFF as emulating what would happen if the
> system received a START or STOP command.  (Note though that part of
> this is that Posix doesn't define CRTSCTS, so POSIX is entirely silent
> on the subject of hardware flow control).

This is the basic interpretation I assumed, and most of what the tty core
already did.

Regards,
Peter Hurley

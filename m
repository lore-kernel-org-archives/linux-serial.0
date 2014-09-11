From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC] tty: Always allow tcflow(TCOON) to unwedge terminal
Date: Thu, 11 Sep 2014 08:34:03 -0400
Message-ID: <541196BB.60407@hurleysoftware.com>
References: <1410384499-4982-1-git-send-email-peter@hurleysoftware.com>	<20140911000343.GA5328@kroah.com>	<5410E8A2.5030802@hurleysoftware.com> <20140911111930.7227abbf@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140911111930.7227abbf@alan.etchedpixels.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/11/2014 06:19 AM, One Thousand Gnomes wrote:
>> It's not common knowledge (and its certainly counterintuitive) that
>> turning off output when output is already turned off (ie., tcflow(TCOOFF))
>> is the required trickery to unwedge a terminal.
>>
>> Unwedging directly seems the straightforward approach.
> 
> Putting the off/on in the man page might be safer still ?

That's my plan if this patch fails to launch.

Regards,
Peter Hurley

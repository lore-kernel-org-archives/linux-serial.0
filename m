From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Insanely high baud rates
Date: Thu, 11 Oct 2018 22:48:51 -0700
Message-ID: <e2d6b234-0127-78df-6d37-13e0c4777db8@zytor.com>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
 <20181010211717.30c1f052@alans-desktop>
 <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
 <20181011133134.085624af@alans-desktop>
 <8A583BC1-A295-48D2-B4C3-3E70AA50D035@zytor.com>
 <20181011214035.GC565@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011214035.GC565@thunk.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

On 10/11/18 2:40 PM, Theodore Y. Ts'o wrote:
> On Thu, Oct 11, 2018 at 07:14:30AM -0700, hpa@zytor.com wrote:
>>>
>>> I mean - what is the baud rate of a pty  ?
>>
>> Whatever the master wants it to be...
> 
> I think Alan's point is that it is highly unlikely you would be able
> to push the equivalent of 4 gbps through a PTY layer.  The TTY later
> was never engineered for those speeds, and the real question is ---
> what's the point?  That's what Ethernet is for.
> 

I like to consider the far future; I think things like the Y2038 problem is a
good example. Or, as I like to put it, "numbers are cheap, running out of
numbers is expensive." Sounds like we have enough of a plan that we aren't
completely stuck should it ever become an issue.  It might never, of course.

	-hpa

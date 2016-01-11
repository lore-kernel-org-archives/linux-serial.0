From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: RFC: out-of-tree tty driver breakage (changing ASYNC_ bits)
Date: Sun, 10 Jan 2016 21:16:34 -0800
Message-ID: <56933AB2.8090305@hurleysoftware.com>
References: <5692D054.7050203@hurleysoftware.com>
 <20160111044204.GB12741@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160111044204.GB12741@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux kernel <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

On 01/10/2016 08:42 PM, Greg KH wrote:
> On Sun, Jan 10, 2016 at 01:42:44PM -0800, Peter Hurley wrote:
>> The tty/serial core uses 5 bits in the tty_port.flags field to
>> manage state. They are:
>>
>> ASYNCB_INITIALIZED
>> ASYNCB_SUSPENDED
>> ASYNCB_NORMAL_ACTIVE
>> - and -
>> ASYNCB_CTS_FLOW
>> ASYNCB_CHECK_CD
>>
>> Unfortunately, updates to this field (tty_port.flags) are often
>> non-atomic. Additionally, the field is visible to/modifiable by
>> userspace (the first 3 bits above are not modifiable by userspace
>> though). Lastly, the multi-bit ASYNC_SPD_ bitfield is in this
>> tty_port.flags field as well.
>>
>> What needs to happen is the tty/serial core needs to update its
>> state transitions atomically. I want to re-define the above 5 flags
>> into a separate field in the tty_port structure and designate new
>> symbols for these bits. The base patch that does this is inlined
>> below.
>>
>> This will break out-of-tree drivers but I don't really see a
>> realistic alternative. Also, I think the new symbol prefix ASY_ isn't
>> great and I'd like to get some suggestions.
> 
> Don't worry about breaking out-of-tree drivers, that's fine.
> 
> And try "hiding" the symbol prefix behind inline functions
> (tty_port_initialized(port) and the like) that way the prefix of the
> symbol, or even how you do this with locking or bits or atomics will all
> not matter at all.

Ok, will do. Thanks for the input.

Regards,
Peter Hurley

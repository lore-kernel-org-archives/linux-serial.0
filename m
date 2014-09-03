From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 21/26] tty: Convert tty_struct bitfield to bools
Date: Wed, 03 Sep 2014 11:10:45 -0400
Message-ID: <54072F75.70107@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>	<1409693975-1028-22-git-send-email-peter@hurleysoftware.com>	<20140903115852.5a720754@alan.etchedpixels.co.uk>	<54070643.9080903@hurleysoftware.com> <20140903131919.0d970b6f@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140903131919.0d970b6f@alan.etchedpixels.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/03/2014 08:19 AM, One Thousand Gnomes wrote:
>> Ahh. Thanks for the insight, Alan.
>>
>> But set_bit() et. al. will generate an incredible amount of churn;
>> what if I split the fields up to prevent false-sharing?
> 
> Do you feel lucky ;-)

Hahaha  :)

> I'd rather set_bit and friends were used. They exist largely for this
> kind of reason and they also have atomic test/set methods which may in
> the longer term be very useful.
> 
> Yes it is churn can't argue with that.

Yuck. There should be a better way. IXANY mode is suddenly going to
have a ton of unnecessary bus locks on x86.

Note the ctrl_status field is a byte as well, which can't be RMW'ed by
the bit-locked primitives, and definitely should not be aggregated with
any adjacent field.

Regards,
Peter Hurley

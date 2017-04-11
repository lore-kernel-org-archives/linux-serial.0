From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv3 00/10] Nokia H4+ support
Date: Tue, 11 Apr 2017 13:36:44 +0200
Message-ID: <4FEFA1D8-BE23-40FB-BAA3-3EC910FE9F96@holtmann.org>
References: <20170328155939.31566-1-sre@kernel.org>
 <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
 <C1A408F2-1DF8-4F49-B399-B936542DE6BC@holtmann.org>
 <20170331133353.GA32267@kroah.com>
 <CAL_Jsq+NU3M5yuBpK1UGgzCVvq0eABMApCqEe3_d5+tDaABsgQ@mail.gmail.com>
 <20170410231041.vz35anezpzhscu4t@earth>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170410231041.vz35anezpzhscu4t@earth>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Sebastian,

>>>>>> Here is PATCHv3 for the Nokia bluetooth patchset. I addressed all comments from
>>>>>> Rob and Pavel regarding the serdev patches and dropped the *.dts patches, since
>>>>>> they were queued by Tony. I also changed the patch order, so that the serdev
>>>>>> patches come first. All of them have Acked-by from Rob, so I think it makes
>>>>>> sense to merge them to serdev subsystem (now) and provide an immutable branch
>>>>>> for the bluetooth subsystem.
>>>>> 
>>>>> Greg doesn't read cover letters generally and since the serdev patches
>>>>> are Cc rather than To him, he's probably not planning to pick them up.
>>>> 
>>>> I wonder actually if we should merge all of these via bluetooth-next
>>>> tree with proper Ack from Greg. However it would be good to also get
>>>> buy in from Dave for merging this ultimately through net-next.
>>> 
>>> I don't really care where it goes.  I can take the whole thing in my
>>> tty/serial tree now if no one objects and I get an ack from the relevant
>>> maintainers {hint...}
>> 
>> I think it is better if it goes thru BT tree. I have another driver
>> converted that is dependent on this series. There's a couple other
>> serdev changes on the list too, but this shouldn't depend on them.
> 
> Is this waiting for something, or could it be queued to
> bluetooth-next then? It would be nice to finally have
> this in 4.12 :)

I would prefer if we can get an ACK from Greg. Then I merge it through the bluetooth-next tree.

Regards

Marcel

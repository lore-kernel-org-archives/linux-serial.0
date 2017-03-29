From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv3 00/10] Nokia H4+ support
Date: Wed, 29 Mar 2017 23:33:26 +0200
Message-ID: <C1A408F2-1DF8-4F49-B399-B936542DE6BC@holtmann.org>
References: <20170328155939.31566-1-sre@kernel.org>
 <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

>> Here is PATCHv3 for the Nokia bluetooth patchset. I addressed all comments from
>> Rob and Pavel regarding the serdev patches and dropped the *.dts patches, since
>> they were queued by Tony. I also changed the patch order, so that the serdev
>> patches come first. All of them have Acked-by from Rob, so I think it makes
>> sense to merge them to serdev subsystem (now) and provide an immutable branch
>> for the bluetooth subsystem.
> 
> Greg doesn't read cover letters generally and since the serdev patches
> are Cc rather than To him, he's probably not planning to pick them up.

I wonder actually if we should merge all of these via bluetooth-next tree with proper Ack from Greg. However it would be good to also get buy in from Dave for merging this ultimately through net-next.

Regards

Marcel

From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 13:27:35 +0200
Message-ID: <DF39982E-E8DE-4E28-8F96-E64D326B570C@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com> <20160818104749.GB7427@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818104749.GB7427@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Because it was misunderstood, here a longer answer.

> Am 18.08.2016 um 12:47 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> 
>> 
>> Thereof 4 files, ~260 changes w/o gps demo and documentation/bindings.
> 
> So what do you use for the serial devices?

You misunderstood the w/o documentation/bindings in a way that the full patch
set doesn't use it. But it means changes w/o these aspects...

> platform_device was vetoed
> for that purpose by Greg.

That is true but not relevant at all since nobody wants to introduce platform_device
again.

I have just removed these from counting differences to make the number of
lines comparable to Rob's proposal.

Rob also uses device tree but has not added bindings or documentation to
his patch set so that it would be unfair to include them in the changes count in
one proposal and omit it in the other.

Generally it might not even be important to compare both approaches again
and then the number of files / changes is not important. But if it is, we should
count them correctly.

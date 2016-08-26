From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 0/6] UART slave devices using serio
Date: Fri, 26 Aug 2016 16:29:10 -0500
Message-ID: <CAL_JsqJzFCOmVwrvjVoXyn9JVy1nzmHCcSZXXDnqU8RZJvZFHA@mail.gmail.com>
References: <20160824232437.9446-1-robh@kernel.org> <20160826200509.GA22583@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160826200509.GA22583@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 26, 2016 at 3:05 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2016-08-24 18:24:30, Rob Herring wrote:
>> This is a new approach to supporting UART slave devices using the
>> existing serio bus. After Arnd's proding, I took another look at serio
>> and decided extending it does make sense. Using serio primarily requires
>> adding DT based device matching and supporting buffer based write and
>> receive.
>
> Strange, the series has _two_ 1/6 patches.
>
>> Rob Herring (6):
>>   serio: add DT driver binding
>
> There's one saying "add OF driver binding" on the mailinglist, too...

Ugg, ignore that one. That's what I get for not cleaning out patches
before refreshing them with git-format-patch.

Rob

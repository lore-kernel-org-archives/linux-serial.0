From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/4] serdev: fix broken lifetime assumptions
Date: Wed, 17 May 2017 08:18:21 -0500
Message-ID: <CAL_Jsq+4b4sNfXZ6R_vDAnseHXok8QeGPZ3gWr6=cMLh9avJ2A@mail.gmail.com>
References: <20170411170731.4085-1-johan@kernel.org> <20170517103958.GU3657@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170517103958.GU3657@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, May 17, 2017 at 5:39 AM, Johan Hovold <johan@kernel.org> wrote:
> On Tue, Apr 11, 2017 at 07:07:27PM +0200, Johan Hovold wrote:
>> This series fixes a number of issues with the new serdev code, which was
>> based on incorrect tty-port lifetime assumptions.
>>
>> The first patch disables serdev support by reverting the patch which
>> hooked into the tty layer in a broken way that leads to crashes and
>> leaks when deregistering devices. This one should probably go into 4.11.
>>
>> The second patch fixes a specific bug in the tty-port client
>> registration code, while the third patch adds a new interface for
>> registering serdev devices. The final patch ultimately enables serdev
>> again for the serial drivers.
>>
>> More details can be found in the individual commit messages.
>>
>> Johan
>>
>>
>> Johan Hovold (4):
>>   Revert "tty_port: register tty ports with serdev bus"
>>   serdev: fix tty-port client deregistration
>>   tty/serdev: add serdev registration interface
>>   serial: enable serdev support
>
> Rob, did you have any further comments to this series?

No. For the series,

Reviewed-by: Rob Herring <robh@kernel.org>

> Greg, I think these should go into 4.12-rc2, and the first patch should
> probably also have a stable tag now as serdev resource-management is
> clearly broken in 4.11.
>
> Johan

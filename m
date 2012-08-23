From: Rob Landley <rob@landley.net>
Subject: Re: [PATCHv3 3/9] serial: vt8500: Add devicetree support for
Date: Thu, 23 Aug 2012 16:29:37 -0500
Message-ID: <5036A0C1.4030209@landley.net>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz> <20120821231255.71a7515a@pyramind.ukuu.org.uk> <1345617278.7491.4.camel@gitbox> <201208220644.18059.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201208220644.18059.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Tony Prisk <linux@prisktech.co.nz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alessandro Zummo <a.zummo@towertech.it>, linux-fbdev@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, vt8500-wm8505-linux-kernel@googlegroup.com, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, rtc-linux@googlegroups.com, Stephen Warren <swarren@nvidia.com>, Alan Cox <alan@linux.intel.com>, Mike Turquette <mturquette@ti.com>
List-Id: linux-serial@vger.kernel.org

On 08/22/2012 01:44 AM, Arnd Bergmann wrote:
> On Wednesday 22 August 2012, Tony Prisk wrote:
>> The original patch was very simple, but I revisited it to fix other
>> issues and forgot to add the relevant comments.
>>
>> Port size is changed to fix a problem - WM8505 actually had 6 uart's
>> defined in platform data but the vt8500_ports variable was only 4.
>>
>> I have added devicetree port id support as well.
> 
> If you do multiple things in one driver, you should normally send multiple
> patches as well, each with a description why that change is done.
> It may seem silly at first to send out a one-line patch next to a 100-line
> patch for the same file, but those cases are actually the ones where it's
> most important.

Think of us poor git-bisect monkeys who have no idea why something broke
but can (purely mechanically) figure out which commit did it. If it's a
patch that does three unrelated things, we're kinda stuck.

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: serial console problem with kernel 3.18.0-rc4
Date: Thu, 01 Jan 2015 20:32:21 -0800
Message-ID: <1420173141.2078.1.camel@HansenPartnership.com>
References: <54625FCD.3070008@gmx.de>
	 <1420076022.2085.12.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1420076022.2085.12.camel@HansenPartnership.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-serial@vger.kernel.org, linux-parisc <linux-parisc@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2014-12-31 at 17:33 -0800, James Bottomley wrote:
> I confirm this behaviour on the Mako system as well.  In my case, 3.18
> so royally screws up the serial port that even a power cycle won't
> recover the console connection to the MP (a sort of parisc equivalent of
> a BMC) and I have to go down to the machine room to physically yank the
> power from the system to power down the MP and get the console back.

For those in parisc land following along, I've discovered that a remote
power down followed by a diagnostic reset of the MP will reconnect the
console, thus obviating trips to unplug the actual system.

James



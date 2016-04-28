From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v3 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Thu, 28 Apr 2016 18:35:50 +0100
Message-ID: <1461864950.8029.40.camel@nexus-software.ie>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-04-27 at 16:48 +0300, Andy Shevchenko wrote:
> The patch has been tested on few Intel SoCs / platforms. In any case
> I would
> like to ask Bryan to do independent test.

Andy.

I tested out on Quark and an initial boot was successful, there was no
obvious slowdown or dropped bytes.

I'll ensure I get some sort of decent performance test done for you
over the weekend on Galileo. I actually have a system setup here on my
desk for Edison <=> Galileo but I've been faffing about getting that
working. Expect some sort of feedback by Monday/Tuesday @ the latest.

---
bod

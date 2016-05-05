From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v3 03/11] dmaengine: dw: set polarity of handshake
 interface
Date: Thu, 05 May 2016 18:54:11 +0100
Message-ID: <1462470851.2404.6.camel@nexus-software.ie>
References: <1461764894-14891-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1461764894-14891-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461764894-14891-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-04-27 at 16:48 +0300, Andy Shevchenko wrote:
> +       bool                    polarity;

So this variable is not very intuitively named.

You end up setting somepointer->polarity = true; in a later patch. 

Since you're respining a V4 I'd suggest a name that describes a little
bit better than polarity. Setting polarity = true is a little bit liked
being asked "you you like ice-cream or apple pie" and then saying "yes
please".

---
bod

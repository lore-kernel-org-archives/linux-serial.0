From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH-v8] serial: 8250_dw: Add support for big-endian MMIO
 accesses
Date: Fri, 11 Dec 2015 10:37:05 +0200
Message-ID: <20151211083705.GF4884@kuha.fi.intel.com>
References: <45xw80lci7vs893wq469l1b0.1449765214447@com.syntomo.email>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45xw80lci7vs893wq469l1b0.1449765214447@com.syntomo.email>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "fransklaver@gmail.com" <fransklaver@gmail.com>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Hi Noam,

On Thu, Dec 10, 2015 at 04:33:39PM +0000, Noam Camus wrote:
> Please see
> https://lkml.org/lkml/2015/8/3/806
> Why I added private accessors.

Greg is not saying anything about the iotype checking there? Looks
more like confusion about what exactly is that patch trying to
achieve. I think Greg just thought you moved the writel call from
the beginning of the function to be called later inside the "else"
condition.

You need to start your series with a patch where you just separate the
lcr checking to its own function and follow that with patches where
you introduce the big-endian support. I think this is also what Andy
told you. Use the diff I gave you.

One more thing that I forgot to comment before:

s/dw8250_check_LCR/dw8250_check_lcr/


Thanks,

-- 
heikki

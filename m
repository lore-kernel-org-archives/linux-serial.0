From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2 0/7] serial: exar: Fixes and cleanups
Date: Fri, 10 Feb 2017 20:51:37 +0000
Message-ID: <20170210205137.GA4143@sudip-laptop>
References: <cover.1486570149.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1486570149.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Rob Groner <rgroner@rtd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 08, 2017 at 05:09:02PM +0100, Jan Kiszka wrote:
> Changes in v2:
> - line rewrapped in patch 2 [Andy]
> - reordered PCI ID list [Andy]
> - removed obsolete constants from 8250_pci [Andy]
> - added Commtech devices to 8250_pci blacklist [Andy]
> 
> Original intro:
> 
> Fixes one fall-out from the exar split-up and two longer pending issue
> regarding the correct initialization of exar registers ports > 0.
> Furthermore, it moves remaining exar code over to the new module and
> also cleans up & fixes some registers defines.
> 
> This includes the previously posted "Fix EXAR feature control register
> constants".
> 
> Note that I have no chance to test the Commtech change on real hardware.

+Rob

Hi Rob,
Can you please test these patches on your setup. I don't have a desktop
atm to test.

Regards
Sudip

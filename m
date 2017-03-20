From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] disable RTS override on LPSS UART with Auto Flow Control
Date: Mon, 20 Mar 2017 16:15:53 +0200
Message-ID: <20170320141553.GA29812@kuha.fi.intel.com>
References: <1489587228-10764-1-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489587228-10764-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan O'Donovan <dan@emutex.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 15, 2017 at 02:13:48PM +0000, Dan O'Donovan wrote:
> Currently, Auto Flow Control is not working correctly on the Atom
> X5-Z8350 "Cherry Trail" SoC, because an "RTS override" feature is
> enabled in a vendor-specific register in the LPSS UART. The symptom
> is that RTS is not de-asserted as it should be when RTS/CTS flow
> control is enabled and the RX FIFO fills up.
> 
> This appears to be introduced by commit 1f47a77c4e49 ("ACPI / LPSS:
> not using UART RTS override with Auto Flow Control").
> 
> To _disable_ the RTS override, bit 3 needs to be _set_ in the
> "GENERAL" register at offset 808h.  The power-on default is 0. The
> aforementioned commit appears to have assumed the inverse of this.

True. That is what the public documentation for Atom Z8000
(Cherrytrail/Braswell), and also Z36xx-Z37xx (Baytrail) say. The
internal Lynxpoint PCH documentation I used describe the bit
differently, but we should of course follow the public documentation.
The LPSS block housing the UART is in any case the same in all these
products.

After addressing Andy's comments:
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This should also go to stable.


Thanks,

-- 
heikki

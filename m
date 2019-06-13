From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3 v6] serial: 8250: Add MSR/MCR TIOCM conversion
 wrapper functions
Date: Thu, 13 Jun 2019 21:32:29 +0300
Message-ID: <20190613183229.GS2640@lahna.fi.intel.com>
References: <20190613154542.32438-1-sr@denx.de>
 <20190613154542.32438-2-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190613154542.32438-2-sr@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Yegor Yefremov <yegorslists@googlemail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Giulio Benetti <giulio.benetti@micronovasrl.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 13, 2019 at 05:45:41PM +0200, Stefan Roese wrote:
> This patch adds wrapper functions to convert MSR <-> TIOCM and also
> MCR <-> TIOCM. These functions are used now in serial8250_do_set_mctrl()
> and serial8250_do_get_mctrl().
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

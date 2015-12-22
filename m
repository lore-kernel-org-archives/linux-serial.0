From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v9 1/3] serial: 8250_dw: Avoid serial_outx code duplicate
 with new dw8250_check_lcr()
Date: Tue, 22 Dec 2015 10:57:21 +0200
Message-ID: <20151222085720.GA3005@kuha.fi.intel.com>
References: <1449940707-17633-1-git-send-email-noamc@ezchip.com>
 <1449940707-17633-2-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449940707-17633-2-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, vgupta@synopsys.com, Alexey.Brodkin@synopsys.com, jslaby@suse.com, peter@hurleysoftware.com
List-Id: linux-serial@vger.kernel.org

On Sat, Dec 12, 2015 at 07:18:25PM +0200, Noam Camus wrote:
> From: Noam Camus <noamc@ezchip.com>
> 
> With the help of Heikki we take common code that
> makes sure LCR write wasn't ignored and put it in new function called
> dw8250_check_lcr(). This function serves 3 serial_out routines:
> dw8250_serial_out(), dw8250_serial_out32(), and dw8250_serial_outq().
> 
> This patch only brings better code reuse.
> 
> Signed-off-by: Noam Camus <noamc@ezchip.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

For all tree:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki

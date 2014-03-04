From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 2/2] serial: 8250_pci: change BayTrail default uartclk
Date: Tue, 4 Mar 2014 16:55:07 +0200
Message-ID: <20140304145507.GB25982@xps8300>
References: <694295964.81260.1393897982162.JavaMail.zimbra@xes-inc.com>
 <1222639163.81280.1393898076434.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58660 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757188AbaCDOzV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Mar 2014 09:55:21 -0500
Content-Disposition: inline
In-Reply-To: <1222639163.81280.1393898076434.JavaMail.zimbra@xes-inc.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Mon, Mar 03, 2014 at 07:54:36PM -0600, Aaron Sierra wrote:
> The Intel BayTrail HSUART power-on default reference clock is 44.2368 MHz,
> but 73.728 MHz provides 0% error for additional "conventional" baud rates
> above 460800 (e.g. 576000, 921600, and 1152000).
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks,

-- 
heikki

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 1/2] serial: 8250_pci: more BayTrail error-free bauds
Date: Tue, 4 Mar 2014 16:54:38 +0200
Message-ID: <20140304145438.GA25982@xps8300>
References: <263958445.81234.1393897872966.JavaMail.zimbra@xes-inc.com>
 <376255937.81261.1393898069932.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33357 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757188AbaCDOyv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Mar 2014 09:54:51 -0500
Content-Disposition: inline
In-Reply-To: <376255937.81261.1393898069932.JavaMail.zimbra@xes-inc.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Mon, Mar 03, 2014 at 07:54:29PM -0600, Aaron Sierra wrote:
> Support the following additional baud rates with 0% error:
> 	500000, 1500000, 2500000, 3500000
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks,

-- 
heikki

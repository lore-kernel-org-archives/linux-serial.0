From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 5/7] serial: remove back and forth conversions in serial_out_sync
Date: Fri, 2 Mar 2012 09:13:38 -0500
Message-ID: <4F50D592.70903@windriver.com>
References: <1330655603-5268-1-git-send-email-paul.gortmaker@windriver.com>	<1330655603-5268-6-git-send-email-paul.gortmaker@windriver.com> <20120302112204.4f990c78@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:58504 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab2CBONw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Mar 2012 09:13:52 -0500
In-Reply-To: <20120302112204.4f990c78@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

On 12-03-02 06:22 AM, Alan Cox wrote:
> On Thu,  1 Mar 2012 21:33:21 -0500
> Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> 
>> The two callers to serial_out_sync() have a struct port right
>> there in scope, but then pass in a struct 8250_port which then
>> is locally resolved to a struct port.
> 
> This change I don't like. It means serial_out_sync and serial_out end
> up with different parameters which seems odd to say the least. You then
> extend this oddity by adding helpers for port_in/out but not the sync
> one.

I can't argue that.  I'll reorder it so the generic serial_port_X
helpers are introduced 1st, and then amend this to rename the fcn
from serial_out_sync to serial_port_out_sync.   Or I could just
drop is commit entirely.  Any preference one way or the other?

Thanks for the review.
Paul.

> 
> Otherwise it all looks good to me.
> 
> Alan
> 
> 

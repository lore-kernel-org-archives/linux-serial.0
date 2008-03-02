From: Thomas Koeller <thomas@koeller.dyndns.org>
Subject: Re: RM9000 code broken in 8250.c
Date: Sun, 2 Mar 2008 17:03:12 +0100
Message-ID: <200803021703.13105.thomas@koeller.dyndns.org>
References: <200712211250.18002.thomas@koeller.dyndns.org> <200802260159.09182.thomas@koeller.dyndns.org> <1204040242.24352.32.camel@bling>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx02.hansenet.de ([213.191.73.26]:46720 "EHLO
	webmail.hansenet.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753838AbYCBQCI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Mar 2008 11:02:08 -0500
In-Reply-To: <1204040242.24352.32.camel@bling>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-serial@vger.kernel.org, Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

On Dienstag, 26. Februar 2008, Alex Williamson wrote:
>    If your UART is detected correctly now and you don't have any
> suggestions for further improvements, I'll go ahead and submit this.
> Let me know.  Thanks,

Yes, please go ahead and commit your changes. I ran some more tests
and everything seemed to work as expected.

thanks,
Thomas


-- 
Thomas Koeller
thomas@koeller.dyndns.org

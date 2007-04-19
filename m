From: izumi <izumi2005@soft.fujitsu.com>
Subject: Re: [PATCH][BUG] Fix possible NULL pointer access in 8250 serial
 driver
Date: Thu, 19 Apr 2007 11:28:37 +0900
Message-ID: <4626D3D5.2060408@soft.fujitsu.com>
References: <46242DD2.7030207@soft.fujitsu.com> <20070416225206.cf7d8cd2.akpm@linux-foundation.org> <1176884513.3945.54.camel@kane-linux> <20070418191812.GA21211@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fgwmail8.fujitsu.co.jp ([192.51.44.38]:53777 "EHLO
	fgwmail8.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031096AbXDSDel (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Apr 2007 23:34:41 -0400
In-Reply-To: <20070418191812.GA21211@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com

Russell King wrote:

> NAK.  This means that you change the list of ports available on the
> machine to be limited to only those which are currently open.  Utterly
> useless for debugging, where you normally want people to dump the
> contents of /proc/tty/driver/*.
> 
> The original patch was better.
> 

   Is the original patch sufficient?  or is there anything we should 
correct?

Taku Izumi <izumi2005@soft.fujitsu.com>




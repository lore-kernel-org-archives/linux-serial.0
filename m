From: ian <spyro@f2s.com>
Subject: Re: Line disciplines.
Date: Tue, 15 Jul 2008 23:57:59 +0100
Message-ID: <1216162679.11481.47.camel@wirenth>
References: <1216152625.11481.38.camel@wirenth>
	 <487D18A9.20304@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mk-outboundfilter-4.mail.uk.tiscali.com ([212.74.114.32]:65362
	"EHLO mk-outboundfilter-4.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755550AbYGOW6D (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jul 2008 18:58:03 -0400
In-Reply-To: <487D18A9.20304@microgate.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-serial@vger.kernel.org

On Tue, 2008-07-15 at 15:37 -0600, Paul Fulghum wrote:
> I suspect that since you are using an existing ldisc number
> that the existing ldisc module is being loaded instead of
> your module.

I dont think this is the case, and looking in /proc my line disc was
listed with the number 2. there were no others other than n_tty

> Do you see the init routine of your module called?

Yes.

> If so, what is the return value from tty_register_ldisc()?

Offhand I cant recall (several days ago) but since the ldisc appeared
in /proc/tty/ldiscs I would have thought this succeded?

-Ian


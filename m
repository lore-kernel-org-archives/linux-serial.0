From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 07 Mar 2007 13:46:51 +0100
Message-ID: <m3irddusp0.fsf@maximus.localdomain>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	<m3bqj6jebt.fsf@maximus.localdomain>
	<200703061824.08834.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:58124 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965163AbXCGMqx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Mar 2007 07:46:53 -0500
In-Reply-To: <200703061824.08834.rgetz@blackfin.uclinux.org> (Robin Getz's message of "Tue, 6 Mar 2007 18:24:08 -0500")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: Mike Frysinger <vapier.adi@gmail.com>, rmk@arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

Robin Getz <rgetz@blackfin.uclinux.org> writes:

> It is useful on (broken) legacy serial equipment, where RTS should be 
> completely under the applications control.
>
> Glitches on RTS aren't acceptable, and confuse some devices.

Does that mean you can't use TIOCMSET, TIOCM_RTS etc?

> I understand - the request wasn't to change the default operation - just
> add a 
> method of controlling things, so those minority of people who want the 
> control can have it.

No problem as long as open without CRTSCTS raises RTS by default.
-- 
Krzysztof Halasa

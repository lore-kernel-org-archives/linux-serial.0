From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 07 Mar 2007 13:48:18 +0100
Message-ID: <m3ejo1usml.fsf@maximus.localdomain>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	<m3bqj6jebt.fsf@maximus.localdomain>
	<57354eff0703062113g11ca7d34o6ed82de8195353f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:44224 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965193AbXCGMsU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Mar 2007 07:48:20 -0500
In-Reply-To: <57354eff0703062113g11ca7d34o6ed82de8195353f1@mail.gmail.com> (Oleksiy Kebkal's message of "Wed, 7 Mar 2007 06:13:10 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Oleksiy Kebkal <lesha@evologics.de>
Cc: Mike Frysinger <vapier.adi@gmail.com>, rmk@arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Robin Getz <rgetz@blackfin.uclinux.org>

"Oleksiy Kebkal" <lesha@evologics.de> writes:

> The name of the option is not CCTS, but CRTSCTS, isn't it? So, you may
> not only want to pause own transmission when CTS is inactive, but to
> control the transmission flow from the remote side. Why should RTS be
> active when the port is open even without CRTSCTS?

Because you'd break many devices otherwise.
-- 
Krzysztof Halasa

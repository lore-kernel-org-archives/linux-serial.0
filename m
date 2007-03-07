From: "Oleksiy Kebkal" <lesha@evologics.de>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 7 Mar 2007 06:13:10 +0100
Message-ID: <57354eff0703062113g11ca7d34o6ed82de8195353f1@mail.gmail.com>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	 <m3bqj6jebt.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:32321 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932782AbXCGFNL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Mar 2007 00:13:11 -0500
Received: by nf-out-0910.google.com with SMTP id o25so57123nfa
        for <linux-serial@vger.kernel.org>; Tue, 06 Mar 2007 21:13:10 -0800 (PST)
In-Reply-To: <m3bqj6jebt.fsf@maximus.localdomain>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Mike Frysinger <vapier.adi@gmail.com>, rmk@arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Robin Getz <rgetz@blackfin.uclinux.org>

> > shouldnt TIOCM_RTS be passed down only when the 'r' is appended to the
> > boot cmdline ?
>
> How would it be useful?
>
> CRTSCTS is for CTS only (i.e., the transmission is paused when CTS is
> inactive), not for RTS. DTR and RTS should be active when the port is
> open even without CRTSCTS (= without handshaking), it's used for
> various purposes such as providing +12V to the device (and two pins
> can supply more power than one - sure, it isn't the best idea).

The name of the option is not CCTS, but CRTSCTS, isn't it? So, you may
not only want to pause own transmission when CTS is inactive, but to
control the transmission flow from the remote side. Why should RTS be
active when the port is open even without CRTSCTS? You may still
assert RTS manually if it is used to provide +12V to the device. But
as I understand it is not common use of this pin, isn't it?

And a question is not only about supporting legacy equipment but also
about embedded hardware where RTS/CTS handshaking is handshaking, not
something else...

-Oleksiy

From: "Oleksiy Kebkal" <kebkal@gmail.com>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 7 Mar 2007 14:38:25 +0100
Message-ID: <57354eff0703070538l1a4ed170q6eb8dd8bbf7aadf0@mail.gmail.com>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	 <m3bqj6jebt.fsf@maximus.localdomain>
	 <200703061824.08834.rgetz@blackfin.uclinux.org>
	 <m3irddusp0.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:13121 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965360AbXCGNi1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Mar 2007 08:38:27 -0500
Received: by nf-out-0910.google.com with SMTP id o25so196582nfa
        for <linux-serial@vger.kernel.org>; Wed, 07 Mar 2007 05:38:26 -0800 (PST)
In-Reply-To: <m3irddusp0.fsf@maximus.localdomain>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>, Mike Frysinger <vapier.adi@gmail.com>, rmk@arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

2007/3/7, Krzysztof Halasa <khc@pm.waw.pl>:
> Robin Getz <rgetz@blackfin.uclinux.org> writes:
>
> > It is useful on (broken) legacy serial equipment, where RTS should be
> > completely under the applications control.
> >
> > Glitches on RTS aren't acceptable, and confuse some devices.
>
> Does that mean you can't use TIOCMSET, TIOCM_RTS etc?

No. It is possible to use TIOCMSET only after open syscall. Between
open and ioctl syscals RTS will be asserted. Sometimes it is not
acceptable behaviour.

-Oleksiy

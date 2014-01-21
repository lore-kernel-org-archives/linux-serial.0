From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: samsung: move clock deactivation below uart
 registration
Date: Tue, 21 Jan 2014 09:24:14 -0800
Message-ID: <20140121172414.GB19595@kroah.com>
References: <201312050054.39327.heiko@sntech.de>
 <2813762.7GxfVBIcrq@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43217 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836AbaAURXc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Jan 2014 12:23:32 -0500
Content-Disposition: inline
In-Reply-To: <2813762.7GxfVBIcrq@phil>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>

On Tue, Jan 21, 2014 at 03:26:42PM +0100, Heiko St=FCbner wrote:
> Hi Greg,
>=20
> just wanted to ask about the state of this patch. I can see it in you=
r branch=20
> named "fixes" [0] but it seems it hasn't made its way into the kernel=
 neither=20
> during the 3.13-rcs or with your 3.14-pull [1].
>=20
>=20
> Thanks
> Heiko
>=20
>=20
> [0] https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/log/?=
h=3Dfixes
> [1]=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dbcee63488ece9a0fca8be19951428a7b41001e66

Ah crap, I missed this, sorry, I'll get it to Linus in time for
3.14-final, sorry about that.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

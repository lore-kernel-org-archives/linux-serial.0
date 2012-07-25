From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: n_tty_read panic
Date: Wed, 25 Jul 2012 12:44:16 +0100
Message-ID: <20120725124416.474bed6b@pyramind.ukuu.org.uk>
References: <2cd866$1c50tmu@irja2-156.sinamail.sina.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:47231 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab2GYLkr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Jul 2012 07:40:47 -0400
In-Reply-To: <2cd866$1c50tmu@irja2-156.sinamail.sina.com.cn>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?B?5aSn5p6X?= <yourdarling1999@sina.com>
Cc: linux-serial <linux-serial@vger.kernel.org>

On Wed, 25 Jul 2012 09:47:09 +0800
"=E5=A4=A7=E6=9E=97" <yourdarling1999@sina.com> wrote:

> Hello.
>=20
> Here's a kernel panic caused by n_tty_read, linux kernel version is 2=
=2E6.38.8.
>=20
>=20
> There are many discussions on the subject, this bug solved yet? Where=
 can I download the patch?

Thats a different trace to the others I've seen. Several races have bee=
n
fixed, there are certainly a couple of others left to sort eventually. =
I
don't believe anyone is currently working on them (and indeed until the
rest of the locking and lock splitting work is done it's difficult to s=
ee
how any useful progress could be made here). Patches are however welcom=
e.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

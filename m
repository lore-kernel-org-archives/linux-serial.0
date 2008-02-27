From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: Inter-Character Delay
Date: Wed, 27 Feb 2008 10:57:02 -0500
Message-ID: <200802271057.02716.rgetz@blackfin.uclinux.org>
References: <200802181336.26328.rgetz@blackfin.uclinux.org> <010301c878ba$8365b4b0$8a311e10$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:45962 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbYB0Pz0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Feb 2008 10:55:26 -0500
In-Reply-To: <010301c878ba$8365b4b0$8a311e10$@com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris =?utf-8?q?Dor=C3=A9?= <cdore@connecttech.com>
Cc: linux-serial@vger.kernel.org

On Tue 26 Feb 2008 15:59, Chris Dor=C3=A9 pondered:
> If I read this correctly, the summary is that you:
>=20
> 1. Want to add functionality to the serial driver that supports an ex=
tra
> feature (the delay register).
> 2. Would like to know what the best way is to expose this new functio=
nality
> to a user app.

Yes - that about captures it.

-Robin
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

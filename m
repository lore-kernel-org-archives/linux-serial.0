From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] serial: samsung: Remove hard-coded major/minor numbers
Date: Tue, 31 Dec 2013 16:07:59 +0000
Message-ID: <20131231160759.GF31886@sirena.org.uk>
References: <1388120848-15879-1-git-send-email-tushar.behera@linaro.org>
 <20131227051843.GA840@kroah.com>
 <CAHbNUh27ZZ5UxuLMPvv6weNOSG4XKV9ZRrmTB9F0RvgQxufGDQ@mail.gmail.com>
 <20131227063843.GA3310@kroah.com>
 <CAHbNUh0NBVEBJbSG7UWgnHbORgbKCrA_74=jiArSvv5jaFk1SQ@mail.gmail.com>
 <20131227184424.GA4938@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VvwS7Fyc3fvERiQe"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:49189 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab3LaQII (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Dec 2013 11:08:08 -0500
Content-Disposition: inline
In-Reply-To: <20131227184424.GA4938@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Tushar Behera <tushar.behera@linaro.org>, linux-serial <linux-serial@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, jslaby <jslaby@suse.cz>, Patch Tracking <patches@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, ben@simtec.co.uk, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, heiko <heiko@sntech.de>, Kgene Kim <kgene.kim@samsung.com>


--VvwS7Fyc3fvERiQe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 27, 2013 at 10:44:24AM -0800, Greg KH wrote:

> Please get approval for this patch from others within Linaro before
> sending it out again.  Linaro has a process in place for this type of
> thing, please use it, otherwise it makes people like me really grumpy
> and upset and causes me to yell at people at their conferences.

This isn't really anything to do with Linaro - it's a Samsung driver so
it's their call.  A good proportion of the Samsung guys and their list
are in the CCs so hopefully they'll chime in.

--VvwS7Fyc3fvERiQe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwuvcAAoJELSic+t+oim9SFMP/0bvb6TXdPlUztTjy/OMME6m
MmJBcRUU0Aj09XUQf+9yqjqQxiuyLfxmn9G7x55wOlcV74yVMrF98xecj9V7kCND
Evr61BG0923z2x/HUrsjmzgOvYp1J/1xZOEH1quzwmp6ILtbCokt/IwvawBZw7vf
phOcZ9PvenVzOt2kIxXOGk2AtXKUJ/HXQ5U8dh7bGymIitiNkeZKbBg6p7jeU2wO
9OVAYcKDEnZbei8LfdUGHP7+V3/urqe541KkYhsNK7FvocrTshV9AE6dF9KNM7Vl
JD5gT0EA4R1ymQd5URMzAQTvlVYaO8+BQK11ZNIGNcDCwFQzHOnyx5jETsZdnaUT
MHjEbiYrM3kS92fMQIsZbYbikyJ5EJCIT0hnEn+93IJyls7E9z2/9JKf7qfR1rtx
Xv7YnbVPOAqKA+bApPMfG1XJd7X1WBIhrQ1p5wRyoN9JrqY7ATW4KLje3hjo3liA
pnZuncOurrQkyBgRBySYHReOoJBTWimopiG6AwCKWK2MveONUEd2Qd8cFeeA43OG
F0TWRYv0pc9UMvwomdlYWezqI8Wb+RchNq+XXCG/9ix25Z9kgAop4BL8gAw4A+1J
QUNSe14GunnIM2rIER4Aiv36romnO+4fP34RcjmmFAfp7ttrCucio9hfziylVDRx
oExYe+bWyYV7DE3LCyk+
=jVf1
-----END PGP SIGNATURE-----

--VvwS7Fyc3fvERiQe--

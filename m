From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Thu, 23 Jan 2014 18:40:22 +0000
Message-ID: <20140123184022.GC11727@sirena.org.uk>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
 <1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
 <20140120100530.GY15937@n2100.arm.linux.org.uk>
 <CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
 <20140123180423.1a62611a@www.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58672 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbaAWSko (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Jan 2014 13:40:44 -0500
Content-Disposition: inline
In-Reply-To: <20140123180423.1a62611a@www.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tushar Behera <tushar.behera@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 06:04:23PM +0000, Alan Cox wrote:

> We can then enable that config option for ARM (and in time for any other
> architecture that turns out to need/want it). Eventually it can go away
> (not that its exactly doing any harm if it doesnt).

We'd need to leave it user selectable rather than enabling it for ARM,
the whole reason this got noticed is that people are trying to build
kernels that support a wider range of devices for ARM.

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4WISAAoJELSic+t+oim9/IAP/iQ9FWf4Yvk5hhAuq/9JU9M7
3jJjM/wpQ1I2n2JRu0KyE4Had9tCEdUV1gDwMbWehAP8VsbjRhouOVs0VvDggWcn
s2VQAg0tgMmTkUsdrLagJNuJhvJqB6heXitiIvU/+GAF9IaQKV3VM1LaRSVFazCi
uJltDTdS2+8cdO59prUK528LeE+5hYB096B9LvEuUC37jXOWlkOsA/grl0Arxc+x
GhXCPikVYS8ecq5xSsAfLt7puSg7Uk/rf6ByHDlgtgaSlU4baqEEKEDqBu22RqPl
/X7EadmVfzeGnUghQ2k/6suz6Igf1TdxvIa783Clq171yWpaY7Rdi7MJQ0Y2nZ5P
YGSvvO9UEoBqca1lJjhrLwWVkH0KQbCQVBBmUTIvUMzwALOBOGUOj+GV2c/pb79D
gHAOBOo6RBGpH4hLDAnYD/zILflehMBDsrrzkrkr1JF8MlbkqnP0MFdhF0WJDon9
b6WmfvsyiAX+SK6WGr4Xk9gO1BuschTUoxtVFMXvxeF428c6hVWOreJvm7GWSWph
Re8f417NlKryfw1InFQ23b5SAI+jxpn1OW+P39A9Jx+MBlGaPMx7AG0+MrvpQF4+
K/4RBXERVR3vXUfIwQfXkVvXyaTSsrsJQVsNhXFnCClmvuDA22vIu+g8vYGj15q4
48gdgQL5GfigXUatwXVK
=QPQS
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--

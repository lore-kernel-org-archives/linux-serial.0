From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Thu, 23 Jan 2014 20:05:09 +0000
Message-ID: <20140123200509.GO11727@sirena.org.uk>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
 <1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
 <20140120100530.GY15937@n2100.arm.linux.org.uk>
 <CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
 <20140123180423.1a62611a@www.etchedpixels.co.uk>
 <20140123184022.GC11727@sirena.org.uk>
 <52E163DC.1090002@samsung.com>
 <20140123193633.GG11727@sirena.org.uk>
 <20140123195144.2d3aa44d@www.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YC8Ek3FeOE8ywfXk"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140123195144.2d3aa44d@www.etchedpixels.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tomasz Figa <t.figa@samsung.com>, Tushar Behera <tushar.behera@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org


--YC8Ek3FeOE8ywfXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 07:51:44PM +0000, Alan Cox wrote:

> That strikes me as rather more risky. We can propogate it through the
> drivers as we are sure it is safe to do so on that platform and encourage
> driver authors to migrate. Better than a "big bang" and the inevitable
> fallout.

I don't see how we can meaningfully test this on a platform - the kernel
would have to be pretty demented to care, it's userspace that cares and
that's not really tied to individual serial drivers but is where we
mainly need coverage.

> We do want it user selectable, because we want people to leave it off
> unless they have a need for it - that then becomes a path towards
> eventually getting rid of them static identifiers for good.

Yup.

--YC8Ek3FeOE8ywfXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4XXyAAoJELSic+t+oim9us8P/0xYv2XqvHi3yE9SzYOBiaip
0RrRkMs5QtL/OPJ2rcKcR208BRJepWi2nSDBDpoTx2tOyLGvFeIMmWuHXixfmNhj
RliruFbRlZEKokJcUkp4qxP3WbUK9etbMElCN1Sx+CA2JBbn65I5+UnO7FsmRgXw
E1iFABxXIEQseJgsr1k4GjecKjdgsolV21Edu446+ohWETdaUEn8VtNJt6CW3iNd
CvaDEBngoKE8hJSDqvmx+EtSr0XBiQ1fFhRmITib52NpFaa2IbWqLJxMy5yZd7PY
eNRtplE6uYpELnGikD3kGr6I9HIOzcBob2Btlmb9y9sYNoldLF2/n+LOKW7YZGMZ
MXIgBvxK5jqwB8BwjLAQgqxhkyPsd84IX776rgMrceJrrK9UTgMBX2mG9ZDaw/eu
PrzPfRR9pTZvQs2YprhMnAy+iPKmK1YiUF0ml7QaCCsgouUSnTnPTALg0pk8Kgpt
kht8qR3cU+WdZyUfRxuJYLc8QD3njQIrLcCdMgroz7nSoeFYAu5CJX8GG4p2/93b
0Q5Df9wuobfQ86ikgASiXprFWu3OuMdm1HZV6g65hBoxp1UrkpLyWOrCCUqCnQBF
m9F1SrmnyOm6crJd4GV9cM9+Jlr89bmRSI+BTbOrger72Ta5s1dszP70qIxDnBL1
IkAg6hMJFXwZFsAVG7XP
=EgIW
-----END PGP SIGNATURE-----

--YC8Ek3FeOE8ywfXk--

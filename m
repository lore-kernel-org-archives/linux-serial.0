Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE7B237713;
	Mon,  3 Aug 2026 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783591; cv=none; b=IwYpYvFhRoPAhPi/UYAeMuDNFdyqfIDZEHTZzHMBjOdCOjOdsrICyxTxf/+T2wypDytYr0WAxX9Nxp3H49rPdr2GPWX2QOnenXPpgljHOVVmTC/M4Q17E7KQvSKVUWbYd9kocoh3Q8xZP0ZjdfbGW7A63o/l9yJlnG1J3HQrJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783591; c=relaxed/simple;
	bh=sI5taJ6Ek4Vg1zgporApUZ+TGehj/UVvhegC6jhoUTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwdv54swSd9YCLiNhPm2grdEe+LtMlgC1QuR1VuQp/c8Yqv2X4m+ybiqq6d5pDEHTU8WxNLri7MC18p3yg2pimJ1exW62s35HC+nYGPBioEwasQMbhp6rIi325xumEYPaQNhYonRmkTDoUFgMtCj9B3QMwNzZ7ZwF8jYqOfHmnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjUTNKQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjUTNKQx"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A267D1F00A3A;
	Mon,  3 Aug 2026 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783590;
	bh=sI5taJ6Ek4Vg1zgporApUZ+TGehj/UVvhegC6jhoUTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TjUTNKQxOFsg9eracabGpNREVk9hI78Q9L4EgPsMR33cBBUYzfvdAQvBMFa42IlhT
	 oEUw9WmLUfRbGF8Z0LCvDFl7NcbjJF37AnL67vllBIQ2FHNRfZ3u9SrVT14nroG5lD
	 YdyH2ifD26m3qaMJ7ElpalRTzqfI0lq8YxdgN3yZkzVRssw0JR67wIQ5LoHX1CkLiB
	 Z8nbeVYNEnK2Mc0n1EZCcrmkS/7bqQUoQe5jx6zGwrhIucMANbBs8B83sP2q8dkvU5
	 wMOcQySABoXKfehkDrMsm6jbZebEvbItMsLVAH/MHvXkJBFuuacBY+nabGWEmS7fJv
	 yzkP+Avvqus9Q==
Date: Mon, 3 Aug 2026 20:59:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/6] serial: txx9: Drop usage of uart_match_port()
Message-ID: <anDksB-66XoEIToX@monoceros>
References: <cover.1785489518.git.ukleinek@kernel.org>
 <c785f3269794934d126909719e94d5ad6c35f7dc.1785489518.git.ukleinek@kernel.org>
 <01a84877-9cc7-8136-d5a8-e368a36cda93@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zrixawysfxikyjpb"
Content-Disposition: inline
In-Reply-To: <01a84877-9cc7-8136-d5a8-e368a36cda93@linux.intel.com>


--zrixawysfxikyjpb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/6] serial: txx9: Drop usage of uart_match_port()
MIME-Version: 1.0

On Mon, Aug 03, 2026 at 08:27:22PM +0300, Ilpo J=E4rvinen wrote:
> On Fri, 31 Jul 2026, Uwe Kleine-K=F6nig wrote:
>=20
> > In this driver .iotype is always UPIO_PORT. So uart_match_port() is
> > equivalent to comparing .iobase. Remove the call to uart_match_port()
> > which then only has a single caller that is handled in the next commit.
>=20
> Not directly related to the change. The txx9 driver seems to have some=20
> iotype switch/cases as well so some !UPIO_PORT deadcode too.

So patch #1 could get rid of these, too. Will look into that for v2.

Best regards
Uwe

--zrixawysfxikyjpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpw5SEACgkQj4D7WH0S
/k7nuwf9FcCjT3SAwcpcJ3KY3i5bsoyZzuwF0T86YlkfjvCJgwH51upt+W0wHk1E
dEedXl5MWGGSJIIz5/aJ9vY8LBvNY4VWWnxdRf8RpZe7iNHfewutkkZRLQEi2SNA
lvjUvCJ+0Jbf64r+m95r/5mHlqf2ZYZVC5Lo69JyJE98cKVBSZBJX20aZC9pCYZx
YhVhEfbgGnNxE742FkKIiudemAd5S5sXLWS1ktq+ujFGZY6GwA8TVzhR3j6ipQ0t
Pa2XATgRv1xDZlAen50dE7HQpKucIUrtHoxkZzxXgGQ8Y3LGIT6KXsmZBnGW3EUa
rSq52DXQSbQkDDT6nGR1k9YOVJC3cA==
=Yx2B
-----END PGP SIGNATURE-----

--zrixawysfxikyjpb--

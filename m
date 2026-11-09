Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252955;
	b=yliMYeE94zLK9I9V8Z7UHWkisR+tLMYwxagp/HBe0V48QdzwMlRMAGPMKA0En06ArvAh
	 bAOXaYxUiuAzWbRkDGyLy08liEJEOc9XqQj0sxXLzyZxY/EkOZn0uHAi0/xQ5HoMvFOTO
	 dutFKbGi1mIRdPW09JMlmbS97Aa1MBNZ3kCRVRz1BU3lEDEYvseh68MAQ9PexpVfYWu7K
	 vNpt3DjqtCfKzmwbAG8MaQ3hpHbgy+rjUt1V7kFsri88I/2+BQSyigLkUFPhC4n2zfknI
	 RV27A5geqkpZkHzac+w4Le8Xmwm1LtNb/lRIWCV42Ya3AXhoXQhI+0LETz8x9XTnqzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252955;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GvJbX8tFvo6M8knK9lWgArZHC9iXmXi9MSIFfMGb9XA=;
	b=ToHJHRqAxGSC39GN7i+DOW7u9HsPxoEdzF941mysQG5Zfm9BsHiwbnLrIuqSuMrRhAnk
	 MQpBvK04HowRLXVxvemOt9T0xJ4VY+kvzkjpTT+o/TsTItduKxuaTFBrKxTZXUP9eRhc+
	 t2WFSHS5BwsouOL0pxCnRknw6SmvRp2DFB8rDNzxUSM+aXvNyaRmj4PXuZH58OKJDDCpo
	 ijWpruhL7uvLyvaNmKefD/H0jW/ybFIvu/aUqsuD7g4Qnue+1zIN6Cz4R08whyaCpHAvB
	 3/DkeGIaARiqzpw+N3PIbcGWpYJWqE7bJuSFVT1x9oOmoEw4FkFeopSwbvl74mo75EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmVvzcKy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00406606A321;
	Mon,  9 Nov 2026 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmVvzcKy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602811F0089F;
	Mon,  9 Nov 2026 19:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794252954;
	bh=GvJbX8tFvo6M8knK9lWgArZHC9iXmXi9MSIFfMGb9XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HmVvzcKyyZYSYuEpcGH68C/7nyBvNxOyBaQVvhMISdKwW+YpdA+1Kjxjuor7HcxXp
	 f7HDEoOL91u1jRv2JBFUNyMcw3x6M3sDW78TtDI2QxIzMcWtSxIWYOFTCzOyLVteXD
	 NQdhoTn+MvEaIyCmZxGCCFyDQ0SEtC7dztX2Mv+oiBTGZCF2D6fYFI9MspIKCFMgKC
	 3OBMOqfwd1M8JxZxjnSpXeXQOBGMp59hlIgRISZibX2jOGrGJ9jIxU6SEArS2vt41m
	 d9sH6E9YomHdAHFYSNu4pNZgnJx4zBXbEL7dFDEtI1udb8TCLqnJulwZ1YYrbO9F0w
	 pnfCjx2Q2C+oQ==
Date: Mon, 9 Nov 2026 19:35:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Kohei Otsuka <kohei@spacemachines.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, conor.dooley@microchip.com
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: add Microchip Core16550
Message-ID: <20261109-sheath-companion-d7063fcbdbfa@spud>
References: <20261103-core16550-rs485-v1-0-6d15ebe1e5b9@spacemachines.com>
 <20261103-core16550-rs485-v1-1-6d15ebe1e5b9@spacemachines.com>
 <20261104-zen-aloha-35da49a7e72c@spud>
 <CADMKYUAc3QPCdpH8JL9VHk4d0iETsUL2ao2i4OhoHYoZGoAnnQ@mail.gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xk0qMBEm0ZJtSjIi"
Content-Disposition: inline
In-Reply-To: <CADMKYUAc3QPCdpH8JL9VHk4d0iETsUL2ao2i4OhoHYoZGoAnnQ@mail.gmail.com>

--Xk0qMBEm0ZJtSjIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 01:54:17PM +1100, Kohei Otsuka wrote:
> On Thu, Nov 5, 2026 at 3:20=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > On Tue, Nov 03, 2026 at 11:11:31AM +1100, Kohei Otsuka wrote:
> > > Core16550 is a 16550-compatible UART soft IP core for Microchip FPGAs,
> > > including the fabric of PolarFire SoC. Its registers follow the 16550=
A,
> > > so ns16550a stays the fallback, but
> >
> > > it raises no interrupt on TEMT,
> > > which the driver has to know about to support RS-485 on it.
> >
> > Doesn't this exclude using the fallback to ns16550a, since it requires
> > specific interrupt handling?
> >
> Everything a plain ns16550a driver does works on
> Core16550 including transmit, receive, FIFOs, modem control and the baud =
rate
> divisor. The only thing that needs the specific compatible string is
> software RS-485
> (em485), which waits for a TEMT interrupt the core doesn=E2=80=99t raise.
> Without the patch, RS-485 direction control is missing, but the UART
> otherwise works. If you=E2=80=99d rather
> not have the fallback, I can match the compatible in 8250_of directly.

In my opinion, this is enough to invalidate the ns16550a fallback.

--Xk0qMBEm0ZJtSjIi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavIglgAKCRB4tDGHoIJi
0t2WAQDr+SJzkU/53V56nypiHHoTlra6oqrdLRlSDdP/xbYZlQEAoYodUZrV5P8J
rwEeTsutW32XJGvJzzg/+7yWStxKbg8=
=yd+m
-----END PGP SIGNATURE-----

--Xk0qMBEm0ZJtSjIi--

Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131CA37DEA3
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788618549; cv=none; b=FzLwPMqlMlf1r02HjGWHmCiqiRDpRyJecrZ1yPTtTZQb/2iUM597PLv2syDR49t1zPJBbE2zHoneamgDE8tV7reE6WFi9ZzNziaxzzDMXF1P7+g0D8QBZ946kqUzWfMZRwopfkRUR6PcXxMgDb6iHBsV5leASx6bpBK3Pr3jtcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788618549; c=relaxed/simple;
	bh=NXyv4wuhQn6D03R7lwONpOIv43je5UBefDgSBoCGp7g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NI0VAZpRUWNkBOHi33tGnZilV81wQWLTCHm8ZTXs9RNCkybtgS5RwhVv3gaPmM7KOyxA8FuYwFROg30eZpqRezyMga/Xhh9ylTfvDZghBX3hfyVE5d8Z4shI/RyYU3PCrfftfXjW2a/NeVJshIX+rRb16ayLe8xXYa+ZZfnzZac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=mYopcXCn; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="mYopcXCn"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 360AB24002A
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 16:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788618546;
	bh=NXyv4wuhQn6D03R7lwONpOIv43je5UBefDgSBoCGp7g=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=mYopcXCnQ40KMksywqeRb1wmr8OG2AnVKMYFs0mkLRU5invgngCqAqWzgM+IcvKPz
	 lcQKHNcjWm4TjXVCbcYlt6iebqShqo23U4mW6gHWtgb4lPDroDKHjDgI4p39IoRNTr
	 bl3tnXnH6ytkgPw0mbgyXCNZHcp1wbzelxXDFrkqjXyhvhxEyD3/AAHxuXtKMbbWSN
	 l9PgCrl/SL95zwq0uVO5WhMTbhQysc3yYc8YypVQMoPHTzo2tD5+szcBl2j452GpUl
	 U1yB3KBAEZTenfsf5Hga9rIPOdMFVHv3KUfjfXdv39ntTx1V0hBLJ5EKyfw8lcQ5Y+
	 JGFUpa00KOFIA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcbLS15P7z6tsb;
	Sat,  5 Sep 2026 16:29:04 +0200 (CEST)
Message-ID: <e14be38bf768bfc79e050e71e97dc15f45896698.camel@posteo.de>
Subject: Re: [PATCH] rust: serdev: Fix race condition on driver probe fail
From: Markus Probst <markus.probst@posteo.de>
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
	 <boqun@kernel.org>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida	 <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>,  Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>
Date: Sat, 05 Sep 2026 14:29:05 +0000
In-Reply-To: <DL7G9BAEFESY.2LS09S43WOK9V@garyguo.net>
References: <20260905-rust_serdev_fix-v1-1-2ea92b154a6b@posteo.de>
	 <1b247f730001ea39b6e4044f5673e1a01e187362.camel@posteo.de>
	 <DL7G9BAEFESY.2LS09S43WOK9V@garyguo.net>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-8+VIV4AfOdiyP1j9CJqu"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-8+VIV4AfOdiyP1j9CJqu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-09-05 at 15:24 +0100, Gary Guo wrote:
> On Sat Sep 5, 2026 at 1:22 AM BST, Markus Probst wrote:
> > On Fri, 2026-09-04 at 23:54 +0000, Markus Probst wrote:
> > > If `Driver::probe` fails, the pointer to the driver data (`PrivateDat=
a`)
> > > will first be set to NULL by `drvdata_obtain` and only after that the
> > > serdev device will be closed by Drop. Thus there is a small window in
> > > which the serdev device is still open, but the pointer to the driver =
data
> > > is NULL. Therefore it is possible that `receive_buf_callback` might t=
ry to
> > > access the `active` mutex on a null pointer.
> > It seems, Sashiko found the same issue in a different unrelated place
> > too (while reviewing this patch):
> >=20
> > https://sashiko.dev/#/patchset/20260905-rust_serdev_fix-v1-1-2ea92b154a=
6b%40posteo.de
> >=20
> > Unfortunately, I cannot fix this one so easily, because the serdev
> > device needs to be open for the entire lifetime of the "real" driver
> > data (Driver::Data).
>=20
> What would go wrong if the device is closed before destroying the driver =
data?
The driver would still have a handle to the Device and could call
`Device::set_baudrate` for instance. This would be a use-after-free by
itself.

I am currently investigating, if I can only stop rx and leave the
device for transmission open. There seems to be the `CREAD` c_cflag I
can remove from the tty. But I am not sure yet if it guarantees that
receive_buf isn't called anymore.

Thanks
- Markus Probst

>=20
> Best,
> Gary

--=-8+VIV4AfOdiyP1j9CJqu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqcJyobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSblYQAIGEuLx5E+0K+FNfcAif
ELlbd3+M9SA/5EnRDe4LLk0NueT6Gaac2IT3EtY+Y9i665CCoRrFKHl7gr1pZov9
dySUUVk+B9BcvqEA9wDqORSorG9lN3tNt8RuYKGtB6sCNy5SM03nq4XkszQ5lFp9
eVmc9TPJiJHBBeb8G0wfBAlSbpZRNVPJBPpqhQJcUfPMzbvXZrrJiWRmWUiXit5N
LNeSExg99IF8NVkW6CN5Twf3OChuH7Al7mqq1aNbkYxWn2GZnslBQoQmcyZ6+T3V
Dzr8UOt8LsURE89fpICyM/3T7p9QJpDYKTj0iKv+gh6tT8SAi+/QAOFwlVMRzFn9
oVQnJe2RDY9LW8hKwMPrtKO8np4B0psuhNt7nzLA21KawMOJxFgiJNGbZpwNBqQA
tpcfDrd7plYJsFoF0LZ+zhxaFnlhur7WI6Y26OgCkbfguEVvRLe6uiA4r8bx9iPk
f/iQBeucfFVUQ6rJk/LfCur0fqX7n8F9hdGbUZkTv9+rJiut0jxiY+D0/DKRPS/j
wh14RUkuoV8WbJPo/R2GJdoKlgKG15Qrj2qPmJn8fvAvSTIu5KvVuSyeERCIMBWM
yRs+DpmHzte7aO9vLw3mP0OEewRMkCD8T3jx3vEFZ+SBYLWy1IAJaXYpDMue/UQU
o/g7h/H0OiDO4XMKWmRFD601
=zUl4
-----END PGP SIGNATURE-----

--=-8+VIV4AfOdiyP1j9CJqu--

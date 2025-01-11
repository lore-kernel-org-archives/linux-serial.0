Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D5187342;
	Sat, 11 Jan 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.66.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586908; cv=none; b=jhnU7YUoSRlnAtTXmuq4zYcIGRi31a22z2mHw1XpIKCEPBDiCXlGeS5B8BaxBu8gFBT3ac13/6PfiTtfhNckbykM6zE420ZI3DtmkFbDXHNTOVhAoVNYWEOxJv+UeDze+3gRL6mE+mLCIePbVFX4CemUuMjOIlojmw3C6KuVQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586908; c=relaxed/simple;
	bh=VmDKM6YnsyMMQG7FGAyrizE+A2hthbl0wX+5uv0FBzE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=aAt02L+h0opghZw8wWKCCdDrmNNdaSpyvHGr1/2Lo03x2/bYFRM+S64rL3REU9ZMhKLLnHroD112pQvfKbs4/3OqafdLxKakQvSdRDPPcaz7/k69daR+aY5xGOC7b8yDzWrZXZYtZx8PjZW0eT7T5nWJwa78alkRnBzUer6TeuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=mj76N3dO; arc=none smtp.client-ip=217.182.66.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="mj76N3dO"
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id E9C273E8A9;
	Sat, 11 Jan 2025 10:14:57 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 1E96040078;
	Sat, 11 Jan 2025 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1736586896; bh=VmDKM6YnsyMMQG7FGAyrizE+A2hthbl0wX+5uv0FBzE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=mj76N3dOKTonKwX1UCqQGDsFy+MrweQc2piRAdG1+j00zEwBhVh2DXis5slVZAbN8
	 B5eoqaCi29cnzAwk579Y+xjxxhmibmJe+RX+YrrC+BSYHI3TtQCE6GdFqnv50cNkcb
	 hPlMc3mOi0mh9dFoWNtHrN1CGY2QiGf3G5/Ctk6E=
Received: from ProArtB550CREATOR (unknown [58.32.41.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 4B0F340B6A;
	Sat, 11 Jan 2025 09:14:54 +0000 (UTC)
From: <kexybiscuit@aosc.io>
To: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc: "'Jiri Slaby'" <jirislaby@kernel.org>,
	"'Serge Semin'" <fancer.lancer@gmail.com>,
	"'Thomas Bogendoerfer'" <tsbogend@alpha.franken.de>,
	<linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
References: <20250111-mips_ejtag_fdc-fix-v1-1-f4282a5ce239@aosc.io> <2025011159-whole-undivided-26e9@gregkh>
In-Reply-To: <2025011159-whole-undivided-26e9@gregkh>
Subject: RE: [PATCH] tty: mips_ejtag_fdc: Fix another passing incompatible pointer type warning
Date: Sat, 11 Jan 2025 17:14:49 +0800
Message-ID: <029c01db6409$46e88b50$d4b9a1f0$@aosc.io>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQMYdkJXkBLoEFtq++bmbjCq949M4gIh94iPsIYWFkA=
X-Spamd-Result: default: False [1.40 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[kexybiscuit.aosc.io:server fail,gregkh.linuxfoundation.org:server fail,linux-kernel.vger.kernel.org:server fail,tsbogend.alpha.franken.de:server fail,linux-serial.vger.kernel.org:server fail];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,alpha.franken.de,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1E96040078

Cool, I'll search the list before sending next time, thanks!

-----Original Message-----
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=20
Sent: Saturday, January 11, 2025 1:52 PM
To: Kexy Biscuit <kexybiscuit@aosc.io>
Cc: Jiri Slaby <jirislaby@kernel.org>; Serge Semin =
<fancer.lancer@gmail.com>; Thomas Bogendoerfer =
<tsbogend@alpha.franken.de>; linux-kernel@vger.kernel.org; =
linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: mips_ejtag_fdc: Fix another passing =
incompatible pointer type warning

On Sat, Jan 11, 2025 at 01:38:51AM +0800, Kexy Biscuit wrote:
> mips_ejtag_fdc_encode() method was changed to accept u8** since
> ce7cbd9a6c81, but not all occurrences were changed to adapt it.
>=20
> Some of the warnings or errors was fixed in a previous commit, this
> commit fixes one more of them.
>=20
> drivers/tty/mips_ejtag_fdc.c: In function =
=E2=80=98kgdbfdc_push_one=E2=80=99:
> drivers/tty/mips_ejtag_fdc.c:1224:38: error: passing argument 1 of =
=E2=80=98mips_ejtag_fdc_encode=E2=80=99 from incompatible pointer type =
[-Werror=3Dincompatible-pointer-types]
>  1224 |         word =3D mips_ejtag_fdc_encode(bufs, &kgdbfdc_wbuflen, =
1);
>       |                                      ^~~~
>       |                                      |
>       |                                      const char **
> drivers/tty/mips_ejtag_fdc.c:216:57: note: expected =E2=80=98const u8 =
**=E2=80=99 {aka =E2=80=98const unsigned char **=E2=80=99} but argument =
is of type =E2=80=98const char **=E2=80=99
>   216 | static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
>       |                                              ~~~~~~~~~~~^~~~
>=20
> Fixes: ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character =
pointers")
> Fixes: 188942f05ce4 ("tty: mips_ejtag_fdc: Fix passing incompatible =
pointer type warning")
> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
> ---
>  drivers/tty/mips_ejtag_fdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/mips_ejtag_fdc.c =
b/drivers/tty/mips_ejtag_fdc.c
> index =
afbf7738c7c47c3377560a3288fa95083dd1c6b0..1cc775e74f92d2c5e7a7b4bb500ff2a=
e758da8e0 100644
> --- a/drivers/tty/mips_ejtag_fdc.c
> +++ b/drivers/tty/mips_ejtag_fdc.c
> @@ -1215,7 +1215,7 @@ static int kgdbfdc_read_char(void)
>  /* push an FDC word from write buffer to TX FIFO */
>  static void kgdbfdc_push_one(void)
>  {
> -	const char *bufs[1] =3D { kgdbfdc_wbuf };
> +	const u8 *bufs[1] =3D { kgdbfdc_wbuf };
>  	struct fdc_word word;
>  	void __iomem *regs;
>  	unsigned int i;

Jiri beat you to it yesterday:
	https://lore.kernel.org/r/20250110115228.603980-1-jirislaby@kernel.org



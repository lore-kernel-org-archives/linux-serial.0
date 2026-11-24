Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556260;
	b=gyZhcv0MlAWQI3/b0keOvAml8nnxVvzdStN7vaSXVbZKXdLrhJlf92DOyNWFHWfmcOu6
	 9slSM55N8lU48ZXyGjYuykiFbWPbITNuA1EiYFVjemOM+OWvaB+Vxk5pQfI1tRSTIGXzW
	 M/Oe8iphPracbL2vAMcE/jrp94ffX6RAbRqtkb7MyM7sdva+bk9/tv0154gdj/BqPegnG
	 epsNQqFSdy5uK0z1vuZTSe9h1D1Suhb0/h9nOn2LWOXMLcXz58lKyx5JVodeaJQuZuiKE
	 MHqiT6kZgpPBumchHd3NkFjAau3agW36UsfEVJWm7uQDjuPZpJ04lmlIZM/LcE2cjwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556260;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=5L8GReJaNnujsS7a1EWrgLiqhdYOYglSeCGZ4pyKlcw=;
	b=DxpJKAJmieHqbE4Pnm7PZwOkvnzJM+Z08LCbW3mlhkcv5cjW9lg7guQGRnJ+JImZFKH2
	 OdI3ro3ImGMI0314DW7+VAgmLG8iLDQSXx9iuez8hKixhu18mCLVeIqCaJPY8/cQ2B8zD
	 V7/9Qyp5JEYzp5fRPGMpumxqk6kcVUYGDOyPDhBLxYCRUTIAIXT1StX4ov+jR5SQc9dI2
	 JOjrbklkvMESx7RMDpho1/3CDGiLFYtIalmSgfxcKUiCYF5QZJ9UErUAY9mjIvReDTX9T
	 xlYqPUka2su+CwFdRn2kuQJLhqQ89nMnumQNqY2ceFDaeHsvk+uoKtAM+FFxurwmkIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Lva4JWz0;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322C606A337
	for <linux-serial@vger.kernel.org>; Tue, 24 Nov 2026 21:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0322C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Lva4JWz0
DKIM2-Signature:  i=1; m=1; t=1795556257;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:dPxLHw5Dvkzw+G/NBp5iU0wdPC2O
   7HuwFw9N2Yo4PZXBeJJkYsYK+0IYCuHn1kFrCJj/D/bS1LJPMt29CHbEHHEnL+E8KifolZxxZtT
   AeWWYbc3KZ/AjOCvB7dt+9VZHUeS3Sy3evU2XonvjLPUOX0kYqCT1BKYhQnoWkmKw83XYLlFBj1
   id7OJTUtCOQNwnJgjmbiDz5Rmh4kZo97TENN5M+W1NBVONW0Hgyas+9UKdcT6lmT60Gq6SZ5BGv
   5KRrQB7siwbU7s5gaXOwUOXLZjPvlE8qYYqxfGu6Rb8ZMSVJMZjxkQbxueSazH62zu6GuhNK0dN
   3vzOpwrBtl4Dww==;
Message-Instance:  m=1;
 h=sha256:
   mYowByvkc9s+IKw8eL91SRXeDxAvfennaxsjfOTFoCQ=:
   bB5bhJ3Xemob1i6GTTkra7WAMkaip8ToxUJp/9+us6E=,
  sha512:
   6msYqRfgRe2gOCTq0+mFKzAkzjcuZqiNb/2YW5/FJQVOLv4Ur1wYd46vAOj1JCImUGgfbyiqLbxte+iDz+qH9w==:
   3SkFOiO7a9PC+fglTJVpGT+kOKy3qdJjLSJJnbgs/WdOvsg9h2hrYUMYs5SoF99QsLvl+N82z8GpOjeJQJ+5hw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795556231; x=1796161031; i=deller@gmx.de;
	bh=5L8GReJaNnujsS7a1EWrgLiqhdYOYglSeCGZ4pyKlcw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Lva4JWz00a/quKKlPqgWH7hYBOCzDLdXMW07txyvS1smhs0viIK/UVxTUXjx7llr
	 PdeCw4FPCVXic76vWjohb75dUW+aEt17BBpG4fKs6Uc6cBgLRI3XtuJ7sMILxUbw/
	 8ssd/A2u3CPI7xxckd7wE61c7cB+dxJPRrun1K1p1ZxEU0xUirNhn7HdSaIzger+z
	 fqNZB9dwNjMkHF3TO3ek8XvEMZHklYQubRE5LTtiLOM9bXOCheDCLE08+G8fH2AkI
	 mIdsRFo9SvvFv8O5oa7YRB3LkEJwnGD55BQN8OmYBlltjNg5Z/7P0NyYlKgieFfBM
	 tRCoTRdsBOgIjRiNsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS5A-1yFnLg3mKg-00hETq; Tue, 24
 Nov 2026 22:37:11 +0100
Message-ID: <27cf86d7-b333-41cb-a250-6b6a14034b86@gmx.de>
Date: Tue, 24 Nov 2026 22:37:09 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vt: Skip hardware scrolling while blanked
To: Yu Peng <pengyu@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Nicolas Pitre
 <nico@fluxnic.net>, Ronan Pigott <ronan@rjp.ie>,
 linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261124024811.305592-1-pengyu@kylinos.cn>
 <20261124024811.305592-2-pengyu@kylinos.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261124024811.305592-2-pengyu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:44vrnUG7/85r7xcLvI3Bl7XE5Vcmwu82yVgUfXcyJH4jFbj2ofd
 ggnlm1k2Jeoo7YnLFno7N8UjU8EtFp1HsW8AGfWgyXyZMyQa+q5xGHwqojT34S+nSzByg8J
 kDkpfZeu9yHHQZbE734gdAQPSyASS2FrXEJYfayIxl8hE0T67XoI6081SU5pglhk9mHPJMg
 LJL2cEeJ2zLEwTV7syheA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bd6qMY7KNMw=;qNo+avNQ2b9ntpFVyDkDaUQ19bg
 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

On 11/24/26 03:48, Yu Peng wrote:
> When vgacon is blanked without palette blanking (!vga_palette_blanked),
> vgacon_set_origin() rejects VRAM so vc->vc_origin points to the heap
> buffer vc->vc_screenbuf. Calling hardware scroll callbacks while blanked
> then treats vc->vc_screenbuf as VRAM and causes out-of-bounds accesses.
>=20
> Use con_should_update() to skip hardware scrolling and scrollback while
> blanked, allowing con_scroll() to fall back to software scrolling.
>=20
> Assisted-by: LLM
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> ---
>   drivers/tty/vt/vt.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
both patches applied to fbdev git tree.

Thanks!
Helge

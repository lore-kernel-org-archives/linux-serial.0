Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB64F3904
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773907; cv=none; b=m6NcRIoEm5kUpR470ueSHj7CH5Vg+CDaO7CdihQ1eciOu33dAFS4mkdEBqlznvM0Rno3fFlBg8ywvw88QdYDzVex/EU2IlGzYSzOvDkDe+SGKx6X065qVPsYN4i33ywxiIrJ9Bs+V6v9EZrjSrKNYqHYgS+tiDl3UoOkQ3xz2SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773907; c=relaxed/simple;
	bh=PJKfM2YCYdoxAN0u2MqqiQ9rffn9l5m9jEAa68kuF9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P61vjYzQvb71+J824dmNA+zju0OTqehEoM+7sbzOQYR2TzlZpHi2sKT6Lis29oU06qr0TVNgIYYRqEV3wM//fPUIM54nv4KbnIJBpm1i/1a8sX5OzDIuSfCc18Ojg/YyCGhjaRUfRvoxYGwlT6WNy+8CF7TLOhkjo8PKTxBsSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/csMTlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/csMTlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBB31F000FF;
	Wed, 30 Sep 2026 13:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773898;
	bh=YwUDFy8i/Z99ubECT3knguW0fmRdR1WMZqe89Y2DU+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/csMTlOS9lTwheO10T0/+wXN7HqwlGITVe9I/VLoN3eQoCiYDZnxCWOCPAIWCvBW
	 RuM48dSw/9xmnbda/Mce2xGJwtuY4hfc5qfYNpS/bp9sRu/qP8Nhd07C79p/RyzD12
	 7YmLQSm3H4IEbSooJIqIXoz0IRIZ3i0I4bmzaCl+DRdQVnPyu87j38g2tBwmQ1xck7
	 eOr0TEugH0+4g28R+a/3BJw2Ge4GR6bL/5r/M0S4XiOfq5J/iaK37y2u6W4LbQGKlF
	 x7bvfxdBjNjlANumtF6Zwd6tyIIIoVddVTwCPkXqMRfPxXqWTKRDhd8r/c/GKx15t7
	 jKVMdLddfuFYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: 8250_bcm2835aux: Add support for RTS/CTS
 auto flow control
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260930125620.221836-1-sairon@sairon.cz>
References: <20260930125620.221836-1-sairon@sairon.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:11:38 +0000
Message-Id: <20260930131138.BBBB31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The bcm2835aux mini UART can automatically de-assert RTS based on the RX
> FIFO fill level and gate the transmitter on CTS, but the driver never
> made use of it. Wire it up:
>=20
> - Enable AUTORTS/AUTOCTS (with the RTS4 threshold and inverted, i.e.
>   conventional active-low, polarity) whenever CRTSCTS is set on ports
>   declaring the "uart-has-rtscts" property, advertised via
>   UPF_HARD_FLOW.
>=20
> - Gate the AUTORTS function on TIOCM_RTS in set_mctrl() so that clearing
>   RTS (port close, TIOCMBIC, B0) actually de-asserts the pin while auto
>   flow control is active.
>=20
> - Implement throttle()/unthrottle() by disabling the RX interrupts and
>   letting the FIFO fill up, making the hardware de-assert RTS - the same
> [ ... ]
>   without the rs485_stop_tx() callback ever being called, which would
>   leave the receiver disabled.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jan =C4=8Cerm=C3=A1k <sairon@sairon.cz>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930125620.2218=
36-1-sairon@sairon.cz?part=3D1


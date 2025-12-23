Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278E30F92D;
	Tue, 23 Dec 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766486614; cv=none; b=JWbZYw69lzhsqNHKL7bR8mnLn4q3qVTUhIKOcfookHJtrnImhBk1yTVjL8UnJ7kD2iaNzjARmU87kGR+a3/bKsjEHZcBk9YtTJiOB1SB/QmRdqIre1MDtaQ/WLAQiEEKovL1ZSriVdmc9HtOMfGYdGOiy0WfJUT/vTOBBeRIaqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766486614; c=relaxed/simple;
	bh=g9X3Dk0XV1834mKVYtr4ZyQnjS0CAcSr9absGlcIMTY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=j4gjW812asCInVIBS9jb/Y0O8OOZUrsqadhZwfjFsp3Kvn6DB+q26fdtScyOQOBBqA/X5NaYkz6DCeqgT2AX2BC559xsNVkmVjL/20h+oNWh3QfycLuTxx1b04GnEaWhqmlw+3/MOFVu0zUdXI8yw+QyaiqY2V0GEdDLQgfLl+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=iAgZo3wi; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="iAgZo3wi"
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 0672A162;
	Tue, 23 Dec 2025 11:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1766486604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g9X3Dk0XV1834mKVYtr4ZyQnjS0CAcSr9absGlcIMTY=;
	b=iAgZo3wigskvMPzas5O7yGs+HZkNDlzkNSCcBsDRmP7g07qAcJBTaGagFfgie0tXDky3gC
	BPqawSVTlehA5b3tC3KhAGqVXJkAGnuFHn4bxq82tDQC6k9RrTmnIA+dbYrJ0JNc8fhjwP
	aric1uxvA0leRi4ZFppe3qgnX0h1KRjZBaQTvQzaueGd3S9Mvx7be1xkJKGoAjeS10enBY
	ch/dhNGc9iDC2AiGDmwcG5UypipRkSjZVZQbnjVW45En4DCx0kKNcbKgptpE1Td2zPlpl4
	XexQwDT9bBQ6Apr6kPKd/yKI9SBhf+a8lKRB2xXzSrZs8hLZO60LcL939PtNew==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=17d32d76fcb41777ad9089a6c68374b95f4f824ab89f8e0ec07187e534f6;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 23 Dec 2025 11:43:21 +0100
Message-Id: <DF5J8LL1AALI.8P0VHHFLBDCA@walle.cc>
From: "Michael Walle" <michael@walle.cc>
To: "Alexander Stein" <alexander.stein@ew.tq-group.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/1] serial: core: Fix serial device initialization
Cc: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, "Cosmin
 Tanislav" <demonsingur@gmail.com>
X-Mailer: aerc 0.20.0
References: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20251219152813.1893982-1-alexander.stein@ew.tq-group.com>

--17d32d76fcb41777ad9089a6c68374b95f4f824ab89f8e0ec07187e534f6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Dec 19, 2025 at 4:28 PM CET, Alexander Stein wrote:
> During restoring sysfs fwnode information the information of_node_reused
> was dropped. This was previously set by device_set_of_node_from_dev().
> Add it back manually
>
> Fixes: 24ec03cc5512 ("serial: core: Restore sysfs fwnode information")
> Suggested-by: Cosmin Tanislav <demonsingur@gmail.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Tested-by: Michael Walle <mwalle@kernel.org>

Thanks,
-michael

--17d32d76fcb41777ad9089a6c68374b95f4f824ab89f8e0ec07187e534f6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaUpySREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+B0iAX97oQnnIHvjRE6JNIqEnYR4uKI/jKZbzZjm
QzIJRdXBBMzjw/r/2j+N5hSLI3UG0g0Bf0UkJYHoqhKUt1SXJoxqRdnbeNTpUo5G
Fmy30fn+B3UPljQjNkafMPYgpfXBCd1buw==
=scXj
-----END PGP SIGNATURE-----

--17d32d76fcb41777ad9089a6c68374b95f4f824ab89f8e0ec07187e534f6--

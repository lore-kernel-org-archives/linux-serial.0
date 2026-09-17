Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAEF4F3921
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660842; cv=none; b=cU7TRrAC2zYhAuR49obBsMb9kb0NbOf+fhGnPPxyQxoenTK2WpYfPpo39bMzHRuOogfqkPYDs9hXUGWIMtwFFEo8MdJzyiV81SJ2dtSEwqfnqbhUJD6DHxPJV5THgmWVIxJYshWfO07GES+sc3epenLyB4I+ggMWh2F8HEnIhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660842; c=relaxed/simple;
	bh=QCMj5A8DaEw0KwnuLW+LLyi+jqmDIYYCIEsF087o8tM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LeTqk0Rcfeef8qKS8aF2vGyPgPcgSYjlHSASdU76tSm6NVNKwl1BJcsJF7k5/+GVg6m1M1YzRPapBfwzp2JEUVB7kDNaLJvRO9xAUyewjGfCeiiW46J4OtweAOQTcuCz9SDhwl+gcQWiloCA+Ctnt4k6TK3qHzyNWy7HuZoKAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYumxuCX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYumxuCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F57B1F00893;
	Thu, 17 Sep 2026 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660841;
	bh=QCMj5A8DaEw0KwnuLW+LLyi+jqmDIYYCIEsF087o8tM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYumxuCX+jwnAtFM2ZiYfl4FNk+1DrAIviPBj2Q93ztWmrd+cBtQ59tLbDlEv3iN2
	 mrk5XaSF8bL6ANwdQPHqH8+zT2Cf/QkQUPeVolgIgNAd1kjARBvnW+BnA2I4bz/ik4
	 k+3mkIijK1Xo1v9bvELk+3wNPz5ZCc0/thriorKKiFsdJJhnnvJfLcPQtivpC+GYqf
	 PA99bKRqrXuBzhmEp5w1CyQA5Xzb2IcwMoW7kAnI03Z8lYolJMXxJEvmZfQdPF4Yx1
	 ny2ZVWQGbSjplqDDYRERFLz36VQCTzG04+xENt1gu4m3vw23LJw8nX5GOd+M2qOlHw
	 c1NqCtPA+BSEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kgdboc: Fix tty driver reference leak in
 configure_kgdboc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260917155523.2161202-1-vulab@iscas.ac.cn>
References: <20260917155523.2161202-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:00:40 +0000
Message-Id: <20260917160041.1F57B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> tty_find_polling_driver() returns the tty driver with an extra
> reference taken by tty_driver_kref_get(). configure_kgdboc() stores it
> in kgdb_tty_driver but the reference is never dropped: it is leaked when
> kgdb_register_io_module() fails, when the configuration is cleared, and
> on every reconfigure.
>=20
> Release the reference both when unconfiguring and on the error path.
>=20
> Fixes: 7d7b93c1452f ("tty: kref the tty driver object")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155523.2161=
202-1-vulab@iscas.ac.cn?part=3D1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96B394793
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601238; cv=none; b=UL0C8PFCcM6wFZ4mNcClXWAY/XLON9wZFnJs0MXlo2jmCSSGr1jHpe1glruY1ovqmOTb714iYQ8WH8X6lNcTNkGgLqtTCo+R2ddSqbTsHddygCh/bjFi37pXshOZ9jzmFybWZjZyP2XJb4bL8zimCUYqT+634/8TtyI+dYO2+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601238; c=relaxed/simple;
	bh=/1EQLFpgyE2/iC8PktDKmerNGSaaWaDFjd5M4AIy4vk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GEJK0/TKYEQ5iZ5dINMvHff/j49hIDyPOe9T8QG9PZoIRBxcjbxMyO+PMkczmzuvbrzocANNwe5GdzNkp+CHajH+Y3RKrbuD7Qxj2qi/WtNcSPNusx+KBa9ZmqnAfhUzX9npgBdW9UQ3Tup8n5ndZSkwFVjWLb+yDJd+6MVeKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNUTQwuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNUTQwuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA81F1F00A3E;
	Sat,  5 Sep 2026 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788601237;
	bh=/1EQLFpgyE2/iC8PktDKmerNGSaaWaDFjd5M4AIy4vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TNUTQwuCde7QRndeKC/Wv1snPTWJOyajZ+Kgsnx6anaZXQyxNJDm1euylQxHgQ1WC
	 lnEwwz51CsSBbZxS6F8Gc3pBobf49DA5g8UrK2BdLys6oAbbkAXnVnGVWd01HNsrjD
	 gQYpkj40wDDcXpieBKia9qZLPS84A1lFnEHp2oMFoQ96ZX5TJNmFc1E6eg+JXGYdSf
	 i/S6G08g4R1QFHZ2xk+FuFB9UKy2Ox9J1hoH2ma13EYTQC8dTbzzHVvyXjpGZtbrjh
	 Ua8VsB19WQihLCaUtQIY+UfK+fw4WK1tHp8SLMnQWMMFeT/GKp8XjFJDzE6piLDEY5
	 /en3LdhoNIF/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] cpufreq: schedutil: convert to
 kthread_create_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bradley Morgan" <brads@mainlining.org>
Cc: media-ci@linuxtv.org, linux-serial@vger.kernel.org
In-Reply-To: <b6768a4db5451e90e68befc3a9b498f1dfa52b1c.1788513591.git.brads@mainlining.org>
References: <cover.1788513591.git.brads@mainlining.org>
 <b6768a4db5451e90e68befc3a9b498f1dfa52b1c.1788513591.git.brads@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 09:40:36 +0000
Message-Id: <20260905094036.EA81F1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Convert cpufreq_schedutil to use kthread_create_worker() instead of
> the deprecated kthread_run(kthread_worker_fn) pattern. The new API
> sets worker->task before the worker starts.
>=20
> Signed-off-by: Bradley Morgan <brads@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788513591.gi=
t.brads@mainlining.org?part=3D4


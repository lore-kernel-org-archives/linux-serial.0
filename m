Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976043D4E0;
	Mon, 12 Oct 2026 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788704; cv=none; b=X98A0sZyeRSy8knP2ZqDpanhVUSvIki9tOX/GLY0oiSVVQq4CmR9q9I1ehXwIBaXhOg6bkfAL7nP7sMTzP7kll8k3LB2K0RuJarAHRB42k2cn7EPjF096Xg12f+XnAYHH0bEQ0CMgDmscfJ7RF7Yc9VQm3q4QrLvnMbdWHIAB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788704; c=relaxed/simple;
	bh=ouCFy+dwMHH9NWljsqsG6wpt076jdl0A2KjeW/VwWGs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pzKARFBBgjW3jb4IgTJMwDezFF4hRyjbkUaarStMd2ShS/AGNChTdr30eBB5zpuZGBmAO8l1kSSPXnhU207MoWwIDf+jczdWwAyztac8VMJL3QoIuRM059qCYRLAj2m74/ejWatr70VFfgwYpnrCZ+NVkwXy8mvjJXRV36C6SAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggMKgF8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggMKgF8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6701F0089B;
	Mon, 12 Oct 2026 07:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791788702;
	bh=ouCFy+dwMHH9NWljsqsG6wpt076jdl0A2KjeW/VwWGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggMKgF8a0MBIL9mLkRWhYX3flOI4gJNgwynpItp7MmDKv2hd5pyfgvtPkWoSPZcpF
	 wU1MW/vO9ep/7NwNlG5FIYrwEe4Pbmf68aASdKroqsM58zYeoixm8fkpT/HtakvqEJ
	 xMlWLtC1i9xdq8cXxAn3pxVFKV3SKkanQ9ShmuCXs3SKjKCdIV/Q5EEs1j/5FR6qU4
	 85GrAwn14acXL4QVvgX1gUKYbScnimF+4snoSUXw+VT0xXgQd6N2TSIK47eC/a+ryo
	 2I/7GlLozscZRd9tzIaO5blbJoswD4aD//JiI66AuGA6Y6kYqHwSFOu68kij2MuoTm
	 8KolN3swvl9WA==
Message-ID: <sashiko-outbox-167773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 05/10] ARM: debug: Add Cortina Systems CS75xx
 UART0 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: robh@kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v3-5-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
 <20261012-b4-cs75xx-v3-5-0e0d17a098cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:05:02 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add low-level debug output through UART0 of the Cortina Systems CS75xx
> SoCs. The UART is mapped at a fixed virtual address by the generic
> debug_ll_io_init(), so no platform map_io is needed.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v3-0-0e0d17a098cf@gmail.com?part=3D5


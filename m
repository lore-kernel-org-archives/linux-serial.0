Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA919067C
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096859; cv=none; b=UI21fGJWcQsdZszpQHv555JMKq7pO9zFl13vscXtjb622bhjbk/VgNJj8rUFCc8PsGSMoy4142tLrs+DvDz9/hbhbu6G1QxqWnC/wZIE9CANQpswYJWOHC09btllY6m+fnAZbi/HpihxQ8ooxcAx5gih1rt/O5SG3DCU0Wh7LDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096859; c=relaxed/simple;
	bh=e801zmggctb+XCbDv1di6Rs+n0YcK19uuVS+9NDmaB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N2ClVJYdc8r27GrKHAchyVrFvnqdKLXZlJKiFl3r4EWlSojjOeoB/S4FTLdy4RQI03QN3sc8GHyZ/isGOpLqhPZ71AjsApV7LnLfqsFhywknhxOCXHpLOFF2zK7BKAnnVSoDt8n64Yb5bom3pZGNcEKvewk2RoHhSj3QHbr2Usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/ECFOeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/ECFOeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C054D1F000FF;
	Fri, 11 Sep 2026 03:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789096858;
	bh=e801zmggctb+XCbDv1di6Rs+n0YcK19uuVS+9NDmaB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I/ECFOeVMLjZINqQsE80Q6ZQKvnoPDrXkYmmMyCjKj8l0Vqwi7XvqvT6AiZM6r2vd
	 8Nfjl5hNsfJA/Sye1mjPVHhhTxv+D2870lK/N+l89WXvk6pZfiPgID4h2sHvT81xoj
	 nEf/9h3tQPp0ibpfdmIoDI+Lij1+VWR4ql3S4qgftNM74k834sbvPimOAZonMFZgqD
	 EMv3XTxRnyfHZ/jFraWmzKl2r48T/R6iJvK6qsfv/zjtmSnZaXuTPgTlYr8+Mb5X+1
	 URJ4Z/v8MSWkRRaEn0LnPSd6nschC21jzq2aEpUJui3jOQK6DnA3eV+PCNU7hGbkXo
	 BuhQLhyR6RXXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: sh-sci: Unregister UART on sysfs setup failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-serial@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260911031500.5745-1-mhun512@gmail.com>
References: <20260911031500.5745-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 03:20:57 +0000
Message-Id: <20260911032057.C054D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> sci_probe_single() registers the UART port before sci_probe() creates
> the RX FIFO tuning attributes. If either device_create_file() call
> fails, probe returns an error without removing the port from the serial
> core. Device-managed resources are then released while the port remains
> registered.
>=20
> Unregister the UART port before returning either sysfs creation error.
> If the second attribute fails, remove the first attribute before
> unregistering the port. Keep the existing probe failure policy and leave
> the successful initialization path unchanged.
>=20
> This issue was identified during our ongoing static-analysis research whi=
le
> reviewing kernel code.
>=20
> Fixes: 5d23188a473d ("serial: sh-sci: make RX FIFO parameters tunable via=
 sysfs")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911031500.5745=
-1-mhun512@gmail.com?part=3D1


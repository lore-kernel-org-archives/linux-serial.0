Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161943AAF5D
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763869; cv=none; b=QfeZdqBwA3oOr2fZpO9t0Ban85dAlXAuGIFZvdCYpXE8v74Lz69fau3+X6RY/jALq7iAbMfuDEcB+DPjMJUpNH0tsKj3Xg4f0nBfRfneO6TX521GJq90eNScRBIeA/I3rkLJY9BGfqgVjvSm5he4r8fWiEQ39PI2oR+/cBHXaKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763869; c=relaxed/simple;
	bh=CS+LAM85XlM9o5yWlB5KqzklOLWzIV6nejGFr/GMV+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V8Ym6e+EJQIHGsbFL4cvPLZ9UH/outH1FrTDLjXeXYFpoRx5OhTxgvvXGvC0+aYLQ4elUKnf+d4wMXfq2BcFActVzHTEC35LDsu1J030y7QdPc4hly9km/FujbfEF3xk6jVHi5FulwQPvkVausLJ741tRRzbMKrluF5eapch3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRpkTV8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRpkTV8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603AC1F00A3A;
	Mon,  7 Sep 2026 06:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763867;
	bh=CS+LAM85XlM9o5yWlB5KqzklOLWzIV6nejGFr/GMV+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nRpkTV8dGFznwNH3EoVO5Z2NUSNKvRfGZobdMIS42WX1RjwT8qcsJk2kJ/LT9Dp5S
	 NMkWwRnSUfuv5W4sugzlZcXQKTLv4mjzS+X/n9rzD3TGik9WdrsZ7VHeTiZma6CKca
	 1DlaUyR6twJVXtePAriMSacTqA8QXVqZ285Dg7gtg85S/LgZVVS26mXTGZvlYxMTdL
	 yGeqkPe7zdp6BZYSFsDQJNDanPEx4GUfm8IMNc/uEEivBTNnObZ2xWDkV96IsET8NY
	 0IIZnmX9OvSxmxtfRiQDTANvIrrNbKQ6/2hIPqk3VQg04sFoG0ffGoZ3caIHKNY8G0
	 UqT8kNrzlj0mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] serial: abort TIOCMIWAIT on hangup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260907064418.92953-5-johan@kernel.org>
References: <20260907064418.92953-1-johan@kernel.org>
 <20260907064418.92953-5-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:51:06 +0000
Message-Id: <20260907065107.603AC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add the missing hangup check to the TIOCMIWAIT wait loop to avoid going
> back to sleep (indefinitely) after being woken on hangup.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.o=
rg
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907064418.9295=
3-1-johan@kernel.org?part=3D4


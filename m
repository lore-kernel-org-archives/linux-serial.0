Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2524454707C
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440891; cv=none; b=ErQN39zbQLRjD8Khz4QnVTtPZOGKDPW7yyzaGEZnG160QCXYbD1PjjgWACM5c1I6G2FHLdjTAX3bjJvJRBStxDm6+S1q6XcddMhgbC2MPLXpA1ana7RZztCDqNy6wU9zzs8barnJDyPMcXDtUr3+E/8VNRrE/q/2T2Vi4hJE7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440891; c=relaxed/simple;
	bh=b+iYVPLZv+vxnX+X+abbPp/TVg7OvSP6gXnQalBUxug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R+MQTgBFU/mnOMeKtCx0ftAAnwYn0awk7FYRlimeAYbRelObf7Of8oaQQeotAW1gR2Abdi+MYR7MNH4MxHz6gqBMljSeOzsoZ7eveHePfV2by1IUZwqliyCznnD4eUIUn52IXKGlavkuAZhs6+xfzErio3aw4n84jnfaTyiOhhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZBEPtA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZBEPtA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820861F000FF;
	Sat, 26 Sep 2026 16:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790440883;
	bh=b+iYVPLZv+vxnX+X+abbPp/TVg7OvSP6gXnQalBUxug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QZBEPtA3+LZOrQm57Y2df9iH+tZBXOdQwF+HfRU8NxkPigdkqH5Zmyr2oH6gSZnbI
	 wU1uWYh0LxTp0j1ER8T0yocK5ivCUzWwiCwmA+weXK0k6sFJDdT0VPT4I4NqF4aLPR
	 56u1y0I72UTaErtl1UtfXRK3GHQn2h3400DsQU/gL6hIkOUZ8W/A/Xdw74jlVHCy/+
	 Rb3UYh8FF8B+bMD8xEdAfRnZBD312GSpPzVGBRSN3eXo9KNAIorbPLP2Zn95MbLbtp
	 3zpJg6accfRUMGis7QGUuC99eXc7jCB+cTqrH9f43QE1Yf/OFa0MIZbHy/nspIoI9a
	 987q7dDdfWNtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] rust: sync: lock: use DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: gary@garyguo.net, ojeda@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260926163551.52371-6-mohamed.osama189110@gmail.com>
References: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
 <20260926163551.52371-6-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:41:23 +0000
Message-Id: <20260926164123.820861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace the ScopeGuard usage in the Rust locking implementation with
> DropGuard.
>=20
> The guard preserves the existing scope-exit cleanup behavior while using
> the DropGuard API from the Rust kernel memory module.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163551.5237=
1-1-mohamed.osama189110@gmail.com?part=3D5


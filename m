Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F044162A;
	Wed, 30 Sep 2026 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751977; cv=none; b=nIzWJOF2HUep/j+ScI0hmEkmtO5l4WZq/DqLrv0KOjLIDhhPKAzSJIc5agL7L5+vKYfeB49q/gKwcPuPTP8rtXu+WqPo+3Jq7R4hfuC15kYGag2SS25/R7hC7SZbYJ/YMvjMxOF5wYvWiUSjFufI76tnG7+FoBRbOEBeK2yyEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751977; c=relaxed/simple;
	bh=rPKRN3B0XrpSpchEBigGX8AlAOJVzwqupVvwWrDXT6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LcSwWtZH2//9OzGU+KmsO0gCZH0D7h3zOYBlVF3ywtplNnkhjpcU5300/OAGmt495pPx/jj02OV1J6YhHfETlTrG3OPjgIX9hM8nmLDQQVuOUKk8d8QbOoNsdRjvwPkdd2OcqGPqVF8YQjNDm+wzxZf9y6+O/Tz6y/OSxBA21Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOgfRO0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOgfRO0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A3C1F000FF;
	Wed, 30 Sep 2026 07:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751970;
	bh=rPKRN3B0XrpSpchEBigGX8AlAOJVzwqupVvwWrDXT6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOgfRO0QX9ZDMl9h/RfHmQxj7cTkVJAN+R3wabNzBKXcneO1G1HyEm0ykdfKrq+cS
	 vZmUVKJmJufhDLXYH3cRCsRaGyXvY4ggHK72Uc7oa6sao9SePDUEZ2TqaU0VFuW5ij
	 FmYyoi/Kiuddi7dPiHhNwnb5i4/3utSZGnWj1PJBepKvJv2rGjEaD6OhK9o70HeFyI
	 L6RrisQl9TwmhmB7IQvSIxmAQBz3Jq8Lw5gzxc9NjA1rrhxejlx++7bYT9hlGf0vSX
	 Kib4upIXYVN4Tu2hTkCUQHIvaJRh/igshbfg4BLxYONJmq+l6SNMrvIQu2E3ak4EYW
	 lF+2SX8HcUGKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260930-b4-cs75xx-v1-3-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-3-4617c4463529@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:06:09 +0000
Message-Id: <20260930070610.15A3C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> On the CS7542 the bootloader parks the secondary Cortex-A9 core in a loop
> that waits for an event and then jumps to the address found in a global
> software register. Add the "cortina,cs7542-smp" enable method for it and,
> as with the other release-address based methods, require cpu-release-addr
> to point at that register.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-cs75xx-=
v1-0-4617c4463529@gmail.com?part=3D3


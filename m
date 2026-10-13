Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3E13957E
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863421; cv=none; b=VjHlXkcuUz4nXhD9FBNBnFbFYmE+3MdWbojWiG95U/V/+oWLw7q0o97eq5kk0dfzSUelZOEwr5yox9jE53uRoXLFqdVeSD1BGYweBU/Vn39C9oY79wEJnIwVd4qYBZ6FkXDeJFAhaWFVI1SGBpgJGDfl5dNnzCU8SG3MMAV+At0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863421; c=relaxed/simple;
	bh=LUNCcOzVY8R/95WU++pfFtnml2e4yzOrlJsPAo6FwI0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ap5HUCgr/DeEi187AYTpANBOKCpNAjPHK05kVfECInr92JfysOrwLdQjwPbQfzcuPX5go7kmttn7cXl3tU6P3BXkaVwmNs+W+hPqbVvmFtU7/hYE+Gu7rhDyeV5kKzFUhxhux5P1pGA46Yu4gNM8tOCJYdm2LS6flAk/kZk63zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTKe4C2o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTKe4C2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717711F00893;
	Tue, 13 Oct 2026 03:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863420;
	bh=LUNCcOzVY8R/95WU++pfFtnml2e4yzOrlJsPAo6FwI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTKe4C2onVt7zNaNL3BioLYHI/Xa2FzruvnpjWk04WwLQgWqzcywNwZVqRrez3Cde
	 kpnMLBhZEq3gLYOEzF+coO3OAX6HfcNMSsEl0vwOqlTcB+PPi3flw9sadJYzLNgj2q
	 k0tOhoxNhPHI9AAa7tgAWEVCgTFrDuS/ulV6CRNaoQSeJavYhXDTKdEhB16CQbzsJR
	 bac0PNpf/PcGLsIhDEcEzwckwA4I5s1cIu5OzQoleXiBNslgD6khxi/UjPvnmqCO/+
	 hnKN1rcldVGOPY9wHz9Y0CNP9ti2aOEpXkvZuL4BMXSnfdnfrDvxJI62Ktyp6wVeZo
	 XW2ySCvE8OJjg==
Message-ID: <sashiko-outbox-168923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v5-3-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
 <20261013-b4-cs75xx-v5-3-4e72aa383d39@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:50:20 +0000
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
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v5-0-4e72aa383d39@gmail.com?part=3D3


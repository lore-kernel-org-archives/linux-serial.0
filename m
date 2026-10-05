Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEDD48987B
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207536; cv=none; b=JR1G9UL/AUWBvr+DxHXPS4YkM7If7tSJuKpoV3i+dOmmuzZXOOPC2PMObK5fWfsGws9Y5+RFcDIHKnHQ1+U3C2tDPyKiZ7Yo4aAjfJH5aJNDXGWzTafr6XOf/4Ur4Xl40MI3WdIySmzrbxKfNap4bsJIaIiq3gcYVa27QQVo1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207536; c=relaxed/simple;
	bh=Vo5+jA11ELJ9v10uKkjpaHTklzrf0pHu/DD5BUfuEUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oQcVOxVVNyEgc3ajy2JGjbZZ5FDOgDbtTRgQi+v5615avFI90UtZoqSlzjn9+rWNDsYuEAUoEo/BDSEYL5Vgj6KX3nlW2A+JNtGbkfRYzFsVDFN7myz09tuwpjio4eMa46k6akrN87ceh2Q2YzZyd/zhg8edBMLjrsdlPHkYWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozfvfL87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozfvfL87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3D61F000FF;
	Mon,  5 Oct 2026 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207534;
	bh=Vo5+jA11ELJ9v10uKkjpaHTklzrf0pHu/DD5BUfuEUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ozfvfL870lPTMDwc+n4puO441HKZmPpzxf13eCuxzlgy/23LOMIcMuyaSYjPTJBlS
	 GVUTgyGTOxUmGghriACgPGa/Cws2TbuzkVYgFnTXX2/2QDiNvfJyoh21HYm5XCJkax
	 Qgk61tdlLA/IGo2MNdYhRYv6CxpPJl7Hw6j+m6arx1vPWJj1y4z6VxgQnb4vM/2oiT
	 f9ZNXCQK2z+ZmcveWEiA63xl0xNxu4GXDBhtJ5X2pgVcVGgkitzrwFyBq0gelRP/P9
	 9l7gyc7HJPYoNLp3DptWej/N59/aw0t0S8ja24OcjRdAsMmy8JgHQ9Ovyk1o8spvnR
	 QWDgyvvuAkOhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] vgacon: Use vt_cursor_{start,end}()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261005133335.344302-4-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
 <20261005133335.344302-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:38:54 +0000
Message-Id: <20261005133854.6B3D61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace vgacon's custom cursor metrics with the shared helpers
> vc_cursor_start() and vc_font_cursor_end(). Note that the _end()
> function returns the index of the scanline below the cursor, while
> VGA hardware expects the cursor's final scanline. Hence vgacon
> subtracts 1 from the end value.
>=20
> The cursor shapes remain mostly unchanged, except that non-underline
> cursors now also use the glyph's top-most and bottom-most scanline.
> This follows the style used by fbcon.
>=20
> v4:
> - disable if CUR_DEF maps to CUR_NONE
> v2:
> - restore use of vc_cell_height (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133335.3443=
02-1-tzimmermann@suse.de?part=3D3


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66F14883F
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041011; cv=none; b=SgkfMU/Q8+BV/9tO9Sb3/sQetEbGlbshv8BUzN3rHcJzqBnLfz+kROiuDgbxkF2hfV+hF8e9AEAQYC72gT7Di/tiCWRa8D7Jqtavz+fREB8FYGO2vce9vEzNXbLx+u+HsQS/W1AjFhBg8WMKMgAwbl3r33jBUQ4pYqBGPZ55vTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041011; c=relaxed/simple;
	bh=azUYxzZSAexmRWvh8mrxRas3uYL8U5lOvlDwE4CsOlw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GhfbD0VTJ/lpApXPQRYALYC++PTUcSOjwEfUITHXUFbnT8Fi/XbXzZbyRBoKHb5E/0ezKAYJyAWXHgk17R1YE2WUCETsT/amTTbANAonD2DSC8IhHkkxYNNZk2LOoHzyQ6S/i2xgnjOYiKWYKj/R9UTHe5LKGtJiL4Mup9r3V8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olsDGsig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olsDGsig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BBC1F000FF;
	Tue, 22 Sep 2026 01:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041009;
	bh=azUYxzZSAexmRWvh8mrxRas3uYL8U5lOvlDwE4CsOlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=olsDGsigfkSkCDJ+9Ye2o8FMEWaOtg3n3bgRoShyolgL4aHCFGVFusWEZU3ezSIDz
	 ELNHZs93NCKU6n4hfJMqD9tEMidtKC7op1kPJbjwFVathQlDyM3bMjvMhaS5I0xs18
	 SPiLwQ7vIjkNme1Spbss53pe1dvTEOp5rTFwq3J7nCnvTYXBs984OHSHapt7TUHj/+
	 X56BA9YYnFY0s7jDlMLiYDrEVvSM1ag6hPxYXMSsc/vE0M5Jb41S0VXEv+qgwEIY+C
	 2o532PWEIMcATyiTe6kY4z3cBYPeL7mxDfof+09dU/XChuVhYNEi33+Eoe+etv2V0Z
	 5tE4idOAlTMig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] vt: keyboard: publish accent_table_size with
 release semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-keyboard-v1-4-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
 <20260921-mb-keyboard-v1-4-d170228b80c0@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:36:49 +0000
Message-Id: <20260922013649.A2BBC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Jaidev Shastri <jaidevshastri@vt.edu>
>=20
> vt_do_kdskbdiacr() and vt_do_kdskbdiacruc() rewrite accent_table[] and
> accent_table_size. handle_diacr() reads the size and then walks the
> table.
>=20
> vt_do_kdskbdiacr() sets the size before it converts the entries, so the
> size covers entries that have not been written yet. Set it after the
> loop in both paths and publish it with smp_store_release(); read it once
> with smp_load_acquire() before the walk.
>=20
> Found with MBCheck, a static herd7-based memory consistency checker.
>=20
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-keyboar=
d-v1-0-d170228b80c0@vt.edu?part=3D4


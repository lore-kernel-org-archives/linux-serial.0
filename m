Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C951EB5CE
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041550; cv=none; b=P+hc4uqfCdJTxZNjDFVS8tOl4CbFXSBBY8edItJMBBW8Zd9QzyrVODT3C+juOQN34xSCG+jcT/FJTXmh7cOGIY4456ZIHywyem2927XegH23gWU1PF5N4b+0sqC1vAa4rYO9/6sSwsp0bMkV0sdNHy5AYiSdYpXiikGuvYuV0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041550; c=relaxed/simple;
	bh=oTb8SljSS5IqsXqngfC+NV1XMiFVvUx2tM9la5BeXdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=daT6qQDYxvt6f/R7B28MZhcFR7G1liXmStc15z2oFBVDXyZr2dorXwbriZkvCHj+oc+aLNRM/Zn27A+A+nIIeAwoqMUIJbwz7mu6kY8OvrIkCWasXAOdtT4ZUaEB8lealMmYkrKOq1lg+MCURPQ4aGjg7mO8BbEXhwHICKxXwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9V4aFE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9V4aFE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C36C1F000FF;
	Tue, 22 Sep 2026 01:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041549;
	bh=oTb8SljSS5IqsXqngfC+NV1XMiFVvUx2tM9la5BeXdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9V4aFE77sBAqHUwG9KIqfBsPFb0ftehZ9qhAVP5FUcPE/bhWRwa3H/NvlknR7BjM
	 tBRzv8AH7UL875XrqbA64bU1Cpejf5LyWuD1cLtzoIo5qTsTbmCNfYKcFiQT61WSHm
	 fx9VdO9wKDj0cMoggjgILIlriIu/qi32kp8WPP8LrlwmXppVAVowrNDl+FI3Z9aukI
	 RT4s8wWBowGAJsQmuPmP+QqVRCUo8MFOGfXS3UbinrMfTpVUaPbY/VSb/fbLLu/aCH
	 74iyRIeqnsSqrzFtodEXebQPDCyE6rHXuh7emCF+QhbAZOe8Ti+TLIryE4a7pTn7Ji
	 nmyaBkRPouFSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] vt: order the fg_console switch against
 vt_console_print()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-vt-v1-1-71b7990c26c1@vt.edu>
References: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
 <20260921-mb-vt-v1-1-71b7990c26c1@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:45:48 +0000
Message-Id: <20260922014549.0C36C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Jaidev Shastri <jaidevshastri@vt.edu>
>=20
> redraw_screen() switches fg_console with a plain store once the new
> console's state is set up. vt_console_print(), the printk console
> callback, indexes vc_cons[] with fg_console before it takes
> printing_lock.
>=20
> Store the new index with smp_store_release() and read it with
> smp_load_acquire(), so that the printk path cannot reach the slot before
> the console it denotes is complete.
>=20
> Found with MBCheck, a static herd7-based memory consistency checker.
>=20
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-vt-v1-0=
-71b7990c26c1@vt.edu?part=3D1


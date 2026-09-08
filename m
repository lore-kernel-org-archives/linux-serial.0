Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128237A846;
	Tue,  8 Sep 2026 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846824; cv=none; b=dkUF2sH+yr+EaH63Rvf/oVMMln05EnKeA/4zriCnBDtpaui1WXJiwwSgKiJYJp9o5rGMqjmaDfwa01mAoQWkdxrb5tKKvRmdj/wLce78KFLwNVsce8V7KDAbAZ5zHSWSLHSScb8e3h08P4+IUJqh9pxvBSipgX4rpenktW2FOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846824; c=relaxed/simple;
	bh=7irWsOi0qKiB314XEC0r81gxcqa1CHuy49js3c90MN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WkJ9ErTHDDcb3IxL38hS6ES659eLRuZE1IVbQYhF2t89qUvSmi7/aTEl7wB9atXmBiDjVwj3KnngCEHSB+wBRyn2OzH1f0v0zx9GpOQ89QAT8n9OImC+/iI0GRyAib/icAPBmU5ckjFBSj5/yvkp/ag7pA1DVwgE47Nrkxu7TvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9yLuypH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9yLuypH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B031F00A3A;
	Tue,  8 Sep 2026 05:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788846822;
	bh=nJ1ClPpVfd5MI9GC2FyRDDaRM7bKnCKJb3ab/DK/McU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9yLuypHO6QfLTz06rXKMdfnyvJueCLmeD5LQmlBCWA9EK0sZ/HA5ZI1XoZgXDkDm
	 O79PQQ2OXxhJSQS7b78DiFAixNl6S5M3Ezx3u1Al0Ma8qIoaB2ppF/aIij8wS+Nyc+
	 L7L2xglEWyEWbrOLUNvtxoG/bCDMs4fXy2fDXrtOF7DxezpKPSDWjidhtTHgbLJVUZ
	 sq3wYCq0uHabcTfqlBckofDGy/PcMWwcq7W2wntFaavQZfisZZonTeDNgTwBuL0J9o
	 fVL/6AjKCCgYPkwkEQ9VtzkumPndFtGnqzm1G6AUAiBCYAEDqfLcPev2rTqMLxL/ON
	 X1EWVJmXoJOBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] powerpc: fix repeated words in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: kvm@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260908055133.16469-3-hemanth.selam@gmail.com>
References: <20260908055133.16469-1-hemanth.selam@gmail.com>
 <20260908055133.16469-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:53:41 +0000
Message-Id: <20260908055342.91B031F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Drop words accidentally written twice, reported by checkpatch.pl as a
> possible repeated word.  Only touches comments, no code changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908055133.1646=
9-1-hemanth.selam@gmail.com?part=3D2


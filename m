Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC663A5421;
	Fri, 31 Jul 2026 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484611; cv=none; b=QKte0e+GhCkbckKMmYkmsogG4cGt7Mrkfn5YHfEM6fuqnRilgBLNe+Yza/cUgcdyisjSbLmvIF4+MSndOuolVQHOLrjU8lI/Q0NhWN7WgzJZM5IJcsadEZi0KtXUhOI5vI0a/0pQ0kl9RLecE3QWD64JaRWy5YRX6yuaMgaKcRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484611; c=relaxed/simple;
	bh=8gIvihe41YUE0hiTzXnY5GJgj3ZBN7qyQZyyUmoGS3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPMvrIjgx7BDM3nwbaccm4A4FjIDPPOG9kqO/hXGehB/axYJf+uKIp1d40qzFwR+qGq2zHXn7OcjoTA1ywD+T2DsH4B3BNrW36vlGh/hfCApqj/2ofvZJpQli1Lnd3bl5/gTCBhj0gP/RzzzTcNJ8gmNQO6M8F1Z7Pm6NJFpnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AYEnP5uw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AYEnP5uw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACC81F000E9;
	Fri, 31 Jul 2026 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785484609;
	bh=Kc9FqxbwrDQZK5e9QJ3az4+a4TuBGMtiqHumcepk2ik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AYEnP5uwaZ9kuCkBUtebdPM9ue5ZanQRLCGPGoGPCugcDyte+InLAjYLr3Hu+L3BS
	 cCJ/aJ1IQuCu602eGGXouTkIC5VypyXGxRb5dR3oAyIVxK97NrSfWnEIyi8kTtR05U
	 dY6KsNah2ZUVTr2zLTFGtiuuWciVbAjws3/PANhU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 31 Jul 2026 09:56:17 +0200
Subject: [PATCH 2/2] vt: add permission check for KDSKBMETA ioctl
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-tty-vt-stuff-v1-2-be99b9da8e30@linuxfoundation.org>
References: <20260731-tty-vt-stuff-v1-0-be99b9da8e30@linuxfoundation.org>
In-Reply-To: <20260731-tty-vt-stuff-v1-0-be99b9da8e30@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Joshua Rogers <linux@joshua.hu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=998;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=JrfJuRb/KjUHq199pdX8TWAXMXIH6h0YrvGkU30i36Q=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk5obrHP1fULMjLNmMs4b/h7NNac9Z0YZd04q0rUXx98
 7X2n9vfEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABPZeJphwZF9d1x/lrzft1zj
 seGKy2t4L5yp0GSYKyRn3rQtjItXOuzmI/5Im5YL89/MBAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

KDSKBMETA modifies keyboard meta mode but lacks the !perm check that all
other keyboard setter ioctls in vt_k_ioctl() enforce, allowing a process
to change meta mode on a non-controlling console without authorization.

Assisted-by: AISLE:Snapshot
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/vt_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 28993a3d0acb..deb3b3f93461 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -406,6 +406,8 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 	/* this could be folded into KDSKBMODE, but for compatibility
 	   reasons it is not so easy to fold KDGKBMETA into KDGKBMODE */
 	case KDSKBMETA:
+		if (!perm)
+			return -EPERM;
 		return vt_do_kdskbmeta(console, arg);
 
 	case KDGKBMETA:

-- 
2.55.0


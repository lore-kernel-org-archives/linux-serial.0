Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55825242D65;
	Fri, 31 Jul 2026 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484605; cv=none; b=kAcPh0lGpmSGnBYsoZysNgP4arG9KLKuGxim7eoKaGLi1RbJnGSQ+7zwzrinyLpuFl/BqZcpm5MSDd4qx+R0dPMu7dlJXU50KLwRT1tn68FIJ9TQwTH7NIKxaUcthrpjuRopunPOvwvquXsPgffiLu5YPkpP9kQT0rDVK214row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484605; c=relaxed/simple;
	bh=28mnD8HF54gXg9GIb0vHSQ4UKDZxAAnfW00uowUhskI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GXyKWOVO4Jz7+1Of8kVV0oN3H3sR1JNfo58vsSWOKZn7yowJ2AIP1xbtkFLBtN12Ust/QjTtbIGUSI2UzCmsUL5Hq3BAJeQ9/Swm9WthSzchA3YNPvF4US6Bxky3KHJ044dVNL6GdW2ES55lCRY+wBioJyqJL/4btLLkMjp42HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lw8ImHmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lw8ImHmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA331F000E9;
	Fri, 31 Jul 2026 07:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785484603;
	bh=TF9CQHEloOkWD+oH3Gv+eWigYqCNBEnQPEmvt9m+sKo=;
	h=From:Subject:Date:To:Cc;
	b=lw8ImHmE0l6+ku2+VZYC64Vn5yo9x/SMid+lR+JEeAlELyyNG4r8qUoyzql7SOyx7
	 h1bKneOVjU/3dm0ZhgnHQzGVklSsZ5r6JVJH5gNf9z3oeLYF7ZRcFwextn5i1M2I80
	 YxmQhcqiRNvNB8DAfwnLqoDjefwv4H68N7A7EQpY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] vt: Some small vt bugfixes found by code scans
Date: Fri, 31 Jul 2026 09:56:15 +0200
Message-Id: <20260731-tty-vt-stuff-v1-0-be99b9da8e30@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAxA0atI1g3oCAZ6FemiThONCyuTKBbx7
 o52+Rb/72CclA2exQ6JVzX9ThnVo4A4vKeeUT/ZEMrQlFRX6P7D1dF8EUHuKDZSC1EgyMmcWHS
 7d+3rb1u6kaNfDziOEwpPpW9wAAAA
X-Change-ID: 20260731-tty-vt-stuff-eb7c6f3f7727
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Joshua Rogers <linux@joshua.hu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=673;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=28mnD8HF54gXg9GIb0vHSQ4UKDZxAAnfW00uowUhskI=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk5oToh2y9ncW431lzYfihvycct7j4Pj92yUJtw9d31b
 Y5PBJLVO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAik40ZFmw4ezfmqLGR3y2Z
 18deXVwc9jbkoh3DPHtnrzdMbz3vKWurPZjDHHeMkV1NGgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Joshua at AISLE has been kind enough to run a bunch of scans on
the tty/serial code and here are two minor fixes for the vt code that
the tools found.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Joshua Rogers (2):
      vt: stabilize tty reference in kbd_keycode with tty_port_tty_get
      vt: add permission check for KDSKBMETA ioctl

 drivers/tty/vt/keyboard.c | 5 ++++-
 drivers/tty/vt/vt_ioctl.c | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)
---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260731-tty-vt-stuff-eb7c6f3f7727

Best regards,
--  
Greg Kroah-Hartman <gregkh@linuxfoundation.org>


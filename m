Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB04EEAB
	for <linux-serial@vger.kernel.org>; Sun, 26 Oct 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472877; cv=none; b=bI8pvrhCRcsFIEIkgRLp33d0kj75kF7G/O3rG2eoht/70u3JA3I2fJjQ1F46AOsgRNHaGUG8sNdlnzej5Jf6G5fuKR6ePIVJ6SlKrNGaadIM2cfOtOkXZ74aMbP1AB7dqqciqpOfd+gvu1tJqYsfxShsxqJODET426TxSt0XuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472877; c=relaxed/simple;
	bh=7KD5dGgax9bTmRFpWBp6doF76wbbIxJPMbGDcdBfxus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI9FiF7Q2GLBfc/ozqZfaVFwVBjow0zr9WAm7HAI0fNagRLMipXXW4slCUTti5HYhls/f9sUdSH8CoKj/a6959izTGKshEy0m2yCqkWVQz2sZw3w5SlqHjVtk3x/3t4HiMaQIkk1P1KjeJs+4Xtxo6/2Kw3n/C8yd+qycqEsjh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkQKIbN0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkQKIbN0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290ac2ef203so33271375ad.1
        for <linux-serial@vger.kernel.org>; Sun, 26 Oct 2025 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761472875; x=1762077675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RfGStvJcl4TjNSGKHIZE9j5tm2qV6cEHrkxmBAThP0=;
        b=QkQKIbN0k/9rTMbSZPy21PHzbhewJKcThqGeNCas8ByZ8//PVoid9TkVxc0Wvlb35O
         0W9ZxXl2JrUF5Z1ueincG0OqbgM+8X+IyGeDGgePlj2cgEs/SdCAxK3+crUC9FoZbJzK
         byhmKxb7bfuLxVCt4EBC31QAEDRO4W88AsxUDftEH7mGfKLkSIEd8nDIfKDgiB8bjea1
         FHqASKbSjI6aQ9aIgENVURW+b5CuogJTF9fCA6JzWWdIOssF6whmzGLYkhS6Qy0F9Nxs
         FchEZ0Kvo8NRAMnhN14jZMIgQokQ03PfnptANDDLVuanQfEwY7W9W/4uosaQ/bCpL2Z9
         mJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761472875; x=1762077675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RfGStvJcl4TjNSGKHIZE9j5tm2qV6cEHrkxmBAThP0=;
        b=Ngono72/kZS+BMdTCMVkkT7RgHq4Z/AWQEJsQPrSVcHga2UYSgxQZqYSlwHuOz/CSb
         QZT69U+TCssGT/wKhkbAlqZMR24Q8SIp8GHsurbsCF1ptlw4xSzCIZID70vci5Gv7AUu
         7FtB2VRjZxEo7POpBSiAgwpWPTrr/wY8dHyYqOuxR3M8Gi6nN3VbJg1fWKQosxmSQcgh
         NNJht3Fh0Rj2a7DLZA+57MIgQvRBlQ3d6O5rZdam19v/gYNPSbRT4Zh6GmgJXLB9XUw1
         WLgeB80dz7xJFfQr2ipFKc57lVgntbz0EJQSzIIYj92K115r8RBM7hBKM9QiHCDEmcpW
         xQoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9l/3x3X+Wl7mcZiivJYz1JXf2BskkQfla0R//SD5UbWZoUmB/jE/6V/El4qwEO/3L1nhbL/vw/GvDkBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgls17oSgn29HdlhHH8+VK7jRDGFWEK8eKbdJGGvhO0TuQxLem
	tzoboyh8GAWt2WPPMLFwJ5eXGro+RVU8rWigEjtWBLKo3OVEC4SiTabq
X-Gm-Gg: ASbGncsQydC5SC3C37cbMUCgOyYBo8asTyRIdWV8Q8VQMMVgc9rG5tCru/JUOShaRNf
	nqjIkFx18YfceKsD0UuQOMt+dZM2cTaML/TWXaq2K5JyYC8GbsnEAaWvTTccDNKXWuu19jjg6Pc
	ucIL/TCFH0FgmXek+/sKDt+Yf95TPXzjACgtSnIHwrH1pdoXRFbY3+Cw3Y4Gtz0DMkuPopgBzrf
	r5N+jfkzq9OVXdHDrU60amcapFV/xO4B/7jYuBk/STifQLPoQ6xBLOdAstHy7G/4tXPHNOJHhhk
	xxs1yGYVx+8WuE57jSYdyvBsxxCEYcnFszESo/BXK9jMw1tSEsY2b8Glrg/fnOzqbTdgnaszIzg
	2jt1sfvfDhPtBPX5W7eapAOzp+XRWGTrTgKXupuwFpoK939M9BCWFGrp3r1wmI2mc284yNZLom/
	zmR4voaQ9cH8rW17wqUdM=
X-Google-Smtp-Source: AGHT+IFKNOKTau/QQRGqY0zzzctIn/ja6Be2Y4OB0k/nayMvBEyR1iUbx77eiYu6XXPZj9O6THlOLQ==
X-Received: by 2002:a17:903:2f05:b0:275:f156:965c with SMTP id d9443c01a7336-2948ba5ae75mr89132875ad.52.1761472874942;
        Sun, 26 Oct 2025 03:01:14 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d099b6sm45719905ad.33.2025.10.26.03.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 03:01:14 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	david.hunter.linux@gmail.com,
	xandfury@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH v3] selftests: tty: add tty_tiocsti_test to .gitignore
Date: Sun, 26 Oct 2025 15:30:25 +0530
Message-ID: <20251026100104.3354-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025102634-relive-glutinous-df0c@gregkh>
References: <2025102634-relive-glutinous-df0c@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the tty selftests generates the tty_tiocsti_test binary, which
appears as untracked file in git. As mentioned in the kselftest
documentation, all the generated objects must be placed inside
.gitignore. This prevents the generated objects from accidentally
getting staged and keeps the working tree clean.

Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
staging the build artifact and maintain a clean working tree.

Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details

Fixes: 7553f5173ec3 ("selftests/tty: add TIOCSTI test suite")
Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Suggested-by: David Hunter <david.hunter.linux@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog:
v3:
- Add fixes tag as suggested by Greg KH.
v2:
- Improve the commit wording and explain clearly why this change is needed.

 tools/testing/selftests/tty/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
index fe70462a4aad..2453685d2493 100644
--- a/tools/testing/selftests/tty/.gitignore
+++ b/tools/testing/selftests/tty/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+tty_tiocsti_test
 tty_tstamp_update
-- 
2.43.0


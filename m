Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E01421880
	for <linux-serial@vger.kernel.org>; Thu, 14 May 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769487; cv=none; b=TQyaSPvB21BGxB/scknW/Q3O/PLZwXED6XexZh54NJ/8nN5czzdEan2NU0KBx42GfEs5jKSTrnGZUtQM7uEg3Cod7NczZFUmCdlCh+/tYi2OuH7XFG0RkZuEW8F9y2kyKNTL3l/4TyH57wFjxcKdD4RCeK/zFUDfondmh5W6i2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769487; c=relaxed/simple;
	bh=fXqG8OJzQq5/BhN1LGFZ//RGLMM3FroFMnJgxeGG3kU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xfd+Paz5Ev/jiyZrJ6FfBeFxVhEUzsARCbnRT+Smtg2Nayj1f+J/X08HmpDjFTTDG/RduolP+6gUQHQCZvgnGAT5JFmsyfWca0Neo+l9CVQcipp8MZnytVAkNBss27ZMpHN5Vxksvhrwr9iN/Txnru9pBkhoVs5Id5XfNasRwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqUct4S1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqUct4S1"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a8985fe4e6so729386e87.0
        for <linux-serial@vger.kernel.org>; Thu, 14 May 2026 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769483; x=1779374283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cs4yqTv2hqMjvDUgaOCK+Wz9d4rTDlvDlNK2Zth6ZoA=;
        b=GqUct4S1XOzhDhPEe5ySf3bE4hKJBg7K+e2jVUEd9rGrW/QBvMlL84bq9HwwM43+rw
         SQXci+chk1lIz6Mpkb5gI4/Cal6FsAJX+uQkpeWYndwv9X43rKpRInhcD6rzJiEzLKnA
         X2Jn9EQjIyCgnjAq2zeAUOrSUmlM5eg8B3NdlzqVFB7xjGIxIiBZhmSipDIc3OH/8JXh
         1WIn4jbssv10mWD+0Z6KMr1mv2b6e+XzqA4gC3BaY1gStlFfZPU0usYk67mfM12vdcW9
         1haUT0LJ5UX+SgJCy2xjO4yi9MNEb/NWIe4uEm4ROsAEnBqVxqibaw2U/8EW7K8fWffI
         gO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769483; x=1779374283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs4yqTv2hqMjvDUgaOCK+Wz9d4rTDlvDlNK2Zth6ZoA=;
        b=W3FoA6tijYSyyHAT4WO2UwSAo7B7dQhSdaw8eZ2uJrQaLY3jRbZgY64DPIIu7dibv2
         c8FXlpKvgLC7syOFhzT+Ym6xdlYRWdqZ14Cys/BBRlTWyjqi65uGT9mEzLUb/H3Ua0KN
         Yu3H2gXjESlkRGl8uQY5pky0toj9JIArOMGJnCZ1xaKjioo8Wcw08xKX37Wqh/McZxW3
         9PoGBDoNqZ+5ZfkqGK9GbXDm0v+Z2BJg4Cj252uvZSgsjed0Gnv1yqEv+Hcg+C2OoGCn
         3Ixn4YWPqmbYqua3DGhWm1iS9dFqGp6Fb8rwwrD4ykD+Jion6ZE7bJI5J1TAed5KH1wn
         fslw==
X-Forwarded-Encrypted: i=1; AFNElJ8VxeJPWSay25mIaM++q0JkrIT7gkdqOro7XPtJ3g4/utHTCUj0FzfaBx17Bxr2YrUzVxBbR0+IeEcenxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCp6AUyo7BCeSntmRv+Cw5mS3kzXeH+HO30FiIApZr1/P9IOmP
	1qNFYY/osZQ9Ze8BS3DIOqLHmWhd/6O2PDNKHAw+zvVlhCIj1mvV359m
X-Gm-Gg: Acq92OGW2s481PFc6oGnFrLLMGb7R8O4NcrLzAkRFDy9kx/pKRGw/W0QZefCmEgJWV5
	yyCpHYU6MUty7zcQOb0CxNugEJajRnKNNVlAbaQkFpHmNF/nKEami2e4GTXkOS2pT3Ss4AGdb4K
	dZH/dEmCwnr4pyXPkaUBsflRojDL2y5YVaZylYCmBu2rzuIZImWK/ep51kz3y0Vu6eFmcGOOfLH
	lhOnKdFJgbQiOuwOFwgUDHM1QTLAQam7aNArZfkDhnRcZlEkqvJbqzKvZWRp2tDj62LkN8UyjuE
	XVWhFFA75k+hps0/5Pz37pdvRh/EUnJldFbsAF3jiSQ+32HRFetvy4cBYEBzlz79A38jzlZwnWR
	v6/E0jVgyZozFmxk4HrA2HZtgj8cPzGaF/Eb7veEvlI8K11DC/Dw80tCZ/+ke1jkifng4luxx+a
	vqB8LKm24fSuUgCTuhf3Vw2KqbgmOHM55KfUkyWY6ZJA+Ij0c/N1eV9wBVZg==
X-Received: by 2002:a05:6512:33c9:b0:5a1:30ec:427c with SMTP id 2adb3069b0e04-5a8ef9b3cbfmr944428e87.6.1778769482482;
        Thu, 14 May 2026 07:38:02 -0700 (PDT)
Received: from localhost.localdomain ([144.124.192.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c578sm518716e87.12.2026.05.14.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:38:02 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH 0/2] serial: 8250_dw: clock-notifier cleanup
Date: Thu, 14 May 2026 19:37:44 +0500
Message-Id: <20260514143746.23671-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two-patch series addressing Andy's review of the leak-fix on v1.

Patch 1 keeps the same single-line leak fix as v1, but with:
- the correct "serial: 8250_dw:" prefix (underscore),
- a Fixes: tag pointing at the original clk_notifier introduction,
- Cc: stable@ so the fix gets picked up by stable branches that
  still carry the notifier code.

Patch 2 drops the clock-notifier infrastructure entirely from
mainline, as suggested by Andy. The notifier was introduced for the
Baikal-T1 SoC (shared baudclk between UART ports) and has no other
in-tree user; Baikal-T1 support has been removed from the kernel.

If a future platform needs the cross-device baudclk-rate notification
pattern again, it can be reintroduced in a more general form.

Stepan Ionichev (2):
  serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
  serial: 8250_dw: remove clock-notifier infrastructure

 drivers/tty/serial/8250/8250_dw.c | 79 -------------------------------
 1 file changed, 79 deletions(-)

-- 
2.43.0


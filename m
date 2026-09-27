Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F012384CEE
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790517611; cv=none; b=KZGGGU4Ax+ZELdmaC0PvULtenJpdti/166ldbBztKsbhrIm/ukxN4YggFew3b9QXgjUsBpEBmCBrN8vF1pJ0866Wg0C5bHERzs9hYXHGBJljM76SuNcaJTKWjH2Zci2fA0lObJmIn9y+UQPv+9YB2j192aDlF5+Ea5JAjxqMejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790517611; c=relaxed/simple;
	bh=zXU+tYHOl/YHGHGbII3AHvP4lVS+bS8CAqVO6nFSJhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aV34tbgayMbElYpoPY7ctS7h4Fp4NI0rTcBfWGHVaRUe4bM/kSKIfoZ/kDuKPIhJlN5FfzC2QXuZdqSB0rlL2LzfkLCUWeeP+N+RC1XqPiWyIZEYHWTwHJ37gWbneyUZLbXLmeYZCAAFdr499Hi6UuZ8qn1b+zjwu49h7iIC9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apYkh3iN; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apYkh3iN"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-805cc8b4231so1649767a34.2
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790517608; x=1791122408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zXU+tYHOl/YHGHGbII3AHvP4lVS+bS8CAqVO6nFSJhA=;
        b=apYkh3iN+/RIGSioMpWjLsBsH+OZ5/iuJ2zz0uOGhjw/6ZYa1VExZTIkJ1WXFGTaWm
         xT8PdBQt6UuYT/XI6OUKY1fsxaX1E2RyKzCwDRCKRPuaJ4iete97p4UEbROKDjwa976X
         Pk8bagEd3Md6KYr0gDgIGHehGTzdoPL4vCpkTCup0YcZrXb/yPkz2zoJgKq9TVu53x6T
         cXdbPRRxCXDsh9F8P0NBSCmN1GtIGhp4JPOr0+Jw6TlsHT+2hgDZj7tLYwHJI88/v25x
         P2sfCR33IOiqSc5wI7o32TDyoywIqq6juM8EdgeY3jiyv3oUdV5RpinOjWquCUQgHcya
         Hdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790517608; x=1791122408;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zXU+tYHOl/YHGHGbII3AHvP4lVS+bS8CAqVO6nFSJhA=;
        b=GvuFtx6y2U9EzIHKlWYVU+Rfs4GtwyohCga+bFhUaSYUEPPP7gK2WZx6O62mzRG+MY
         qvU7Yk8SVmJu1WSKFAVLXzFMrYmdff0AjWNm3dSsY49LQqv4mpsjL0NYlrIVKK+HZkLi
         V1i6pt4w/Tu7EITlMdqirU2G6XhSHLkv7GOStWOBvgTZRizb997lDmkJOZV/5p7U6nKr
         8wfK921bf7QSAtUgA+KLCDB2KSk3JGo+2u4B9c6RCmxWJNiu5j5UHoKxz+f00HONw24U
         rGlfHrKpgegIp6mmO77u1guDOLDusaWh45F6iPU6THN2FSyq1nHEMT07xzLX4lgO9upl
         /T8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxEvIwcb26sBuMIyTc9tBswnkSMGWiTRS5eng+p7yMovU9Ugf792JKXvFNLCN3lCy6/D+uiWx5DojX6nQc=@vger.kernel.org
X-Gm-Message-State: AFuF++lxXuYNrJOz32BFUJw+Y9NSM55mQ/DkNbJihIT+eRdj+E87Yah4
	Anld5n+k4Np/c1zYhifY8CW+6soAf5wzumqP2IUYRrGl0pGVkK8n27DQ
X-Gm-Gg: AYBFou0X9Eb9bN71UJjYJETdwIgVjJqIOSgOo+UKOMJq/uA7GQylTnFcE11vGX5OnjH
	OOzn6Vcps1m2y0wYe2CZRWve72/TKzPNobk1OXwtbuMj6Pwimj/0cGSTiiuYpJkeIdtE589lgaS
	oQ4otmdBVUycbtlcjGIjWyi87OPeQa0Kwo4756xO29E99BuSD3iyCPStBsGsSc4Iof1haGXm+Ti
	/cTAmUzAhIuTlk7WLh40Zi9S14JksbZhp1TXHiwJzsoNrCXswDB+zsqZkqRTAnzOGqhmgb+SBSs
	Djzr2QSE9c9cPA4sacfjWyL2tW0053+ZTmGrXL7a9vTwbg04u4i24oYWL3WKcegdZrRYr0EeAWG
	zhq5Gxku2tsoVGlDuN1gYwXUygrs6T8j+KK4PwE+WFM3esWSSCj0EQH6LS/orom2evQBq+SbK0r
	c9IHvC2bXDAALv0GFW+oM2hT8QwpDImFT74KNLfzxxcUBo1j4d2y8zchAITBp5WbwCk3AL7d/Zk
	gW3TFauQE8ZQ1wqVydXLS9dlijKzH0OgnHiKkVc
X-Received: by 2002:a05:6820:1f05:b0:6bd:850:7634 with SMTP id 006d021491bc7-6d43f89b4e9mr11060817eaf.26.1790517608344;
        Sun, 27 Sep 2026 07:00:08 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d882dc49dbsm2210058eaf.9.2026.09.27.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:00:06 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: u.kleine-koenig@baylibre.com
Cc: Danish Khateeb <danishkhateeb03@gmail.com>,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Fix section mismatch with CONFIG_MODULES=n
Date: Sun, 27 Sep 2026 09:00:05 -0500
Message-ID: <20260927140005.28291-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <argClwhgQyMkeq29@monoceros>
References: <20260926163506.487201-1-danishkhateeb03@gmail.com> <argClwhgQyMkeq29@monoceros>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Uwe,

On Sat, Sep 26, 2026 at 07:40:03PM +0200, Uwe Kleine-König wrote:
> Isn't that a false positive because with CONFIG_MODULES=n .exit is
> discarded and so the section mismatch doesn't matter?

Yes, it's harmless at runtime, but modpost still warns on every
CONFIG_MODULES=n build with SERIAL_8250_PNP (e.g. kunit.py --alltests),
and the build fails with CONFIG_SECTION_MISMATCH_WARN_ONLY=n.

> I thought __init_or_module was the right annotation ...

It is, modpost just doesn't know that. Without it the two helpers stay in
memory after boot, 16 bytes each on x86_64. The alternative is teaching
modpost to skip exit -> init references in vmlinux when CONFIG_MODULES=n.

Thanks
Danish

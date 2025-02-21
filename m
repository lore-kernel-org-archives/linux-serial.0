Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775B1EB1B9;
	Fri, 21 Feb 2025 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141876; cv=none; b=nexYf6BdHTsJrZZ7N6hwUS8hmDUZRZVJuPeMVxKtfgCnGNDKatQGJev0iKmohJSHgTrQtFF0BXaaxZbTbQ5X2lZ5H40XCIGP+vfIktAlNwMaBwJubDmKkm08z/KU9jc/4/vcFFHjqmvRicM7GIqasDY5AEz0ir78F27gVXKC+AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141876; c=relaxed/simple;
	bh=a6sUn0scJ6tDPZKaf6Vw3R5XFCRTJ0WOPh+DEvqiTiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKGyYMfJnLbbxWP6ssCfR5o1GDNXTv03XFcuelTNWi+31s2AtBKv4Dzhx35ArLSPUbPj0rdhweFETSX0eIPGAKXE3zl+W+ZzalIHMmO12+EuQ7ZPG7oxJR0iUmPdpFGKBTlOeKhplhQ6U/V0XfmmtWUjJ4ScYX0upoGl/27IU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p029j7ox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p029j7ox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01E0C4CED6;
	Fri, 21 Feb 2025 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740141874;
	bh=a6sUn0scJ6tDPZKaf6Vw3R5XFCRTJ0WOPh+DEvqiTiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p029j7oxm/V0Ncx1LvJRn74Tyfm/mxcfrgVVhdFk44GqDvW5CzvHNpyE9AQYxQBSa
	 faCe3tYupA61RKXQK/6j6yt3JaO8duXVlCII9k0oQcWzBZcYY9uCt2Rd3rr911exmT
	 w7/1WcNE4GmuvX+jmbyka0Wne10DyG/mb0eR0QRi52ybEaWx3qBPs7IsKP3UAardUT
	 FBAfiNCg/Hli2omm8MQ4dFqMp31GL+xEYchE6oSrAk6PcdugGndEAR2nzN18Cr/gwH
	 /G/U8x7zgBnbppngmtVrU0hShc2Efbpu8kXZ9xXioWQV3ChOeO34xj4qrizUelvt8h
	 t+SPBWTkFJGWQ==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 0/2] tty/vt: Cleanups for keyboard driver
Date: Fri, 21 Feb 2025 13:43:51 +0100
Message-ID: <cover.1740141518.git.legion@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739881707.git.legion@kernel.org>
References: <cover.1739881707.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a few minor cleanups I found in keybord driver. There's nothing
important here and these changes just slightly improve readability.

---
v2:
* Removed the faulty use of KVAL for npadch_value.

Alexey Gladkov (2):
  tty/vt: Use KVAL instead of use bit operation
  tty/vt: Gather the code that outputs char with utf8 in mind

 drivers/tty/vt/keyboard.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

-- 
2.48.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B802701D7;
	Fri, 25 Apr 2025 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588932; cv=none; b=L96nTJ7JkG0oebFjd/D7Pb/2UTQyWXE7Pw2gjuVcVJjqw8u+7l56x2Z76Kx2K341UuahZcuqrv1LAoo6fTQ5157tVg9eUlCWVZUvtT3x+dUwBRzq9tyGP/Uq5fm4XOLTEJSrpie+MwFnRRcCoPmvddo97tXQDHeaJs7Ro9wEQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588932; c=relaxed/simple;
	bh=kujicpzvoRSlHugDHwA7J9T6+AQK4/ZzRqtqpaG29ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gXHxvUvAodRwzT16WN1dEZHLhIRiDhFq84f6tk6lSdAJQoU0TtNp/EGBEzPH3GiHyKdzVhlufMCvH9I75BHgoS5+nMGZ45yKoaQcuJyzAU2RqpDZXa9o1lB33BMGFdGmuSWC76t3a5kuMDpfX2ZxNggUoXThViete2e6Jp6LZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FEWr2hC6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FEWr2hC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAADC4CEE4;
	Fri, 25 Apr 2025 13:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745588932;
	bh=kujicpzvoRSlHugDHwA7J9T6+AQK4/ZzRqtqpaG29ZQ=;
	h=Date:From:To:Cc:Subject:From;
	b=FEWr2hC6zC2vVuWZn2zX//Ng2rfywtqiv2VKwdRJ3bmjn5uZ1kBy81w5t4Wo9B9We
	 cPr9zd0wK6LyqEvxy+yprkI/XZamjJVwpGybXW/O6LhxXGqGa42Byphvt49iS0svzk
	 84STMuqQ0pxm1ehu82gdLKLBHAtIlgI74flU5wlA=
Date: Fri, 25 Apr 2025 15:48:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fixes for 6.15-rc4
Message-ID: <aAuSwdh2viW2ohGH@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.15-rc4

for you to fetch changes up to e1ca3ff28ab1e2c1e70713ef3fa7943c725742c3:

  serial: sifive: lock port in startup()/shutdown() callbacks (2025-04-15 15:02:39 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 6.15-rc4

Here are 3 small tty/serial driver fixes for 6.15-rc4 to resolve some
reported issues.  They include:
  - permissions change for TIOCL_SELMOUSEREPORT to resolve a relaxing of
    permissions that showed up 6.14 that wasn't _quite_ right.
  - sifive serial driver fix
  - msm serial driver fix

All of these have been in linux-next for over a week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Günther Noack (1):
      tty: Require CAP_SYS_ADMIN for all usages of TIOCL_SELMOUSEREPORT

Ryo Takakura (1):
      serial: sifive: lock port in startup()/shutdown() callbacks

Stephan Gerhold (1):
      serial: msm: Configure correct working mode before starting earlycon

 drivers/tty/serial/msm_serial.c | 6 ++++++
 drivers/tty/serial/sifive.c     | 6 ++++++
 drivers/tty/vt/selection.c      | 5 ++---
 3 files changed, 14 insertions(+), 3 deletions(-)

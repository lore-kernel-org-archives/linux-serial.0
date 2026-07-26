Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046419E992;
	Sun, 26 Jul 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070900; cv=none; b=QKGWOlfqbmSrCCUOjba7y93EAiHsYABUvkHHcdhD7nrRKLhM2eUJhgcqAEwgukmm5ayKNJWCl/lpkeXbkS3E9HTIkAV6lZAtdIhYSgmGSc3+4TLZyGp9NX6fgEpIAGqxiFArizSpk5XV/gDeqQCULyrgyV5MTc5nVeCMFkj9WqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070900; c=relaxed/simple;
	bh=8ep0DTgv4e/I/IsMALUNVb4iWUi2PCKnByIYINhu3Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nC5iMx5OLNtMhN5DBOwEXJV1L9UwsNBE/Dz+UNqhLF/EmHFTfEF5+oEpafQE/QsLkWJ7m19W8BL0EVELgud6eWfEeMujKKRSnztMyPL228+7KQoekwpa9Uq3SKLxQjlMDfTfPG++dH8bNn/FRoEmnPk5PPjA1LcvDCaSwDQ7KOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pVseHvQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pVseHvQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB84C1F000E9;
	Sun, 26 Jul 2026 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785070899;
	bh=d6gXeRbAemdT7G4x+JGMjfFkDJfvAFtUJumr6iHkgVo=;
	h=Date:From:To:Cc:Subject;
	b=pVseHvQDf/GWBiOVi4RrjRIN0QGBZLkvABZxBA6kwRUOwNdo/HNusAmxAJfbLGLjy
	 htchw9L61CnVJQ4Yr7H+6cT2ffVjb+ljPUmcAFdkybMYj8u0a4XTQ8RVdR2nDLOnT4
	 k23c9nttY4ETLycugOAUUaamhrc3iNawtpQCwLRk=
Date: Sun, 26 Jul 2026 15:01:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 7.2-rc5
Message-ID: <amYFJ1HX82HOiPjx@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.2-rc5

for you to fetch changes up to af071d9e07e57cfff239e8d09d2f3b05ebc9c667:

  serial: sc16is7xx: implement gpio get_direction() callback (2026-07-17 13:07:32 +0200)

----------------------------------------------------------------
Serial driver fixes for 7.2-rc5

Here are two small serial driver fixes for 7.2-rc5.  They are:
  - sc16is7xx get_direction() callback fix, which resolves a
    user-triggerable warning in the driver
  - NULL pointer dereference on some platforms using the 8250_mid serial
    driver

Both have been in linux-next for over a week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Hugo Villeneuve (1):
      serial: sc16is7xx: implement gpio get_direction() callback

Jiangshan Yi (1):
      serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms

 drivers/tty/serial/8250/8250_mid.c | 14 +++++++++-----
 drivers/tty/serial/sc16is7xx.c     | 12 ++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

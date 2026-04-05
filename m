Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642C34B183;
	Sun,  5 Apr 2026 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775377890; cv=none; b=W8uswJRQWtHaAYOd+NxtZZAXg/DzhCZfDb/JgDu1zF7XexT9vOVfWTORFhqz7ywCOa1cZmLCOblx4lFyU9XSkCIZJ9znHTwmFUjK/8HNptU/LP6z4Ut/O343q2/AJZLoT9k755b7pH8EmAwfIysxoE2MNhWdGHT+dtBHdZaKiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775377890; c=relaxed/simple;
	bh=JIcsC0AqlwBt49c+viBKOyjvMUGantIwNDbjFI0PulY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gf9OQ172w5udULj7oa/s616QSXA8oQjwc3qbZaMPw04rEBi0kj2QWOBw3U3GQLARf3o78IaQ6WJhyS8oX/Vo5Ld33dvQVM+MNDH2ge8hEA5YSgWBj2h889XnVTExBUgXM88Fnpf6QUkPfHDqOJnx962X0P+Z1ikh7U1sLIvSQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zy6+XHYZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zy6+XHYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8722C116C6;
	Sun,  5 Apr 2026 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775377890;
	bh=JIcsC0AqlwBt49c+viBKOyjvMUGantIwNDbjFI0PulY=;
	h=Date:From:To:Cc:Subject:From;
	b=Zy6+XHYZupC/KJE5YfTv9oc1f0WRkWjC1PNXIkhyXIS+kSzTff2UCXnZR4hsMKI79
	 6shwixj4WnLsbF4K+3xFBbhpFHTFx4vW7fyg2wxK3crE4rsqBXr14xo7nz/MIoIVlB
	 9pBUE/3WvLJpioxEB+OaUEOOYzWNAhtkB9dlRKZY=
Date: Sun, 5 Apr 2026 10:31:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY driver fixes for 7.0-rc7
Message-ID: <adId31g54PFsRJ_s@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.0-rc7

for you to fetch changes up to 3ddbea7542ae529c1a88ef9a8b1ce169126211f6:

  vt: resize saved unicode buffer on alt screen exit after resize (2026-03-30 17:39:44 +0200)

----------------------------------------------------------------
TTY core fixes for 7.0-rc7

Here are 2 small tty vt fixes for 7.0-rc7 to resolve some reported
issues with the resize ability of the alt screen buffer.  Both of these
have been in linux-next all week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Liav Mordouch (1):
      vt: discard stale unicode buffer on alt screen exit after resize

Nicolas Pitre (1):
      vt: resize saved unicode buffer on alt screen exit after resize

 drivers/tty/vt/vt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

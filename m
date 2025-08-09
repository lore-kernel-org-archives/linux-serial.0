Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311758F6E;
	Sat,  9 Aug 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754750935; cv=none; b=N70r/vj3WWVQH1qwgL01OqKX8Qb0qcNZVQi7kPXiT41nIhZkfG+f9tOe124sgzbJWCekxFr73GoKQakNqqSKngw4wJa7hIs7z4vFn+8IbBVwDH4s7wUYrGmQFw71DnV3iCP+58ZQTZr1vX05aGOcIaCfMQ1/wTY3DvWhRWlZQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754750935; c=relaxed/simple;
	bh=M1gFEMf8+38S/oUkGKCMKE38PwWCqvuXqGZWlaW/cK4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jvnatdIEkMFazTbv7MIEnUVOeNftSJrdTglrjO3LNtB+XgYtJjm1vsHZQw3MElME6jcJgtRxMN2pAOLdaHhSUPXmEG8S3nygCnttKMbjzoF9vo2YMr2DAYsWc0AakzS9hXRCWhHQx9YmrdDFstT7V8AKyCP0tixshhMyEzxk4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oSxwYQY/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oSxwYQY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F130C4CEE7;
	Sat,  9 Aug 2025 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754750934;
	bh=M1gFEMf8+38S/oUkGKCMKE38PwWCqvuXqGZWlaW/cK4=;
	h=Date:From:To:Cc:Subject:From;
	b=oSxwYQY/y3GIAG/g5hniedXhVqsNd7gyJRvtwyDD3oq2qjG5+zah//jem2eH+KX0H
	 M7pC4ESlhRqf179HpZDPSkiWWoOCN8MfdA32SIxlcqRG1HSY4U9Eqr/iUKHRCrq8KY
	 +cxccCj8Id7ojFLFrWiapxbdTb9ncAzoXiYIoFaw=
Date: Sat, 9 Aug 2025 16:48:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver fix for 6.17-rc1
Message-ID: <aJdf0rAZ5x5klUhX@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 89748acdf226fd1a8775ff6fa2703f8412b286c8:

  Merge tag 'drm-next-2025-08-01' of https://gitlab.freedesktop.org/drm/kernel (2025-07-31 21:47:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc1-2

for you to fetch changes up to 55a984928bfa30c7877e28f16910e6de1c170f1f:

  Revert "tty: vt: use _IO() to define ioctl numbers" (2025-08-01 10:42:22 +0200)

----------------------------------------------------------------
TTY revert fix for 6.16-rc1

Here is a single revert of one of the previous patches that went in the
last tty/serial merge that is breaking userspace on some platforms
(specifically powerpc, probably a few others.)  It accidentially changed
the ioctl values of some tty ioctls, which breaks xorg.

The revert has been in linux-next all this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jiri Slaby (SUSE) (1):
      Revert "tty: vt: use _IO() to define ioctl numbers"

 include/uapi/linux/vt.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

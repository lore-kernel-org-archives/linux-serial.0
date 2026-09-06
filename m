Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240435CB6E;
	Sun,  6 Sep 2026 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788687563; cv=none; b=k2UqSkq5WuUbeWHWWjr53dHQVkusqcBtfF43BQFZg4145P0NyGBHcpFlfS1odPkX/NwKeUVZguvEev0OIMS3WqNU1PBeTz6Qb5lvKUTNpppHiqdPJQxQeZTIYL0Hjwx8HpsaREBEKIR+k6545j3kFf2Wa6YvonZ7TXud5fYHS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788687563; c=relaxed/simple;
	bh=sW7qcHQ8oEr7WJbnUKR6tDgXqbJfhQunuajmspbzicY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VP3Cuq0X6OllB4ZGVpAF3OF8TYItyvlGj4Ev2jMKZr5uyAhKL7J41JNP/yblripxhvHidcGGdNZTjXlHhtNQPO1UDXdwKT/Vr0qF2nvlSoeXTDqDq7MNg5LYbYlEaq7t+/WG9DcyTgWKjcvLvlrklqRIyiIlBzGpkj2g1cLmlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ymVB7EZ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ymVB7EZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12AD1F00A3A;
	Sun,  6 Sep 2026 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788687561;
	bh=04o8bsrmhveeOkO8JrfzXrhYZVIXuRINZLJmt9QYR0Q=;
	h=Date:From:To:Cc:Subject;
	b=ymVB7EZ0d3U9cabOrS4R/pNh8sNDCEd9kXO/m7RryOcYzMLD0L0u3lXkN+j/0p6EJ
	 4IqCx0W035Ox2CLU5IGWTWhBJno3YWMCpYhjZPnEaBTY5gntYupr+fIouBH+UfVIQA
	 SHfVFjTP0Zg76QVeJcMrg0junyqoP91V+FvPrQMY=
Date: Sun, 6 Sep 2026 11:37:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] virtio driver fix for 7.3-rc2
Message-ID: <ap00YPFzE_T6B5Dh@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.3-rc2

for you to fetch changes up to b144dc5a24149ba9a0cb2197001973a74b8c93b2:

  virtio_console: allocate the port_buffer with the caller's gfp (2026-09-05 19:28:39 +0200)

----------------------------------------------------------------
virtio console fix for 7.3-rc2

Here is a single virtio console fix for 7.3-rc2 to fix a much reported
regression in 7.3-rc1, sorry about that.  It's not been in linux-next,
but it has been sent by many different developers to resolve the issue
and is "obviously" correct.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Breno Leitao (1):
      virtio_console: allocate the port_buffer with the caller's gfp

 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

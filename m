Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82212E55;
	Sat,  1 Jun 2024 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717222594; cv=none; b=uYAqeHFnYEegkO16rZaCxJTh3bMhmLzml0VcfucNgxKMMBaJ82ffLp55BztZsq6H6TOEj/zq280yF+/Gr5Ptmvj7lvMThVEt5xN4oaLk/HgFlYm3sHRTPK1BIXrjhAi1eQmQdb0g0l7Wcpb99+M0zqdXU75VOv3m1Rl+fVj/I98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717222594; c=relaxed/simple;
	bh=vVcP5jiWCp7KZP6g68w/ZgwT3HccqxwQFBIOQ3HSitI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sfOBv2iNluVOXE6Lj9st+ZBIRj3zOb+mt20+DcxWAI/LP5+KB8uLAdAprRw4fCOBMZw6XR7q1FZOOvV1+A8PYyLuYvldiYiaRWpPojEt65QSJr4MDhZ+5GCcKdy7N2wKa+h6MITJW4Wpz/i/E+z+EyCKlaVaIo0VwK49eawoV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uj9n1MM9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uj9n1MM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B98BC116B1;
	Sat,  1 Jun 2024 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717222593;
	bh=vVcP5jiWCp7KZP6g68w/ZgwT3HccqxwQFBIOQ3HSitI=;
	h=Date:From:To:Cc:Subject:From;
	b=Uj9n1MM9SjKAUqhDooL+gGVzHQidX66s6i7GM0Md2OQLt8DxRVIbQzHMbnbgp7uL9
	 EFd53eso1I4QOkGb2xn+Z5yfthlMc20JXW4U0pGrvvP73qkjTHeSIv/IGCHgAs56eR
	 np42k15gZxcqaEiLHHKA8+fScCcgBXJJKTiU0zUw=
Date: Sat, 1 Jun 2024 08:16:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY driver fix for 6.10-rc2
Message-ID: <Zlq8yMiUBTOisuWp@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.10-rc2

for you to fetch changes up to 7bc4244c882a7d7d79f4afefc50893244eb11d07:

  Revert "VT: Use macros to define ioctls" (2024-06-01 07:28:21 +0200)

----------------------------------------------------------------
TTY fix for 6.10-rc2

Here is a single revert for a much-reported regression in 6.10-rc1 when
it comes to a few older architectures.  Turns out that the VT ioctls
don't work the same across all cpu types because of some old
compatibility requrements for stuff like alpha and powerpc.  So revert
the change that attempted to have them use the _IO() macros and go back
to the known-working values instead.

This has NOT been in linux-next but has had many reports that it fixes
the issue with 6.10-rc1.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Revert "VT: Use macros to define ioctls"

 include/uapi/linux/kd.h | 96 ++++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 49 deletions(-)

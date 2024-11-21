Received: from m204-245.eu.mailgun.net (m204-245.eu.mailgun.net [161.38.204.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FAA14BF87
	for <linux-serial@vger.kernel.org>; Thu, 21 Nov 2024 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187876; cv=none; b=kQeUBQcKY3QnkGq9i7Dg4+/b2haYk9ilTe9EQCUxBCgfzeMHarxcndBdEUtsWkqQsXjsfub7pVIjmXu1heWnCmgz9OmDAoG0SWvmXvkmnOQePN+sdr14xQB7UhPkwCcq6sIrA02FxWsWi7h1QdwMsO+MDqsW6DEdTPYjkq6z0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187876; c=relaxed/simple;
	bh=lskpCqARPZ66IGsZu+9xuo/vvvshx0hu6hKhAuvzgo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JD/C7zC+LocHUNcQErhlJybNGU8rSstMe2YQiqmTYMd1cgXoB74ZPGeLZB5oYnPIy8Sq6/Lj1GAGVplG20drF8gE83nb+ptu4vOkzrODL9+QzaGUJHRCZpW/KWNa0Bemp/Wa98oEW2kdaeNbaNx2D9Wz5GtG3CuVc3E20RTO8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gpost.dk; spf=pass smtp.mailfrom=gpost.dk; dkim=pass (1024-bit key) header.d=gpost.dk header.i=@gpost.dk header.b=utp0Fhkh; arc=none smtp.client-ip=161.38.204.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gpost.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpost.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gpost.dk header.i=@gpost.dk header.b="utp0Fhkh"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=gpost.dk; q=dns/txt; s=mta; t=1732187872; x=1732195072;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=oTgoFAGcGKxQkLCwpsqFWVJVat/rKItNxvq2AQgkwGA=;
 b=utp0FhkhtTjdWzorxDSCmMsLvlq7M1dQ3nRqmT2839maTh35xls7mftEfPVVFb8BzKu4oGLuqT+pXDltZiHATOFsvuvh1p/ZBqyWdYyDSt6AFa+pd+knEcWAZtDw0nWhUFmzlDXUftZQfJ2oSYIEGq6Tkf2PD9jAMW+KB0twJ5c=
X-Mailgun-Sending-Ip: 161.38.204.245
X-Mailgun-Sending-Ip-Pool-Name: 
X-Mailgun-Sending-Ip-Pool: 
X-Mailgun-Sid: WyI1MmE4ZSIsImxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmciLCJmODkzZCJd
Received: from qubit.home (11.85.120.188.andels.net [188.120.85.11]) by afe10bebdc9e
 with SMTP id 673f16e05111dcf9bdc000f7; Thu, 21 Nov 2024 11:17:52 GMT
Sender: gpdev@gpost.dk
From: Gil Pedersen <gpdev@gpost.dk>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Gil Pedersen <gpdev@gpost.dk>
Subject: [PATCH 0/1] Fix to allow more correct isatty()
Date: Thu, 21 Nov 2024 12:12:53 +0100
Message-ID: <20241121111506.4717-1-gpdev@gpost.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch comes from an issue discovered in systemd, where it can fail to
restore a text TTY session after a GUI session is stopped when compiled
with musl libc.

The specific systemd integration issue is currently resolved in the musl
master branch by closer aligning the implementation with glibc, but the
underlying isatty() implementation is still flawed since it can return 0
(false) for something that is definitely a TTY. Essentially both musl
and glibc give up correctly handling this case on Linux due to
inadequate/buggy kernel APIs.

Thus I am proposing this patch as a solution to fix the kernel APIs. An
alternative fix could be to add a new IOCTL to specifically handle this,
but that seems overkill.

Link: https://github.com/systemd/systemd/pull/34039
Link: https://gitlab.alpinelinux.org/alpine/aports/-/merge_requests/70711
Link: https://www.openwall.com/lists/musl/2024/08/20/2
Link: https://git.musl-libc.org/cgit/musl/commit/src/unistd/isatty.c?id=c94a0c16f08894ce3be6dafb0fe80baa77a6ff2a
Link: https://sourceware.org/bugzilla/show_bug.cgi?id=32103

Gil Pedersen (1):
  tty: respond to TIOCGWINSZ when hung

 drivers/tty/tty_io.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
2.45.2


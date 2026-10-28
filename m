Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193748;
	b=LM5NsPk6ZsoriPXAXQTd/hkkgvV/Fwn3DKxg0WeugT0WzLFFbYdU9hrK8G5nvQssjjYg
	 K7mUpwEGFhwSPdzO0MgeTUGG26pfbr52fiE32o4JNKlLEsp6efWbkmApu7HcpH8GH8lUm
	 zXov0Ih8Phwo73cXZKpeZpMEhMHhQX7ZULBWY8ZPLFdgveXXIXLJFCFh9esMFfv/RxNs1
	 trynjtZa3mzttaQSoCOfELDu7o9A2wxtWO3c+DvZ6mQysOyuKg5FHGtcZcj5VJLm1hy6R
	 6E7j4DH1mPQu+n8cuUveMiPptg8dWFS4YITTP0CWSNf13mjwB46pnW2kt2H6+wTTA8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193748;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UAl0HEQZXwmaIz1J8l8z7zHm6iuvqiJoeALAbI0gpRQ=;
	b=dZNRmvzPPYG7eCwlu8bQIdtM4xRaIZqU30mHDvkRdi66WEk8UgQEuI2TX8F8yt6A1o9o
	 pUNXbLiowF7eFAXOBpOQj5C47SkoZFb7j8r3VGQtUh+Kn7g9KJ4yqXqhawqsKOE3jZGr/
	 BA+EJi/B1LLUORTSLZ/HX/5ZOIj2XtueJ9fCoSCnAYLx3zEBXf04OYOnuJ37NaokEYy6P
	 gwQHlig5MMRh/pE2llLRAwPKdFBKeFc23v5djOfPQFjDz8xFtrdkHrt1FGBc+4iVGsWXp
	 joyVLwotZiYLN3ikGGXcxKnZkLARov/hc4KAFWfhrQGa+b+lKHODl2xFyXEYtozKu9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuABEHMR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07114606A31C;
	Wed, 28 Oct 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuABEHMR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862551F01825;
	Wed, 28 Oct 2026 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193747;
	bh=UAl0HEQZXwmaIz1J8l8z7zHm6iuvqiJoeALAbI0gpRQ=;
	h=From:To:Cc:Subject:Date;
	b=OuABEHMRKq5cRYV+lLjjOKFkVhtHFMev1nlU6GKMb4K6BnJJDPccJiOQxzlc9bvzG
	 nppde+U1pAFXuFMXctyZP2RzicDccAvdvw2tHZy15vaUnuS+M5lFpSzPhPPs+avwrE
	 E1QQ93XXgv+8ajUMAfS8bslEsj+MIyVHheR9PuqosUWDDoJlr4JXUamX3ak22R8MLw
	 yrEw+c7Ptiyo3hD5TUvHCH8ib8tOrzZ62J/AE/YNhNoYSkvzAzB+z8rwePZc2YVg/9
	 ssVEHc68npeqMd5SOypFX4aHL4w/5GqQPp3l6IKiRJbACmNsiHhjyMNCq29hlA4erC
	 zsjUI6/jtQlXw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xM3bl-000000033X5-2TB6;
	Wed, 28 Oct 2026 14:22:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] tty: n_hdlc: fix hangup handling
Date: Wed, 28 Oct 2026 14:20:46 +0100
Message-ID: <20261028132049.728457-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An LLM incorrectly flagged three hangup issues in n_hdlc as leading to
hangups stuck in uninterruptible sleep.

This used to be the case before commit c96cf923a98d ("tty: Don't block
on IO when ldisc change is pending") which incidentally fixed the stuck
hangup issues by turning tty_io_nonblock() into an indirect hangup
check.

Since then read() and write() can return -EAGAIN also for files opened
in blocking mode on ldisc changes, which looks questionable. This change
was added to address a regression introduced by a series adding missing
locking to tty_reopen() but should probably be reconsidered. [1]

This series addresses the underlying hangup issues and incorrect -EAGAIN
on hangup meanwhile.

Johan


[1] https://lore.kernel.org/all/alpine.LRH.2.02.1809191330590.19146@file01.intranet.prod.int.rdu2.redhat.com/


Johan Hovold (3):
  tty: n_hdlc: fix missing write() hangup check
  tty: n_hdlc: fix read() hangup race
  tty: n_hdlc: fix read() hangup check

 drivers/tty/n_hdlc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.55.0


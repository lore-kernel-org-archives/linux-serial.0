Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738A134406
	for <linux-serial@vger.kernel.org>; Tue, 16 Apr 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292157; cv=none; b=P3oT/k9ApzvLhzvs1u/RiQ92+sEMzqS2yiPCIMNp7W5myqGF+uHlEAFmtOJzQF+v+OG/v+uTqOQJCJaaMhf0GPw6VO05OcnGoySu7GQkFHuHFb2lKbB5brVsNe1pvDfWX4NDYgV9Fqj+5ZIC5la2+mMa3zKlYImM+bSbR9INiCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292157; c=relaxed/simple;
	bh=v+czfn0IfSapZZ8pqxRYSfkPUjwNRdVUep4x5Tza0QA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CDBuOkEAE2YpO9PWDBltvQ1TwGx9gY7R0ZXLh47JNy1jM0bUQ0hm1b53qZJEBJL2cHq7SFiJjuTnvpvj7JhSOlDL8MSY6xpHKE3ObrzGT9OQeCLC+oXih2slz4JoYIEGfysRfLXHBv9TKZU/pLiEoZ7ToFXgMOTTugvcmjZAt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=jWGQPi8d; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jWGQPi8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1713292152; x=1713551352;
	bh=hzNvp2rdWqKMsdmDAYXgUDD3rBTlt6eZV6vZgFT9zFo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jWGQPi8dLclrNLoIEExXmBHGzqXEro1BDfTNAP3ZPEHOTUkBl2PBM5PvpbzZxvmsD
	 1KpNudoXV7JBIyzhj8MYhdJERm+Fb+0eSKvrwutZCbA1rkcijQsHfhTLlUUtL71O7U
	 fQkOuh2GTtinjyg8+FDk6kv2cjCKr+0b6TI1Wd3n1B23qM3nM4lbRVxKEbyHDGyUO7
	 HF/bqhFGdri0cmZ9tn9lO8yl03wap3LE/LoYx82cY1XmDZNhHHqDcwiI5oomt5CsEV
	 2G3R55ki5M0QM9rf0uRrv9nwQA9g+FoiKvS/De2kpWabxH04QADMuQmuf/6HlocG6+
	 0el4g6UkKL+ZQ==
Date: Tue, 16 Apr 2024 18:28:41 +0000
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
From: Michael Pratt <mcpratt@pm.me>
Cc: Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>, Michael Pratt <mcpratt@pm.me>
Subject: [PATCH v2 0/3] serial: 8250: Set fifo timeout with uart_fifo_timeout()
Message-ID: <20240416182741.22514-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, Jan 11, 2024 I submitted a single patch solution
for this issue of data overrun because of the default timeout
value which is insufficient for very low baud rates
with the internal fifo device enabled.

Following the advice of Vamshi Gajjela in the v1 thread,
I tried to find a way to limit the amount of math
being done within the write operation, and this is a possibility.

In this series, I'm proposing we bring back the
"timeout" member of struct uart_port, and also that we
add a new member of struct uart_8250_port in order
to store whether the fifo device has been enabled.

This way, in the function wait_for_lsr()
all we need to do is convert the value from jiffies to usecs
in order to have the appropriate timeout value.

I'm hoping to get this in during the RC phase of v6.9
and I'm trying to keep this fix as simple as possible,
or at least I think this is the appropriate time to
bring this issue up again...

Thanks in advance for your time.

--
MCP

Michael Pratt (3):
  serial: core: Store fifo timeout again
  serial: 8250: Store whether fifo device is enabled
  serial: 8250: Set fifo timeout using uart_fifo_timeout()

 drivers/tty/serial/8250/8250_port.c | 7 ++++++-
 drivers/tty/serial/serial_core.c    | 3 +++
 include/linux/serial_8250.h         | 1 +
 include/linux/serial_core.h         | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)


base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
--
2.30.2



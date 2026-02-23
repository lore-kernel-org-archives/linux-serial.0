Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206D37F739
	for <linux-serial@vger.kernel.org>; Mon, 23 Feb 2026 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889389; cv=none; b=TfxbPPSK1fPqQnV3LLNUZlTql5MCyAaNLCvXwulyKcvhPXDKVG8lZCFplzoLmSIRYXEQObyAPoXgK2oOM+30smT4laA2SxtXamm8AKfnfHzW0usWEK38J5JHATqU93VGgXH0Rpt9B5YQykjTGA8CvrpB4aPtwFZzjT/AWB4kYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889389; c=relaxed/simple;
	bh=5X+mHcPY8BYiGhq21zGnYHWzBP+QZdBmGFkyvOnzHZQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bds7sA5PqKJZu3GTyMOQObtoZ8l8Fz9fVuSfmtYyYzOERO7iPkgVjf4lEoJ+G1vz3rmnad+R3kXUfzllfGLoX+epRZOSH3iyH7ijIQ1eitzuH4INqwIUce4WRNKvwewRVHdTtn8zp2q5q0G9bmasi0pCkqdPCd4SYW58EVl9tSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gaga.casa; spf=pass smtp.mailfrom=gaga.casa; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gaga.casa
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaga.casa
Received: from 192-184-189-139.static.sonic.net (192-184-189-139.static.sonic.net [192.184.189.139])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 61NNJ3To029605
	for <linux-serial@vger.kernel.org>; Mon, 23 Feb 2026 15:19:03 -0800
From: Forest <forestix@gaga.casa>
To: linux-serial@vger.kernel.org
Subject: Seeking help diagnosing serial port failure to transmit (while receive works)
Date: Mon, 23 Feb 2026 15:19:03 -0800
Message-ID: <7imppktb51fdnlm8jaovts1tkhr6r1751c@sonic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVZfYk2yRinjJBH80TkuDdbISQHE4My7iVMKF1YQHggXF4QwBXb6qB09NoY4s/iEFEEGB7iDQV69jHOubqrnAsQQ
X-Sonic-ID: C;RHHsCg4R8RGdBLw6laNSag== M;/t8YCw4R8RGdBLw6laNSag==
X-Spam-Flag: No
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd

Hi, folks.

I'm seeing puzzling behavior from a recent AMD motherboard serial port:
It receives data, but doesn't appear to send, and doesn't report any
errors. Does this problem ring a bell for anyone here?

dmesg reports this:
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A

The /proc/tty/driver/serial tx count rises as I type in picocom, but the
terminal at the other end of a null-modem cable (a laptop with a
USB/serial adapter) doesn't see the typed characters. The other
direction of the same connection works just fine.

Things that have not helped:
- Replacing the motherboard's cables and connectors
- Replacing the null modem adapter with a different model
- Replacing the remote USB/serial adapter with a different model
- Switching picocom's flow control between RTS/CTS, xon/xoff, none
- Changing the serial port's IRQ and address in the BIOS
- Changing between 9600 and 115200 bps

I'm approaching my wit's end. Could this be a known problem with the
kernel's serial driver and the B650 chipset (socket AM5), or with recent
AGESA versions?

Thanks for your thoughts.

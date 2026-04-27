Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE12DB7BD;
	Mon, 27 Apr 2026 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275139; cv=none; b=MIjAqhgmsGUCCUZvnT7j7AtQsn6mJx3luJh7jMasq3i1LjpmoHOhurnfAqRjl9Wm8i9vP6zu4MCTDH2iIb3XelQp9XomadutZ6lVSBn79b6KS85GEmKS1OkPWFBDukwh+Cj1CKMiLTODbjWNBPbv83Ax6dHjqYuY8S62puONgig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275139; c=relaxed/simple;
	bh=z6STT3pmp/kQBgHhBzbeymcDt4gyan7Jmn4OwjXUfv8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=jxwHjPhIGIE07UymaSj3bg21z4f0FcGS+xqKlMOvLf8cWbFPNMqSoSe9JaSTbzq7AHnA7oE6hH7hL7dJevk7tuBSqzvvmfQSWsR+Rg1gvc0HpIEPufUhJPUhLsY8cCkplydMZ97yZAN4QgrO5B+y1oYP4NaR7meYFgTQZq6/P5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=N7sMJ2Qg; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="N7sMJ2Qg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=9daiWUd7+mDFWppd/lLOASVmD/eZMAIDQ
	fi0EwUbB8o=; b=N7sMJ2QgL6XBV0wtW5cpZ/1rA44oP2O5kQW3qtOPXgfkfKsSx
	S2URw5PtkEw/GLM8DaBQbdzuEFHvZwM/CHROGElWD9aTstZzMlKAminWXNn9eSVo
	nmjU3P0DqjyRjjvyUt5O34BimApD/WqcOvMhySMbTr0Dd39nW4yVJO+t/8=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEEIcEe9pwwEDAA--.1554S2;
	Mon, 27 Apr 2026 15:32:45 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
From: Jia Wang <wangjia@ultrarisc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Jia Wang <wangjia@ultrarisc.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-serial <linux-serial@vger.kernel.org>, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <aeuJTMqADw8J0x0u@ashevche-desk.local>
References: <20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com>
 <20260424-ultrarisc-serial-v4-2-1765a0b4c4a0@ultrarisc.com>
 <4548483c-cbba-899e-6b1a-1290d36b59cd@linux.intel.com>
 <aetv2ljDOpH_Hs4s@ashevche-desk.local>
 <363a636d-f014-cc29-6be4-ec3041f43855@linux.intel.com>
 <aeuJTMqADw8J0x0u@ashevche-desk.local>
Date: Mon, 27 Apr 2026 15:32:00 +0800
Message-Id: <177727512077.1796253.17951689513534549167.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777275121; l=1960;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=z6STT3pmp/kQBgHhBzbeymcDt4gyan7Jmn4OwjXUfv8=;
 b=Zmk7cQzNqKX2aQZQQyrNt5HXRMNdjrAcbrEgt4ShlWIw9e2VNfgYrlj6XxHuyq4nBzzOfBOmT
 rcay0btFWpBDRxDF7nT33gZad7L1/8UktLaSjW/pLS0coTWS7LZ0xcn
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwDXEEIcEe9pwwEDAA--.1554S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWxtw13GFW8XryDZryDAwb_yoW8Cr1Dpr
	W3Wa4jqFZ7KrnrAr4kt3WFqF4rtFs8JFyDXrn8Xry8AFZF9r1agrW8tFWYkF9rZrn3Aw1U
	Aa1UXa9xu34vvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwAHsm

On 2026-04-24 18:16 +0300, Andy Shevchenko wrote:
> On Fri, Apr 24, 2026 at 05:09:46PM +0300, Ilpo Järvinen wrote:
> > On Fri, 24 Apr 2026, Andy Shevchenko wrote:
> > > On Fri, Apr 24, 2026 at 02:38:56PM +0300, Ilpo Järvinen wrote:
> > > > On Fri, 24 Apr 2026, Jia Wang wrote:
> 
> ...
> 
> > > > Hmm, maybe there should also be macro also for this one which takes the 
> > > > fifosize as input and converts it to CPR field vlaue (effectively, the 
> > > > macro is an inverse of DW_UART_CPR_FIFO_SIZE()). It would be more readable 
> > > > than the literal.
> > > 
> > > But this can be done separately, right?
> > 
> > It's logically part of the cpr_value literal to defines conversion (of 
> > course one could introduce it in own patch without users but I don't see 
> > much benefit from that).
> 
> No objections.
> 
> > > > Also include BUILD_BUG_ON(!IS_ALIGNED(fifosize, 16) + bounds checks) 
> > > > inside that macro to catch invalid fifo sizes (+ don't forget the 
> > > > necessary headers for those two new things).
> > > 
> > > Hmm... Some devices may have FIFO = 8 or 4 bytes (Intel Quark IIRC has less
> > > than 16 and it's DW IP).
> > 
> > Perhaps but according the DW databook I've at hand, there are no values in 
> > FIFO_MODE field for such FIFO sizes. So what would CPR contain in those
> > cases for FIFO_MODE field?
> 
> On real HW it returns 0s for all registers above 0x07 (multiplied by 4 as
> a stride). But I also checked the values of xmit_fifo_size and it shows 16.
> What 8 is it is the DMA max_burst. Hence the proposed assertion should work.
> 

Thanks for the discussion and clarification. I'll add the macro
DW_UART_CPR_FIFO_MODE_FROM_SIZE() in 8250_dwlib.h (in patch 2) with the
suggested build‑time checks (using BUILD_BUG_ON_ZERO for bounds validation),
 and update patch 4 to use it.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

Best Regards,
Jia Wang




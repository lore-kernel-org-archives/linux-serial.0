Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099786;
	b=n9aCpZxBfv/viC+EUfSARBegbJk58Qm7H5xPoWuBYhkaVPMOoJse4MXL2XKRO9nq+3sj
	 56rzdv8oPSyjQhx8NP53ihoZCcN9bQFzHRJS1g7xKguMGQIMkZuYmaFBpTEi2CZ+kZw0a
	 BmGfjwefiB2HlNo5MtF/hEzuXwC0lZHIobEoGOn+1pmD/jkps4ob6XNjSKBhynnrlgWxd
	 vVobA87vIYKR4s2Ana3nO5AiDAWt6U9aUKbpeQWU2KX3UGaSr1Feq+gn3k3WLieofRTbX
	 uKVf2/qdf2W4CUJV/SXvQqQyG1bm1D/yW24GYpoTTTm7ur6lYSTCBlsCMXtwGeY+INg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FOOL6IwXKQCsNcYxBkMJ1eB6Uvf1KNQ+3MG1b5G/VZY=;
	b=br8FHN4Qr4K66DdpNJG6RmkHesm8RJea9+XaJ0953ela6hBTLKu+Bd+YKbp9XPQGS0Xu
	 Xml8BtwzxDoorb8kDnNUT93xGN8nw48H03B5VTTfddsfvBdYmJVwlKWpiMrPbgrLr+2zr
	 QNhQI84zIEytIVcDTQ6MniSd4RF0NgL/uOS5JwGbb1lbNXJ946ElTtJIkDOb0hjGouaJn
	 YhLOroNOp0sXtwNNBqWKBQbYLcrFy4yftIZtXT+gUVOXcSle5rPk9uGLn+seduPe1D62O
	 gm6oRl51l+v7KCA0giGJbTJ9I1LaN/1VcqWqn7+HKxxCQ7LMqCb8623wSjTeelQf8zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Id8CFgHv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCDB606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Id8CFgHv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABFB1F01825;
	Tue, 27 Oct 2026 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099785;
	bh=FOOL6IwXKQCsNcYxBkMJ1eB6Uvf1KNQ+3MG1b5G/VZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Id8CFgHv3IeQ+lbz868joTBU+gUycUYgAgh9V7hc7x/wb+P/tZIrV/HWmysoqwle9
	 xWWfA61zPzGWTbaWDzs90Y78tTsuUFmQYO10CWVQ982OHql0/+C1Wz8lCoG21r+idE
	 Vdnjt77aBeQHvTX5hBD2BPfrfiFH5RPBNGxhDMJ13WVT2CyFvM0OOcbAGurQeewGTU
	 fc9o/0SeNeLCP6wx2Fv2IL1R/fiVCmJfgvNXhLgxw1Zi8aFP6FMlq/YESK9AmkWMQU
	 NUkr4KhaaE9Z910s9aolzFy4ESbqt2j5QVlJjY2lySmr3pP/846IQcYNoe475f7BOj
	 AUM5KlLKvT2fQ==
Message-ID: <sashiko-outbox-186429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/24] serial: 8250: don't report a wakeup to a closed
 tty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-4-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-4-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:16:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> If its interrupt is a wakeup source, serial8250_handle_irq_locked()
> reports the characters which arrive as a wakeup event of
> tport->tty->dev.  That pointer is only set while the port is open.  The
> port of a console is not shut down by the last close, so its interrupt
> handler goes on running without a tty.  If the system is then woken up
> by a character on the console, the handler dereferences a NULL pointer.
>=20
> Take a reference to the tty, and leave the event out if there is none.
>=20
> Fixes: 0ba9e3a13c6a ("serial: 8250: Add missing wakeup event reporting")
> Cc: stable <stable@kernel.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D4


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D671FA0
	for <linux-serial@vger.kernel.org>; Fri, 24 Nov 2023 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0uut1qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999F6C433C8;
	Fri, 24 Nov 2023 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700831008;
	bh=NUJpLAiq0V9wfKoWZ8yHbnyipzfbdiqAH8EwRQp2WVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0uut1qiG0cJzVA4Rnsu2L8he9uz2OvlpYtrwLjXPucjwC9YGWl1Q7Es+MqJjVqTZ
	 Qn7S83pVEbefFQmEf+dKnjqvbhoAxfUhR3E3TB7hc37phnf/DqRoIEdJhVWAs6Y7gn
	 mrQzVl9zgJPZM8Mg9yMWPQgStbIKTWzj77xwjLgA=
Date: Fri, 24 Nov 2023 13:03:25 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Paul Geurts <paul_geurts@live.nl>, jirislaby@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	linux-imx@nxp.com, u.kleine-koenig@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: imx: fix tx statemachine deadlock
Message-ID: <2023112434-winter-embezzle-1b46@gregkh>
References: <2023100450-charger-disregard-9683@gregkh>
 <AM0PR09MB2675934BBFB6E1DA8E0F626295B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
 <CAOMZO5AgDjwUeePO4ibUeKkpf-YV9v=Dws0S01HMERdDf85yoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AgDjwUeePO4ibUeKkpf-YV9v=Dws0S01HMERdDf85yoQ@mail.gmail.com>

On Fri, Nov 24, 2023 at 09:58:19AM -0300, Fabio Estevam wrote:
> Hi Paul,
> 
> On Fri, Nov 24, 2023 at 9:55 AM Paul Geurts <paul_geurts@live.nl> wrote:
> >
> > When using the serial port as RS485 port, the tx statemachine is used to
> > control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
> > TTY port is closed in the middle of a transmission (for instance during
> > userland application crash), imx_uart_shutdown disables the interface
> > and disables the Transmission Complete interrupt. afer that,
> > imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
> > by the TC interrupt. This interrupt is disabled and therefore the tx
> > statemachine never transitions out of SEND. The statemachine is in
> > deadlock now, and the TX_EN remains low, making the interface useless.
> >
> > imx_uart_stop_tx now checks for incomplete transmission AND whether TC
> > interrupts are enabled before bailing to be retriggered. This makes sure
> > the state machine handling is reached, and is properly set to
> > WAIT_AFTER_SEND.
> >
> > Fixes: cb1a60923609 serial: imx: implement rts delaying for rs485
> 
> One nit: the correct format for the Fixes tag is:
> 
> Fixes: cb1a60923609 ("serial: imx: implement rts delaying for rs485")
> 
> And no blank line is needed between the Fixes and Signed-off-by line.

It's not really a "nit", our tools will complain if this is in the wrong
format as so many things depend on this being correct.

Paul, can you make a v3 with this change?

And really, this should have been v3 anyway, as the difference being you
added a changelog from v2 :)

thanks,

greg k-h

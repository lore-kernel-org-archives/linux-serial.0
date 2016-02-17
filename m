From: =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=
	<torso.nafi@gmail.com>
Subject: Re: [PATCH v8 3/3] tty: 8250_omap: Use software emulated RS485
 direction control
Date: Wed, 17 Feb 2016 19:56:00 +0300
Message-ID: <CAEo2pzsqo5Zp99n9GKD3e1_f_+YErJiRHc=rQy7HPvmQ92iM3A@mail.gmail.com>
References: <CAEo2pzv-kSy+34JzC1hOxMLX_j2EB1KkiHsao5Tpm2cKVz9Qrg@mail.gmail.com>
	<CAJs94EZNi=g5D08c9-m0aGQFTDUSksaJNsrcT6RYsyd_az75Qg@mail.gmail.com>
	<CAEo2pzs7mTUFpUGvsyrzt5cYPXsWLiBLaoQ==SypBm5fKjkFjA@mail.gmail.com>
	<CAJs94Ea-3Lvfmh=72EOnDhXKawBfBbM3Ue2tuW-OLemXSFTZfA@mail.gmail.com>
	<CAEo2pzsRdhqiFiHOc8BxFsiJwJ9WTru3dGaWgfssJLWQ5FCTyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEo2pzsRdhqiFiHOc8BxFsiJwJ9WTru3dGaWgfssJLWQ5FCTyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

After testing the patch v8, I found two more glitches, which happen at
least in 4.1 kernel (I applied the changes to 8250_core.c, since
8250_port.c isn't made separate in 4.1):

1) When serial8250_em485_init is called from omap_8250_rs485_config,
there is a lockdep warning, and according to the stack trace it
happens at kmalloc invocation. Passing GFP_ATOMIC instead of
GFP_KERNEL in flags apparently fixes the problem.

2) Once a transmission happens and completes, the behavior of AM335x
UART becomes strange - it seemingly doesn't receive anything (or fails
to return to userspace the received payload). At the time of next
transmission (sometimes just before, sometimes just after, but never
during it) the single last received byte is returned via read, the
rest of the payload discarded. However when SER_RS485_RX_DURING_TX is
set, it works just okay. The problem is, this happens when clearly the
payload is not received during transmission, so it isn't liable to be
discarded upon clearing FIFO. Best guess the Rx interrupt which is
disabled in start_tx_rs485 upon calling serial8250_stop_rx isn't
properly restored.


Regards,
Ilyas G.

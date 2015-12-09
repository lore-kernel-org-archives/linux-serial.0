From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v1] serial: core: support more baud rates when serial
 console setup
Date: Wed, 9 Dec 2015 12:05:54 +0000
Message-ID: <20151209120554.7d6153a5@lxorguk.ukuu.org.uk>
References: <1449644878-25508-1-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449644878-25508-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jslaby@suse.com, gregkh@linuxfoundation.org, rockchip-discuss@chromium.org
List-Id: linux-serial@vger.kernel.org

On Wed,  9 Dec 2015 15:07:58 +0800
Jeffy Chen <jeffy.chen@rock-chips.com> wrote:

> Currently, when tring to set up a serial console with a higher
> baud rate, it would fallback to 921600.
> 
> So, add more baud rates to the baud rate array.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>


Far simpler I think would be if we finally lost this old code and just did

	memset(&termios, 0, sizeof(struct termios));
	termios.c_cflag |= CREAD | HUPCL | CLOCAL;
	tty_termios_encode_baud_rate(&termios, baud, baud);


	if (bits == 7)
		..


and just removed the baud_rates table for good. The console drivers now
understand arbitrary rate requests and the core tty code has for years
supported doing the mapping for arbitrary baud rates as well as back
mapping them onto "classic" B9600 type encoding when possible.

That would also various devices with insane baud rates where someone was
too cheap to fit an extra crystal.

Alan

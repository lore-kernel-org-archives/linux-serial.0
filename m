From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 8/9] tty: ircomm: remove dead and broken ioctl code
Date: Tue, 6 Jun 2017 12:27:04 +0100
Message-ID: <20170606122704.3e328125@lxorguk.ukuu.org.uk>
References: <20170606105441.689-1-johan@kernel.org>
        <20170606105441.689-9-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-9-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue,  6 Jun 2017 12:54:40 +0200
Johan Hovold <johan@kernel.org> wrote:

> Remove three ifdefed and broken implementations of TIOCSSERIAL and
> TIOCGICOUNT, and parity handling in set_termios which had suffered
> severe bit rot.

I would be amazed if the IRDA code still works. It's not been tested
properly for years and it never followed the tty rules properly in the
first place - so this looks good, although moving IRDA into staging
and /dev/null would IMHO be far better.

IRDA is dead, and IR remotes are handled via completely different code.

Alan

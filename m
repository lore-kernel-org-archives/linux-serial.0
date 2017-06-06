From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/9] tty: drop broken alt-speed handling
Date: Tue, 6 Jun 2017 12:29:46 +0100
Message-ID: <20170606122946.13d63430@lxorguk.ukuu.org.uk>
References: <20170606105441.689-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue,  6 Jun 2017 12:54:32 +0200
Johan Hovold <johan@kernel.org> wrote:

> Setting an alt-speed using TIOCSSERIAL and SPD flags has been deprecated
> since v2.1.69 and has been broken for all tty drivers but serial-core
> since v3.10 and commit 6865ff222cca ("TTY: do not warn about setting
> speed via SPD_*") without anyone noticing (for four years).

We have the ability to set the speed directly via termios so I doubt
anyone is using the remaining hacks either but I guess someone may. All
looks good to me.

Reviewed-by: Alan Cox <alan@linux.intel.com>

Alan

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a
	ll recent versions)
Date: 28 Jul 2002 21:04:36 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1152.39892988956$1027882358@news.gmane.org>
References: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE>
	<200207271507.56873.rwhite@pobox.com> <20020727232129.GA26742@win.tue.nl>
	<200207271934.27102.rwhite@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <200207271934.27102.rwhite@pobox.com>
List-Id: linux-serial@vger.kernel.org
To: rwhite@pobox.com
Cc: Andries Brouwer <aebr@win.tue.nl>, Russell King <rmk@arm.linux.org.uk>, Ed Vance <EdV@macrolink.com>, 'Theodore Tso' <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sun, 2002-07-28 at 03:34, Robert White wrote:
> Having virtually every user on the planet realize this and just set VMIN == 1 
> is an fairly telling indicator.
> 
> Repeatedly calling the kernel to assemble an input buffer which is necessary 
> if VMIN ==1, is dumb.

VMIN was basically invented for communication protocols when you know
the block length that should arrive within a given timeout. Its pretty
much essential on old old boxes and was very important for
interrupt/context switch reduction when doing block transfers. In that
world the read blocks or in O_NDELAY returns -EAGAIN (0 in old SYS5)
until the data block is big enough to warrant its copying. Similarly
poll has no business saying data is ready until a large enough block is.

When talking to a human setting VMIN > 1 makes no sense anyway. In fact
nowdays it makes even less sense than it did before because of the use
of UTF8 encodings for unicode characters.



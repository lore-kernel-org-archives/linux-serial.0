From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v7] serial: support for 16550A serial ports on LP-8x4x
Date: Tue, 1 Mar 2016 18:43:27 +0000
Message-ID: <20160301184327.148b3ad4@lxorguk.ukuu.org.uk>
References: <1456589675-25377-1-git-send-email-ynvich@gmail.com>
	<1456781209-11390-1-git-send-email-ynvich@gmail.com>
	<1456830401.13244.189.camel@linux.intel.com>
	<1456849504.23036.108.camel@gmail.com>
	<1456850782.13244.208.camel@linux.intel.com>
	<1456852472.23036.124.camel@gmail.com>
	<1456854532.13244.215.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456854532.13244.215.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sergei Ianovich <ynvich@gmail.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Burton <paul.burton@imgtec.com>, Mans Rullgard <mans@mansr.com>, Joachim Eastwood <manabian@gmail.com>, Scott Wood <scottwood@freescale.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.ke>
List-Id: linux-serial@vger.kernel.org

> Maybe you just set a baud rate nearest to the one from the table in
> case of BOTHER?

This is broken. BOTHER can be set with a perfectly valid baud rate that
could equally be represented by B9600 say.

If you are stuck with limited ranges then

	switch(baud) {
	case 9600:
	case 4800:

etc

and don't worry about BOTHER, it's entirely transparent to you. The core
kernel code will provide you with a baud rate number, the re-encoder will
always do the right thing.

A driver should never care about BOTHER or any of the baud bits in the
termios structure directly.

Alan

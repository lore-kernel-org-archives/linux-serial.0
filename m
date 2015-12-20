From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Sun, 20 Dec 2015 17:42:08 +0000
Message-ID: <20151220174208.1447d2f3@lxorguk.ukuu.org.uk>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
	<20151220164353.6ef29f77@lxorguk.ukuu.org.uk>
	<20151220172841.GB8471@sudip-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151220172841.GB8471@sudip-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> So then should I rewrite it as MFD or should it be like the way you
> suggested in the other mail to have it as bool in the Kconfig and combine
> the file with 8250_pci.c when the symbol is selected?

Yes although I'm really not sure which is the best approach of the two.

Alan

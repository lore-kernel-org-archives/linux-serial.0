From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/7] serial/8250: remove obsolete and broken PORT_RSA
 support
Date: Tue, 28 Jun 2011 11:11:28 +0100
Message-ID: <20110628111128.43d968a3@lxorguk.ukuu.org.uk>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<1309211120-2803-6-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309211120-2803-6-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Kiyokazu SUTO <suto@ks-and-ks.ne.jp>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 27 Jun 2011 23:45:18 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> For all I can tell, the RSA support in the 8250 driver
> is not functional and has not been for a long time.

Seems fair enough

Only one that needs dealing with properly is the PIO method ifdef stuff.

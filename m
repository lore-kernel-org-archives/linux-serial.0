From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 01/68] USB: cdc-acm, use tty_standard_install
Date: Mon, 5 Mar 2012 23:39:10 +0000
Message-ID: <20120305233910.728e60d7@pyramind.ukuu.org.uk>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
	<1330955575-26641-2-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:57305 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757794Ab2CEXhW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Mar 2012 18:37:22 -0500
In-Reply-To: <1330955575-26641-2-git-send-email-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com

On Mon,  5 Mar 2012 14:51:48 +0100
Jiri Slaby <jslaby@suse.cz> wrote:

> This is a piece I missed the last time.
> 
> Do not copy the functionality all over the tree. Instead, use the
> helper the tty layer provides us with.

All looks sane to me

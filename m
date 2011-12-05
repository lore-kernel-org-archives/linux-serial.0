From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] serial: bfin-uart: remove redundant CTS check for
 hardware CTS control.
Date: Mon, 5 Dec 2011 11:38:40 +0000
Message-ID: <20111205113840.02e42ffa@lxorguk.ukuu.org.uk>
References: <1323079991-4855-1-git-send-email-sonic.adi@gmail.com>
	<1323079991-4855-2-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46631 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932082Ab1LELhk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Dec 2011 06:37:40 -0500
In-Reply-To: <1323079991-4855-2-git-send-email-sonic.adi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

On Mon, 5 Dec 2011 18:13:11 +0800
Sonic Zhang <sonic.adi@gmail.com> wrote:

> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> Blackfin hardware CTS control generate interrupt for both CTS on and off.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

Both

Acked-by: Alan Cox <alan@linux.intel.com>

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] serial: 8250: Add a wakeup_capable module param
Date: Tue, 17 Jan 2012 20:10:36 +0000
Message-ID: <20120117201036.6d99f98f@pyramind.ukuu.org.uk>
References: <1326826563-32215-1-git-send-email-sjg@chromium.org>
	<1326826563-32215-3-git-send-email-sjg@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50848 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab2AQUJR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jan 2012 15:09:17 -0500
In-Reply-To: <1326826563-32215-3-git-send-email-sjg@chromium.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

On Tue, 17 Jan 2012 10:56:03 -0800
Simon Glass <sjg@chromium.org> wrote:

> Since serial_core now does not make serial ports wake-up capable by
> default, add a parameter to support this feature in the 8250 UART.
> This is the only UART where I think this feature is useful.

NAK

Things should just work for users. Magic parameters is not an
improvement. If its a performance problem someone needs to fix the rcu
sync overhead or stop using rcu on that path.

Alan

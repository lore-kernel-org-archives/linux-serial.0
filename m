From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial8250: ratelimit "too much work" error
Date: Sat, 2 Oct 2010 15:22:29 +0100
Message-ID: <20101002152229.5f0f957b@lxorguk.ukuu.org.uk>
References: <20101002110438.801F49D401B@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59537 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755480Ab0JBN5s (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 2 Oct 2010 09:57:48 -0400
In-Reply-To: <20101002110438.801F49D401B@zog.reactivated.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: akpm@linux-foundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat,  2 Oct 2010 12:04:38 +0100 (BST)
Daniel Drake <dsd@laptop.org> wrote:

> Running a serial console, if too many kernel messages are generated within
> a short time causing a lot of serial I/O, the 8250 driver will generate
> another kernel message reporting this, which just adds to the I/O. It has
> a cascading effect and quickly results the system being brought to its knees
> by a flood of "too much work" messages.
> 
> Ratelimit the error message to avoid this.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Acked-by: Alan Cox <alan@linux.intel.com>


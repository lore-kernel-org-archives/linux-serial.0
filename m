From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial/8250: fix uninitialized warnings
Date: Mon, 10 Nov 2008 23:48:43 +0000
Message-ID: <20081110234843.0fba9f16@lxorguk.ukuu.org.uk>
References: <20081105022353.7CB0.KOSAKI.MOTOHIRO@jp.fujitsu.com>
	<20081104174142.360a964a@lxorguk.ukuu.org.uk>
	<20081110143039.6f21fdc3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50958 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752401AbYKJXsl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Nov 2008 18:48:41 -0500
In-Reply-To: <20081110143039.6f21fdc3.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kosaki.motohiro@jp.fujitsu.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

> That's a regression in current gcc, surely?

Oh and as a PS: Gcc is I believe right because if the loop is run zero
times then pos = NULL (ie n == NULL so the first BUG_ON fires)


Alan
